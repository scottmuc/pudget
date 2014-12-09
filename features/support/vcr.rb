require_relative "../../spec/vcr_helper"

VCR.cucumber_tags do |t|
  t.tag "bulk-adding-podcasts"
  t.tag "adding-2-unique-podcasts"
end

