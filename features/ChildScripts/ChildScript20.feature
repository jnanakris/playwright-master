Feature:Validate Add group, Edit group and Delete group functionality

  @Group @ChildScript 
  @ChildScript20
  #Createdby: Mary
  #CreatedDate:05/11/2023
  Scenario: Validate Add group, Edit group and Delete group functionality
    Given user login to "Finlevit_admin" with "Admin" credentials
    And User wait until the spinner disappears
    Then User delete group "Test - Automation Group_update" in "Groups" screen
    Then User delete group "Test - Automation Group" in "Groups" screen
    And User wait until the spinner disappears
    # Add New group 
    When User create group "Test - Automation Group" with description "Group - Created by Automation" in "Groups" screen
    # Edit Description, Group Admin and Group Name
    Then User edit "Description" as "Group - Created by Automation-updated" in "Groups" screen
    Then User edit "Group Admin" as "Tom Hanks" in "Groups" screen
    Then User edit "GroupName" as "Test - Automation Group_update" in "Groups" screen
    # Edit Group Name with already exist group name and make sure group already exists message displays
    Then User edit group name with already exist group name in "Groups" screen
    # Delete Group
    Then User delete group "Test - Automation Group_update" in "Groups" screen
    