require 'monadist'
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



def get_github_api_urls
  github_root_url = 'https://api.github.com/'

  Monadist::Continuation.new { |success| get_json github_root_url, &success }
end



def get_org(urls, name)
  org_url_template = URITemplate.new(urls['organization_url'])
  org_url = org_url_template.expand(org: name)

  Monadist::Continuation.new { |success| get_json org_url, &success }
end



def get_repos(org)
  repos_url = org['repos_url']

  Monadist::Continuation.new { |success| get_json repos_url, &success }
end



def get_most_popular_repo(repos)
  most_popular_repo = repos.max_by { |repo| repo['watchers_count'] }
  repo_url = most_popular_repo['url']

  Monadist::Continuation.new { |success| get_json repo_url, &success }
end



def get_contributors(repo)
  contributors_url = repo['contributors_url']

  Monadist::Continuation.new { |success| get_json contributors_url, &success }
end



def get_most_prolific_user(contributors)
  most_prolific_user = contributors.max_by { |user| user['contributions'] }
  user_url = most_prolific_user['url']

  Monadist::Continuation.new { |success| get_json user_url, &success }
end



get_github_api_urls.
  bind { |urls| get_org urls, 'ruby' }.
  bind { |org| get_repos org }.
  bind { |repos| get_most_popular_repo repos }.
  bind { |repo| get_contributors repo }.
  bind { |contributors| get_most_prolific_user contributors }.
  run { |user| puts "The most influential Rubyist is #{user['name']} (#{user['login']})" }

sleep(1) while Thread.list.count > 1
