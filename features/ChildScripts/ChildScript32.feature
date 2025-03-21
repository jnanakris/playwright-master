
Feature: Edit/Delete Task in workflow Designer

  @ChildScript
  @ChildScript32
  @editTask
  #Created By: Mohan.S

  Scenario: Use case to demonstrate the Edit/Delete Task in workflow Designer

    #CreateGroup
    Given user login to "Finlevit_admin" with "GroupAdmins" credentials
    And User get the Test data from "Usecase_TestData/ChildScript32" json file in "WorkFlow UI" screen
    Then User will open "GroupName" group in "HomePage" screen
    # To Create an Application
    Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
    Then User will search for "Application_Name" in "Application" screen
    Then User see text "Front Office" in "FO" in "Page" screen
    # To Design Front Office

    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget    | X   | Y   | FieldName            | Title                |
      | Container | 200 | 100 | PersonalInformation | Personal Information |
    When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget               | X   | Y   |
      | Personal Information | 850 | 500 |

    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget     | X   | Y   | FieldName  | FieldLabel | Action | Status | PlaceHolder        |
      | Text Input | 275 | 200 | FirstName | First Name |        |        |                    |
      | Text Input | 575 | 200 | LastName  | Last Name  |        |        |                    |
      | Email      | 575 | 400 | Email      | Email      |        |        | example@domain.com |
      | Button     | 675 | 800 | Submit     | Submit     | Submit | Save   |                    |


    Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
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
      | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status | Action2 | Action2Status |
      | Task   | 400 | 300 | Review1  | Application Manager | 2           | Accept  | In Progress   | Reject  | In Progress   |

    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
      | Widget | X   | Y   | TaskName     | Role                | noOfActions | Action1 | Action1Status |
      | Task   | 850 | 300 | Final Review | Application Manager | 1           | Accept  | In Progress   |

    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
      | Widget | X    | Y   | TaskName  |
      | End    | 1200 | 300 | End Task1 |

    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
      | Widget | X   | Y   | TaskName  |
      | End    | 400 | 600 | End Task2 |


    Then User will connect "tasks" in "BackOfficeCanvas"
      | Source       | Action | Target       |
      | Start        |        | Review1      |
      | Review1      | Accept | Final Review |
      | Review1      | Reject | End Task2    |
      | Final Review | Accept | End Task1    |

    Then User click on "button" "VersionControl" in "Version" screen
    Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen

    And User wait for "2000"
    Then User click on "button" "VersionControl" in "Version" screen
    When User checkout the version "latest version" for app modification
    Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
    Then User click on "tab" "Workflow Design" in "backOffice" screen
    And User wait for "2000"

    Then User will delete the action "Reject" in "Review1" task in "tasks" screen
    Then User will edit the "Review1" task in "tasks" page
      | TaskName      | Role  | Action1 | ActionEdit1 | Action2 | ActionEdit2 |
      | Review-Edited | Agent | Accept  | Approve     | Reject  | Delete      |


    Then User will delete the task "End Task2" in "tasks" page
    Then User will delete the task "Final Review" in "tasks" page
    Then User click on "button" "Save" in "workflowDesigner" screen
    Then User will connect "tasks" in "BackOfficeCanvas"
      | Source        | Action  | Target    |
      | Review-Edited | Approve | End Task1 |

    Then User click on "button" "VersionControl" in "Version" screen
    Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen

    And User validate Payload app opening in a new tab
    # Payload Validation
    Given user login to payload application with "Finlevit_payload" with "1" agent
    #Enter Data
    And User enter "text" in "First Name" with "7" characters
    And User enter "text" in "Last Name" with "7" characters
    And User enter "email" in "Email" with "5" characters
    And User wait for "1000"
    Then User click on "Button" widget "Submit" in "payload" screen
    And User get Transaction Id and save it in json file
    # #WorkFlow UI
    Given user login to workflow UI "Finlevit_workflow" with "1" "AppManager" credentials
    And User wait until the "Filter Transaction id" appears in "WorkFlow UI" screen
    Then User click on "Button" "Home" in "HomePage" screen
    Then User will open "GroupName" group in "HomePage" screen
    Then User will search for "Application_Name" in "Application" screen
    And User wait for "2000"
    # And User validate Transaction table header under "Team Task" in "WorkFlow UI" screen
    #  | SLA | Transaction Id | Task Name | Priority | Created At | Submitted By | Last Updated By | Last Updated At | Assigned To |
    And As "Agent" user verify Task "1" Details under "Team Task" in "WorkFlow UI" screen
    Then Based on the Task assigned to person logout or continue with the same user in "WorkFlow UI" screen for "Application_Name"
    # And User validate Transaction table header under "Team Task" in "WorkFlow UI" screen
 #     | SLA | Transaction Id | Task Name | Priority | Created At | Submitted By | Last Updated By | Last Updated At | Assigned To |
    And As "Application Manager" user verify Task "1" Details under "Team Task" in "WorkFlow UI" screen
    Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
    And User validate left side menu options for the Task in "WorkFlow UI" screen
    And User wait for "4000"
    Then User validate Task "1" Actions and select "Approve" action in "WorkFlow UI" screen
    And User wait for "2000"