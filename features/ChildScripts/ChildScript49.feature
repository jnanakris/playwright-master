Feature: Application with on change action options and response mapping in FO

    @sanityTestSuite
    @onchangeAction
    @ChildScript49 @ChildScript
    #Created By: Mohan.S
    Scenario: Use case to demonstrate onload triggers with onchange action options and response mapping in FO

        #CreateGroup
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "Usecase_TestData/ChildScript49" json file in "WorkFlow UI" screen
        # GroupSetting
        Then User will open "GroupName" group in "HomePage" screen
        Then User click on "button" "group_settings" in "Groups" screen
        Then User click on "button" "dataSources" in "onLoadTrigger" screen
        And User get unique field in Data Source "Countries" in "onLoadTrigger" screen and save it in "CountryId"
        And User get unique field in Data Source "PI API for Automation" in "onLoadTrigger" screen and save it in "PIId"
        Then User will open "GroupName" group in "HomePage" screen
        # To Create an Application
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
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

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X   | Y   | FieldName | FieldLabel | Action | Status |
            | Button | 750 | 700 | submit    | Submit     | Submit | Save   |

        When User make below field as Read only in "UniqueWidgetFields" screen
            | Widget       |
            | First Name   |
            | Last Name    |
            | PinNPIN      |
            | Email        |
            | Phone Number |
        Then User click on "span" "Save" in "Page" screen

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
        Then User see text "Front Office" in "FO" in "Page" screen
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

        #  To add Front Office Agent
        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget       | X   | Y  |
            | PersonalInfo | 200 | 90 |

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
            | Task   | 400 | 150 | Review 1 | Application Manager | 1           | Accept  | In Progress   | 1        | 0       |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | End    | 950 | 225 |
        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source   | Action | Target   |
            | Start    |        | Review 1 |
            | Review 1 | Accept | End      |
        #  To validate Version Management
        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        #  To validate Preview
        And User validate Payload app opening in a new tab
        # Payload Validation
        Given user login to payload application with "Finlevit_payload" with "1" agent
        And User wait for "1000"
        And User validate "Text Input" widget "First Name" is not empty in "payload" screen
        And User validate "Text Input" widget "Last Name" is not empty in "payload" screen
        And User validate "Email" widget "Email" is not empty in "payload" screen
        And User validate "Phone Number" widget "Phone Number" is not empty in "payload" screen
        # Then User should have count "250" in "DropdownValues" in "payload" screen
        And User wait for "1000"
        # Then User should have count "33" in "DropdownValues" in "payload" screen
        And User select "ayoung" in "Pin" dropdown in "payload" screen
        And User wait for "3000"
        And User select "China" in "countryDropdown" dropdown in "payload" screen
        And User wait for "3000"
        Then User click on "button" "States" in "payload" screen
        # And User select " " in "States" dropdown in "payload" screen
        Then User click on "button" "Submit_btn" in "payload" screen
        And User wait for "1000"
        And User get Transaction Id and save it in json file

