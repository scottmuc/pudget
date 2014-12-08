require_relative "../../spec/vcr_helper"

VCR.cucumber_tags do |t|
  t.tag "calculate-time-committment-for-a-feed"
  t.tag "calculate-time-committment-for-a-list-of-feeds"
  t.tag "adding-2-unique-podcasts"
end

