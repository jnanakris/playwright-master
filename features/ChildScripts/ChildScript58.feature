Feature: USeCase to create group as super admin and logout and login as group admin and edit the group admin
    @ChildScript58
    @ChildScript
    #Createdby: Mohan S

    Scenario: UseCase to create group as super admin then logout and login as group admin and edit the group admin and verify error only super admin can do it

        Given user login to "Finlevit_admin" with "Admin" credentials
        And User get the Test data from "Usecase_TestData/ChildScript58" json file in "WorkFlow UI" screen
        Then User delete group "#GroupName" in "Groups" screen
        When User create group "#GroupName" with description "Group - Created by Automation" in "Groups" screen

        #login as group admin create an app
        Then User will "Logout" from "Page" the current session
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        Then User will open "#GroupName" group in "HomePage" screen
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        Then User see text "Front Office" in "FO" in "Page" screen

        #login as another group admin verify if app is visible
        Then User will "Logout" from "Page" the current session
        Given user login to "Finlevit_admin" with "SecondGroupAdmins" credentials
        Then User will open "#GroupName" group in "HomePage" screen
        And User wait until the spinner disappears
        Then User will search for "Application_Name" in "Application" screen
        Then User see text "Front Office" in "FO" in "Page" screen
        Then User will "Logout" from "Page" the current session

        # login as super admin -> update group admin
        Given user login to "Finlevit_admin" with "Admin" credentials
        Then User will open "#GroupName" group in "HomePage" screen
        And User wait for "3000"
        Then User will update group member with "Mohan" in "HomePage" screen
        And User wait for "5000"
        And User wait until the spinner disappears
        Then User will search for "Application_Name" in "Application" screen

        #verify the earlier step if new admin can see created app
        Then User will "Logout" from "Page" the current session
        Given user login to "Finlevit_admin" with "#msrinivasan" credentials
        And User wait until the spinner disappears
        Then User will open "#GroupName" group in "HomePage" screen
        And User wait until the spinner disappears
        Then User will search for "Application_Name" in "Application" screen
        Then User see text "Front Office" in "FO" in "Page" screen
        Then User will "Logout" from "Page" the current session
        Given user login to "Finlevit_admin" with "Admin" credentials
        And User wait until the spinner disappears
        Then User delete group as group admin "#GroupName" in "Groups" screen
        And User wait for "3000"



