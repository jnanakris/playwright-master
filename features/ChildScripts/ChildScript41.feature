Feature: Application with on change action options and response mapping for FO fields in BO

    @sanityTestSuite
    @onchangeAction
    @ChildScript41 @ChildScript
    #Created By: Mohan.S
    Scenario: Use case to demonstrate onload triggers with onchange action options and response mapping for FO fields in BO

        #CreateGroup
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "Usecase_TestData/ChildScript41" json file in "WorkFlow UI" screen
        # # GroupSetting
        Then User will open "GroupName" group in "HomePage" screen
        And User wait for "5000"
        Then User click on "button" "group_settings" in "Groups" screen
        Then User click on "button" "dataSources" in "onLoadTrigger" screen
        And User get unique field in Data Source "Countries" in "onLoadTrigger" screen and save it in "CountryId"
        And User get unique field in Data Source "PI API for Automation" in "onLoadTrigger" screen and save it in "PIId"
        Then User will open "GroupName" group in "HomePage" screen
        # To Create an Application
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        Then User see text "Front Office" in "FO" in "Page" screen
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X   | Y  | FieldName | FieldLabel | Action | Status |
            | Button | 850 | 80 | Submit    | Submit     | Submit | Save   |
        # widget
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X   | Y   | FieldName    | Title         |
            | Container | 180 | 120 | PersonalInfo | Personal Info |
        When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget        | X    | Y   |
            | Personal Info | 1100 | 900 |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName | FieldLabel | PlaceHolder        | OptionType       | Action | Status |
            | Dropdown   | 400 | 110 | Pin       | Pin        |                    | ConfigureOptions |        |        |
            | Text Input | 210 | 200 | firstName | First Name |                    |                  |        |        |
            | Text Input | 400 | 200 | lastName  | Last Name  |                    |                  |        |        |
            | Text Input | 600 | 200 | pinNPIN   | PinNPIN    |                    |                  |        |        |
            | Email      | 210 | 350 | email     | Email      | example@domain.com |                  |        |        |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget       | X   | Y   | FieldName   | FieldLabel   |
            | Phone Number | 400 | 350 | phoneNumber | Phone Number |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget   | X   | Y   | FieldName          | FieldLabel           | OptionType       |
            | Dropdown | 210 | 500 | CountryOfResidence | Country Of Residence | ConfigureOptions |
            | Dropdown | 410 | 500 | States             | States               | ConfigureOptions |
        When User make below field as Read only in "UniqueWidgetFields" screen
            | Widget       |
            | First Name   |
            | Last Name    |
            | PinNPIN      |
            | Email        |
            | Phone Number |
        Then User click on "button" "CanvasSave" in "UniqueWidgetFields" screen
        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User see text "Back Office" in "BO" in "Page" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget       | X   | Y   |
            | PersonalInfo | 180 | 120 |
            | Pin          | 400 | 110 |

        # # To set Onload Triggers
        # And User create Onload Triggers with "1" Options Mapping "addOnloadTrigger" in "onLoadTrigger" screen
        #     | Name          | Description   | DataSource            | DataList                      | Field1               | Label1 | Value1 | DefaultKey1 | Defaultvalue1 |
        #     | Get Countries | Get Countries | Countries             | Get All Countries             | Country Of Residence | name   | iso2   | iso2        | US            |
        #     | Get Pins      | Get Pins      | PI API for Automation | Get All PI API for Automation | Pin                  | Pin    | Pin    | Pin         | mross         |

        And User create Onload Triggers with "1" Rule Options Mapping "addOnloadTrigger" in "onLoadTrigger" screen
            | Name          | Description   | DataSource            | DataList                      | Rule1 | Ref1 | RootKey1     | Field1             | Label1 | Value1 | DefaultValue1 |
            | Get Countries | Get Countries | Countries             | Get All Countries             | Rule1 | CN   |              | CountryOfResidence | name   | iso2   | US            |
            | Get Pins      | Get Pins      | PI API for Automation | Get All PI API for Automation | Rule1 | User | PersonalInfo | Pin                | Pin    | Pin    | mross         |
        And User wait for "2000"
        # To Configure a Trigger on a Dropdown
        Then User click on "tab" "Design" in "Page" screen
        And User create an Event Configuration in "EventConfigurations" screen
            | EventName        | EventType         | Widget | DataSource            | DataList                        | Type | UniqueField | Value |
            | Get By Id PI API | On Change Actions | Pin    | PI API for Automation | Get By Id PI API for Automation | ref  | PIId        | Pin   |
        Then User will create transformation rule for "Populate" "Get By Id PI API" and connect Input and Output nodes in "transformation" screen
            | Destination        | Source             |
            | pinNPIN            | Pin                |
            | firstName          | FirstName          |
            | lastName           | LastName           |
            | email              | Email              |
            | phoneNumber        | Phone              |
            | CountryOfResidence | CountryofResidence |
            | States             | State              |
        And User wait for "1000"

        # And User create event configuration with "1" Options Mapping "addOnloadTrigger" in "EventConfigurations" screen
        #     | EventName | EventType         | Widget             | DataSource | DataList                         | Type | UniqueField | paramValue         | Field1 | Label1 | Value1    | DefaultKey1 | Defaultvalue1 |
        #     | Get State | On Change Actions | CountryOfResidence | States     |   Get By Filter Field countryCode | ref  | CountryId   | CountryOfResidence | States | name   | stateCode | stateCode   | NC            |
        And User create event configuration Options Mapping with "1" Rule "addOnloadTrigger" in "EventConfigurations" screen
            | EventName | EventType         | Widget             | DataSource | DataList                         | Type | UniqueField | paramValue         | Rule1 | Ref1 | Field1 | Label1 | Value1    | DefaultValue1 |
            | Get State | On Change Actions | CountryOfResidence | States     |   Get By Filter Field countryCode | ref  | CountryId   | CountryOfResidence | Rule1 | ST   | States | name   | stateCode | NC            |

        And User write "Front Office" widgets in "FrontOffice_Widgets" in "UniqueWidgetFields" screen
        And User write "Back Office" widgets in "BackOffice_Widgets" in "UniqueWidgetFields" screen
        # To add Back Office roles
        # Edit existing role
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
        #  To validate Version Management
        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        #  To validate Preview
        And User validate Payload app opening in a new tab
        # Payload Validation
        Given user login to payload application with "Finlevit_payload" with "1" agent
        #Submit Transaction
        Then User click on "Button" widget "Submit" in "payload" screen
        And User get Transaction Id and save it in json file
        # WorkflowUI
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
        And User wait for "1000"
        And User validate "Text Input" widget "First Name" is not empty in "payload" screen
        And User validate "Text Input" widget "Last Name" is not empty in "payload" screen
        And User validate "Email" widget "Email" is not empty in "payload" screen
        And User validate "Phone Number" widget "Phone Number" is not empty in "payload" screen
        # Then User should have count "250" in "DropdownValues" in "payload" screen
        And User select "ayoung" in "Pin" dropdown in "payload" screen
        And User wait for "1000"
        And User wait until the spinner disappears
        And User wait for "1000"
        # And User select "China" in "countryDropdown" dropdown in "payload" screen
        # And User wait for "4000"
        # And User select "Beijing" in "States" dropdown in "payload" screen
        And User select drop down option "China" in "Country Of Residence" widget in "payload" screen
        And User wait for "5000"
        And User select drop down option "Beijing" in "States" widget in "payload" screen
        And User wait for "1000"
        Then User validate Task "1" Actions and select "Accept" action in "WorkFlow UI" screen
        And User wait for "1000"
        And User validate Transaction details are removed from "Team Task" and it is displaying under "History" on the successful workflow completion in "WorkFlow UI" screen
        Then User will "Logout" from "Page" the current session

        

