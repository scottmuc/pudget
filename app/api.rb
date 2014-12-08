require_relative 'domain/podcast'
require_relative 'domain/podcasts'

module Pudget
  class API
    def self.handle_url(&block)
      begin
        block.call
      rescue Exception => e
        p e
        { :success => false }
      end
    end

    def self.get_podcasts(opml, url)
      if opml == "on"
        handle_url do
          podcasts = Podcasts.fetch_from_the_internet! url
          { :podcasts => podcasts }
        end
      else
        handle_url do
          podcast = Podcast.fetch_from_the_internet! url
          { :podcasts => [podcast]}
        end
      end
    end
  end
end

