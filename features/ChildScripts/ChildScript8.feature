Feature: Application to validate FO - Edit response mapping and add new fields and do mapping for new fields

  @BOOnloadTrigger @ChildScript @ChildScript8
  #Createdby: Mary
  #CreatedDate:05/03/2023
  Scenario: Use case to demonstrate FO - Edit response mapping and add new fields
    Given user login to "Finlevit_admin" with "GroupAdmins" credentials
    And User get the Test data from "Usecase_TestData/ChildScript8" json file in "WorkFlow UI" screen
    Then User will open "GroupName" group in "HomePage" screen
    #  User get unique field in Data Source
    Then User click on "button" "group_settings" in "Groups" screen
    Then User click on "button" "dataSources" in "onLoadTrigger" screen
    And User get unique field in Data Source "EmployerDetails" in "onLoadTrigger" screen and save it in "EmployerPin"
    Then User will open "GroupName" group in "HomePage" screen
    # To Create an Application
    Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
    Then User will search for "Application_Name" in "Application" screen
    And User wait for "2000"
    Then User see text "Front Office" in "FO" in "Page" screen
    And User wait until the spinner disappears
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget   | X  | Y  | FieldName         | FieldLabel          | OptionType    | ValueCount | Value1 | Value2      | Value3 | Value4       |
      | Dropdown | 50 | 50 | UsersfromEmployee | Users from Employee | ManualOptions | 4          | marul  | msrinivasan | makula | pchadalawada |
    And User set Default value "marul" to the "Dropdown" field "Users from Employee" in "UniqueWidgetFields" screen
    # Drag Widgets onto the Canvas in Front Office
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget    | X  | Y   | FieldName           | Title                |
      | Container | 50 | 200 | EmployerInformation | Employer Information |
    When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget               | X   | Y   |
      | Employer Information | 900 | 500 |
    Then User click on "span" "Save" in "Page" screen
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget     | X   | Y   | FieldName    | FieldLabel    |
      | Text Input | 60  | 300 | EmployerID   | Employer ID   |
      | Text Input | 275 | 300 | EmployerName | Employer Name |
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget      | X   | Y   | FieldName | FieldLabel | ValuesAlignment      | ValueCount | Value1    | Value2    |
      | Radio Group | 500 | 300 | JobType   | Job Type   | ValueAlignHorizontal | 2          | Full Time | Part Time |

    When User expand "Radio Group" widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget   | X   | Y   |
      | Job Type | 700 | 400 |
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget   | X   | Y   | FieldName | FieldLabel | OptionType       |
      | Dropdown | 60  | 420 | Country   | Country    | ConfigureOptions |
      | Dropdown | 275 | 420 | State     | State      | ConfigureOptions |
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget | X  | Y   | FieldName | FieldLabel | Action | Status |
      | Button | 50 | 600 | Submit    | Submit     | Submit | Save   |
    # # To set Onload Triggers for Country dropdown
    # And User create Onload Triggers with "1" Options Mapping "addOnloadTrigger" in "onLoadTrigger" screen
    #   | Name          | Description   | DataSource | DataList          | Field1  | Label1 | Value1 |
    #   | Get Countries | Get Countries | Countries  | Get All Countries | Country | name   | iso2   |
    #   | Get States    | Get States    | States     | Get All States    | State   | name   | name   |
    And User create Onload Triggers with "1" Rule Options Mapping "addOnloadTrigger" in "onLoadTrigger" screen
      | Name          | Description   | DataSource | DataList          | Rule1 | Ref1 | Field1  | Label1 | Value1    |
      | Get Countries | Get Countries | Countries  | Get All Countries | Rule1 | CN   | Country | name   | iso2      |
      | Get States    | Get States    | States     | Get All States    | Rule1 | ST   | State   | name   | stateCode |
    # Create on load trigger for Response Mapping
    And User create Onload Triggers with Response Mapping "addOnloadTrigger" in "onLoadTrigger" screen
      | Name                 | Description      | DataSource      | DataList                  | Type | uniqueField | uniqueFieldValue    |
      | Get Employer Details | Employer Details | EmployerDetails | Get By Id EmployerDetails | ref  | EmployerPin | Users from Employee |
    Then User will create transformation rule for "Response Mapping" "Save Employee" and connect Input and Output nodes in "transformation" screen
      | Destination  | Source       |
      | EmployerName | EmployerName |
      | EmployerID   | EmployerId   |
      | Country      | Country      |
      | State        | State        |
      | JobType      | JobType      |
    And User wait for "1000"
    And User see text "Onload Triggers" in "onLoadTriggerTitle" in "onLoadTrigger" screen

    # And User write "Front Office" widgets in "FrontOffice_Widgets" in "UniqueWidgetFields" screen
    # Edit existing role
    Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
    # To Design Back Office
    Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
    Then User see text "Back Office" in "BO" in "Page" screen
    # Drag the Front Office widgets onto Back office Canavas
    Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
      | Widget              | X  | Y  |
      | EmployerInformation | 50 | 50 |
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
    # Checkout the version
    Then User click on "button" "VersionControl" in "Version" screen
    And User wait for "1000"
    When User checkout the version "latest version" for app modification
    Then User click on "tab" "Design" in "Page" screen
    Then User click on "FrontOffice" "Click_FrontOffice" in "Application" screen
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget | X   | Y   | FieldName | FieldLabel |
      | SSN    | 500 | 420 | ssnNumber | SSN        |
      | Number | 730 | 420 | salary    | Salary     |
    Then User Edit Response Mapping "Get Employer Details" in "onLoadTrigger" screen
    Then User edit "Response Mapping" with name "Save Employee" event and update mapping in "transformation" screen
      | Destination | Source |
      | salary      | Salary |
      | ssnNumber   | ITIN   |

    And User wait for "1000"
    And User see text "Onload Triggers" in "onLoadTriggerTitle" in "onLoadTrigger" screen
    Then User click on "button" "VersionControl" in "Version" screen
    And User wait for "1000"
    Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
    # Payload
    Given user login to payload application with "Finlevit_payload" with "1" agent
    And User wait for "1000"
    And User validate "Text Input" widget "Employer ID" is not empty in "payload" screen
    And User validate "Text Input" widget "Employer Name" is not empty in "payload" screen
    And User validate "Radio Group" widget "Job Type" is not empty in "payload" screen
    And User validate "Dropdown" widget "Country" is not empty in "payload" screen
    # And User validate "Dropdown" widget "State" is not empty in "payload" screen
    And User validate "Number" widget "Salary" is not empty in "payload" screen
    And User validate "SSN / ITIN" widget "SSN" is not empty in "payload" screen
    Then User click on "Button" widget "Submit" in "payload" screen
    And User get Transaction Id and save it in json file
    # And User wait until the spinner appears
    And User wait until the spinner disappears
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
    And User validate "Dropdown" widget "State" is not empty in "payload" screen
    And User validate "Number" widget "Salary" is not displayed in "payload" screen
    And User validate "SSN / ITIN" widget "SSN" is not displayed in "payload" screen
    And User select drop down option "India" in "Country" widget in "payload" screen
    And User wait for "5000"
    And User select drop down option "Tamil Nadu" in "State" widget in "payload" screen
    And User wait for "1000"
    Then User validate Task "1" Actions and select "Accept" action in "WorkFlow UI" screen
    And User wait for "5000"
    And User validate Transaction details are removed from "Team Task" in "WorkFlow UI" screen
