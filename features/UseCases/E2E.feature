Feature: Konfig e2e App with multiple widgets and add FO widgets to BO,design simple workflow and payload validation

    @sanityTestSuite
    @e2eApp @e2e
    #Created By: Mary
    #Created on : 01/25/2023
    Scenario Outline: Initial use case to demonstrate group and App creation

        #CreateGroup
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "Usecase_TestData/E2EFeature" json file in "WorkFlow UI" screen
        # When User enter create group with "GroupName" and "GroupDescription" in "Groups" screen
        Then User will open "GroupName" group in "HomePage" screen
        # To Create an Application
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        Then User see text "Front Office" in "FO" in "Page" screen
        #  To Design Front Office
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X   | Y  | FieldName            | FieldLabel | Title                | Action | Status |
            | Container | 125 | 90 | PersonalInformation |            | Personal Information |        |        |
        When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget        | X   | Y   |
            | Personal Info | 850 | 500 |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName | FieldLabel | Action | Status |
            | Text Input | 275 | 200 | FirstName | First Name |        |        |
            | Text Input | 475 | 200 | LastName  | Last Name  |        |        |
            | Number     | 275 | 450 | Number    | Number     |        |        |
            | Button     | 675 | 450 | Submit    | Submit     | Submit | Save   |
        And User make "First Name" field as require field in "UniqueWidgetFields" screen
        And User make "Last Name" field as require field in "UniqueWidgetFields" screen
        Then User click "Number" Inputs and choose clear button in "UniqueWidgetFields" screen
        Then User click "Number" and add tooltip as "<tooltip>" in "UniqueWidgetFields" screen
        # To add Front Office Agent
        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
        # To Design Front Office
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User see text "Back Office" in "BO" in "Page" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget               | X   | Y  |
            | PersonalInformation | 200 | 90 |
        Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget      | X   | Y   | FieldName  | FieldLabel  | ValuesAlignment    | ValueCount | Value1 | Value2 |
            | Text Input  | 275 | 300 | FatherName | Father Name |                    |            |        |        |
            | Text Input  | 475 | 300 | MotherName | Mother Name |                    |            |        |        |
            | Radio Group | 670 | 300 | Gender     | Gender      | ValueAlignVertical | 2          | Male   | Female |
        # # And User write "Front Office" widgets in "FrontOffice_Widgets" in "UniqueWidgetFields" screen
        # # And User write "Back Office" widgets in "BackOffice_Widgets" in "UniqueWidgetFields" screen

        # To add Back Office roles
        # Edit existing role
        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        # Add a new role
        Then User "Add" the "Operations" role and add "Operations" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        #To Add the required tasks onto the workflow Designer
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 230 | 250 |
            | End    | 845 | 250 |
        #  To Configure the Task Name
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName           | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
            | Task   | 500 | 250 | Review Transaction | Application Manager | 1           | Accept  | In Progress   | 1        | 0       |
        # To connect the tasks present on the workflow designer canvas
        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source             | Action | Target             |
            | Start              |        | Review Transaction |
            | Review Transaction | Accept | End                |
        Then User click on "button" "Save" in "workflowDesigner" screen
        #  To validate Version Management
        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        #  To validate Preview
        And User validate Payload app opening in a new tab
        Given user login to payload application with "Finlevit_payload" with "1" agent
        # And User should see all the "Front office" fields "FrontOffice_Widgets" in payload screen
        # And User should not see all the "Back office" fields "BackOffice_Widgets" in payload screen
        Then User click on "button" "Submit_btn" in "payload" screen
        And User see text "Failed to validate:  First Name" in "Pagelevel_alert_messgae" in "payload" screen
        And User see text "First Name is required" in "FirstName_field_require_error" in "payload" screen
        And User see text "Last Name is required" in "LastName_field_require_error" in "payload" screen
        And User enter text "<firstName>" in "FirstName" in "payload" screen
        Then User click on "button" "Submit_btn" in "payload" screen
        And User see text "Failed to validate:  Last Name" in "Pagelevel_alert_messgae" in "payload" screen
        And User enter text "<lastName>" in "LastName" in "payload" screen
        Then User click on "button" "Submit_btn" in "payload" screen
        # And User see text "This transaction is in progress, Modifications not allowed" in "Pagelevel_alert_messgae" in "payload" screen

        Examples:
            | tooltip | firstName | lastName |
            | Check   | Tom       | Hanks    |

    @e2eFrontoffice
    #Created By: Mary
    #Created on : 01/11/2023
    Scenario Outline: Verify front office design
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        #CreateGroup
        When User enter create group with "GroupName" and "GroupDescription" in "Groups" screen
        Then User will create "Existing" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        And User Drag and Drop below widgets in "frontoffice_canvas_body" in "widget" screen
            | Widget     | X   | Y   | FieldName           | Action | Status |
            | Container  | 200 | 90  | Personal Informaton |        |        |
            | Text Input | 375 | 200 | First Name          |        |        |
            | Text Input | 575 | 200 | Last Name           |        |        |
            | Button     | 700 | 450 | Submit              | Submit | Save   |
        And User make "First Name" field as require field in "widget" screen
        And User make "Last Name" field as require field in "widget" screen
        Then User click on "button" "roles_menu" in "Roles" screen
        Then User click on "button" "agent_edit_btn" in "Roles" screen
        And User select drop down option "Tom Hanks" in "create_app_Admins_Dropdown" in "Application" screen
        Then User click on "button" "create_app_Admins_OK_button" in "Application" screen
        Then User click on "button" "create_app_save_button" in "Application" screen



        Examples:
            | url            | user       | groupName     | groupDescription          | appName |
            | Finlevit_admin | admin_user | QA Automation | QA Automation Description | App     |


    @sanityTestSuite
    @e2eCreateGroup
    #Created By: Mary
    #Created on : 01/11/2023
    Scenario Outline: Create or open existing group
        And User get the Test data from "Usecase_TestData/E2EFeature" json file in "WorkFlow UI" screen
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        When User enter create group with "GroupName" and "GroupDescription" in "Groups" screen

        Examples:
            | url            | user       | GroupName | groupDescription | appName |
            | Finlevit_admin | admin_user | GroupName | Test             | App     |

    @e2eFrontofficeToBackoffice
    #Created By: Mohan
    Scenario Outline: Switch from FO to BO
        Given user login to "<url>" with "<user>" credentials
        Then User click on "button" "search_group" in "Groups" screen
        And User enter text "<groupName>" in "search_group_textbox" in "Groups" screen
        Then User click on "button" "select_first_group" in "Groups" screen
        Then User click on "button" "New_Application_button" in "Application" screen
        And User enter application name "<appName>" in "create_application_name" in "Application" screen
        Then User click on "radio button" "create_application_radio_newapp" in "Application" screen
        And User enter text "<appName>" in "create_application_description" in "Application" screen
        And User select drop down option "Tom Hanks" in "create_app_Admins_Dropdown" in "Application" screen
        Then User click on "button" "create_app_Admins_OK_button" in "Application" screen
        Then User click on "button" "create_app_save_button" in "Application" screen
        Then User click on "button" "search_application_textbox" in "Application" screen
        And User enter text "#Application_Name" in "search_application_textbox" in "Application" screen
        Then User click on "button" "select_first_application" in "Application" screen
        # Then User click on "button" "search_application_textbox" in "Application" screen
        # Then User click on "button" "APP" in "ExistingGroup" screen
        Then User see text "Front Office" in "FO" in "Page" screen
        And User Drag and Drop below widgets in "canvas_body" in "widget" screen
            | Widget     | X   | Y   | FieldName           |
            | Container  | 200 | 90  | Personal Informaton |
            | Text Input | 275 | 200 | First Name          |
            | Text Input | 475 | 200 | Last Name           |
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User Drag and Drop particular FO widgets in BO "canvas_body" in "widget" screen
            | Widget              | X   | Y  |
            | Personal Informaton | 200 | 90 |
        Then User click on "AllWidget" "BO_AllWidgets" in "widget" screen
        And User Drag and Drop in BO below widgets in "canvas_body" in "widget" screen
            | Widget      | X   | Y   | FieldName   | ValueCount | Value1 | Value2 |
            | Text Input  | 275 | 300 | Father Name |            |        |        |
            | Text Input  | 475 | 300 | Mother Name |            |        |        |
            | Radio Group | 600 | 300 | Gender      | 2          | Male   | Female |
        Then User click on "button" "roles_menu" in "Roles" screen
        Then User click on "button" "AppManager_edit_btn" in "Roles" screen
        And User select drop down option " Scott Dale" in "AddRoleMembers" in "Roles" screen
        Then User click on "button" "create_app_Manager_OK_button" in "Application" screen
        Then User click on "button" "create_app_save_button" in "Application" screen
        Then User click on "button" "Add_Role" in "Roles" screen
        And User enter text "<RoleName>" in "Add_Role_Name" in "Roles" screen
        And User enter text "<RoleDescription>" in "Add_Role_Description" in "Roles" screen
        And User select drop down option " Mike Ross" in "AddRoleMembers" in "Roles" screen
        Then User click on "button" "create_Role_OK_button" in "Roles" screen
        Then User click on "button" "create_Role_save_button" in "Roles" screen
        And User write Roles "App_Manager" from "AppManager_edit_btn" to JSON file
        And User write Roles "Operations" from "operations_edit_btn" to JSON file




        Examples:
            | url            | user       | groupName     | groupDescription          | appName | RoleName   | RoleDescription |
            | Finlevit_admin | admin_user | QA Automation | QA Automation Description | App     | Operations | Operations      |

    @e2eVerifyPublish
    #Created By: Mohan
    Scenario Outline: Veirfy and publish app
        Given user login to "<url>" with "<user>" credentials
        Then User click on "button" "search_group" in "Groups" screen
        And User enter text "<groupName>" in "search_group_textbox" in "Groups" screen
        Then User click on "button" "select_first_group" in "Groups" screen
        Then User click on "button" "APP" in "ExistingGroup" screen
        Then User see text "Front Office" in "FO" in "Page" screen
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        # Then User click on "button" "roles_menu" in "Roles" screen
        # Then User click on "button" "AppManager_edit_btn" in "Roles" screen
        # And User select drop down option " Scott Dale" in "AddRoleMembers" in "Roles" screen
        # # Then User click on "button" "create_app_Manager_OK_button" in "Application" screen
        # # Then User click on "button" "create_app_save_button" in "Application" screen
        # Then User click on "button" "Add_Role" in "Roles" screen
        # And User enter text "<RoleName>" in "Add_Role_Name" in "Roles" screen
        # And User enter text "<RoleDescription>" in "Add_Role_Description" in "Roles" screen
        # And User select drop down option " Mike Ross" in "AddRoleMembers" in "Roles" screen
        # Then User click on "button" "create_Role_OK_button" in "Roles" screen
        # Then User click on "button" "create_Role_save_button" in "Roles" screen
        # # And User write Roles "App_Manager" from "AppManager_edit_btn" to JSON file
        # And User write Roles "Operations" from "operations_edit_btn" to JSON file
        Then User click on "button" "VersionControl" in "Version" screen
        Then User click on "button" "Verify & Publish" in "Version" screen




        Examples:
            | url            | user       | groupName     | groupDescription          | RoleName   | RoleDescription |
            | Finlevit_admin | admin_user | QA Automation | QA Automation Description | Operations | Operations      |

    @e2eBackofficeWorkflow
    #Created By: Mani
    Scenario Outline:Add task in backoffice workflow
        Given user login to "<url>" with "<user>" credentials
        Then User click on "button" "search_group" in "Groups" screen
        And User enter text "<groupName>" in "search_group_textbox" in "Groups" screen
        Then User click on "button" "select_first_group" in "Groups" screen
        Then User click on "button" "New_Application_button" in "Application" screen
        And User enter application name "<appName>" in "create_application_name" in "Application" screen
        Then User click on "radio button" "create_application_radio_newapp" in "Application" screen
        And User enter text "<appName>" in "create_application_description" in "Application" screen
        And User select drop down option "Tom Hanks" in "create_app_Admins_Dropdown" in "Application" screen
        Then User click on "button" "create_app_Admins_OK_button" in "Application" screen
        Then User click on "button" "create_app_save_button" in "Application" screen
        Then User click on "button" "search_application_textbox" in "Application" screen
        And User enter text "#Application_Name" in "search_application_textbox" in "Application" screen
        Then User click on "button" "select_first_application" in "Application" screen
        Then User click on "tab" "Design" in "frontOffice" screen
        Then User click on "span" "BackOffice" in "frontOffice" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        # To Add the required tasks onto the workflow Designer
        Then User will Drag and Drop "tasks" on "BackOfficeCanvas"
            | Widget | X   | Y   |
            | Start  | 230 | 250 |
            | End    | 845 | 250 |
            | Task   | 500 | 250 |
        #  To Configure the Task Name
        And User enter text "<Task>" in "TaskNameInput" in "tasks" screen
        And User select drop down option "<Role>" in "RoleDropDown" in "tasks" screen
        And User enter text "<Action Name>" in "ActionNameInput" in "tasks" screen
        And User select drop down option "<Status>" in "ActionStatus" in "tasks" screen
        Then User click on "button" "Save" in "tasks" screen
        # To connect the tasks present on the workflow designer canvas
        Then User will connect "tasks" in "BackOfficeCanvas"
            | Widget    | X   | Y   |
            | StartTask | 505 | 255 |
            | TaskNode  | 847 | 255 |
        Then User click on "button" "Save" in "workflowDesigner" screen
        Examples:
            | url            | user       | groupName | groupDescription          | appName | Task               | Role  | Action Name | Status      |
            | Finlevit_admin | admin_user | TestGroup | QA Automation Description | App1    | Review Transaction | Agent | Approve     | In Progress |



    @e2ePreview
    #Created By: Mary
    #Created on : 01/25/2023
    Scenario Outline: Verify payload app is loading in new tab
        Given user login to "<url>" with "<user>" credentials
        Then User click on "button" "search_group" in "Groups" screen
        And User enter text "<groupName>" in "search_group_textbox" in "Groups" screen
        Then User click on "button" "select_first_group" in "Groups" screen
        Then User click on "button" "search_application_textbox" in "Application" screen
        And User enter text "#Application_Name" in "search_application_textbox" in "Application" screen
        Then User click on "button" "select_first_application" in "Application" screen
        # Then User click on "button" "Preview" in "Page" screen
        And User validate Payload app opening in a new tab



        Examples:
            | url            | user       | groupName     |
            | Finlevit_admin | admin_user | QA Automation |

