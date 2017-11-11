require 'hashie/mash'

def stub_simple_rss(rss_hash)
  Hashie::Mash.new(rss_hash)
end

