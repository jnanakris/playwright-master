Feature: Application to validate SLA with Followup task with Manual Task

  # @ChildScript
  @ChildScript34
  #Createdby: Mary
  #CreatedDate:05/29/2023
  Scenario: Use case to validate SLA with Followup task with Manual Task
    Given user login to "Finlevit_admin" with "GroupAdmins" credentials
    And User get the Test data from "Usecase_TestData/ChildScript34" json file in "WorkFlow UI" screen
    Then User will open "GroupName" group in "HomePage" screen

    # To Create an Application
    Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
    Then User will search for "Application_Name" in "Application" screen
    And User wait for "2000"
    Then User see text "Front Office" in "FO" in "Page" screen

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
      | Widget | X   | Y   | FieldName | FieldLabel |
      | SSN    | 60  | 420 | SSN_ITIN  | SSN/ITIN   |
      | Number | 275 | 420 | Salary    | Salary     |

    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget | X  | Y   | FieldName | FieldLabel | Action | Status |
      | Button | 50 | 600 | Submit    | Submit     | Submit | Save   |

    # # And User write "Front Office" widgets in "FrontOffice_Widgets" in "UniqueWidgetFields" screen
    # Edit existing role
    Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
    # To Design Back Office
    Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
    Then User see text "Back Office" in "BO" in "Page" screen
    # Drag the Front Office widgets onto Back office Canvas
    Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
      | Widget              | X  | Y  |
      | EmployerInformation | 50 | 50 |
    # # And User write "Back Office" widgets in "BackOffice_Widgets" in "UniqueWidgetFields" screen


    # Edit existing role
    Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
    Then User click on "tab" "Workflow Design" in "backOffice" screen
    # To Add the required tasks onto the workflow Designer
    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
      | Widget | X   | Y   |
      | Start  | 230 | 250 |

    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
      | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
      | Task   | 500 | 250 | Review   | Application Manager | 1           | Accept  | In Progress   | 2        | 0       |

    And User will Edit the task "Review" and add Followup Task in "tasks" page
      | TaskName          | Role                | WaitTime | Frequency | WhentoStart | SLAHours |
      | Validate Followup | Application Manager | 3        | 1         | 1           | 2        |
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
    # Payload1
    Given user login to payload application with "Finlevit_payload" with "1" agent
    And User wait for "1000"
    And User enter "text" in "Employer ID" with "5" characters
    And User enter "text" in "Employer Name" with "5" characters
    And User Fill "Full Time" in "Radio Group" widget "Job Type" in "payload" screen
    And User enter "SSN" in "SSN/ITIN" with "9" characters
    And User enter "number" in "Salary" with "5" characters
    Then User click on "Button" widget "Submit" in "payload" screen
    #    And User wait until the spinner appears
    #    And User wait until the spinner disappears
    And User get Transaction Id and save it in json file
    # Validate Workflow UI - Follow up with No Response (Follow-up task will be removed and original task will still open)
    Given user login to workflow UI "Finlevit_workflow" with "1" "AppManager" credentials
    And User wait until the "Filter Transaction id" appears in "WorkFlow UI" screen
    Then User click on "Button" "Home" in "HomePage" screen
    Then User will open "GroupName" group in "HomePage" screen
    And User wait until the spinner disappears
    Then User will search for "Application_Name" in "Application" screen
    And User wait for "5000"
    And As "Agent" user verify Task "1" Details under "Team Task" in "WorkFlow UI" screen
    # And User wait for "75000"
    And User wait for "80000"
    And User wait for "60000"
    And As "Agent" user verify Task "1" Followup task Details under "Team Task" in "WorkFlow UI" screen
    Then Based on the Task assigned to person logout or continue with the same user in "WorkFlow UI" screen for "Application_Name"
    And As "Application Manager" user verify Task "1" Followup task Details under "My Task" in "WorkFlow UI" screen
    # Validate SLA
    And User validate SLA started when task is started in "WorkFlow UI" screen
    Then User Suspend the task for "1" hour and Continue SLA in "WorkFlow UI" screen
    # Validate widgets in WF
    Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
    And User validate left side menu options for the Task in "WorkFlow UI" screen
    And User validate "Text Input" widget "Employer ID" is not empty in "WorkFlow UI" screen
    And User validate "Text Input" widget "Employer Name" is not empty in "WorkFlow UI" screen
    And User validate "Radio Group" widget "Job Type" is not empty in "WorkFlow UI" screen
    And User validate "Number" widget "Salary" is not empty in "WorkFlow UI" screen
    And User validate "SSN / ITIN" widget "SSN/ITIN" is not empty in "WorkFlow UI" screen
    # Complete action
    And User select drop down option "Submit" in "Actions Dropdown" in "WorkFlow UI" screen
    And User select "span" tag drop down option "No" in "Followup GotResponse Dropdown" in "WorkFlow UI" screen
    Then User click on "button" "OkButton" in "WorkFlow UI" screen
    And User validate Followup task removed from "Team Task" in "WorkFlow UI" screen
    And User wait for "50000"
    Then User click on "Menu" "My Task" in "WorkFlow UI" screen
    Then User click on "Menu" "Team Task" in "WorkFlow UI" screen
    # And User validate Transaction details are removed from "Team Task" in "WorkFlow UI" screen
    Then User will "Logout" from "Page" the current session

