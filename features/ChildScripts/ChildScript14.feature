Feature: validate prePopulate using response task and API task-Delete and Update

    @ChildScript
    @ChildScript14
    @responseTask
    #Created By: Mohan.S
    Scenario: Use case to demonstrate the validation prepopulate using response task and API task-Delete and Update

        # #CreateGroup
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "Usecase_TestData/ChildScript14" json file in "WorkFlow UI" screen
        Then User will open "GroupName" group in "HomePage" screen
        Then User click on "button" "group_settings" in "Groups" screen
        Then User click on "button" "dataSources" in "onLoadTrigger" screen
        And User get unique field in Data Source "EmployeeDetails" in "onLoadTrigger" screen and save it in "EmpID"
        Then User will open "GroupName" group in "HomePage" screen
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        Then User see text "Front Office" in "FO" in "Page" screen
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X   | Y   | FieldName           | Title                |
            | Container | 100 | 200 | personalInformation | Personal Information |
        When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget               | X   | Y   |
            | Personal Information | 900 | 600 |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget       | X   | Y   | FieldName   | FieldLabel  | PlaceHolder        | OptionType | Action | Status |
            | Text Input   | 250 | 300 | firstName   | FirstName   |                    |            |        |        |
            | Text Input   | 500 | 300 | lastName    | LastName    |                    |            |        |        |
            | Text Input   | 750 | 300 | pin         | Pin         |                    |            |        |        |
            | Email        | 250 | 500 | email       | Email       | example@domain.com |            |        |        |
            | Phone Number | 500 | 500 | phoneNumber | PhoneNumber |                    |            |        |        |
            | SSN          | 750 | 500 | SSN         | SSN/ITIN    |                    |            |        |        |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X   | Y   | FieldName | FieldLabel | Action | Status |
            | Button | 750 | 700 | Submit    | Submit     | Submit | Save   |

        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget              | X   | Y   |
            | personalInformation | 100 | 200 |
        Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X   | Y   | FieldName | FieldLabel | Action | Status |
            | Button | 550 | 100 | Fetch     | Fetch      | None   | Save   |
            | Button | 775 | 100 | Refresh   | Refresh    | None   | Clear  |
        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget       | X   | Y   | FieldName     | FieldLabel     | PlaceHolder        | OptionType | Action | Status |
            | Email        | 250 | 700 | boEmail       | BO-Email       | example@domain.com |            |        |        |
            | Phone Number | 500 | 700 | boPhoneNumber | BO-PhoneNumber |                    |            |        |        |
            | SSN          | 750 | 700 | boSSN         | BO-SSN/ITIN    |                    |            |        |        |

        And User create an Event Configuration in "EventConfigurations" screen
            | EventName        | EventType | Widget | DataSource      | DataList                  | Type | UniqueField | Value |
            | Get By Id PI API | Populate  | Fetch  | EmployeeDetails | Get By Id EmployeeDetails | ref  | EmpID       | pin   |
        Then User will create transformation rule for "Populate" "Get By Id PI API" and connect Input and Output nodes in "transformation" screen
            | Destination | Source    |
            | phoneNumber | Phone     |
            | pin         | Pin       |
            | firstName   | FirstName |
            | lastName    | LastName  |
            | email       | Email     |
            | SSN         | SSN       |

        # And User edit "Clear" action and set "Reset Field Values" on widget "Refresh" in "UniqueWidgetFields" screen
        #     | Widgets        |
        #     | Pin            |
        #     | FirstName      |
        #     | LastName       |
        #     | Email          |
        #     | PhoneNumber    |
        #     | SSN/ITIN       |
        #     | BO-Email       |
        #     | BO-PhoneNumber |
        #     | BO-SSN/ITIN    |
        And User write "Front Office" widgets in "FrontOffice_Widgets" in "UniqueWidgetFields" screen
        And User write "Back Office" widgets in "BackOffice_Widgets" in "UniqueWidgetFields" screen

        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 150 | 225 |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget   | X   | Y   | TaskName      | SuccesStatus | FailedStatus | FailureTaskRole     | DataSource      | DataList             |
            | API Task | 300 | 200 | Create Record | In Progress  | In Progress  | Application Manager | EmployeeDetails | Save EmployeeDetails |
        When User Edit "API task" "Create Record" field to Configure Service in "tasks" screen
        Then User will create transformation rule for "API Task" "Save Employee" and connect Input and Output nodes in "transformation" screen
            | Destination | Source      |
            | FirstName   | firstName   |
            | LastName    | lastName    |
            | Pin         | pin         |
            | Email       | email       |
            | Phone       | phoneNumber |
            | SSN         | SSN         |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
            | Task   | 500 | 200 | Review1  | Application Manager | 1           | Accept  | In Progress   | 1        | 0       |

        # update api
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget   | X   | Y   | TaskName      | SuccesStatus | FailedStatus | FailureTaskRole     | DataSource      | DataList                     |
            | API Task | 700 | 200 | Update Record | In Progress  | In Progress  | Application Manager | EmployeeDetails | Update By Id EmployeeDetails |
        When User Edit "API task" "Update Record" field to Configure Service in "tasks" screen
        Then User will create transformation rule for "API Task" "update Employee" and connect Input and Output nodes in "transformation" screen
            | Destination | Source      | UniqueField |
            | FirstName   | firstName   |             |
            | LastName    | lastName    |             |
            | Pin         | pin         |             |
            | Email       | email       |             |
            | Phone       | phoneNumber |             |
            | SSN         | SSN         |             |
            | Pin         | pin         | Yes         |

        # ResponseTask
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget           | X   | Y   | TaskName | SuccesStatus | FailedStatus | FailureTaskRole     | Resources     |
            | Response Mapping | 900 | 200 | Response | In Progress  | In Progress  | Application Manager | Update Record |
        When User Edit "Response task" "Response" field to Configure Service in "tasks" screen
        Then User will create transformation rule for "Response Task" "Get Employee" and connect Input and Output nodes in "transformation" screen
            | Destination   | Source |
            | boEmail       | Email  |
            | boPhoneNumber | Phone  |
            | boSSN         | SSN    |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X    | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
            | Task   | 1100 | 200 | Review2  | Application Manager | 1           | Accept  | In Progress   | 1        | 0       |

        # delete api
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget   | X    | Y   | TaskName      | SuccesStatus | FailedStatus | FailureTaskRole     | DataSource      | DataList                     |
            | API Task | 1300 | 200 | Delete Record | In Progress  | In Progress  | Application Manager | EmployeeDetails | Delete By Id EmployeeDetails |
        When User Edit "API task" "Delete Record" field to Configure Service in "tasks" screen
        Then User will create transformation rule for "API Task" "Delete Employee" and connect Input and Output nodes in "transformation" screen
            | Destination | Source |
            | Pin         | pin    |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X    | Y   | TaskName     | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
            | Task   | 1300 | 400 | Final-Review | Application Manager | 1           | Accept  | In Progress   | 1        | 0       |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X    | Y   |
            | End    | 1300 | 580 |
        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source        | Action  | Target        |
            | Start         |         | Create Record |
            | Create Record | Success | Review1       |
            | Review1       | Accept  | Update Record |
            | Update Record | Success | Response      |
            | Response      | Success | Review2       |
            | Review2       | Accept  | Delete Record |
            | Delete Record | Success | Final-Review  |
            | Final-Review  | Accept  | End           |
        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        #  To validate Preview
        And User validate Payload app opening in a new tab
        # Payload Validation
        Given user login to payload application with "Finlevit_payload" with "1" agent
        And User enter "text" in "FirstName" with "7" characters
        And User enter "text" in "LastName" with "7" characters
        And User enter text "TestCs-14" in "Pin" in "PayloadValidate" screen
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
        # And User validate Transaction table header under "Team Task" in "WorkFlow UI" screen
        #     | SLA | Transaction Id | Task Name | Priority | Created At | Submitted By | Last Updated By | Last Updated At | Assigned To |
        And As "Agent" user verify Task "1" Details under "Team Task" in "WorkFlow UI" screen
        Then Based on the Task assigned to person logout or continue with the same user in "WorkFlow UI" screen for "Application_Name"
        # And User validate Transaction table header under "My Task" in "WorkFlow UI" screen
        #     | SLA | Transaction Id | Task Name | Priority | Created At | Submitted By | Last Updated By | Last Updated At | Assigned To |
        And As "Application Manager" user verify Task "1" Details under "My Task" in "WorkFlow UI" screen
        Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
        And User validate left side menu options for the Task in "WorkFlow UI" screen
        And User wait for "5000"
        And User validate "Text Input" widget "FirstName" is not empty in "payload" screen
        And User validate "Text Input" widget "LastName" is not empty in "payload" screen
        And User validate "Text Input" widget "Pin" is not empty in "payload" screen
        And User validate "Text Input" widget "Email" is not empty in "payload" screen
        And User validate "Text Input" widget "PhoneNumber" is not empty in "payload" screen
        And User validate "Text Input" widget "SSN/ITIN" is not empty in "payload" screen
        And User enter "phoneNumber" in "PhoneNumber" with "10" characters
        And User enter "SSN" in "SSN/ITIN" with "9" characters
        Then User validate Task "1" Actions and select "Accept" action in "WorkFlow UI" screen

        # Review2
        And As "Agent" user verify Task "2" Details under "Team Task" in "WorkFlow UI" screen
        Then Based on the Task assigned to person logout or continue with the same user in "WorkFlow UI" screen for "Application_Name"
        # And User validate Transaction table header under "My Task" in "WorkFlow UI" screen
        #     | SLA | Transaction Id | Task Name | Priority | Created At | Submitted By | Last Updated By | Last Updated At | Assigned To |
        And As "Application Manager" user verify Task "2" Details under "My Task" in "WorkFlow UI" screen
        Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
        And User validate "Text Input" widget "BO-Email" is not empty in "payload" screen
        And User validate "Text Input" widget "BO-PhoneNumber" is not empty in "payload" screen
        And User validate "Text Input" widget "BO-SSN/ITIN" is not empty in "payload" screen
        And User wait for "2000"
        Then User validate Task "2" Actions and select "Accept" action in "WorkFlow UI" screen
        And User wait for "5000"

        #FinalTask
        And As "Agent" user verify Task "3" Details under "Team Task" in "WorkFlow UI" screen
        Then Based on the Task assigned to person logout or continue with the same user in "WorkFlow UI" screen for "Application_Name"
        # And User validate Transaction table header under "My Task" in "WorkFlow UI" screen
        #     | SLA | Transaction Id | Task Name | Priority | Created At | Submitted By | Last Updated By | Last Updated At | Assigned To |
        And As "Application Manager" user verify Task "3" Details under "My Task" in "WorkFlow UI" screen
        Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
        And User wait for "3000"
        Then User click on "Button" widget "Refresh" in "payload" screen
        And User wait for "3000"
        # And User enter text "TestCs-14" in "Pin" in "PayloadValidate" screen
        Then User click on "Button" widget "Fetch" in "payload" screen
        And User should contain text "API Data not Found for unique identifier" in "Pagelevel_alert_messgae" in "payload" screen
        And User wait for "2000"
        Then User validate Task "3" Actions and select "Accept" action in "WorkFlow UI" screen
        And User validate Transaction details are removed from "Team Task" in "WorkFlow UI" screen
        And User wait for "5000"







