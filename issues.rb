#!/usr/bin/env ruby

require 'octokit'
require 'chronic'
require 'time'

## Create markdown version of output, with newlines.  


# give repo as first argument
@text = ARGV[0]
@address = "#{@text}" #"cboettig/"+"#{@text}"



repo = Octokit.issues(@address) # grab the data. Can this go in "initialize?"
  out = "<ul>"
  for i in 0 ... [repo.size, 20].min ## displays up to 20.  sorted by date?
    lab = ""
    if repo[i].labels[0].class == Hashie::Mash  # Get labels for issues, with color, where applicable 
      lab = " (<font color=\"#" + repo[i].labels[0].color + 
            "\">" + repo[i].labels[0].name  + "</font>)"
    end
    ## Actually only pulls open issues
    if repo[i].state == "open" # Print only open issues 
      out = out + "<li> <a href=\"" + repo[i].html_url + "\">" +  repo[i].title + "</a> " + lab + "</li>"
    end
    if repo[i].state == "closed" # strike out closed issues 
      out = out + "<li> <strike> <a href=\"" + repo[i].html_url + "\">" +  repo[i].title + "</a> " + lab + "</strike> </li>"
    end
  end
  out = out + "</ul>"
  print out
