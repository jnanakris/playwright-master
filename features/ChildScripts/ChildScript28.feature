Feature: Validate Queue Task
    @ChildScript28 
    # @ChildScript
    @QueueTask
    #Createdby: Mohan S

    Scenario: Use case to cover QueueTask in WF UI
        # JSON Outbound file
        Given user login to "Finlevit_admin" with "Admin" credentials
        And User get the Test data from "Usecase_TestData/ChildScript28" json file in "WorkFlow UI" screen
        And User test connection for the queue in "queue" screen
        Then User click on "Menu" "fileSetupMenu" in "HomePage" screen
        And User use below "Require Fields" when create app source setup in "fileSetup" screen
            | FieldName   | DataType | IsRequired | MaxLength |
            | FirstName   | string   | Yes        | 10        |
            | Email       | string   | Yes        | 15        |
            # | IsUSCitizen | boolean  | Yes        |         |
            | LastName    | string   | Yes        | 12        |
            | Phone       | string   | Yes        | 10        |
            | Pin         | string   | Yes        | 10        |

        Then User will create file setup with "JSON" file in "fileSetup" screen
            | FileType   | FileUpload      |Destination|
            | JSON       | AutomationPrimary.json |Queue|

        Then User click on "Button" "Home" in "HomePage" screen
        Then User will open "GroupName" group in "HomePage" screen
        # To Create an Application
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "1000"

        # widget
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X  | Y  | FieldName    | Title         |
            | Container | 25 | 25 | PersonalInfo | Personal Info |
        When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget        | X    | Y   |
            | Personal Info | 1100 | 900 |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName | FieldLabel | Action | Status |
            | Text Input | 50  | 125 | Pin       | Pin        |        |        |
            | Text Input | 300 | 125 | firstName | First Name |        |        |
            | Text Input | 550 | 125 | lastName  | Last Name  |        |        |
            | Button     | 850 | 650 | Submit    | Submit     | Submit | Save   |

        And User wait for "1000"
        Then User click on "button" "Save" in "expressionBuilder" screen
        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget       | X  | Y  |
            | PersonalInfo | 25 | 25 |
        Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName   | FieldLabel    | PlaceHolder        |
            | Email      | 50  | 300 | email       | Email         | example@domain.com |
            | Text Input | 300 | 300 | phoneNumber | Phone Number  |                    |
            | Checkbox   | 550 | 300 | IsUSCitizen | Is US Citizen |                    |

        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 150 | 225 |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
            | Task   | 400 | 150 | Review   | Application Manager | 1           | Accept  | In Progress   | 1        | 0       |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget    | X   | Y   | TaskName | FileName     | SuccesStatus | FailedStatus | FailureTaskRole     |
            | QueueTask | 700 | 150 | Queue    | #FileNameinFileSetup | In Progress  | In Progress  | Application Manager |
        When User Edit "Queue task" "Queue" field to Configure Service in "tasks" screen
        Then User will create transformation rule for "QueueTask" "Save Employee" and connect Input and Output nodes in "transformation" screen
            | Destination | Source      |
            | Pin         | Pin         |
            | FirstName   | firstName   |
            | LastName    | lastName    |
            | Email       | email       |
            | Phone       | phoneNumber |
            | IsUSCitizen | IsUSCitizen |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName |
            | End    | 900 | 150 | End1     |
        # Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
        #     | Widget | X   | Y   | TaskName |
        #     | End    | 700 | 400 | End2     |
        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source | Action  | Target |
            | Start  |         | Review |
            | Review | Accept  | Queue  |
            | Queue  | Success | End1   |
            # | Queue  | Failed  | End2   |

        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        #  To validate Preview
        And User validate Payload app opening in a new tab
        # Payload
        Given user login to payload application with "Finlevit_payload" with "1" agent
        And User enter "text" in "Pin" with "5" characters
        And User enter "text" in "First Name" with "7" characters
        And User enter "text" in "Last Name" with "7" characters
        Then User click on "Button" widget "Submit" in "payload" screen
        And User get Transaction Id and save it in json file
        # WorkflowUI
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
        And User enter "email" in "Email" with "5" characters
        And User enter "phoneNumber" in "Phone Number" with "10" characters
        And User validate "Text Input" widget "Pin" is not empty in "payload" screen
        And User validate "Text Input" widget "First Name" is not empty in "payload" screen
        And User validate "Text Input" widget "Last Name" is not empty in "payload" screen
        And User validate "Email" widget "Email" is not empty in "payload" screen
        And User validate "Phone Number" widget "Phone Number" is not empty in "payload" screen
        And User Fill "Is US Citizen" in "Checkbox" widget "Is US Citizen" in "payload" screen
        Then User validate Task "1" Actions and select "Accept" action in "WorkFlow UI" screen
        And User wait for "1000"
        And User validate Transaction details are removed from "Team Task" and it is displaying under "History" on the successful workflow completion in "WorkFlow UI" screen
        Then User will "Logout" from "Page" the current session











