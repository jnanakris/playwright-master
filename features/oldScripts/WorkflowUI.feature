Feature: Konfig Workflow UI

    @workflow_Admin @WFPOC
    #Created By: Mary
    #Created on : 01/25/2023
    Scenario: Initial use case to demonstrate group and App creation

        #CreateGroup
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "Usecase_TestData/WFPOC" json file in "WorkFlow UI" screen
        Then User will open "GroupName" group in "HomePage" screen
        # To Create an Application
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        Then User see text "Front Office" in "FO" in "Page" screen
       #  To Design Front Office
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X   | Y  | FieldName            | FieldLabel | Title                | Action | Status |
            | Container | 125 | 90 | Personal Information |            | Personal Information |        |        |
        When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget        | X   | Y   |
            | Personal Info | 850 | 500 |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName  | FieldLabel | Action | Status |
            | Text Input | 275 | 200 | First Name | First Name |        |        |
            | Text Input | 475 | 200 | Last Name  | Last Name  |        |        |
            | Number     | 275 | 450 | Number     | Number     |        |        |
            | Button     | 675 | 450 | Submit     | Submit     | Submit | Save   |
        And User make "First Name" field as require field in "UniqueWidgetFields" screen
        And User make "Last Name" field as require field in "UniqueWidgetFields" screen
        Then User click "Number" Inputs and choose clear button in "UniqueWidgetFields" screen
        # To add Front Office Agent
        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
        # To Design Front Office
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User see text "Back Office" in "BO" in "Page" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget               | X   | Y  |
            | Personal Information | 200 | 90 |
        Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget      | X   | Y   | FieldName   | FieldLabel  | ValuesAlignment    | ValueCount|Value1 | Value2 |
            | Text Input  | 275 | 300 | Father Name | Father Name |                    |           |       |        |
            | Text Input  | 475 | 300 | Mother Name | Mother Name |                    |           |       |        |
            | Radio Group | 670 | 300 | Gender      | Gender      | ValueAlignVertical |    2      | Male  | Female |
        # # And User write "Front Office" widgets in "FrontOffice_Widgets" in "UniqueWidgetFields" screen
        # # And User write "Back Office" widgets in "BackOffice_Widgets" in "UniqueWidgetFields" screen

        # # To add Back Office roles
        # # Edit existing role
        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        # # Add a new role
        Then User "Add" the "Operations" role and add "Operations" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        #To Add the required tasks onto the workflow Designer
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 230 | 250 |
            | End    | 869 | 416 |
        #  To Configure the Task Name
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName           | Role                | noOfActions | Action1 | Action1Status | Action2 | Action2Status |
            | Task   | 500 | 250 | Review Transaction | Application Manager | 2           | Accept  | In Progress     | Reject  | In Progress     |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName           | Role       | noOfActions | Action1 | Action1Status |
            | Task   | 765 | 248 | Secondary Review   | Operations | 1           | Accept  | In Progress   | 
        # To connect the tasks present on the workflow designer canvas
        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source             | Action | Target             |
            | Start              |        | Review Transaction |
            | Review Transaction | Accept | Secondary Review   |
            | Review Transaction | Reject | End                |
            | Secondary Review   | Accept | End                |
        Then User click on "button" "Save" in "workflowDesigner" screen
        #  To validate Version Management
        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        #  To validate Preview
        And User validate Payload app opening in a new tab


    # # @workflow @WFPOC
    # # Scenario Outline: Verify konfig workflow UI with Accept scenario
        # And User get the Test data from "Usecase_TestData/WFPOC" json file in "WorkFlow UI" screen
        Given user login to payload application with "Finlevit_payload" with "1" agent
        # And User should see all the "Front office" fields "FrontOffice_Widgets" in payload screen
        Then User click on "button" "Submit_btn" in "payload" screen
        And User see text "Failed to validate:  First Name" in "Pagelevel_alert_messgae" in "payload" screen
        And User see text "First Name is required" in "FirstName_field_require_error" in "payload" screen
        And User see text "Last Name is required" in "LastName_field_require_error" in "payload" screen
        And User enter text "<FirstName>" in "FirstName" in "payload" screen
        Then User click on "button" "Submit_btn" in "payload" screen
        And User see text "Failed to validate:  Last Name" in "Pagelevel_alert_messgae" in "payload" screen
        And User enter text "<LastName>" in "LastName" in "payload" screen
        Then User click on "button" "Submit_btn" in "payload" screen
        And User get Transaction Id and save it in json file
        Given user login to workflow UI "Finlevit_workflow" with "1" "AppManager" credentials
        Then User will open "GroupName" group in "HomePage" screen
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "5000"
        And User validate Transaction table header under "Team Task" in "WorkFlow UI" screen
        | SLA | Transaction Id | Task Name | Priority | Created At | Submitted By | Last Updated By | Last Updated At | Assigned To |
        And As "Agent" user verify Task "1" Details under "Team Task" in "WorkFlow UI" screen
    Then Based on the Task assigned to person logout or continue with the same user in "WorkFlow UI" screen for "Application_Name"
        And User validate Transaction table header under "My Task" in "WorkFlow UI" screen
        | SLA | Transaction Id | Task Name | Priority | Created At | Submitted By | Last Updated By | Last Updated At | Assigned To |
        And As "Application Manager" user verify Task "1" Details under "My Task" in "WorkFlow UI" screen
        Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
        And User validate left side menu options for the Task in "WorkFlow UI" screen
        And User should see all the "Back office" fields "BackOffice_Widgets" in payload screen
        And User validate "Text Input" widget "First Name" is "<FirstName>" in "WorkFlow UI" screen
        And User validate "Text Input" widget "Last Name" is "<LastName>" in "WorkFlow UI" screen
        And User Fill "<Father Name>" in "Text Input" widget "Father Name" in "WorkFlow UI" screen
        And User Fill "<Mother Name>" in "Text Input" widget "Mother Name" in "WorkFlow UI" screen
        And User Fill "<Gender>" in "Radio Group" widget "Gender" in "WorkFlow UI" screen
        And User Fill "<Number>" in "Number" widget "Number" in "WorkFlow UI" screen
        # And User wait for "5000"
        Then User validate Task "1" Actions and select "Accept" action in "WorkFlow UI" screen
        And As "Agent" user verify Task "2" Details under "Team Task" in "WorkFlow UI" screen
    Then Based on the Task assigned to person logout or continue with the same user in "WorkFlow UI" screen for "Application_Name"
        And As "Operations" user verify Task "2" Details under "My Task" in "WorkFlow UI" screen
        Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
        And User validate left side menu options for the Task in "WorkFlow UI" screen
        And User should see all the "Back office" fields "BackOffice_Widgets" in payload screen
        And User validate "Text Input" widget "First Name" is "<FirstName>" in "WorkFlow UI" screen
        And User validate "Text Input" widget "Last Name" is "<LastName>" in "WorkFlow UI" screen
        And User validate "Text Input" widget "Father Name" is "<Father Name>" in "WorkFlow UI" screen
        And User validate "Text Input" widget "Mother Name" is "<Mother Name>" in "WorkFlow UI" screen
        And User validate "Number" widget "Number" is "<Number>" in "WorkFlow UI" screen
        And User validate "Radio Group" widget "Gender" is "<Gender>" in "WorkFlow UI" screen
        Then User validate Task "2" Actions and select "Accept" action in "WorkFlow UI" screen
        And User wait for "5000"
        And User validate Transaction details are removed from "Team Task" and it is displaying under "History" on the successful workflow completion in "WorkFlow UI" screen
        And User validate Transaction table header under "History" in "WorkFlow UI" screen
        | Transaction Id | Created At | Submitted By | Last Updated By | Last Updated At |
        Then User will "Logout" from "Page" the current session
        And User wait for "5000"

         Examples:
           | FirstName   | LastName | Father Name| Mother Name|Gender |Number   |
           | Scott       | Dale     | Father     |   Mother   |Male   |987654321|

     @workflow @WFPOCReject
    Scenario Outline: Verify konfig workflow UI with Reject scenario
        And User get the Test data from "Usecase_TestData/WFPOC" json file in "WorkFlow UI" screen
        Given user login to payload application with "Finlevit_payload" with "1" agent
        # And User should see all the "Front office" fields "FrontOffice_Widgets" in payload screen
        Then User click on "button" "Submit_btn" in "payload" screen
        And User see text "Failed to validate:  First Name" in "Pagelevel_alert_messgae" in "payload" screen
        And User see text "First Name is required" in "FirstName_field_require_error" in "payload" screen
        And User see text "Last Name is required" in "LastName_field_require_error" in "payload" screen
        And User enter text "<FirstName>" in "FirstName" in "payload" screen
        Then User click on "button" "Submit_btn" in "payload" screen
        And User see text "Failed to validate:  Last Name" in "Pagelevel_alert_messgae" in "payload" screen
        And User enter text "<LastName>" in "LastName" in "payload" screen
        Then User click on "button" "Submit_btn" in "payload" screen
        And User get Transaction Id and save it in json file
        Given user login to workflow UI "Finlevit_workflow" with "1" "AppManager" credentials
        Then User will open "GroupName" group in "HomePage" screen
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "5000"
        And User validate Transaction table header under "Team Task" in "WorkFlow UI" screen
        | SLA | Transaction Id | Task Name | Priority | Created At | Submitted By | Last Updated By | Last Updated At | Assigned To |
        And As "Agent" user verify Task "1" Details under "Team Task" in "WorkFlow UI" screen
    Then Based on the Task assigned to person logout or continue with the same user in "WorkFlow UI" screen for "Application_Name"
        And User validate Transaction table header under "My Task" in "WorkFlow UI" screen
        | SLA | Transaction Id | Task Name | Priority | Created At | Submitted By | Last Updated By | Last Updated At | Assigned To |
        And As "Application Manager" user verify Task "1" Details under "My Task" in "WorkFlow UI" screen
        Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
        And User validate left side menu options for the Task in "WorkFlow UI" screen
        And User should see all the "Back office" fields "BackOffice_Widgets" in payload screen
        And User validate "Text Input" widget "First Name" is "<FirstName>" in "WorkFlow UI" screen
        And User validate "Text Input" widget "Last Name" is "<LastName>" in "WorkFlow UI" screen
        And User Fill "<Father Name>" in "Text Input" widget "Father Name" in "WorkFlow UI" screen
        And User Fill "<Mother Name>" in "Text Input" widget "Mother Name" in "WorkFlow UI" screen
        And User Fill "<Gender>" in "Radio Group" widget "Gender" in "WorkFlow UI" screen
        And User Fill "<Number>" in "Number" widget "Number" in "WorkFlow UI" screen
        # And User wait for "5000"
        Then User validate Task "1" Actions and select "Reject" action in "WorkFlow UI" screen
        And User wait for "5000"
        And User validate Transaction details are removed from "Team Task" and it is displaying under "History" on the successful workflow completion in "WorkFlow UI" screen
        And User validate Transaction table header under "History" in "WorkFlow UI" screen
        | Transaction Id | Created At | Submitted By | Last Updated By | Last Updated At |

         Examples:
           | FirstName   | LastName | Father Name| Mother Name|Gender |Number   |
           | Tom         | Hanks    | Father     |   Mother   |Male   |987654321|
       
