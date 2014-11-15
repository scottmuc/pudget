Feature: Know how much time you need to commit to a feed

  @calculate-time-committment-for-a-feed
  Scenario: Calculate time committment for a feed
    When I lookup StartUp Podcast
    Then then the weekly committment time is displayed

