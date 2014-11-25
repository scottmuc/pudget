Feature: Know how much time you need to commit to a feed

  @calculate-time-committment-for-a-feed
  Scenario: Calculate time committment for a feed
    When I lookup StartUp Podcast
    Then the weekly committment time is displayed

  Scenario: Lookup a cached podcast
    Given Serial Podcast is cached with a time of 20
    When I lookup Serial Podcast
    Then then a time of 20 minutes is displayed

