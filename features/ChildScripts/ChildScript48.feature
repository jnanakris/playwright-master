Feature: Application to validate Workflow UI Preferences

  @ChildScript
  @ChildScript48
  #Createdby: Mary
  #CreatedDate:05/03/2023
  Scenario: Use case to demonstrate to validate Workflow UI Preferences
    Given user login to "Finlevit_admin" with "GroupAdmins" credentials
    And User get the Test data from "Usecase_TestData/ChildScript48" json file in "WorkFlow UI" screen
    Then User will open "GroupName" group in "HomePage" screen
    # To Create first Application
    Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
    Then User will search for "Application_Name" in "Application" screen
    And User wait for "2000"
    Then User see text "Front Office" in "FO" in "Page" screen
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget   | X  | Y  | FieldName     | FieldLabel    | OptionType    | ValueCount | Value1 | Value2      | Value3 | Value4       |
      | Dropdown | 50 | 50 | UsersfromFO | Users from FO | ManualOptions | 4          | marul  | msrinivasan | makula | pchadalawada |

    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget | X  | Y   | FieldName | FieldLabel | Action | Status |
      | Button | 50 | 200 | Submit    | Submit     | Submit | Save   |
    And User wait for "1000"
    # Edit existing role
    Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
    # To Design Back Office
    Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
    Then User see text "Back Office" in "BO" in "Page" screen
    # Drag the Front Office widgets onto Back office Canavas
    Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
    Then User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget   | X  | Y  | FieldName     | FieldLabel    | OptionType    | ValueCount | Value1 | Value2      | Value3 | Value4       |
      | Dropdown | 50 | 50 | UsersfromBO | Users from BO | ManualOptions | 4          | marul  | msrinivasan | makula | pchadalawada |

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
    Then User will "Logout" from "Page" the current session

    Given user login to "Finlevit_admin" with "GroupAdmins" credentials
    Then User will open "GroupName" group in "HomePage" screen
    # To Create Second Application
    Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
    Then User will search for "Application_Name" in "Application" screen
    And User wait for "2000"
    Then User see text "Front Office" in "FO" in "Page" screen
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget   | X  | Y  | FieldName     | FieldLabel    | OptionType    | ValueCount | Value1 | Value2      | Value3 | Value4       |
      | Dropdown | 50 | 50 | UsersfromFO | Users from FO | ManualOptions | 4          | marul  | msrinivasan | makula | pchadalawada |

    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget | X  | Y   | FieldName | FieldLabel | Action | Status |
      | Button | 50 | 200 | Submit    | Submit     | Submit | Save   |
    And User wait for "1000"
    # Edit existing role
    Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
    # To Design Back Office
    Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
    Then User see text "Back Office" in "BO" in "Page" screen
    # Drag the Front Office widgets onto Back office Canavas
    Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
    Then User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget   | X  | Y  | FieldName     | FieldLabel    | OptionType    | ValueCount | Value1 | Value2      | Value3 | Value4       |
      | Dropdown | 50 | 50 | UsersfromBO | Users from BO | ManualOptions | 4          | marul  | msrinivasan | makula | pchadalawada |

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
    # Payload
    Given user login to payload application with "Finlevit_payload" with "3" agent
    And User wait for "1000"
    And User select drop down option "marul" in "Users from FO" widget in "payload" screen
    Then User click on "Button" widget "Submit" in "payload" screen
    And User get Transaction Id and save it in json file
    # WorkFlow UI
    Given user login to workflow UI "Finlevit_workflow" with "3" "AppManager" credentials
    And User wait for "5000"
    And User wait until the "Filter Transaction id" appears in "WorkFlow UI" screen
    Then User click on "Button" "Home" in "HomePage" screen
    # And User wait for "5000"
    Then User click on "Button" "Preferences Menu" in "WorkFlow UI" screen
    And User validate Preferences table header under "Preferences" in "WorkFlow UI" screen
      | Order | Group | Applications | Role | Updated By | Last Updated On | Action |
    # And User verify group name and App Name under my task again default preference in "WorkFlow UI" screen
    And User Reorder preferences and verify group name and App Name under my task again default preference in "WorkFlow UI" screen
    And User change default "Application" and validate under my task when login in "WorkFlow UI" screen
    And User change default "Role" and validate under my task when login in "WorkFlow UI" screen
