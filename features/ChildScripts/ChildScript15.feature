Feature: Dropdown, Radio button, and Checkbox group with the Labels and Value configuration with response mapping

    @ChildScript
    @ChildScript15
    @labelsandValues
    #Created By: Mohan.S
    Scenario: use case to demonstrate and validate the response mapping for Dropdown, Radio button, and Checkbox group
        #CreateGroup
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "Usecase_TestData/ChildScript15" json file in "WorkFlow UI" screen
        Then User will open "GroupName" group in "HomePage" screen
        Then User click on "button" "group_settings" in "Groups" screen
        Then User click on "button" "dataSources" in "onLoadTrigger" screen
        And User get unique field in Data Source "EmployeeDetails" in "onLoadTrigger" screen and save it in "EmpID"
        Then User will open "GroupName" group in "HomePage" screen
        # To Create an Application
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        Then User see text "Front Office" in "FO" in "Page" screen
        And User wait until the spinner disappears
        # To Design Front Office
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget   | X   | Y  | FieldName | FieldLabel | OptionType    | InputType     | ValueCount | Label1 | Value1 | Label2 | Value2 | Label3 | Value3 | Label4 | Value4 |
            | Dropdown | 100 | 50 | Pin       | Pin        | ManualOptions | Labels&Values | 4          | mross  | mross  | agreen | agreen | asong  | asong  | ayoung | ayoung |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X   | Y   | FieldName            | Title                |
            | Container | 100 | 200 | PersonalInformation | Personal Information |
        When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget               | X    | Y   |
            | Personal Information | 900 | 500 |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget      | X   | Y   | FieldName  | FieldLabel | ValuesAlignment      | InputType     | ValueCount | Value1 | Label1 | Label2 | Value2 |
            | Text Input  | 150 | 300 | FirstName | First Name |                      |               |            |        |        |        |        |
            | Text Input  | 150 | 400 | LastName  | Last Name  |                      |               |            |        |        |        |        |
            | Radio Group | 400 | 300 | Gender     | Gender     | ValueAlignHorizontal | Labels&Values | 2          | Male   | M      | F      | Female |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget   | X   | Y   | FieldName  | FieldLabel | OptionType    | InputType     | ValueCount | Label1 | Value1   | Label2 | Value2   | Label3 | Value3   | Label4 | Value4   |
            | Dropdown | 650 | 300 | EmployerID | EmployerID | ManualOptions | Labels&Values | 2          | 00005  | emp00005 | 00007  | emp00007 | 00010  | emp00010 | 0011   | emp00011 |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget         | X   | Y   | FieldName          | FieldLabel | ValuesAlignment      | InputType     | ValueCount | Value1 | Label1 | Value2 | Label2 | Value3 | Label3 |
            | Checkbox Group | 900 | 300 | CountryOfResidence | Country    | ValueAlignHorizontal | Labels&Values | 3          | AL     | AL     | US     | US     | AT     | AT     |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X   | Y   | FieldName | FieldLabel | Action | Status |
            | Button | 675 | 600 | Submit    | Submit     | Submit | Save   |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X   | Y   | FieldName | FieldLabel | Action | Status |
            | Button | 475 | 600 | Logout    | Logout     | Logout | Save   |
        
        And User create Onload Triggers with Response Mapping "addOnloadTrigger" in "onLoadTrigger" screen
            | Name                | Description         | DataSource      | DataList                  | Type    | Pin    | uniqueField | uniqueFieldValue |
            | Get EmployeeDetails | Get EmployeeDetails | EmployeeDetails | Get By Id EmployeeDetails | session | userId | EmpID       | userId           |
        Then User will create transformation rule for "Response Mapping" "Save EmployeeName" and connect Input and Output nodes in "transformation" screen
            | Destination        | Source             |
            | Pin                | Pin                |
            | EmployerID         | EmployerID         |
            | FirstName         | FirstName          |
            | LastName          | LastName           |
            | Gender             | Gender             |
            # | CountryOfResidence | CountryofResidence |
        
        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget               | X   | Y   |
            | PersonalInformation | 100 | 200 |
            | Pin                  | 100 | 50  |
        Then User click on "button" "CanvasSave" in "UniqueWidgetFields" screen
        # And User write "Front Office" widgets in "FrontOffice_Widgets" in "UniqueWidgetFields" screen
        # And User write "Back Office" widgets in "BackOffice_Widgets" in "UniqueWidgetFields" screen

        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 150 | 225 |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
            | Task   | 400 | 150 | Review   | Application Manager | 1           | Accept  | In Progress   | 1        | 0       |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | End    | 950 | 225 |
        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source | Action | Target |
            | Start  |        | Review |
            | Review | Accept | End    |
        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        #  To validate Preview
        And User validate Payload app opening in a new tab
        # Payload Validation
        Given user login to payload application with "Finlevit_payload" with "1" agent
        And User wait for "2000"
        And User validate "Text Input" widget "First Name" is not empty in "payload" screen
        And User validate "Radio Group" widget "Gender" is not empty in "payload" screen
        And User validate "Dropdown" widget "EmployerID" is not empty in "payload" screen
        And User validate "Dropdown" widget "Pin" is not empty in "payload" screen
        Then User click on "button" "Submit_btn" in "payload" screen
        And User get Transaction Id and save it in json file
        # #WorkflowUI
        Given user login to workflow UI "Finlevit_workflow" with "1" "AppManager" credentials
        And User wait until the "Filter Transaction id" appears in "WorkFlow UI" screen
        Then User click on "Button" "Home" in "HomePage" screen
        Then User will open "GroupName" group in "HomePage" screen
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "5000"
        # And User validate Transaction table header under "Team Task" in "WorkFlow UI" screen
        #     | SLA | Transaction Id | Task Name | Priority | Created At | Submitted By | Last Updated By | Last Updated At | Assigned To |
        And As "Agent" user verify Task "1" Details under "Team Task" in "WorkFlow UI" screen
    Then Based on the Task assigned to person logout or continue with the same user in "WorkFlow UI" screen for "Application_Name"
        # And User validate Transaction table header under "My Task" in "WorkFlow UI" screen
        #     | SLA | Transaction Id | Task Name | Priority | Created At | Submitted By | Last Updated By | Last Updated At | Assigned To |
        And As "Application Manager" user verify Task "1" Details under "My Task" in "WorkFlow UI" screen
        Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
        And User validate left side menu options for the Task in "WorkFlow UI" screen
        And User wait for "5000"
        And User validate "Text Input" widget "First Name" is not empty in "payload" screen
        And User validate "Radio Group" widget "Gender" is not empty in "payload" screen
        And User validate "Dropdown" widget "EmployerID" is not empty in "payload" screen
        And User validate "Dropdown" widget "Pin" is not empty in "payload" screen
        And User validate left side menu options for the Task in "WorkFlow UI" screen
        Then User validate Task "1" Actions and select "Accept" action in "WorkFlow UI" screen
        And User validate Transaction details are removed from "Team Task" in "WorkFlow UI" screen
        And User validate Transaction details are removed from "Team Task" and it is displaying under "History" on the successful workflow completion in "WorkFlow UI" screen
        # And User validate Transaction table header under "History" in "WorkFlow UI" screen
        #     | Transaction Id | Created At | Submitted By | Last Updated By | Last Updated At |
        Then User will "Logout" from "Page" the current session
        And User wait for "5000"