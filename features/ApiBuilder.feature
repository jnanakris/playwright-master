Feature: API Builder
    
    @apiBuilder @createServiceProvider
    Scenario: Create Service Provider with API Builder and Configure Operations
        Given user login to "Finlevit_admin" with "Admin" credentials
        And User get the Test data from "resources/TestData" json file in "WorkFlow UI" screen
        When User enter create group with "GroupName" and "GroupDescription" in "Groups" screen
        Then User click on "button" "group_settings" in "Groups" screen
        Then User click on "button" "apiSetup" in "GroupSetting" screen
        # Create Service Provider
        And User create service provider in "apiSetup" screen
            | SPName     | Description                                 | SPType   | AccessType | AuthorizationType | APIBuilder |
            | Member API | SP for API Builder created using automation | External | Public     | No Auth           | True       |

        When User creates a new service provider with following details
            | Name          | AuthType |
            | MemberService | No Auth  |
        And User enables "API Builder" checkbox for the service provider
        And User clicks on "Create" button
        When User configures operation with following details
            | Name          | Path         | SuccessResponse       |
            | getMemberByID | /member/{id} | {"status": "success"} |
        And User clicks on "Create" button to create operation
        When User adds a new data source with following details
            | Type     | Name     | ServiceProvider |
            | Rest API | MemberDS | MemberService   |
        And User creates data list with following details
            | Name          | Service | Operation     |
            | getMemberByID | service | getMemberByID |
        When User creates app source with following details
            | Type    | SourceName      | Group     | DataSource |
            | Service | MemberAppSource | GroupName | MemberDS   |
        And User uploads member details file
        And User clicks on "Next" button
        When User creates a new existing app
        Then User verifies the app creation is successful
        And User will "Logout" from "Page" the current session