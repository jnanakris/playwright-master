Feature: Cover all Columns in AdvanceTable
    # @ChildScript
    @ChildScript45
    @ColumnsAdvTable
    #Createdby: Mohan S


    Scenario: Use case to cover all the columns in AdvanceTable
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "Usecase_TestData/ChildScript45" json file in "WorkFlow UI" screen
        And User will open "GroupName" group in "HomePage" screen
        # To Create an Application
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "2000"

        # widget
        And User Drag and Drop below widgets in "CanvasBody" in "AdvanceTable" screen
            | Widget | X   | Y   | Name            |
            | Table  | 180 | 200 | EmployeeRecords |
        When User expand "Table" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget  | X    | Y   |
            | Actions | 1000 | 600 |
        And User wait for "3000"
        Then User double click on "widget" "AdvanceTableEdit" in "AdvanceTable" screen
        Then User click on "button" "COLUMNS" in "AdvanceTable" screen

        When User click "Advance Table" and add below columns in "AdvanceTable" screen
            | Name     | Alignment             | ColumnType | OptionType    | FieldLabel | ValueCount | Value1 | Value2 | Value3 | Value4 |
            | UniqueID | ColumnAlignmentCenter | Dropdown   | ManualOptions | UniqueID   | 4          | M123   | F363   | G23623 | K363   |
        When User click "Advance Table" and add below columns in "AdvanceTable" screen
            | Name     | Alignment             | ColumnType | FieldLabel |
            | FullName | ColumnAlignmentCenter | Text Input | Full Name  |
        When User click "Advance Table" and add below columns in "AdvanceTable" screen
            | Name | Alignment             | ColumnType | FieldLabel |
            | DOB  | ColumnAlignmentCenter | Date       | DOB        |
        When User click "Advance Table" and add below columns in "AdvanceTable" screen
            | Name   | Alignment             | ColumnType  | FieldLabel | NoofInput | Value1 | Value2 |
            | Gender | ColumnAlignmentCenter | Radio Group | Gender     | 2         | Male   | Female |
        When User click "Advance Table" and add below columns in "AdvanceTable" screen
            | Name   | Alignment             | ColumnType | FieldLabel | TypeOfFormat | CurrencyCountry |
            | Salary | ColumnAlignmentCenter | Number     | Salary     | Currency     | United States   |
        When User click "Advance Table" and add below columns in "AdvanceTable" screen
            | Name         | Alignment             | ColumnType | FieldLabel     |
            | IsUSResident | ColumnAlignmentCenter | Checkbox   | Is US Resident |
            | Email        | ColumnAlignmentCenter | Email      | Email          |
        When User click "Advance Table" and add below columns in "AdvanceTable" screen
            | Name           | Alignment             | ColumnType | FieldLabel      |
            | AddressDetails | ColumnAlignmentCenter | Modal      | Address Details |
        Then User click on "Button" "WidgetSave" in "UniqueWidgetFields" screen
        And User wait for "2000"
        Then User click on "button" "AddressDetail" in "UniqueWidgetFields" screen
        And User wait for "2000"
        And User Drag and Drop below widgets in "ModalBody" in "UniqueWidgetFields" screen
            | Widget  | X   | Y  | FieldName | FieldLabel |
            | Address | 100 | 50 | Address   | Address    |
        Then User click on "Button" "ModalClose" in "AdvanceTable" screen
        Then User click on "Button" "CanvasSave" in "UniqueWidgetFields" screen
        When User make Advance table "Email" cloumn field as require field in "AdvanceTable" screen
        And User wait for "5000"
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X   | Y   | FieldName | FieldLabel | Action | Status |
            | Button | 675 | 800 | Submit    | Submit     | Submit | Save   |
        # # And User write "Front Office" widgets in "FrontOffice_Widgets" in "UniqueWidgetFields" screen
        # Edit existing role
        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
        # To Design Back Office
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User see text "Back Office" in "BO" in "Page" screen
        # Drag the Front Office widgets onto Back office Canavas
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget          | X  | Y  |
            | EmployeeRecords | 50 | 50 |
        # # And User write "Back Office" widgets in "BackOffice_Widgets" in "UniqueWidgetFields" screen

        # Edit existing role
        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        # To Add the required tasks onto the workflow Designer
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 230 | 250 |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
            | Task   | 500 | 250 | Review   | Application Manager | 1           | Accept  | In Progress   | 1        | 0       |
        And User will Edit the task "Review" and add Followup Task in "tasks" page
            | TaskName          | Role                | WaitTime | Frequency | WhentoStart |
            | Validate Followup | Application Manager | 1        | 1         | 1           |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | End    | 745 | 250 |
        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source | Action | Target |
            | Start  |        | Review |
            | Review | Accept | End    |
        Then User click on "button" "Save" in "workflowDesigner" screen
        #  To validate Version Management
        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        #  To validate Preview
        And User validate Payload app opening in a new tab
        # Payload1
        Given user login to payload application with "Finlevit_payload" with "1" agent
        When User click on "AddRow" "Advanced table add new row icon" in "payload" screen
        When User select drop down option "M123" in "AdvanceTableDropDownUniqueId" in "payload" screen
        When User Fill "Mohan S" in "AdvanceTableFullName" in "payload" screen
        Then User click on "DOB" "AdvanceTableDOB" in "payload" screen
        And User enter text "01/01/1999" in "AdvanceTableDOB" in "payload" screen
        When User click on "Male" "AdvanceTableRadiGroupMale" in "payload" screen
        When User Fill "3563636" in "AdvanceTableSalary" in "payload" screen
        When User click on "IsUSCitizen" "AdvanceTableCheckbox" in "payload" screen
        Then User click on "button" "AddressDetail" in "UniqueWidgetFields" screen
        And User enter "number" in "Address" with "3" characters
        And User wait for "1000"
        Then User select on "Address" "SelectFirstAddress" in "payload" screen
        Then User click on "Button" "ModalClose" in "AdvanceTable" screen
        When User click on "Save" "Advanced table first row save icon" in "payload" screen
        When User see text "Email is required" in "AdvanceTableEmailVAlidation" in "payload" screen
        And User wait for "2000"
        When User Fill "KonfigTest@test.com" in "AdvanceTableEmail" in "payload" screen
        When User click on "Save" "Advanced table first row save icon" in "payload" screen
        And User wait for "5000"
        Then User click on "Button" widget "Submit" in "payload" screen
        And User get Transaction Id and save it in json file
        #WorkFlow UI
        Given user login to workflow UI "Finlevit_workflow" with "1" "AppManager" credentials
        And User wait until the "Filter Transaction id" appears in "WorkFlow UI" screen
        Then User click on "Button" "Home" in "HomePage" screen
        Then User will open "GroupName" group in "HomePage" screen
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "5000"
        And As "Agent" user verify Task "1" Details under "Team Task" in "WorkFlow UI" screen
        Then Based on the Task assigned to person logout or continue with the same user in "WorkFlow UI" screen for "Application_Name"
        Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
        Then User validate Task "1" Actions and select "Accept" action in "WorkFlow UI" screen
        And User wait for "5000"
        And User validate Transaction details are removed from "Team Task" in "WorkFlow UI" screen
        Then User will "Logout" from "Page" the current session
