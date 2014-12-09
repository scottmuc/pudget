Feature: Add podcasts to your pudget

  @adding-2-unique-podcasts
  Scenario: Adding 2 unique podcasts
    Given that I have a pudget
    When I add Startup Podcast
    And I add EconTalk Podcast
    Then 2 podcasts are displayed

  @bulk-adding-podcasts
  Scenario: Bulk adding podcasts
    Given that I have a pudget
    When I import Scott Muc's OPML feed
    Then 4 podcasts are displayed

