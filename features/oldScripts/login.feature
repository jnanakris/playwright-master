Feature: Konfig login page

    @login
    Scenario Outline: Verify konfig login page
        Given user login to "<url>" with "<user>" credentials
        
        
        
        Examples:
            | url             | user        |
            | Finlevit_admin  | admin_user  | 
            
    @logout
    Scenario: Logout from the current session
     Given user login to "Finlevit_admin" with "GroupAdmins" credentials
     When User enter create group with "GroupName" and "GroupDescription" in "Groups" screen
     Then User will "Logout" from "Page" the current session
