Feature: Application to validate onload triggers using option mapping, response mapping and on change populate action for Backoffice field

    @RS
    @RS2
    @BOOnloadTrigger
    Scenario Outline: Use case to demonstrate onload triggers using option mapping, response mapping and on change populate action for Backoffice fields
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "Usecase_TestData/ChildScript2" json file in "WorkFlow UI" screen
        Then User will open "GroupName" group in "HomePage" screen
        Then User click on "button" "group_settings" in "Groups" screen
        Then User click on "button" "dataSources" in "onLoadTrigger" screen
        And User get unique field in Data Source "EmployerDetails" in "onLoadTrigger" screen and save it in "EmployerPin"
        Then User will open "GroupName" group in "HomePage" screen
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        And User wait until the spinner disappears
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget   | X   | Y   | FieldName         | FieldLabel          | OptionType       |
            | Dropdown | 400 | 150 | UsersfromEmployee | Users from Employee | ConfigureOptions |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X   | Y   | FieldName | FieldLabel | Action | Status |
            | Button | 400 | 350 | Submit    | Submit     | Submit | Save   |
            Then User clicks on "AutoAlign" in "frontOffice" screen
        Then User click on "span" "Save" in "Page" screen
        And User create Onload Triggers with "1" Rule Options Mapping "addOnloadTrigger" in "onLoadTrigger" screen
            | Name      | Description | DataSource      | DataList                | Rule1 | Ref1 | RootKey1        | Field1            | Label1 | Value1 |
            | Get users | Get users   | EmployeeDetails | Get All EmployeeDetails | Rule1 | User | EmployeeDetails | UsersfromEmployee | Pin    | Pin    |
        
        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User see text "Back Office" in "BO" in "Page" screen

        Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
        Then User click on "span" "Save" in "Page" screen
        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName    | FieldLabel    |
            | Text Input | 500 | 300 | EmployerID   | Employer ID   |
            | Text Input | 700 | 300 | EmployerName | Employer Name |
        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget      | X   | Y   | FieldName | FieldLabel | ValuesAlignment      | ValueCount | Value1    | Value2    |
            | Radio Group | 500 | 600 | JobType   | Job Type   | ValueAlignHorizontal | 2          | Full Time | Part Time |

        When User expand "Radio Group" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget   | X   | Y   |
            | Job Type | 700 | 800 |
        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget   | X   | Y   | FieldName | FieldLabel | OptionType       |
            | Dropdown | 650 | 900 | Country   | Country    | ConfigureOptions |
            | Dropdown | 800 | 1000 | State     | State      | ConfigureOptions |
        Then User clicks on "AutoAlign" in "backOffice" screen
        Then User click on "span" "Save" in "Page" screen
        # To set Onload Triggers for Country dropdow?n
        And User create Onload Triggers with "1" Rule Options Mapping "addOnloadTrigger" in "onLoadTrigger" screen
            | Name          | Description   | DataSource | DataList          | Rule1 | Ref1 | Field1  | Label1 | Value1 | DefaultValue1 |
            | Get Countries | Get Countries | Countries  | Get All Countries | Rule1 | CN   | Country | name   | iso2   | US            |

        And User create Onload Triggers with Response Mapping "addOnloadTrigger" in "onLoadTrigger" screen
            | Name                 | Description      | DataSource      | DataList                  | Type | uniqueField | uniqueFieldValue    |
            | Get Employer Details | Employer Details | EmployerDetails | Get By Id EmployerDetails | ref  | EmployerPin | Users from Employee |

        Then User will create transformation rule for "Response Mapping" "Save EmployeeName" and connect Input and Output nodes in "transformation" screen
            | Destination  | Source       |
            | EmployerName | EmployerName |
            | EmployerID   | EmployerId   |
            | Country      | Country      |
            | State        | State        |
            | JobType      | JobType      |

        And User wait for "1000"
        And User see text "Onload Triggers" in "onLoadTriggerTitle" in "onLoadTrigger" screen
        # # Create on change triggers
        # And User create event configuration with "1" Options Mapping "addOnloadTrigger" in "EventConfigurations" screen
        #   | EventName | EventType         | Widget  | DataSource | DataList                         | Type | UniqueField | paramValue | Field1 | Label1 | Value1    | DefaultKey1 | Defaultvalue1 |
        #   | Get State | On Change Actions | Country | States     |   Get By Filter Field: countryCode | ref  | CountryId   | Country    | State  | name   | stateCode | stateCode   | NC            |
        And User create event configuration Options Mapping with "1" Rule "addOnloadTrigger" in "EventConfigurations" screen
            | EventName | EventType         | Widget  | DataSource | DataList                        | Type | UniqueField | paramValue | Rule1 | Ref1 | Field1 | Label1 | Value1    | DefaultValue1 |
            | Get State | On Change Actions | Country | States     | Get By Filter Field countryCode | ref  | CountryId   | Country    | Rule1 | ST   | State  | name   | stateCode | NC            |
        # And User write "Back Office" widgets in "BackOffice_Widgets" in "UniqueWidgetFields" screen
        # Edit existing role
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
        #  To validate Preview
        And User validate Payload app opening in a new tab
        # Payload
        Then user will clear browser cookies
        Given user login to payload application with "Finlevit_payload" with "1" agent
        And User select drop down option "<Users>" in "Users from Employee" widget in "payload" screen
        And User wait for "1000"
        Then User click on "Button" widget "Submit" in "payload" screen
        And User get Transaction Id and save it in json file
        Then user will clear browser cookies
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
        And User validate left side menu options for the Task in "WorkFlow UI" screen
        And User wait for "3000"
        And User validate "Text Input" widget "Employer ID" is not empty in "payload" screen
        And User validate "Text Input" widget "Employer Name" is not empty in "payload" screen
        And User validate "Radio Group" widget "Job Type" is not empty in "payload" screen
        And User validate "Dropdown" widget "Country" is not empty in "payload" screen
        # And User validate "Dropdown" widget "State" is not empty in "payload" screen
        And User select drop down option "India" in "Country" widget in "payload" screen
        And User wait for "5000"
        And User select drop down option "Tamil Nadu" in "State" widget in "payload" screen
        And User wait for "1000"
        Then User validate Task "1" Actions and select "Accept" action in "WorkFlow UI" screen
        And User wait for "5000"
        And User validate Transaction details are removed from "Team Task" in "WorkFlow UI" screen

        Examples:
            | Users |
            | mross |
