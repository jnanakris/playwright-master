Feature: Application to validate FO/BO - Delete Onload Triggers

  @BOOnloadTrigger @ChildScript
  @ChildScript19
  #Createdby: Mary
  #CreatedDate:05/03/2023
  Scenario: Use case to demonstrate FO/BO - Delete Onload Triggers
    Given user login to "Finlevit_admin" with "GroupAdmins" credentials
    And User get the Test data from "Usecase_TestData/ChildScript19" json file in "WorkFlow UI" screen
    Then User will open "GroupName" group in "HomePage" screen
    # To Create an Application
    Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
    Then User will search for "Application_Name" in "Application" screen
    And User wait for "2000"
    Then User see text "Front Office" in "FO" in "Page" screen
    And User wait until the spinner disappears
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget   | X  | Y  | FieldName   | FieldLabel    | OptionType       |
      | Dropdown | 50 | 50 | UsersfromFO | Users from FO | ConfigureOptions |
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget | X  | Y   | FieldName | FieldLabel | Action | Status |
      | Button | 50 | 200 | Submit    | Submit     | Submit | Save   |
    # To set Onload Triggers for User dropdown
    And User create Onload Triggers with "1" Rule Options Mapping "addOnloadTrigger" in "onLoadTrigger" screen
      | Name      | Description | DataSource      | DataList                | Rule1 | Ref1 | RootKey1        | Field1      | Label1 | Value1 |
      | Get users | Get users   | EmployeeDetails | Get All EmployeeDetails | Rule1 | User | EmployeeDetails | UsersfromFO | Pin    | Pin    |
    And User wait for "1000"
    # Edit existing role
    Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
    # To Design Back Office
    Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
    Then User see text "Back Office" in "BO" in "Page" screen
    # Drag the Front Office widgets onto Back office Canavas
    Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
    Then User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget   | X  | Y  | FieldName   | FieldLabel    | OptionType       |
      | Dropdown | 50 | 50 | UsersfromBO | Users from BO | ConfigureOptions |
    And User create Onload Triggers with "1" Rule Options Mapping "addOnloadTrigger" in "onLoadTrigger" screen
      | Name      | Description | DataSource      | DataList                | Rule1 | Ref1 | RootKey1        | Field1      | Label1 | Value1 |
      | Get users | Get users   | EmployeeDetails | Get All EmployeeDetails | Rule1 | User | EmployeeDetails | UsersfromBO | Pin    | Pin    |
    # Edit existing role
    Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
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
      | Widget   | X   | Y  | FieldName  | FieldLabel | OptionType       |
      | Dropdown | 400 | 50 | FO_Country | FO_Country | ConfigureOptions |
    Then User click on "button" "CanvasSave" in "UniqueWidgetFields" screen
    And User Delete Onload Trigger "Get users" in "onLoadTrigger" screen
    And User create Onload Triggers with "1" Rule Options Mapping "addOnloadTrigger" in "onLoadTrigger" screen
      | Name             | Description   | DataSource | DataList          | Rule1 | Ref1 | Field1     | Label1 | Value1 |
      | Get BO Countries | Get Countries | Countries  | Get All Countries | Rule1 | CN   | FO_Country | name   | iso2   |
    Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
    Then User see text "Back Office" in "BO" in "Page" screen
    Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
    And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget   | X   | Y  | FieldName  | FieldLabel | OptionType       |
      | Dropdown | 400 | 50 | BO_Country | BO_Country | ConfigureOptions |
    And User Delete Onload Trigger "Get users" in "onLoadTrigger" screen
    And User create Onload Triggers with "1" Rule Options Mapping "addOnloadTrigger" in "onLoadTrigger" screen
      | Name             | Description   | DataSource | DataList          | Rule1 | Ref1 | Field1     | Label1 | Value1 |
      | Get BO Countries | Get Countries | Countries  | Get All Countries | Rule1 | CN   | BO_Country | name   | iso2   |
    # # And User write "Front Office" widgets in "FrontOffice_Widgets" in "UniqueWidgetFields" screen
    # # And User write "Back Office" widgets in "BackOffice_Widgets" in "UniqueWidgetFields" screen

    And User wait for "1000"
    Then User click on "button" "VersionControl" in "Version" screen
    And User wait for "1000"
    Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
    # Payload
    Given user login to payload application with "Finlevit_payload" with "1" agent
    And User wait for "1000"
    Then User click on "Dropdown" widget "FO_Country" in "payload" screen
    And User wait for "1000"
    Then User should have count more than "200" in "DropdownValues" in "payload" screen
    Then User click on "Dropdown" widget "FO_Country" in "payload" screen
    And User select drop down option "India" in "FO_Country" widget in "payload" screen
    Then User click on "Dropdown" widget "Users from FO" in "payload" screen
    And User wait for "1000"
    Then User should have count "1" in "DropdownValues" in "payload" screen
    Then User click on "Dropdown" widget "Users from FO" in "payload" screen
    Then User click on "Button" widget "Submit" in "payload" screen
    And User get Transaction Id and save it in json file
    #WorkFlow UI
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
    And User wait until the spinner disappears
    Then User click on "Dropdown" widget "BO_Country" in "payload" screen
    And User wait for "1000"
    Then User should have count more than "200" in "DropdownValues" in "payload" screen
    Then User click on "Dropdown" widget "BO_Country" in "payload" screen
    And User select drop down option "India" in "BO_Country" widget in "payload" screen
    Then User click on "Dropdown" widget "Users from BO" in "payload" screen
    And User wait for "1000"
    Then User should have count "1" in "DropdownValues" in "payload" screen
    Then User click on "Dropdown" widget "Users from BO" in "payload" screen
    Then User validate Task "1" Actions and select "Accept" action in "WorkFlow UI" screen
    And User wait for "5000"
    And User validate Transaction details are removed from "Team Task" and it is displaying under "History" on the successful workflow completion in "WorkFlow UI" screen
    # And User validate Transaction table header under "History" in "WorkFlow UI" screen
    #   | Transaction Id | Created At | Submitted By | Last Updated By | Last Updated At |
    Then User will "Logout" from "Page" the current session
