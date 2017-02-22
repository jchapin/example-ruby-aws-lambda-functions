#!/usr/bin/env ruby
require 'httparty'

@config = YAML.load_file('settings.yml')

###
# Just so a nice date can be presented...
###
class Integer
  def ordinalize
    if (11..13).cover?(self % 100)
      "#{self}th"
    else
      case self % 10
      when 1 then "#{self}st"
      when 2 then "#{self}nd"
      when 3 then "#{self}rd"
      else "#{self}th"
      end
    end
  end
end

###
# Post a chat message to Slack
###
def post_chat_message
  HTTParty.post(
    'https://slack.com/api/chat.postMessage',
    body: { channel: 'developers', as_user: @config['slack']['user'],
            text: message, token: @config['slack']['token'] }
  )
end

###
# Compose a message to post to chat when a PR review is requested.
###
def message
  now = Time.now
  "@channel, reminder that it's the #{now.day.ordinalize}. Submit time "\
  'records for invoicing.'
end

# Post a message to the chat room
post_chat_message
