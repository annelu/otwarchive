@works, @users
Feature: Orphan account
  In order to have an archive full of works
  As an author
  I want to orphan all works in my account

Scenario: Orphan all works belonging to a user
  Given I have an orphan account
  And the following activated user exists
    | login         | password   |
    | orphaneer     | password   |
    And I am logged in as "orphaneer" with password "password"
  When I post the work "Shenanigans"
  And I post the work "Shenanigans 2"
  And I post the work "Shenanigans - the early years"
  When I follow "orphaneer"
  Then I should see "Recent works"
    And I should see "Shenanigans"
    And I should see "Shenanigans 2"
    And I should see "Shenanigans - the early years"
  When I follow "My Preferences"
  Then I should see "Update My Preferences"
  When I follow "Orphan My Works"
  Then I should see "Orphan All Works"
    And I should see "Are you sure you want to permanently remove"
  When I choose "Use the default orphan pseud"
  And I press "Yes, I'm sure"
  Then I should see "Orphaning was successful."
  When I view the work "Shenanigans"
  Then I should see "orphan_account" within ".byline"
    And I should not see "orphaneer" within ".byline"
  When I view the work "Shenanigans 2"
  Then I should see "orphan_account" within ".byline"
    And I should not see "orphaneer" within ".byline"
  When I view the work "Shenanigans - the early years"
  Then I should see "orphan_account" within ".byline"
    And I should not see "orphaneer" within ".byline"

Scenario: Orphan all works belonging to a user, add a copy of the pseud to the orphan_account
Given I have an orphan account
  And the following activated user exists
  | login         | password   |
  | orphaneer     | password   |
  And I am logged in as "orphaneer" with password "password"
  When I post the work "Shenanigans"
  When I post the work "Shenanigans 2"
  When I post the work "Shenanigans - the early years"
  When I follow "orphaneer"
  Then I should see "Recent works"
    And I should see "Shenanigans"
    And I should see "Shenanigans 2"
    And I should see "Shenanigans - the early years"
  When I follow "My Preferences"
  Then I should see "Update My Preferences"
  When I follow "Orphan My Works"
  Then I should see "Orphan All Works"
    And I should see "Are you sure you want to permanently remove"
  When I choose "Make a copy of my pseud under the orphan account"
  And I press "Yes, I'm sure"
  Then I should see "Orphaning was successful."
  When I am on orphaneer's user page
    Then I should not see "Shenanigans"
  When I am logged out
    And I am on orphan_account's pseuds page
    And I follow "orphaneer"
  Then I should see "Shenanigans"
    And I should see "Shenanigans 2"
    And I should see "Shenanigans - the early years"
  When I view the work "Shenanigans"
  Then I should see "orphaneer (orphan_account)" within ".byline"
