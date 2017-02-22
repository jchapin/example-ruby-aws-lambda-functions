#!/usr/bin/env ruby
require 'httparty'

@config = YAML.load_file('settings.yml')

github_headers = {
  'User-Agent' => @config['github']['username'],
  'Accept' => 'application/vnd.github.black-cat-preview+json',
  'Authorization' => "token #{@config['github']['access_token']}"
}.freeze

###
# Post a chat message to Slack
###
def post_chat_message(pr)
  HTTParty.post(
    'https://slack.com/api/chat.postMessage',
    body: { channel: 'developers', as_user: @config['slack']['user'],
            text: message(pr), token: @config['slack']['token'] }
  )
end

###
# Compose a message to post to chat when a PR review is requested.
###
def message(pr)
  return if pr['requested_reviewers'].empty?
  "@channel a review has been requested! URL: #{pr['html_url']} Attn: "\
  "#{pr['requested_reviewers'].map { |r| r['login'] }.join(' ')}"
end

###
# Roll through each of the configured repositories and all of their PRs.
###
@config['github']['repos'].each do |repo|
  pull_requests = HTTParty.get(
    "https://api.github.com/repos/#{repo['owner']}/#{repo['repo']}/pulls",
    query: { state: 'open' }, headers: github_headers
  )
  pull_requests.each { |pr| post_chat_message(pr) }
end
