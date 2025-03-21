Feature: Email Task and manual task mapped to merge task and then one manual task as review

  @ChildScript
  @ChildScript16
  @mergeTask
  #Created By: Mohan.s
  Scenario: End to end till workflow using email and merge task

    #CreateGroup
    Given user login to "Finlevit_admin" with "GroupAdmins" credentials
    And User get the Test data from "Usecase_TestData/ChildScript16" json file in "WorkFlow UI" screen
    Then User will open "GroupName" group in "HomePage" screen
    # To Create an Application
    Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
    Then User will search for "Application_Name" in "Application" screen
    Then User see text "Front Office" in "FO" in "Page" screen
    # To Design Front Office
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget    | X   | Y   | FieldName       | Title                                  |
      | Container | 200 | 100 | ChildScript16 | Child Script 16 - Personal Information |
    When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget          | X   | Y   |
      | Child Script 16 - Personal Information | 850 | 500 |
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget       | X   | Y   | FieldName    | FieldLabel   | Action | Status | PlaceHolder        |
      | Text Input   | 275 | 200 | FirstName   | First Name   |        |        |                    |
      | Text Input   | 575 | 200 | LastName    | Last Name    |        |        |                    |
      | Phone Number | 275 | 400 | PhoneNumber | Phone Number |        |        |                    |
      | Email        | 575 | 400 | Email        | Email        |        |        | example@domain.com |
      | Address      | 275 | 600 | Address      | Address      |        |        |                    |
      | Button       | 675 | 800 | Submit       | Submit       | Submit | Save   |                    |
    Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
    Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
    Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
      | Widget          | X   | Y   |
      | ChildScript16 | 200 | 100 |
      | Address         | 275 | 600 |
    # # And User write "Front Office" widgets in "FrontOffice_Widgets" in "UniqueWidgetFields" screen
    # # And User write "Back Office" widgets in "BackOffice_Widgets" in "UniqueWidgetFields" screen

    Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
    Then User click on "tab" "Workflow Design" in "backOffice" screen
    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
      | Widget | X   | Y   |
      | Start  | 150 | 300 |
    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
      | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
      | Task   | 400 | 100 | Review1  | Application Manager | 1           | Accept  | In Progress   | 1        | 0       |
    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
      | Widget | X   | Y   | TaskName | To     | Sub     | Template | FailureTaskRole     |
      | Email  | 400 | 500 | Email    | @Email | MailSub | MailBody | Application Manager |
    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
      | Widget | X   | Y   | TaskName           | Status      |
      | Merge  | 650 | 300 | Merge After Review | In Progress |
    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
      | Widget | X   | Y   | TaskName     | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
      | Task   | 850 | 300 | Final Review | Application Manager | 1           | Accept  | In Progress   | 1        | 0       |
    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
      | Widget | X    | Y   | 
      | End    | 1200 | 300 | 
    Then User will connect "tasks" in "BackOfficeCanvas"
      | Source       | Action | Target       |
      | Start        |        | Review1      |
      | Start        |        | Email        |
      | Review1      | Accept | Merge        |
      | Email        |        | Merge        |
      | Merge        |        | Final Review |
      | Final Review | Accept | End      |
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
    And User enter "phoneNumber" in "Phone Number" with "10" characters
    And User enter "number" in "Address" with "3" characters
    And User wait for "1000"
    Then User select on "Address" "SelectFirstAddress" in "payload" screen
    Then User click on "Button" widget "Submit" in "payload" screen
    And User get Transaction Id and save it in json file
    #WorkFlow UI
    Given user login to workflow UI "Finlevit_workflow" with "1" "AppManager" credentials
    And User wait until the "Filter Transaction id" appears in "WorkFlow UI" screen
    Then User click on "Button" "Home" in "HomePage" screen
    Then User will open "GroupName" group in "HomePage" screen
    Then User will search for "Application_Name" in "Application" screen
    And User wait for "5000"
    #Task1
    # And User validate Transaction table header under "Team Task" in "WorkFlow UI" screen
    #  | SLA | Transaction Id | Task Name | Priority | Created At | Submitted By | Last Updated By | Last Updated At | Assigned To |
    And As "Agent" user verify Task "1" Details under "Team Task" in "WorkFlow UI" screen
    Then Based on the Task assigned to person logout or continue with the same user in "WorkFlow UI" screen for "Application_Name"
    # And User validate Transaction table header under "Team Task" in "WorkFlow UI" screen
    #     | SLA | Transaction Id | Task Name | Priority | Created At | Submitted By | Last Updated By | Last Updated At | Assigned To |
    And As "Application Manager" user verify Task "1" Details under "My Task" in "WorkFlow UI" screen
    Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
    Then User click on "History" "TaskHistory" in "WorkFlow UI" screen
    Then User validates Tasks event and Action as "Success" in "WorkFlow UI" screen
      | Task  |
      | Email |
    Then User click on "Task" "My Task" in "WorkFlow UI" screen
    Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
    And User validate left side menu options for the Task in "WorkFlow UI" screen
    Then User validate Task "1" Actions and select "Accept" action in "WorkFlow UI" screen
    And User wait for "5000"
    #Task2
    And As "Agent" user verify Task "2" Details under "Team Task" in "WorkFlow UI" screen
    Then Based on the Task assigned to person logout or continue with the same user in "WorkFlow UI" screen for "Application_Name"
    # And User validate Transaction table header under "Team Task" in "WorkFlow UI" screen
    #     | SLA | Transaction Id | Task Name | Priority | Created At | Submitted By | Last Updated By | Last Updated At | Assigned To |
    And As "Application Manager" user verify Task "2" Details under "My Task" in "WorkFlow UI" screen
    Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
    And User validate left side menu options for the Task in "WorkFlow UI" screen
    Then User validate Task "2" Actions and select "Accept" action in "WorkFlow UI" screen
    And User wait for "5000"
    And User validate Transaction details are removed from "Team Task" in "WorkFlow UI" screen


