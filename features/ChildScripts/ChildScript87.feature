Feature: Validate FO-OLT and BO-Populate event

  @BODataPopulation @ChildScript87
  #Createdby: Mary
  #CreatedDate:04/20/2023
  Scenario Outline: Validate FO-OLT and BO-Populate event

    Given user login to "Finlevit_admin" with "GroupAdmins" credentials
    And User get the Test data from "Usecase_TestData/ChildScript87" json file in "WorkFlow UI" screen
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
    And User wait until the spinner disappears
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget    | X  | Y  | FieldName     | Title                                  |
      | Container | 25 | 25 | ChildScript87 | Child Script 87 - Personal Information |
    When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget          | X    | Y   |
      | Child Script 87 | 1050 | 600 |

    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget     | X   | Y   | FieldName | FieldLabel |
      | Text Input | 50  | 125 | Pin       | Pin        |
      | Text Input | 300 | 125 | FirstName | First Name |
      | Text Input | 550 | 125 | LastName  | Last Name  |

    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget      | X  | Y   | FieldName | FieldLabel | ValuesAlignment    | ValueCount | Value1 | Value2 |
      | Radio Group | 50 | 300 | Gender    | Gender     | ValueAlignVertical | 2          | Male   | Female |

    And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget   | X   | Y   | FieldName | FieldLabel | OptionType       |
      | Dropdown | 300 | 300 | Country   | Country    | ConfigureOptions |

    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget | X   | Y   | FieldName | FieldLabel | PlaceHolder        |
      | Email  | 550 | 300 | Email     | Email      | example@domain.com |

    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget | X   | Y   | FieldName | FieldLabel | Action | Status |
      | Button | 150 | 650 | Submit    | Submit     | Submit | Save   |
    Then User click on "span" "Save" in "Page" screen

    #To set Onload Triggers for Countries dropdown
    And User create Onload Triggers with "1" Rule Options Mapping "addOnloadTrigger" in "onLoadTrigger" screen
      | Name          | Description   | DataSource | DataList          | Rule1 | Ref1 | Field1  | Label1 | Value1 | DefaultValue1 |
      | Get Countries | Get Countries | Countries  | Get All Countries | Rule1 | CN   | Country | name   | iso2   | US            |

    # Edit existing role
    Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
    # To Design Back Office
    Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
    Then User see text "Back Office" in "BO" in "Page" screen
    Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
      | Widget        | X  | Y  |
      | ChildScript87 | 50 | 50 |
    Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
    And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget     | X   | Y   | FieldName  | FieldLabel  |
      | Text Input | 50  | 475 | employerID | Employer ID |
      | Number     | 300 | 475 | Salary     | Salary      |
      | SSN        | 550 | 475 | ssnNumber  | SSN         |

    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget | X   | Y   | FieldName | FieldLabel | Action | Status |
      | Button | 550 | 650 | fetch     | Fetch      | None   | Save   |

    Then User click on "span" "Save" in "Page" screen
    And User create an Event Configuration in "EventConfigurations" screen
      | EventName              | EventType | Widget | DataSource      | DataList                  | Type | UniqueField | Value |
      | Get By Id Employer API | Populate  | fetch  | EmployerDetails | Get By Id EmployerDetails | ref  | EmployerPin | Pin   |
    Then User will create transformation rule for "Populate" "Get By Id Employer API" and connect Input and Output nodes in "transformation" screen
      | Destination | Source     |
      | employerID  | EmployerId |
      | Salary      | Salary     |
      | ssnNumber   | ITIN       |

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
    And User Fill "mross" in "Text Input" widget "Pin" in "payload" screen
    And User Fill "Mike" in "Text Input" widget "First Name" in "payload" screen
    And User Fill "Ross" in "Text Input" widget "Last Name" in "payload" screen
    And User Fill "Male" in "Radio Group" widget "Gender" in "payload" screen
    And User enter "email" in "Email" with "5" characters
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
    And User validate left side menu options for the Task in "WorkFlow UI" screen
    And User wait for "3000"
    And User wait until the spinner disappears
    Then User click on "Button" widget "Fetch" in "payload" screen
    And User wait for "3000"
    And User wait until the spinner disappears
    And User validate "Text Input" widget "Employer ID" is not empty in "payload" screen
    And User validate "Number" widget "Salary" is not empty in "payload" screen
    And User validate "SSN / ITIN" widget "SSN" is not empty in "payload" screen
    Then User validate Task "1" Actions and select "Accept" action in "WorkFlow UI" screen
    And User wait for "5000"
    And User validate Transaction details are removed from "Team Task" in "WorkFlow UI" screen

