Feature: Validate FO - Edit SP mapping, add new fields and validate on payload

    @ChildScript
    @ChildScript10
    Scenario: Use case to demonstrate FO - Edit SP mapping, add new fields and validate on payload
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "Usecase_TestData/ChildScript10" json file in "WorkFlow UI" screen
        Then User will open "GroupName" group in "HomePage" screen
        Then User click on "button" "group_settings" in "Groups" screen
        Then User click on "button" "dataSources" in "onLoadTrigger" screen
        And User get unique field in Data Source "PI API for Automation" in "onLoadTrigger" screen and save it in "Pin"
        Then User will open "GroupName" group in "HomePage" screen
        # To Create an Application
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "2000"
        And User wait until the spinner disappears
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName | FieldLabel |
            | Text Input | 50  | 125 | pin       | Pin        |
            | Text Input | 300 | 125 | firstName | First Name |
            | Text Input | 550 | 125 | lastName  | Last Name  |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X  | Y   | FieldName | FieldLabel | PlaceHolder        |
            | Email  | 50 | 300 | email     | Email      | example@domain.com |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget       | X   | Y   | FieldName   | FieldLabel   |
            | Phone Number | 300 | 300 | phoneNumber | Phone Number |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X   | Y   | FieldName | FieldLabel | Action            | Status |
            | Button | 75  | 500 | create    | Create     | Service Providers | None   |
            | Button | 250 | 500 | fetch     | Fetch      | Populate          | None   |
            | Button | 450 | 500 | submit    | Submit     | Submit            | Save   |

        Then User add toast message to "Create" button as "CreateRecord Completed" in "UniqueWidgetFields" pageScreen
        Then User add toast message to "Fetch" button as "Fetching Data is Success" in "UniqueWidgetFields" pageScreen

        # # And User write "Front Office" widgets in "FrontOffice_Widgets" in "UniqueWidgetFields" screen
        And User create an Event Configuration in "EventConfigurations" screen
            | EventName        | EventType         | Widget | DataSource            | DataList                   |
            | Save PI API Data | Service Providers | create | PI API for Automation | Save PI API for Automation |
        Then User will create transformation rule for "Service Provider" "Save PI API Data" and connect Input and Output nodes in "transformation" screen
            | Destination | Source      |
            | Pin         | pin         |
            | FirstName   | firstName   |
            | LastName    | lastName    |
            | Email       | email       |
            | Phone       | phoneNumber |
        And User wait for "1000"
        #   Then User "Save" "Save PI API Data" event in "EventConfigurations" screen
        And User create an Event Configuration in "EventConfigurations" screen
            | EventName        | EventType | Widget | DataSource            | DataList                        | Type | UniqueField | Value |
            | Get By Id PI API | Populate  | fetch  | PI API for Automation | Get By Id PI API for Automation | ref  | Pin         | pin   |
        Then User will create transformation rule for "Populate" "Get By Id PI API" and connect Input and Output nodes in "transformation" screen
            | Destination | Source    |
            | pin         | Pin       |
            | firstName   | FirstName |
            | lastName    | LastName  |
            | email       | Email     |
            | phoneNumber | Phone     |
        And User wait for "1000"
        #Then User "Save" "Get By Id PI API" event in "EventConfigurations" screen
        And User wait for "2000"
        #add FO agent role
        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
        #Switch to BO
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        # And User write "Back Office" widgets in "BackOffice_Widgets" in "UniqueWidgetFields" screen

        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        # To Add the required tasks onto the workflow Designer
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 200 | 100 |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
            | Task   | 600 | 300 | Review   | Application Manager | 1           | Accept  | In Progress   | 1        | 0       |

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
        #  Payload
        Given user login to payload application with "Finlevit_payload" with "1" agent
        # Enter Data
        And User enter "text" in "Pin" with "5" characters
        And User enter "text" in "First Name" with "7" characters
        And User enter "text" in "Last Name" with "7" characters
        And User enter "email" in "Email" with "5" characters
        And User enter "phoneNumber" in "Phone Number" with "10" characters
        Then User click on "Button" widget "Create" in "payload" screen
        And User wait for "5000"
        And User wait until the spinner disappears
        And User reloads the page
        When User enters "Pin" from test data file in "Pin"
        Then User click on "Button" widget "Fetch" in "payload" screen
        And User wait until the toast message disappears
        And User wait for "3000"
        And User validate "Text Input" widget "First Name" is not empty in "payload" screen
        And User validate "Text Input" widget "Last Name" is not empty in "payload" screen
        And User validate "Email" widget "Email" is not empty in "payload" screen
        And User validate "Phone Number" widget "Phone Number" is not empty in "payload" screen
        And User wait until the toast message disappears
        Then User click on "Button" widget "Submit" in "payload" screen
        # And User wait for "5000"
        And User get Transaction Id and save it in json file
        # AdminPage
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        Then User will open "GroupName" group in "HomePage" screen
        Then User will search for "Application_Name" in "Application" screen
        Then User click on "button" "VersionControl" in "Version" screen
        When User checkout the version "latest version" for app modification
        Then User click on "FrontOffice" "Click_FrontOffice" in "Application" screen
        When User reloads the page
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget  | X   | Y   | FieldName | FieldLabel |
            | Address | 550 | 300 | Address   | Address    |
        Then User "Edit" "Save PI API Data" event in "EventConfigurations" screen
        Then User edit "Service Provider" with name "Save PI API Data" event and update mapping in "transformation" screen
            | Destination | Source               |
            | Line1       | Address              |
            | Locality    | Address_1_locality   |
            | Zipcode     | Address_1_postalCode |
            | State       | Address_1_state      |
        And User wait for "2000"
        Then User "Edit" "Get By Id PI API" event in "EventConfigurations" screen
        And User edit "Populate" with name "Get By Id PI API" event and update mapping in "transformation" screen
            | Destination          | Source   |
            | Address              | Line1    |
            | Address_1_locality   | Locality |
            | Address_1_postalCode | Zipcode  |
            | Address_1_state      | State    |
        When User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        #  To validate Preview
        And User validate Payload app opening in a new tab
        Then User will "Logout" from "Page" the current session
        # # Payload
        Given user login to payload application with "Finlevit_payload" with "1" agent
        #Enter Data
        And User enter "text" in "Pin" with "5" characters
        And User enter "text" in "First Name" with "7" characters
        And User enter "text" in "Last Name" with "7" characters
        And User enter "email" in "Email" with "5" characters
        And User enter "phoneNumber" in "Phone Number" with "10" characters
        # And User enter "number" in "Address" with "3" characters
        And User enter text "11020" in "Address" in "payload" screen
        And User wait for "1000"
        Then User select on "Address" "SelectFirstAddress" in "payload" screen
        Then User click on "Button" widget "Create" in "payload" screen
        And User wait for "5000"
        And User wait until the spinner disappears
        And User reloads the page
        When User enters "Pin" from test data file in "Pin"
        Then User click on "Button" widget "Fetch" in "payload" screen
        And User validate "Text Input" widget "First Name" is not empty in "payload" screen
        And User validate "Text Input" widget "Last Name" is not empty in "payload" screen
        And User validate "Email" widget "Email" is not empty in "payload" screen
        And User validate "Phone Number" widget "Phone Number" is not empty in "payload" screen
        And User validate "Text Input" widget "Address" is not empty in "payload" screen
        And User validate "Text Input" widget "City" is not empty in "payload" screen
        #        And User validate "Text Input" widget "Zip" is not empty in "payload" screen
        Then User click on "Button" widget "Submit" in "payload" screen
