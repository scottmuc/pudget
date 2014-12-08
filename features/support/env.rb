require 'capybara/cucumber'
require_relative '../../app/pudget'
Capybara.app = Pudget::App

def podcast_urls
  { "Startup Podcast" => "http://feeds.hearstartup.com/hearstartup",
    "EconTalk Podcast" => "http://files.libertyfund.org/econtalk/EconTalk.xml",
  }
end

