Feature: Mouse hover on all the icons at app level

        /*
        created by:Mohan.s
        Date: 18Jan23
        */

    @appValidation
    
    Scenario Outline: Validate App level
        Given user login to "<url>" with "<user>" credentials
        Then User click on "button" "SearchGroup" in "ExistingGroup" screen
        And User enter text "<groupName>" in "SearchBar" in "ExistingGroup" screen
        Then User click on "MohanGroup" "MohanGroup" in "ExistingGroup" screen
        Then User click on "TestApp" "APP" in "ExistingGroup" screen
        When User mouseover "Preview" in "Page" screen
        Then User see text "Preview" in "PreviewTooltip" in "Page" screen
        When User mouseover "Design" in "Page" screen
        Then User see text "Design" in "DesignTooltip" in "Page" screen
        When User mouseover "Roles" in "Page" screen
        Then User see text "Roles" in "RolesTooltip" in "Page" screen
        When User mouseover "VersionManagement" in "Page" screen
        Then User see text "Version Management" in "VersionTooltip" in "Page" screen
        When User mouseover "Settings" in "Page" screen
        Then User see text "Settings" in "SettingsTooltip" in "Page" screen
        When User mouseover "Logout" in "Page" screen
        Then User see text "Logout" in "LogoutTooltip" in "Page" screen
        When User mouseover "Admin" in "Page" screen
        Then User see text "Admin" in "AdminTooltip" in "Page" screen
        Then User see text "Front Office" in "FO" in "Page" screen





        Examples:
            | url            | user       | groupName   |
            | Finlevit_admin | admin_user | Mohan Group |

    @StaticApplication
    Scenario Outline: Validate Static Application
       #CreateGroup
        Given user login to "Finlevit_admin" with "Admin" credentials
        And User get the Test data from "Usecase_TestData/ChildScript81" json file in "WorkFlow UI" screen
        Then User will open "GroupName" group in "HomePage" screen
        And User wait for "5000"
        # App
        Then User will create "Static" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "3000"
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 150 | 225 |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget   | X   | Y   | TaskName      | SuccesStatus | FailedStatus | FailureTaskRole     | DataSource      | DataList             |
            | API Task | 300 | 200 | Create Record | In Progress  | In Progress  | Application Manager | EmployeeDetails | Save EmployeeDetails |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X    | Y   |
            | End    | 500 | 580 |
        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source        | Action  | Target        |
            | Start         |         | Create Record |
            | Create Record | Success | End       |
        Then User click on "button" "Save" in "workflowDesigner" screen
        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        
