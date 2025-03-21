Feature: Validate BO - Edit SP mapping, add new fields, and validate on WF UI

    @ChildScript
    @ChildScript11

    #Createdby: Manikanta
    Scenario Outline: Use case to demonstrate BO - Edit SP mapping, add new fields, and validate on WF UI

        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "Usecase_TestData/ChildScript11" json file in "WorkFlow UI" screen
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
        And User wait until the spinner disappears
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X   | Y   | FieldName | FieldLabel | Action | Status |
            | Button | 150 | 500 | Submit    | Submit     | Submit | Save   |

        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen

        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName | FieldLabel |
            | Text Input | 50  | 125 | Pin       | Pin        |
            | Text Input | 300 | 125 | FirstName | First Name |
            | Text Input | 550 | 125 | LastName  | Last Name  |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X  | Y   | FieldName | FieldLabel | PlaceHolder        |
            | Email  | 50 | 300 | Email     | Email      | example@domain.com |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget       | X   | Y   | FieldName   | FieldLabel   |
            | Phone Number | 300 | 300 | PhoneNumber | Phone Number |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X   | Y   | FieldName | FieldLabel | Action | Status |
            | Button | 75  | 500 | create    | Create     | None   | Save   |
            | Button | 250 | 500 | Fetch     | Fetch      | None   | Save   |
            | Button | 75  | 650 | Refresh   | Refresh    | None   | Clear  |

        Then User add toast message to "Create" button as "CreateRecord Completed" in "UniqueWidgetFields" pageScreen
        Then User add toast message to "Fetch" button as "Fetching Data is Success" in "UniqueWidgetFields" pageScreen
        Then User add toast message to "Refresh" button as "Successfully Refreshed" in "UniqueWidgetFields" pageScreen

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

        And User create an Event Configuration in "EventConfigurations" screen
            | EventName        | EventType | Widget | DataSource            | DataList                        | Type | UniqueField | Value |
            | Get By Id PI API | Populate  | Fetch  | PI API for Automation | Get By Id PI API for Automation | ref  | Pin         | Pin   |
        Then User will create transformation rule for "Populate" "Get By Id PI API" and connect Input and Output nodes in "transformation" screen
            | Destination | Source    |
            | PhoneNumber | Phone     |
            | Pin         | Pin       |
            | FirstName   | FirstName |
            | LastName    | LastName  |
            | Email       | Email     |
        # And User write "Back Office" widgets in "BackOffice_Widgets" in "UniqueWidgetFields" screen
        Then User click on "Design" "Design" in "Page" screen
        And User edit "Clear" action and set "Reset Field Values" on widget "Refresh" in "UniqueWidgetFields" screen
            | Widgets     |
            | Pin         |
            | FirstName   |
            | LastName    |
            | Email       |
            | PhoneNumber |
        Then User click on "button" "WidgetSave" in "UniqueWidgetFields" screen
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
        #  To validate Preview
        And User validate Payload app opening in a new tab
        Then User will "Logout" from "Page" the current session
        # # Payload
        Given user login to payload application with "Finlevit_payload" with "1" agent
        #Submit Transaction
        Then User click on "Button" widget "Submit" in "payload" screen
        And User get Transaction Id and save it in json file
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
        And User enter "text" in "Pin" with "5" characters
        And User enter "text" in "First Name" with "7" characters
        And User enter "text" in "Last Name" with "7" characters
        And User enter "email" in "Email" with "5" characters
        And User enter "phoneNumber" in "Phone Number" with "10" characters
        Then User click on "Button" widget "Create" in "payload" screen
        Then User click on "Button" widget "Refresh" in "payload" screen
        When User enters "Pin" from test data file in "Pin"
        Then User click on "Button" widget "Fetch" in "payload" screen
        And User validate "Text Input" widget "First Name" is not empty in "payload" screen
        And User validate "Text Input" widget "Last Name" is not empty in "payload" screen
        And User validate "Email" widget "Email" is not empty in "payload" screen
        And User validate "Phone Number" widget "Phone Number" is not empty in "payload" screen
        Then User validate Task "1" Actions and select "Accept" action in "WorkFlow UI" screen
        And User wait for "5000"
        Then User will "Logout" from "Page" the current session
        # AdminPage
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        Then User will open "GroupName" group in "HomePage" screen
        And User wait for "5000"
        Then User will search for "Application_Name" in "Application" screen
        Then User click on "button" "VersionControl" in "Version" screen
        When User checkout the version "latest version" for app modification
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        When User reloads the page
        Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget  | X   | Y   | FieldName | FieldLabel |
            | Address | 550 | 300 | Address   | Address    |

        Then User "Edit" "Save PI API Data" event in "EventConfigurations" screen
        Then User edit "Service Provider" with name "Save PI API Data" event and update mapping in "transformation" screen
            | Destination | Source             |
            | Line1       | Address            |
            | Locality    | Address_1_locality |
            #            | Zipcode     | Address_1_postalCode |
            | State       | Address_1_state    |
        And User wait for "2000"
        Then User "Edit" "Get By Id PI API" event in "EventConfigurations" screen
        And User edit "Populate" with name "Get By Id PI API" event and update mapping in "transformation" screen
            | Destination          | Source   |
            | Address              | Line1    |
            | Address_1_locality   | Locality |
            | Address_1_postalCode | Zipcode  |
            | Address_1_state      | State    |
        Then User click on "Design" "Design" in "Page" screen
        And User edit "Clear" action and set "Reset Field Values" on widget "Refresh" in "UniqueWidgetFields" screen
            | Widgets              |
            | Address              |
            | Address_1_locality   |
            | Address_1_postalCode |
            | Address_1_state      |
        Then User click on "button" "WidgetSave" in "UniqueWidgetFields" screen
        When User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        #  To validate Preview
        And User validate Payload app opening in a new tab
        Then User will "Logout" from "Page" the current session
        # # Payload
        Given user login to payload application with "Finlevit_payload" with "1" agent
        #Submit Transaction
        Then User click on "Button" widget "Submit" in "payload" screen
        And User get Transaction Id and save it in json file
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
        Then User click on "Button" widget "Refresh" in "payload" screen
        When User enters "Pin" from test data file in "Pin"
        Then User click on "Button" widget "Fetch" in "payload" screen
        And User validate "Text Input" widget "First Name" is not empty in "payload" screen
        And User validate "Text Input" widget "Last Name" is not empty in "payload" screen
        And User validate "Email" widget "Email" is not empty in "payload" screen
        And User validate "Phone Number" widget "Phone Number" is not empty in "payload" screen
        And User validate "Text Input" widget "Address" is not empty in "payload" screen
        And User validate "Text Input" widget "City" is not empty in "payload" screen
        And User validate "Text Input" widget "Zip" is not empty in "payload" screen
        Then User validate Task "1" Actions and select "Accept" action in "WorkFlow UI" screen
        And User wait for "5000"
        Then User will "Logout" from "Page" the current session

        # # Validate Edit API setup and datalist
        Given user login to "Finlevit_admin" with "Admin" credentials
        Then User will open "GroupName" group in "HomePage" screen
        Then User click on "button" "group_settings" in "Groups" screen
        Then User click on "button" "apiSetup" in "GroupSetting" screen
        And User "Edit" "Service Provider" "Generated APIs" in "GroupSetting" screen and validate text contains "Updated Successfully"
        And User click on "Generated APIs" in "GroupSetting" screen
        # And User "Edit" "Service" "PI API for Automation" in "GroupSetting" screen and validate text contains ""
        And User click on "PI API for Automation" in "GroupSetting" screen
        And User "Edit" "Operations" "Save PI API for Automation" in "GroupSetting" screen and validate text contains "FL1409 : This Item is being used in DATA LIST : [Save PI API for Automation]"
        Then User click on "button" "dataSources" in "GroupSetting" screen
        And User "Edit" "Data Sources" "PI API for Automation" in "GroupSetting" screen and validate text contains "The process could not be completed as the following data list(s) are currently in use."
        And User click on "PI API for Automation" in "GroupSetting" screen
        And User "Edit" "Data Lists" "Save PI API for Automation" in "GroupSetting" screen and validate text contains "Update process cannot be completed at this time as the data list is currently in use"

        # Delete API setup and datalist
        Then User click on "button" "apiSetup" in "GroupSetting" screen
        And User "Delete" "Service Provider" "Generated APIs" in "GroupSetting" screen and validate text contains "FL1409 : This Item is being used in DATA_RESOURCE"
        And User click on "Generated APIs" in "GroupSetting" screen
        And User "Delete" "Service" "PI API for Automation" in "GroupSetting" screen and validate text contains "FL1409 : This Item is being used in DATA LIST"
        And User click on "PI API for Automation" in "GroupSetting" screen
        And User "Delete" "Operations" "Save PI API for Automation" in "GroupSetting" screen and validate text contains "FL1409 : This Item is being used in DATA LIST : [Save PI API for Automation]"
        Then User click on "button" "dataSources" in "GroupSetting" screen
        And User "Delete" "Data Sources" "PI API for Automation" in "GroupSetting" screen and validate text contains "The process could not be completed as the following data list(s) are currently in use."
        And User click on "PI API for Automation" in "GroupSetting" screen
        And User "Delete" "Data Lists" "Save PI API for Automation" in "GroupSetting" screen and validate text contains " The process could not be completed as the following data list(s) are currently in use."

