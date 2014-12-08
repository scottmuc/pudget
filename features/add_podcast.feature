Feature: Add podcasts to your pudget

  @adding-2-unique-podcasts
  Scenario: Adding 2 unique podcasts
    Given that I have a pudget
    When I add Startup Podcast
    And I add EconTalk Podcast
    Then both podcasts are displayed

