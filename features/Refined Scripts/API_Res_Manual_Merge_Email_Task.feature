Feature: Response task,Manual task,Email task is executed parallel to the merge task and one manual task after merge task

    @RS6
    @RS
    @mergeTask3

    Scenario: Use case to demonstrate merge task with combination of API task,Response task, Manual Task, Email task

        #CreateGroup
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "Usecase_TestData/ChildScript22" json file in "WorkFlow UI" screen
        Then User will open "GroupName" group in "HomePage" screen

        # To Create an Application
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "2000"
        Then User see text "Front Office" in "FO" in "Page" screen
        # To Design Front Office
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget       | X   | Y   | FieldName   | FieldLabel  | PlaceHolder        | OptionType | Action | Status |
            | Text Input   | 250 | 300 | FirstName   | FirstName   |                    |            |        |        |
            | Text Input   | 500 | 300 | LastName    | LastName    |                    |            |        |        |
            | Text Input   | 750 | 300 | Pin         | Pin         |                    |            |        |        |
            | Email        | 250 | 500 | Email       | Email       | example@domain.com |            |        |        |
            | Phone Number | 500 | 500 | PhoneNumber | PhoneNumber |                    |            |        |        |
            | SSN          | 750 | 500 | ssnNumber   | SSN/ITIN    |                    |            |        |        |

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X    | Y   | FieldName | FieldLabel | Action | Status |
            | Button | 1075 | 750 | Submit    | Submit     | Submit | Save   |
        Then User clicks on "AutoAlign" in "frontOffice" screen
        Then User click on "span" "Save" in "Page" screen
        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget      |
            | FirstName   |
            | LastName    |
            | Pin         |
            | Email       |
            | PhoneNumber |
            | ssnNumber   |

        Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget       | X   | Y   | FieldName     | FieldLabel     | PlaceHolder        | OptionType | Action | Status |
            | Email        | 300 | 900 | BOEmail       | BO-Email       | example@domain.com |            |        |        |
            | Phone Number | 600 | 900 | BOPhoneNumber | BO-PhoneNumber |                    |            |        |        |
            | SSN          | 900 | 900 | BOSSNITIN     | BO-SSN/ITIN    |                    |            |        |        |
        Then User clicks on "AutoAlign" in "backOffice" screen
        Then User click on "span" "Save" in "Page" screen
        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 150 | 300 |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget   | X   | Y   | TaskName      | SuccesStatus | FailedStatus | FailureTaskRole     | DataSource      | DataList             |
            | API Task | 400 | 300 | Create Record | In Progress  | In Progress  | Application Manager | EmployeeDetails | Save EmployeeDetails |

        When User Edit "API task" "Create Record" field to Configure Service in "tasks" screen
        Then User will create transformation rule for "API Task" "Save Employee" and connect Input and Output nodes in "transformation" screen
            | Destination | Source      |
            | FirstName   | FirstName   |
            | LastName    | LastName    |
            | Pin         | Pin         |
            | Email       | Email       |
            | Phone       | PhoneNumber |
            | SSN         | ssnNumber   |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
            | Task   | 700 | 100 | Review1  | Application Manager | 1           | Accept  | In Progress   | 1        | 0       |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | To     | Sub     | Template | FailureTaskRole     |
            | Email  | 700 | 700 | Email    | @Email | MailSub | MailBody | Application Manager |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget           | X   | Y   | TaskName | SuccesStatus | FailedStatus | FailureTaskRole     | Resources     |
            | Response Mapping | 700 | 300 | Response | In Progress  | In Progress  | Application Manager | Create Record |
        When User Edit "Response task" "Response" field to Configure Service in "tasks" screen
        Then User will create transformation rule for "Response Task" "Get Employee" and connect Input and Output nodes in "transformation" screen
            | Destination   | Source |
            | BOEmail       | Email  |
            | BOPhoneNumber | Phone  |
            | BOSSNITIN     | SSN    |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X    | Y   | TaskName           | Status      |
            | Merge  | 1000 | 300 | Merge After Review | In Progress |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X    | Y   | TaskName     | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
            | Task   | 1200 | 300 | Final Review | Application Manager | 1           | Accept  | In Progress   | 1        | 0       |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X    | Y   |
            | End    | 1400 | 300 |

        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source        | Action  | Target        |
            | Start         |         | Create Record |
            | Create Record | Success | Review1       |
            | Create Record | Success | Email         |
            | Create Record | Success | Response      |
            | Review1       | Accept  | Merge         |
            | Email         |         | Merge         |
            | Response      | Success | Merge         |
            | Merge         |         | Final Review  |
            | Final Review  | Accept  | End           |

        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        # To validate Preview
        And User validate Payload app opening in a new tab
        # Payload Validation
        Then user will clear browser cookies
        Given user login to payload application with "Finlevit_payload" with "1" agent
        #Enter Data
        And User enter "text" in "FirstName" with "7" characters
        And User enter "text" in "LastName" with "7" characters
        And User enter "text" in "Pin" with "7" characters
        And User enter "email" in "Email" with "5" characters
        And User enter "phoneNumber" in "PhoneNumber" with "10" characters
        And User enter "SSN" in "SSN/ITIN" with "9" characters
        And User wait for "1000"
        Then User click on "Button" widget "Submit" in "payload" screen
        And User get Transaction Id and save it in json file
        #WorkFlow UI
        Then user will clear browser cookies
        Given user login to workflow UI "Finlevit_workflow" with "1" "AppManager" credentials
        And User wait until the "Filter Transaction id" appears in "WorkFlow UI" screen
        Then User click on "Button" "Home" in "HomePage" screen
        Then User will open "GroupName" group in "HomePage" screen
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "5000"

        # #Task1
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
            | Response      |
        Then User click on "Task" "My Task" in "WorkFlow UI" screen
        Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
        And User validate left side menu options for the Task in "WorkFlow UI" screen
        And User validate "Text Input" widget "FirstName" is not empty in "payload" screen
        And User validate "Text Input" widget "LastName" is not empty in "payload" screen
        And User validate "Text Input" widget "Pin" is not empty in "payload" screen
        And User validate "Text Input" widget "Email" is not empty in "payload" screen
        And User validate "Text Input" widget "PhoneNumber" is not empty in "payload" screen
        And User validate "Text Input" widget "SSN/ITIN" is not empty in "payload" screen
        Then User validate Task "1" Actions and select "Accept" action in "WorkFlow UI" screen
        And User wait for "5000"
        #Task2
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
