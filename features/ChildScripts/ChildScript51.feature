Feature: Validate Reason Required, Comment Required actions in Manual task

  @ChildScript
  @ChildScript51 @ChildScript61
    #Created By: Mary
  Scenario: Usecase to Validate Reason Required, Comment Required actions in Manual task and Manual Task assign in workflow UI

    Given user login to "Finlevit_admin" with "GroupAdmins" credentials
    And User get the Test data from "Usecase_TestData/ChildScript51" json file in "WorkFlow UI" screen
    Then User will open "GroupName" group in "HomePage" screen
    Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
    And User wait until the spinner disappears 
        # Edit the App and uncheck AutoAssignTasks checkbox
    And User edit application in "Application" screen
    Then User click on "checkbox" "AutoAssignTasks Checkbox" in "Application" screen
    Then User click on "button" "create_app_save_button" in "Application" screen
    Then User click on "icon" "clear_app_search" in "Application" screen
    And User wait until the spinner disappears
        # search for application
    Then User will search for "Application_Name" in "Application" screen
    Then User see text "Front Office" in "FO" in "Page" screen
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget    | X   | Y   | FieldName            | Title                |
      | Container | 100 | 200 | PersonalInformation | Personal Information |
    When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget               | X   | Y   |
      | Personal Information | 900 | 600 |
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget       | X   | Y   | FieldName   | FieldLabel  | PlaceHolder        | OptionType | Action | Status |
      | Text Input   | 250 | 300 | FirstName   | FirstName   |                    |            |        |        |
      | Text Input   | 500 | 300 | LastName    | LastName    |                    |            |        |        |
      | Text Input   | 750 | 300 | Pin         | Pin         |                    |            |        |        |
      | Email        | 250 | 500 | Email       | Email       | example@domain.com |            |        |        |
      | Phone Number | 500 | 500 | PhoneNumber | PhoneNumber |                    |            |        |        |
      | SSN          | 750 | 500 | SSN_ITIN    | SSN/ITIN    |                    |            |        |        |
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget | X   | Y   | FieldName | FieldLabel | Action | Status |
      | Button | 750 | 700 | Submit    | Submit     | Submit | Save   |

    Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
    Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
    Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
      | Widget               | X   | Y   |
      | PersonalInformation | 100 | 200 |

    Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
    Then User click on "tab" "Workflow Design" in "backOffice" screen
    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
      | Widget | X   | Y   |
      | Start  | 150 | 225 |
    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
      | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays | NoofReason | Reason1 | Reason2      | IsComment | AssignNextTask |
      | Task   | 400 | 200 | Review   | Application Manager | 1           | Accept  | In Progress   | 1        | 0       | 2          | IGO     | Correct Data | Yes       | Yes            |

    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
      | Widget | X   | Y   | TaskName     | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
      | Task   | 663 | 200 | Final-Review | Application Manager | 1           | Accept  | In Progress   | 1        | 0       |
    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
      | Widget | X   | Y   |
      | End    | 930 | 200 |
    Then User will connect "tasks" in "BackOfficeCanvas"
      | Source       | Action | Target       |
      | Start        |        | Review       |
      | Review       | Accept | Final-Review |
      | Final-Review | Accept | End          |
    Then User click on "button" "VersionControl" in "Version" screen
    Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        #  To validate Preview
    And User validate Payload app opening in a new tab
        # Payload Validation
    Given user login to payload application with "Finlevit_payload" with "1" agent
    And User enter "text" in "FirstName" with "7" characters
    And User enter "text" in "LastName" with "7" characters
    And User enter "text" in "Pin" with "7" characters
    And User enter "email" in "Email" with "5" characters
    And User enter "phoneNumber" in "PhoneNumber" with "10" characters
    And User enter "SSN" in "SSN/ITIN" with "9" characters
    And User wait for "5000"
    Then User click on "button" "Submit_btn" in "payload" screen
    And User get Transaction Id and save it in json file
        #Workflow
    Given user login to workflow UI "Finlevit_workflow" with "1" "AppManager" credentials
    And User wait until the "Filter Transaction id" appears in "WorkFlow UI" screen
    Then User click on "Button" "Home" in "HomePage" screen
    Then User will open "GroupName" group in "HomePage" screen
    Then User will search for "Application_Name" in "Application" screen
    And User wait for "5000"
    And As "Application Manager" user verify Task "1" Details under "Team Task" in "WorkFlow UI" screen
    And User validate task is unassigned and assign to "1" user in "AppManager" in "WorkFlow UI" screen
    Then Based on the Task assigned to person logout or continue with the same user in "WorkFlow UI" screen for "Application_Name"
    And As "Application Manager" user verify Task "1" Details under "My Task" in "WorkFlow UI" screen
    Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
    And User validate left side menu options for the Task in "WorkFlow UI" screen
    And User wait for "5000"
    Then User validate Task "1" Actions and select "Accept" action in "WorkFlow UI" screen
    And User select "span" tag drop down option "IGO" in "Followup Reason Dropdown" in "WorkFlow UI" screen
    And User Fill "Completed Task Review" in "Followup Comment" in "WorkFlow UI" screen
    Then User click on "button" "OkButton" in "WorkFlow UI" screen
        #FinalTask
    And As "Application Manager" user verify Task "2" Details under "Team Task" in "WorkFlow UI" screen
    And User validate task is unassigned and assign to "1" user in "AppManager" in "WorkFlow UI" screen
        # And As Assign Next Task To Task Originator is set in admin the task is assigned to the previous task user in "WorkFlow UI" screen
    Then Based on the Task assigned to person logout or continue with the same user in "WorkFlow UI" screen for "Application_Name"
    And As "Application Manager" user verify Task "2" Details under "My Task" in "WorkFlow UI" screen
    Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
    And User wait for "2000"
    Then User validate Task "2" Actions and select "Accept" action in "WorkFlow UI" screen
    And User validate Transaction details are removed from "Team Task" in "WorkFlow UI" screen
    And User wait for "5000"







