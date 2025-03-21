Feature: Test if user is able to login create an app create a workflow and publish the app
 
    @RS
    @RS1
    @AdminLogin
    Scenario Outline: Use case to demonstrate On change Populate action and configure data population for BO fields

        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "RefinedScripts_TestData/Login" json file in "Admin" screen
        Then User will open "GroupName" group in "HomePage" screen
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        # And User wait until the spinner disappears
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget       | X    | Y   | FieldName   | FieldLabel   | PlaceHolder        |
            | Text Input   | 500  | 300 | Name        | Name         |                    |
            | Email        | 800  | 300 | Email       | Email        | example@domain.com |
            | Phone Number | 1100 | 300 | PhoneNumber | Phone Number |                    |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X   | Y   | FieldName | FieldLabel | Action | Status |
            | Button | 675 | 700 | Submit    | Submit     | Submit | Save   |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget      | X   | Y   | FieldName | FieldLabel    |
            | Date Picker | 500 | 800 | DOB       | Date of Birth |
        When User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget   | X   | Y | FieldName | FieldLabel  | OptionType    | ValueCount | Value1 | Value2 | Value3 | Value4 |
            | Dropdown | 900 | 8 | UserNames | Users Names | ManualOptions | 4          | mross  | thanks | agreen | efrank |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget      | X   | Y    | FieldName | FieldLabel | ValuesAlignment      | ValueCount | Value1    | Value2    |
            | Radio Group | 800 | 1000 | JobType   | Job Type   | ValueAlignHorizontal | 2          | Full Time | Part Time |
        Then User clicks on "AutoAlign" in "frontOffice" screen
        Then User click on "span" "Save" in "Page" screen
        And User wait for "1000"
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget      |
            | Name        |
            | Email       |
            | PhoneNumber |
            | DOB         |
            | UserNames   |
            | JobType     |

        Then User clicks on "AutoAlign" in "backOffice" screen
        Then User click on "span" "Save" in "Page" screen
        And User wait for "5000"
        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        # Add a new role
        Then User "Add" the "Operations" role and add "Operations" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        # To Add the required tasks onto the workflow Designer
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 230 | 250 |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
            | Task   | 500 | 250 | Review   | Application Manager | 1           | Accept  | In Progress   | 1        | 0       |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | End    | 845 | 250 |

        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source | Action | Target |
            | Start  |        | Review |
            | Review | Accept | End    |
        Then User click on "button" "Save" in "workflowDesigner" screen
        #  To validate Version Management
        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen