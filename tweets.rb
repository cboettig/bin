#!/usr/bin/env ruby

require 'twitter'
require 'redcarpet'
require 'chronic'

#day = context.environments.first["page"]["date"]
if ARGV.length == 2 
  user = ARGV[0]
  count = ARGV[1]
elsif ARGV.length == 1 
  user = ARGV[0]
  count = 5
else 
  user = "cboettig" 
  count = 5
end

out = ""
markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                   :autolink => true, :space_after_headers => true)

tweets = Twitter.user_timeline(user)
for i in 0 ... count.to_i
out = out + "* " + tweets[i].text + 
  "[" + tweets[i].created_at.strftime("%I:%M %Y/%m/%d") + "]" +
  "(http://twitter.com/" + user + "/statuses/" + 
  tweets[i].id.to_s + ")\n"  
end

print out 
