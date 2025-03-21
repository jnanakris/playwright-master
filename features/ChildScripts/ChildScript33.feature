Feature: Validate Field Permissions

    @ChildScript
    @ChildScript33
    Scenario: Use case to validate that field permissions configured on the payload application widget are working as expected

        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "Usecase_TestData/ChildScript33" json file in "WorkFlow UI" screen
        Then User will open "GroupName" group in "HomePage" screen
        # To Create an Application
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "2000"
        And User add status and name as "Validate" and "No" endTask in "Status" screen
        Then User click on "FrontOffice" "Click_FrontOffice" in "Application" screen
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X  | Y  | FieldName     | Title                                  |
            | Container | 25 | 25 | ChildScript33 | Child Script 33 - Personal Information |
        When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget          | X    | Y   |
            | Child Script 33 | 1050 | 600 |

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName | FieldLabel |
            | Text Input | 50  | 125 | Pin       | Pin        |
            | Text Input | 300 | 125 | FirstName | First Name |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X  | Y   | FieldName | FieldLabel | PlaceHolder        |
            | Email  | 50 | 300 | Email     | Email      | example@domain.com |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget       | X   | Y   | FieldName   | FieldLabel   |
            | Phone Number | 300 | 300 | PhoneNumber | Phone Number |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X   | Y   | FieldName | FieldLabel | Action | Status   |
            | Button | 150 | 474 | Validate  | Validate   | Save   | Validate |
            | Button | 450 | 474 | Submit    | Submit     | Submit | Save     |
        Then User click on "span" "Save" in "Page" screen
        # # And User write "Front Office" widgets in "FrontOffice_Widgets" in "UniqueWidgetFields" screen
        # #add FO agent role
        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
        And User configure Field Permissions on widgets for "Agent" role "Validate" status in "FieldPermision" screen
            | fieldName | Permission |
            | Pin       | Disable    |
            | Email     | Disable    |
            | FirstName | Hide       |
        And User wait for "3000"
        Then User click on "FrontOffice" "Click_FrontOffice" in "Application" screen
        #Switch to BO
        And User wait for "3000"
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User see text "Back Office" in "BO" in "Page" screen
        And User add status and name as "BOValidate" and "No" endTask in "Status" screen
         And User wait for "1000"
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget        | X  | Y  |
            | ChildScript33 | 50 | 25 |
        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        # To Add the required tasks onto the workflow Designer
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 200 | 100 |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
            | Task   | 400 | 200 | Review   | Application Manager | 1           | Accept  | BOValidate    | 1        | 0       |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
            | Task   | 700 | 200 | Approve  | Application Manager | 1           | Accept  | In Progress   | 1        | 0       |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | End    | 900 | 300 |
        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source  | Action | Target  |
            | Start   |        | Review  |
            | Review  | Accept | Approve |
            | Approve | Accept | End     |
        And User configure Field Permissions on widgets for "Application Manager" role "Review-Accept" status in "FieldPermision" screen
            | fieldName | Permission |
            | Pin       | Disable    |
            | Email     | Disable    |
            | FirstName | Hide       |
        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        #  To validate Preview
        And User validate Payload app opening in a new tab
        Then User will "Logout" from "Page" the current session
        # Payload
        Given user login to payload application with "Finlevit_payload" with "1" agent
        #Enter Data
        And User enter "text" in "Pin" with "5" characters
        And User enter "text" in "First Name" with "7" characters
        And User enter "email" in "Email" with "5" characters
        And User enter "phoneNumber" in "Phone Number" with "10" characters
        When User click on "Button" widget "Validate" in "payload" screen

        #Validate Field Permissions
        Then User Verify field permissions are working as expected in "Payload" screen
            | fieldName  | Permission |
            | Pin        | Disable    |
            | Email      | Disable    |
            | First Name | Hide       |
        Then User click on "Button" widget "Submit" in "payload" screen
        And User get Transaction Id and save it in json file
        ## WF Validation
        Given user login to workflow UI "Finlevit_workflow" with "1" "AppManager" credentials
        And User wait until the "Filter Transaction id" appears in "WorkFlow UI" screen
        Then User click on "Button" "Home" in "HomePage" screen
        Then User will open "GroupName" group in "HomePage" screen
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "5000"
        And As "Agent" user verify Task "1" Details under "Team Task" in "WorkFlow UI" screen
        Then Based on the Task assigned to person logout or continue with the same user in "WorkFlow UI" screen for "Application_Name"
        And As "Application Manager" user verify Task "1" Details under "My Task" in "WorkFlow UI" screen
        Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
        Then User validate Task "1" Actions and select "Accept" action in "WorkFlow UI" screen
        And As "Agent" user verify Task "2" Details under "Team Task" in "WorkFlow UI" screen
        Then Based on the Task assigned to person logout or continue with the same user in "WorkFlow UI" screen for "Application_Name"
        And As "Application Manager" user verify Task "2" Details under "My Task" in "WorkFlow UI" screen
        Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
        #Validate Field Permissions
        Then User Verify field permissions are working as expected in "Payload" screen
            | fieldName  | Permission |
            | Pin        | Disable    |
            | Email      | Disable    |
            | First Name | Hide       |
        Then User will "Logout" from "Page" the current session