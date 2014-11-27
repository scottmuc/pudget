Feature: Know how much time you need to commit to a feed

  @calculate-time-committment-for-a-feed
  Scenario: Calculate time committment for a feed
    When I lookup StartUp Podcast
    Then the weekly committment time is displayed

  @calculate-time-committment-for-a-list-of-feeds
  Scenario: Calculate time committment for a list of feeds
    When I lookup Scott Muc's podcast list
    Then the weekly committment time is displayed

