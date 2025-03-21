Feature: Validate Create app, Edit app and Delete app functionality

  @ChildScript24
  @ChildScript57
  #Createdby: Mary
  #CreatedDate:05/12/2023
  Scenario: Validate Create app, Edit app and Delete app functionality
    Given user login to "Finlevit_admin" with "Admin" credentials
    When User will open "GroupName" group in "HomePage" screen
    # Delete App if already exist
    Then User delete app "CS24_Test Application(update)" in "Application" screen
    Then User delete app "CS24_Test Duplicate Application" in "Application" screen
     Then User delete app "CS24_Test Application" in "Application" screen
    # Create new app
    Then User create "New" App "CS24_Test Duplicate Application" with description "Test Application - created through Automation" in "Application" screen
    And User wait until the spinner disappears
    Then User create "New" App "CS24_Test Application" with description "Test Application - created through Automation" in "Application" screen
    # Edit App Description, App Admins, App Name
    Then User edit app "Description" as "Test Application - created through Automation-updated" in "Application" screen
    Then User edit app "App Admin" as "Arthur Song" in "Application" screen
    Then User edit app "AppName" as "CS24_Test Application(update)" in "Application" screen
    And User validate App details in "Application" screen
    # Edit App Name with already exist app name and make sure app already exists message displays
    Then User edit app name with already exist app name "CS24_Test Duplicate Application" in "Application" screen
    # Create new App with already exist app name and make sure app already exists message displays
    Then User create "New" App "CS24_Test Duplicate Application" with description "Test Application - created through Automation" in "Application" screen
    Then User click on "button" "Group_alert_close" in "Groups" screen
    Then User click on "button" "create_app_cancel_button" in "Application" screen
    # Delete App
    Then User delete app "CS24_Test Application(update)" in "Application" screen
    Then User delete app "CS24_Test Duplicate Application" in "Application" screen

  # # Delete App if already exist
  #   Then User delete app "CS24_Existing Application(update)" in "Application" screen
  #   Then User delete app "CS24_Existing Duplicate Application" in "Application" screen
  #   # Create Existing app
  #   Then User create "Existing" App "CS24_Existing Duplicate Application" with description "Existing Application - created through Automation" in "Application" screen
  #   Then User create "Existing" App "CS24_Existing Application" with description "Existing Application - created through Automation" in "Application" screen
  #   # Edit App Description, App Admins, App Name
  #   Then User edit app "Description" as "Existing Application - created through Automation-updated" in "Application" screen
  #   Then User edit app "App Admin" as "Arthur Song" in "Application" screen
  #   Then User edit app "AppName" as "CS24_Existing Application(update)" in "Application" screen
  #   And User validate App details in "Application" screen
  #   # Edit App Name with already exist app name and make sure app already exists message displays
  #   Then User edit app name with already exist app name "CS24_Existing Duplicate Application" in "Application" screen
  #   # Create new App with already exist app name and make sure app already exists message displays
  #   Then User create "Existing" App "CS24_Existing Duplicate Application" with description "Existing Application - created through Automation" in "Application" screen
  #   Then User click on "button" "Group_alert_close" in "Groups" screen
  #   Then User click on "button" "create_app_cancel_button" in "Application" screen
  #   # Delete App
  #   Then User delete app "CS24_Existing Application(update)" in "Application" screen
  #   Then User delete app "CS24_Existing Duplicate Application" in "Application" screen
    