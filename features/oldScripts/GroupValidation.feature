Feature: Mouse hover on all the icons at group level

      
      
    /*
    created by:Mohan.s
    date:18Jan23
    */

    @groupValidation
    Scenario Outline: Validate Group level
        Given user login to "<url>" with "<user>" credentials
        When User mouseover "Group" in "HomePage" screen
        Then User see text "Groups" in "GroupsToolTip" in "HomePage" screen
        When User mouseover "Members" in "HomePage" screen
        Then User see text "Members" in "MembersToolTip" in "HomePage" screen
        When User mouseover "Queue" in "HomePage" screen
        Then User see text "Queue" in "QueueToolTip" in "HomePage" screen
        When User mouseover "Source" in "HomePage" screen
        Then User see text "Payload" in "PayloadToolTip" in "HomePage" screen
        When User mouseover "Document" in "HomePage" screen
        Then User see text "Document" in "DocumentToolTip" in "HomePage" screen
        When User mouseover "Environment" in "HomePage" screen
        Then User see text "Environments" in "EnvironmentsToolTip" in "HomePage" screen
        When User mouseover "API Generator" in "HomePage" screen
        Then User see text "API Generator" in "APIGeneratorToolTip" in "HomePage" screen
        When User mouseover "Support" in "HomePage" screen
        Then User see text "Support" in "SupportToolTip" in "HomePage" screen
        When User mouseover "Email" in "HomePage" screen
        Then User see text "Email Setup" in "EmailToolTip" in "HomePage" screen
        When User mouseover "Logout" in "HomePage" screen
        Then User see text "Logout" in "LogoutToolTip" in "HomePage" screen
        When User mouseover "Admin" in "HomePage" screen
        Then User see text "Admin" in "AdminToolTip" in "HomePage" screen
        And User see text "<GroupsTitle>" in "GroupAssertion" in "HomePage" screen
        When User mouseover "Members" in "HomePage" screen
        Then User should have page title as "Finlevit Admin " in "HomePage" screen










        Examples:
            | url            | user       | GroupsTitle |
            | Finlevit_admin | admin_user | Groups      |