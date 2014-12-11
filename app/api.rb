require_relative 'domain/podcast'
require_relative 'domain/podcasts'
require_relative 'domain/podcast_slicer'

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

    def self.get_podcasts(url, opml)
      if opml
        handle_url do
          podcasts = Podcasts.fetch_from_the_internet! url
          sliced = podcasts.map do |podcast|
            PodcastSlicer.slice podcast
          end
          { :podcasts => sliced }
        end
      else
        handle_url do
          podcast = Podcast.fetch_from_the_internet! url
          sliced =  PodcastSlicer.slice podcast
          { :podcasts => [sliced] }
        end
      end
    end
  end
end

