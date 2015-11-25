Feature: Select a Series from the Environment

Scenario: Select Bubble Guppies
Given that onboarding has already been completed
  And I am in the environment
 When I tap on Bubble Guppies
 Then I see a Loading screen
  And I see the player with Bubble Guppies
  