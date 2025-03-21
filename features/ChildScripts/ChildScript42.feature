Feature: WidgetEvents covering serviceProvider Create,Populate,Update,Delete in FO

    @ChildScript
    @ChildScript42

    #Createdby: Mohan.S
    Scenario: Use case to demonstrate eventConfiguration for serviceProvider Create,Populate,Upate,Delete in FO

        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "Usecase_TestData/ChildScript42" json file in "WorkFlow UI" screen
        Then User will open "GroupName" group in "HomePage" screen
        Then User click on "button" "group_settings" in "Groups" screen
        Then User click on "button" "dataSources" in "onLoadTrigger" screen
        And User get unique field in Data Source "PI API for Automation" in "onLoadTrigger" screen and save it in "Pin"
        Then User will open "GroupName" group in "HomePage" screen
        # To Create an Application
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "2000"
        Then User see text "Front Office" in "FO" in "Page" screen
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X  | Y  | FieldName     | Title           |
            | Container | 25 | 25 | ChildScript11 | Child Script 11 |
        When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget          | X    | Y   |
            | Child Script 11 | 1050 | 600 |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget       | X   | Y   | FieldName   | FieldLabel   | PlaceHolder        |
            | Text Input   | 50  | 125 | Pin         | Pin          |                    |
            | Text Input   | 300 | 125 | FirstName   | First Name   |                    |
            | Text Input   | 550 | 125 | LastName    | Last Name    |                    |
            | Email        | 50  | 300 | Email       | Email        | example@domain.com |
            | Phone Number | 300 | 300 | PhoneNumber | Phone Number |                    |

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget       | X   | Y   | FieldName     | FieldLabel     | PlaceHolder        |
            | Email        | 50  | 650 | REmail       | R Email        | example@domain.com |
            | Phone Number | 300 | 650 | RPhoneNumber | R Phone Number |                    |

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X   | Y   | FieldName | FieldLabel | Action | Status |
            | Button | 75  | 500 | create    | Create     | None   | Save   |
            | Button | 250 | 500 | fetch     | Fetch      | None   | Save   |
            | Button | 450 | 500 | Update    | Update     | None   | Save   |
            | Button | 650 | 500 | Delete    | Delete     | None   | Save   |
            | Button | 750 | 125 | Refresh   | Refresh    | None   | Save   |


        Then User add toast message to "Create" button as "CreateRecord Completed" in "UniqueWidgetFields" pageScreen
        Then User add toast message to "Fetch" button as "Fetching Data is Success" in "UniqueWidgetFields" pageScreen
        Then User add toast message to "Update" button as "Update Record Completed" in "UniqueWidgetFields" pageScreen
        Then User add toast message to "Refresh" button as "Successfully Refreshed" in "UniqueWidgetFields" pageScreen
        Then User add toast message to "Delete" button as "Record Deleted permanently" in "UniqueWidgetFields" pageScreen

        # ServiceProvider-Save
        And User create an Event Configuration in "EventConfigurations" screen
            | EventName        | EventType         | Widget | DataSource            | DataList                   |
            | Save PI API Data | Service Providers | create | PI API for Automation | Save PI API for Automation |
        Then User will create transformation rule for "Service Provider" "Save PI API Data" and connect Input and Output nodes in "transformation" screen
            | Destination | Source      |
            | Pin         | Pin         |
            | FirstName   | FirstName   |
            | LastName    | LastName    |
            | Email       | Email       |
            | Phone       | PhoneNumber |
        #ServiceProvider-Update
        And User create an Event Configuration in "EventConfigurations" screen
            | EventName          | EventType         | Widget | DataSource            | DataList                           |
            | Update PI API Data | Service Providers | Update | PI API for Automation | Update By Id PI API for Automation |
        Then User will create transformation rule for "Service Provider" "Update PI API Data" and connect Input and Output nodes in "transformation" screen
            | Destination | Source      | UniqueField |
            | Pin         | Pin         | Yes         |
            | Pin         | Pin         |             |
            | FirstName   | FirstName   |             |
            | LastName    | LastName    |             |
            | Email       | Email       |             |
            | Phone       | PhoneNumber |             |
        Then User "ResponsePopulate" "Update PI API Data" event in "EventConfigurations" screen
        Then User will create transformation rule for "Response Populate" "Update PI API Data" and connect Input and Output nodes in "transformation" screen
            | Destination   | Source |
            | REmail       | Email  |
            | RPhoneNumber | Phone  |
        # Populate
        And User create an Event Configuration in "EventConfigurations" screen
            | EventName        | EventType | Widget | DataSource            | DataList                        | Type | UniqueField | Value |
            | Get By Id PI API | Populate  | fetch  | PI API for Automation | Get By Id PI API for Automation | ref  | Pin         | Pin   |
        Then User will create transformation rule for "Populate" "Get By Id PI API" and connect Input and Output nodes in "transformation" screen
            | Destination | Source    |
            | PhoneNumber | Phone     |
            | Pin         | Pin       |
            | FirstName   | FirstName |
            | LastName    | LastName  |
            | Email       | Email     |

        # ServiceProvider-Delete
        And User create an Event Configuration in "EventConfigurations" screen
            | EventName          | EventType         | Widget | DataSource            | DataList                           |
            | Delete PI API Data | Service Providers | Delete | PI API for Automation | Delete By Id PI API for Automation |
        Then User will create transformation rule for "Service Provider" "Delete PI API Data" and connect Input and Output nodes in "transformation" screen
            | Destination | Source |
            | Pin         | Pin    |


        Then User click on "Design" "Design" in "Page" screen
        And User edit "Save" action and set "Reset Field Values" on widget "Refresh" in "UniqueWidgetFields" screen
            | Widgets     |
            | Pin         |
            | FirstName   |
            | LastName    |
            | Email       |
            | PhoneNumber |
        Then User click on "button" "WidgetSave" in "UniqueWidgetFields" screen
        Then User click on "span" "Save" in "Page" screen
        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User see text "Back Office" in "BO" in "Page" screen
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
        #  To validate Preview
        And User validate Payload app opening in a new tab
        Then User will "Logout" from "Page" the current session
        # Payload
        Given user login to payload application with "Finlevit_payload" with "1" agent
        And User enter "text" in "Pin" with "5" characters
        And User enter "text" in "First Name" with "7" characters
        And User enter "text" in "Last Name" with "7" characters
        And User enter "email" in "Email" with "5" characters
        And User enter "phoneNumber" in "Phone Number" with "10" characters
        Then User click on "Button" widget "Create" in "payload" screen
        And User wait for "4000"
        Then User click on "Button" widget "Refresh" in "payload" screen
        And User wait for "1000"
        When User enters "Pin" from test data file in "Pin"
        And User wait for "3000"
        Then User click on "Button" widget "Fetch" in "payload" screen
        And User wait for "3000"
        And User validate "Text Input" widget "First Name" is not empty in "payload" screen
        And User validate "Text Input" widget "Last Name" is not empty in "payload" screen
        And User validate "Email" widget "Email" is not empty in "payload" screen
        And User validate "Phone Number" widget "Phone Number" is not empty in "payload" screen
        And User wait for "1000"
        When User enter "" text in "Phone Number" field
        And User wait for "3000"
        When User enter "9999999999" text in "Phone Number" field
        And User wait for "3000"
        Then User click on "Button" widget "Update" in "payload" screen
        And User wait for "3000"
        And User validate "Email" widget "R Email" is not empty in "payload" screen
        And User validate "Phone Number" widget "R Phone Number" is not empty in "payload" screen
        Then User click on "Button" widget "Refresh" in "payload" screen
        And User wait for "3000"
        When User enters "Pin" from test data file in "Pin"
        Then User click on "Button" widget "Fetch" in "payload" screen
        And User wait for "3000"
        And User validate "Text Input" widget "First Name" is not empty in "payload" screen
        And User validate "Text Input" widget "Last Name" is not empty in "payload" screen
        And User validate "Email" widget "Email" is not empty in "payload" screen
        And User validate "Phone Number" widget "Phone Number" is not empty in "payload" screen
        And User wait for "3000"
        Then User click on "Button" widget "Delete" in "payload" screen
        And User wait for "3000"
        Then User click on "Button" widget "Refresh" in "payload" screen
        And User wait for "3000"
        When User enters "Pin" from test data file in "Pin"
        Then User click on "Button" widget "Fetch" in "payload" screen
        And User should contain text "API Data not Found for unique identifier" in "Pagelevel_alert_messgae" in "payload" screen














