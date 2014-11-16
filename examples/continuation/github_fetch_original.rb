require 'net/http'
require 'json'
require 'uri_template'



def get_json(url, &success)
  Thread.new do
    puts "Reading from #{url}"
    uri = URI url
    json = Net::HTTP.start uri.host, uri.port, :use_ssl => uri.scheme == 'https' do |http|
      http.request_get(uri.path).body
    end
    value = JSON.parse json
    success.call value
  end
end



get_json('https://api.github.com/') do |urls|
  org_url_template = URITemplate.new(urls['organization_url'])
  org_url = org_url_template.expand(org: 'ruby')

  get_json(org_url) do |org|
    repos_url = org['repos_url']

    get_json(repos_url) do |repos|
      most_popular_repo = repos.max_by { |repo| repo['watchers_count'] }
      repo_url = most_popular_repo['url']

      get_json(repo_url) do |repo|
        contributors_url = repo['contributors_url']

        get_json(contributors_url) do |users|
          most_prolific_user = users.max_by { |user| user['contributions'] }
          user_url = most_prolific_user['url']

          get_json(user_url) do |user|
            puts "The most influential Rubyist is #{user['name']} (#{user['login']})"
          end
        end
      end
    end
  end
end

sleep(1) while Thread.list.count > 1
