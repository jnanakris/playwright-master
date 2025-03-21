Feature: API task,Manual task,Email task is executed parallel to the merge task and one manual task after merge task

    @ChildScript
    @ChildScript21
    @mergeTask2
    #Created By: Mohan
   
    Scenario: Use case to demonstrate merge task with combination of API task, MAnual Task, Email task

        #CreateGroup
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "Usecase_TestData/ChildScript21" json file in "WorkFlow UI" screen
        Then User will open "GroupName" group in "HomePage" screen
        Then User click on "button" "group_settings" in "Groups" screen
        Then User click on "button" "dataSources" in "onLoadTrigger" screen
        And User get unique field in Data Source "EmployeeDetails" in "onLoadTrigger" screen and save it in "EmployeePin"
        Then User will open "GroupName" group in "HomePage" screen
        # To Create an Application
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        Then User see text "Front Office" in "FO" in "Page" screen
        # To Design Front Office

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X   | Y   | FieldName            | Title                |
            | Container | 25 | 25 | PersonalInformation | Personal Information |

        When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget               | X    | Y   |
            | Personal Information | 1050 | 600 |

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget       | X   | Y   | FieldName   | FieldLabel  | PlaceHolder        | OptionType | Action | Status |
            | Text Input   | 50  | 125 | FirstName   | FirstName   |                    |            |        |        |
            | Text Input   | 300 | 125 | LastName    | LastName    |                    |            |        |        |
            | Text Input   | 550 | 125 | Pin         | Pin         |                    |            |        |        |
            | Email        | 50  | 300 | Email       | Email       | example@domain.com |            |        |        |
            | Phone Number | 300 | 300 | PhoneNumber | PhoneNumber |                    |            |        |        |
            | SSN          | 550 | 300 | ssnNumber   | SSN         |                    |            |        |        |

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X    | Y   | FieldName | FieldLabel | Action | Status |
            | Button | 150 | 474 | Submit    | Submit     | Submit | Save   |

        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget               | X   | Y   |
            | PersonalInformation | 100 | 200 |

        # # And User write "Front Office" widgets in "FrontOffice_Widgets" in "UniqueWidgetFields" screen
        # # And User write "Back Office" widgets in "BackOffice_Widgets" in "UniqueWidgetFields" screen


        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 150 | 300 |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status |SLAHours | SLADays |
            | Task   | 377 | 107 | Review1  | Application Manager | 1           | Accept  | In Progress   |1        | 0       |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | To     | Sub     | Template | FailureTaskRole     |
            | Email  | 378 | 261 | Email    | @Email | MailSub | MailBody | Application Manager |
        
        # Create API task and Assign Destination and Source
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget   | X   | Y   | TaskName      | SuccesStatus | FailedStatus | FailureTaskRole     |DataSource      | DataList             |
            | API Task | 372 | 419 | Create Record | In Progress  | In Progress  | Application Manager |EmployeeDetails | Save EmployeeDetails |
    
        When User Edit "API task" "Create Record" field to Configure Service in "tasks" screen
        Then User will create transformation rule for "API Task" "Save Employee" and connect Input and Output nodes in "transformation" screen
            | Destination | Source      |
            | FirstName   | FirstName   |
            | LastName    | LastName    |
            | Pin         | Pin         |
            | Email       | Email       |
            | Phone       | PhoneNumber |
            | SSN         | ssnNumber     |
        
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName           | Status      |
            | Merge  | 596 | 261 | Merge After Review | In Progress |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName     | Role                | noOfActions | Action1 | Action1Status |SLAHours | SLADays |
            | Task   | 742 | 266 | Final Review | Application Manager | 1           | Accept  | In Progress   |1        | 0       |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X    | Y   | 
            | End    | 979 | 295 | 

        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source        | Action  | Target        |
            | Start         |         | Review1       |
            | Start         |         | Email         |
            | Start         |         | Create Record |
            | Review1       | Accept  | Merge         |
            | Email         |         | Merge         |
            | Create Record | Success | Merge         |
            | Merge         |         | Final Review  |
            | Final Review  | Accept  | End      |

        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        # To validate Preview
        And User validate Payload app opening in a new tab
        # Payload Validation
        Given user login to payload application with "Finlevit_payload" with "1" agent
        #Enter Data
        And User enter "text" in "FirstName" with "7" characters
        And User enter "text" in "LastName" with "7" characters
        And User enter "text" in "Pin" with "7" characters
        And User enter "email" in "Email" with "5" characters
        And User enter "phoneNumber" in "PhoneNumber" with "10" characters
        And User enter "SSN" in "SSN" with "9" characters
        And User wait for "1000"
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
        #     | SLA | Transaction Id | Task Name | Priority | Created At | Submitted By | Last Updated By | Last Updated At | Assigned To |
        And As "Agent" user verify Task "1" Details under "Team Task" in "WorkFlow UI" screen
       Then Based on the Task assigned to person logout or continue with the same user in "WorkFlow UI" screen for "Application_Name"
        # And User validate Transaction table header under "My Task" in "WorkFlow UI" screen
        #     | SLA | Transaction Id | Task Name | Priority | Created At | Submitted By | Last Updated By | Last Updated At | Assigned To |
        And As "Application Manager" user verify Task "1" Details under "My Task" in "WorkFlow UI" screen
        Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
        Then User click on "History" "TaskHistory" in "WorkFlow UI" screen
        Then User validates Tasks event and Action as "Success" in "WorkFlow UI" screen
            | Task          |
            | Email         |
            | Create Record |
        Then User click on "Task" "My Task" in "WorkFlow UI" screen
        Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
        And User validate left side menu options for the Task in "WorkFlow UI" screen
        And User validate "Text Input" widget "FirstName" is not empty in "payload" screen
        And User validate "Text Input" widget "LastName" is not empty in "payload" screen
        And User validate "Text Input" widget "Pin" is not empty in "payload" screen
        And User validate "Text Input" widget "Email" is not empty in "payload" screen
        And User validate "Text Input" widget "PhoneNumber" is not empty in "payload" screen
        And User validate "Text Input" widget "SSN" is not empty in "payload" screen
        Then User validate Task "1" Actions and select "Accept" action in "WorkFlow UI" screen
        And User wait for "5000"
        # #Task2
        And As "Agent" user verify Task "2" Details under "Team Task" in "WorkFlow UI" screen
        Then Based on the Task assigned to person logout or continue with the same user in "WorkFlow UI" screen for "Application_Name"
        # And User validate Transaction table header under "My Task" in "WorkFlow UI" screen
        #     | SLA | Transaction Id | Task Name | Priority | Created At | Submitted By | Last Updated By | Last Updated At | Assigned To |
        And As "Application Manager" user verify Task "2" Details under "My Task" in "WorkFlow UI" screen
        Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
        And User validate left side menu options for the Task in "WorkFlow UI" screen
        Then User validate Task "2" Actions and select "Accept" action in "WorkFlow UI" screen
        And User wait for "5000"
        And User validate Transaction details are removed from "Team Task" in "WorkFlow UI" screen
