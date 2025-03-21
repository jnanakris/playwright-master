Feature: USeCase to create group as super admin and logout and login as group admin and edit the group admin
    @ChildScript59
    @ChildScript
    #Createdby: Mohan S

    Scenario: UseCase to create group as super admin then logout and login as group admin and edit the group admin and verify error only super admin can do it

        Given user login to "Finlevit_admin" with "Admin" credentials
        And User get the Test data from "Usecase_TestData/ChildScript59" json file in "WorkFlow UI" screen
        Then User delete group "#GroupName" in "Groups" screen
        When User create group "#GroupName" with description "Group - Created by Automation" in "Groups" screen

        #Logout
        Then User will "Logout" from "Page" the current session
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        Then User will open "#GroupName" group in "HomePage" screen
        Then User will update group member with "Mohan" in "HomePage" screen
        Then User should see an element "SystemAdminValidation" in "HomePage" screen
        When User reloads the page
        Then User will "Logout" from "Page" the current session
        Given user login to "Finlevit_admin" with "Admin" credentials
        And User wait until the spinner disappears
        Then User delete group as group admin "#GroupName" in "Groups" screen
        # Then User click on "button" "DeleteSubmit" in "tasks" screen
        And User wait for "3000"





