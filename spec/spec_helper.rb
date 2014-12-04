require 'codeclimate-test-reporter'
require 'hashie/mash'

CodeClimate::TestReporter.start

def stub_simple_rss(rss_hash)
  Hashie::Mash.new(rss_hash)
end

