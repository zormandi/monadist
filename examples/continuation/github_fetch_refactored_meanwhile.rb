require 'monadist'
require 'net/http'
require 'json'
require 'uri_template'



def get_json(url)
  puts "Reading from #{url}"
  uri = URI url
  json = Net::HTTP.start uri.host, uri.port, :use_ssl => uri.scheme == 'https' do |http|
    http.request_get(uri.path).body
  end
  JSON.parse json
end



def get_org(urls, name)
  org_url_template = URITemplate.new(urls['organization_url'])
  get_json org_url_template.expand(org: name)
end



def get_most_popular_repo(repos)
  most_popular_repo = repos.max_by { |repo| repo['watchers_count'] }
  get_json most_popular_repo['url']
end



def get_most_prolific_user(contributors)
  most_prolific_user = contributors.max_by { |user| user['contributions'] }
  get_json most_prolific_user['url']
end



Monadist::Meanwhile.unit('https://api.github.com/').
  fmap { |github_api_url| get_json github_api_url }.
  fmap { |urls| get_org urls, 'ruby' }.
  fmap { |org| get_json org['repos_url'] }.
  fmap { |repos| get_most_popular_repo repos }.
  fmap { |repo| get_json repo['contributors_url'] }.
  fmap { |contributors| get_most_prolific_user contributors }.
  run { |user| puts "The most influential Rubyist is #{user['name']} (#{user['login']})" }

sleep 1 while Thread.list.count > 1
