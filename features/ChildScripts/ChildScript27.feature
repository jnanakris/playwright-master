Feature: Add New status and use that in event actions

  @ChildScript
  @ChildScript27
  @addStatus
  #Created By: Mohan.S

  Scenario: Use case to demonstrate to add status in actions

    # #CreateGroup
    Given user login to "Finlevit_admin" with "GroupAdmins" credentials
    And User get the Test data from "Usecase_TestData/ChildScript27" json file in "WorkFlow UI" screen
    Then User will open "GroupName" group in "HomePage" screen

    # To Create an Application
    Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
    Then User will search for "Application_Name" in "Application" screen
    Then User see text "Front Office" in "FO" in "Page" screen
    # To Design Front Office
    And User add status and name as "Completed" and "No" endTask in "Status" screen
    Then User click on "FrontOffice" "Click_FrontOffice" in "Application" screen
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget    | X   | Y   | FieldName            | Title                |
      | Container | 200 | 100 | PersonalInformation | Personal Information |
    When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget               | X   | Y   |
      | Personal Information | 850 | 500 |
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget     | X   | Y   | FieldName | FieldLabel | Action | Status    | PlaceHolder        |
      | Text Input | 275 | 200 | FirstName | First Name |        |           |                    |
      | Text Input | 575 | 200 | LastName  | Last Name  |        |           |                    |
      | Email      | 575 | 400 | Email     | Email      |        |           | example@domain.com |
      | Button     | 675 | 800 | Submit    | Submit     | Submit | Save      |                    |
      | Button     | 475 | 800 | Save      | Save       | Save   | Completed |                    |
    Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
    #Add Status
    And User wait for "3000"
    Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
    Then User see text "Back Office" in "BO" in "Page" screen
    And User add status and name as "Proceed" and "Yes" endTask in "Status" screen
    And User add status and name as "API CAll is Success" and "Yes" endTask in "Status" screen
    And User add status and name as "API CAll is failed" and "No" endTask in "Status" screen
    Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
    Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
      | Widget               | X   | Y   |
      | PersonalInformation | 200 | 100 |
    # # And User write "Front Office" widgets in "FrontOffice_Widgets" in "UniqueWidgetFields" screen
    # # And User write "Back Office" widgets in "BackOffice_Widgets" in "UniqueWidgetFields" screen

    Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
    Then User click on "tab" "Workflow Design" in "backOffice" screen
    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
      | Widget | X   | Y   |
      | Start  | 150 | 300 |

    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
      | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status |
      | Task   | 400 | 300 | Review1  | Application Manager | 1           | Accept  | Proceed       |

    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
      | Widget   | X   | Y   | TaskName      | SuccesStatus        | FailedStatus       | FailureTaskRole     | DataSource      | DataList             |
      | API Task | 600 | 300 | Create Record | API CAll is Success | API CAll is failed | Application Manager | EmployeeDetails | Save EmployeeDetails |
    When User Edit "API task" "Create Record" field to Configure Service in "tasks" screen
    Then User will create transformation rule for "API Task" "Save Employee" and connect Input and Output nodes in "transformation" screen
      | Destination | Source    |
      | FirstName   | FirstName |
      | LastName    | LastName  |
      | Email       | Email     |

    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
      | Widget | X   | Y   | 
      | End    | 900 | 300 | 
    Then User will connect "tasks" in "BackOfficeCanvas"
      | Source        | Action  | Target        |
      | Start         |         | Review1       |
      | Review1       | Accept  | Create Record |
      | Create Record | Success | End       |

    Then User click on "button" "VersionControl" in "Version" screen
    Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
    # To validate Preview
    And User validate Payload app opening in a new tab
    # Payload Validation
    Given user login to payload application with "Finlevit_payload" with "1" agent
    #Enter Data
    And User enter "text" in "First Name" with "7" characters
    And User enter "text" in "Last Name" with "7" characters
    And User enter "email" in "Email" with "5" characters
    And User wait for "1000"
    # Then User click on "Button" widget "Submit" in "payload" screen
    # And User get Transaction Id and save it in json file




