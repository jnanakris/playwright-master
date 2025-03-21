Feature: Create Exsiting Application using MongoDB DataSource to Manual task

    @ChildScript75
    @ChildScript
    Scenario: Create Exsiting Application using MongoDB DataSource to Manual task

        #CreateGroup
        Given user login to "Finlevit_admin" with "Admin" credentials
        And User get the Test data from "Usecase_TestData/ChildScript75" json file in "WorkFlow UI" screen
        When User enter create group with "GroupName" and "GroupDescription" in "Groups" screen
        Then User click on "button" "group_settings" in "Groups" screen

        Then User add the "Generated APIs","MongoDB" Data resource name it as "MongoDB_PIAPI2" add DataList and "Select" ApplicationSourceSetup with below name service operation in "GroupSetting" screen
            | ListName                      | DataBase | CollectionName    | OperationType | ReturnSingleRecord | Query                    | UpdateQuery | ResponseJson | Parameters | DataType1 | Value1 |
            | Get All PI API for Automation | KON_API  | PI_API_AUTOMATION | FIND          |                    | #GetAllPiApiForAutomation |             | {}           |            |           |        |
        And User use below "Require Fields" when create app source setup in "appSourceSetup" screen
            |  |
        Then User will create app source setup with "Data List" in "appSourceSetup" screen
            | GroupName | DataResource   | DataList                      | SourceType | Frequency | CronExpression | SourceName |
            | GroupName | MongoDB_PIAPI2 | Get All PI API for Automation | Primary    | Cron      | 0 0/5 * * * *  | New        |
        Then User will open "GroupName" group in "HomePage" screen
        # App
        Then User will create "Existing" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "3000"
        When User click on "FrontOffice" "Click_FrontOffice" in "Application" screen
        Then User see text "Front Office" in "FO" in "Page" screen

        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User see text "Back Office" in "BO" in "Page" screen

        Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X  | Y  | FieldName | Title  |
            | Container | 50 | 50 | PI_API    | PI_API |
        When User expand below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X   | Y   |
            | PI_API | 900 | 850 |
        Then User click on "button" "FOFields" in "UniqueWidgetFields" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X   | Y   |
            | Pin       | 150 | 150 |
            | FirstName | 350 | 150 |
            | LastName  | 550 | 150 |
            | Phone     | 150 | 350 |
            | Email     | 350 | 350 |
            | Salary    | 550 | 350 |
            | Line1     | 150 | 550 |
            | State     | 350 | 550 |
        Then User click on "span" "Save" in "Page" screen

        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        # To Add the required tasks onto the workflow Designer
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 200 | 100 |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
            | Task   | 300 | 300 | Review   | Application Manager | 1           | Accept  | In Progress   | 1        | 0       |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | End    | 900 | 300 |
        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source | Action | Target |
            | Start  |        | Review |
            | Review | Accept | End    |
        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        Then user will clear browser cookies
        When User refresh the page screen

        # Workflow
        And User wait for "60000"
        And User wait for "60000"
        And User wait for "60000"
        And User wait for "60000"
        And User wait for "60000"
        Given user login to workflow UI "Finlevit_workflow" with "1" "AppManager" credentials
        And User wait until the "Filter Transaction id" appears in "WorkFlow UI" screen
        Then User click on "Button" "Home" in "HomePage" screen
        Then User will open "GroupName" group in "HomePage" screen
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "5000"
        Then User click on "Menu" "Team Task" in "WorkFlow UI" screen
        And User wait until the spinner disappears
        And User select "span" tag drop down option "Application Manager" in "Role Dropdown" in "WorkFlow UI" screen
        And User assign task to "1" user in "AppManager" in "WorkFlow UI" screen
        Then User click on "Menu" "My Task" in "WorkFlow UI" screen
        Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
        And User validate "Text Input" widget "Pin" is not empty in "WorkFlow UI" screen
        And User validate "Text Input" widget "FirstName" is not empty in "payload" screen
        And User validate "Text Input" widget "LastName" is not empty in "payload" screen
        Then User validate Task "1" Actions and select "Accept" action in "WorkFlow UI" screen
        Then User will "Logout" from "Page" the current session