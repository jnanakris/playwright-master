Feature: Validate On change Populate action and configure data population for BO fields

  @BODataPopulation @ChildScript @ChildScript1 @RS1
  Scenario Outline: Use case to demonstrate On change Populate action and configure data population for BO fields

    Given user login to "Finlevit_admin" with "GroupAdmins" credentials
    And User get the Test data from "Usecase_TestData/ChildScript1" json file in "WorkFlow UI" screen
    Then User will open "GroupName" group in "HomePage" screen
    #  User get unique field in Data Source
    Then User click on "button" "group_settings" in "Groups" screen
    Then User click on "button" "dataSources" in "onLoadTrigger" screen
    And User get unique field in Data Source "EmployerDetails" in "onLoadTrigger" screen and save it in "EmployerPin"
    Then User will open "GroupName" group in "HomePage" screen
    # # To Create an Application
    Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
    Then User will search for "Application_Name" in "Application" screen
    And User wait for "2000"
    And User wait until the spinner disappears
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget   | X   | Y   | FieldName | FieldLabel | OptionType       |
      | Dropdown | 400 | 150 | Employees | Employees  | ConfigureOptions |

    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget | X   | Y   | FieldName | FieldLabel | Action | Status |
      | Button | 400 | 350 | Submit    | Submit     | Submit | Save   |
    Then User clicks on "AutoAlign" in "frontOffice" screen
    Then User click on "span" "Save" in "Page" screen
    #To set Onload Triggers for users dropdown
    And User create Onload Triggers with "1" Rule Options Mapping "addOnloadTrigger" in "onLoadTrigger" screen
      | Name      | Description | DataSource      | DataList                | Rule1 | Ref1 | RootKey1        | Field1    | Label1 | Value1 |
      | Get users | Get users   | EmployeeDetails | Get All EmployeeDetails | Rule1 | User | EmployeeDetails | Employees | Pin    | Pin    |

    # # And User write "Front Office" widgets in "FrontOffice_Widgets" in "UniqueWidgetFields" screen
    # Edit existing role
    Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
    # To Design Back Office
    Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
    Then User see text "Back Office" in "BO" in "Page" screen

    Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
    # Drag Widgets onto the Canvas in Front Office
    And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget   | X  | Y  | FieldName         | FieldLabel          | OptionType    | ValueCount | Value1 | Value2      | Value3 | Value4       |
      | Dropdown | 50 | 50 | UsersfromEmployee | Users from Employee | ManualOptions | 4          | marul  | msrinivasan | makula | pchadalawada |
 
    Then User click on "span" "Save" in "Page" screen
    And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget     | X   | Y   | FieldName    | FieldLabel    |
      | Text Input | 50  | 300 | employerID   | Employer ID   |
      | Text Input | 275 | 300 | employerName | Employer Name |
    And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget      | X   | Y   | FieldName | FieldLabel | ValuesAlignment      | ValueCount | Value1    | Value2    | InputType |
      | Radio Group | 500 | 300 | jobType   | Job Type   | ValueAlignHorizontal | 2          | Full Time | Part Time | Values    |

    When User expand "Radio Group" widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget   | X   | Y   |
      | Job Type | 700 | 400 |
    And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget   | X   | Y   | FieldName | FieldLabel | OptionType       |
      | Dropdown | 50  | 420 | country   | Country    | ConfigureOptions |
      | Dropdown | 275 | 420 | state     | State      | ConfigureOptions |
    And User wait for "2000"
    Then User clicks on "AutoAlign" in "backOffice" screen
    Then User click on "span" "Save" in "Page" screen
    And User create an Event Configuration in "EventConfigurations" screen
      | EventName        | EventType         | Widget            | DataSource      | DataList                  | Type | UniqueField | Value             |
      | Get By Id PI API | On Change Actions | UsersfromEmployee | EmployerDetails | Get By Id EmployerDetails | ref  | EmployerPin | UsersfromEmployee |
    Then User will create transformation rule for "Populate" "Get By Id PI API" and connect Input and Output nodes in "transformation" screen
      | Destination  | Source       |
      | employerID   | EmployerId   |
      | employerName | EmployerName |
      | jobType      | JobType      |
      | country      | Country      |
      | state        | State        |

    And User wait for "1000"
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
    #   # Payload
    Given user login to payload application with "Finlevit_payload" with "1" agent
    And User select drop down option "<Users>" in "Employees" widget in "payload" screen
    And User wait for "1000"
    Then User click on "Button" widget "Submit" in "payload" screen
    And User get Transaction Id and save it in json file
    Given user login to workflow UI "Finlevit_workflow" with "1" "AppManager" credentials
    And User wait until the "Filter Transaction id" appears in "WorkFlow UI" screen
    Then User click on "Button" "Home" in "HomePage" screen
    Then User will open "GroupName" group in "HomePage" screen
    Then User will search for "Application_Name" in "Application" screen
    And As "Agent" user verify Task "1" Details under "Team Task" in "WorkFlow UI" screen
    Then Based on the Task assigned to person logout or continue with the same user in "WorkFlow UI" screen for "Application_Name"
    And As "Application Manager" user verify Task "1" Details under "My Task" in "WorkFlow UI" screen
    Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
    And User validate left side menu options for the Task in "WorkFlow UI" screen
    And User wait for "3000"
    And User wait until the spinner disappears
    And User select drop down option "marul" in "Users from Employee" widget in "payload" screen
    And User wait for "3000"
    And User wait until the spinner disappears
    And User validate "Text Input" widget "Employer ID" is not empty in "payload" screen
    And User validate "Text Input" widget "Employer Name" is not empty in "payload" screen
    And User validate "Radio Group" widget "Job Type" is not empty in "payload" screen
    And User select drop down option "makula" in "Users from Employee" widget in "payload" screen
    And User wait for "2000"
    And User validate "Text Input" widget "Employer ID" is not empty in "payload" screen
    And User validate "Text Input" widget "Employer Name" is not empty in "payload" screen
    And User validate "Radio Group" widget "Job Type" is not empty in "payload" screen
    Then User validate Task "1" Actions and select "Accept" action in "WorkFlow UI" screen
    And User wait for "5000"
    And User validate Transaction details are removed from "Team Task" in "WorkFlow UI" screen

    Examples:
      | Users |
      | marul |
