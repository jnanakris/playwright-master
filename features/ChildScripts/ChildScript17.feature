Feature: BO AdvanceTable with onload triggers and with create,update and delete record in Workflow

    # @ChildScript
    @ChildScript17
    @boAdvanceTable
    #Created By: Mohan.S
    Scenario:Use case to demonstrate the Advance Table with onload triggers to create,update,delete

        #CreateGroup
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "Usecase_TestData/ChildScript17" json file in "WorkFlow UI" screen
        Then User will open "GroupName" group in "HomePage" screen
        Then User click on "button" "group_settings" in "Groups" screen
        Then User click on "button" "dataSources" in "onLoadTrigger" screen
        And User get unique field in Data Source "EmployeeDetails" in "onLoadTrigger" screen and save it in "EmployeePin"
        Then User will open "GroupName" group in "HomePage" screen
        # # To Create an Application
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        Then User see text "Front Office" in "FO" in "Page" screen
        #  To Design Front Office
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName  | FieldLabel | Action | Status |
            | Text Input | 275 | 200 | First Name | First Name |        |        |
            | Text Input | 575 | 200 | Last Name  | Last Name  |        |        |
            | Button     | 675 | 450 | Submit     | Submit     | Submit | Save   |

        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen

        Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
        And User Drag and Drop in BO below widgets in "CanvasBody" in "AdvanceTable" screen
            | Widget | X  | Y   | Name          |
            | Table  | 25 | 245 | Employee List |
        When User expand "Table" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget  | X    | Y   |
            | Actions | 1100 | 400 |
        Then User click on "span" "Save" in "Page" screen
        When User click "Advance Table" and add columns in "AdvanceTable" screen
            | Name                   | Alignment             | ColumnType | FieldLabel |
            | EmployeeList_Pin       | ColumnAlignmentCenter | Text Input | Pin        |
            | EmployeeList_FirstName | ColumnAlignmentCenter | Text Input | First Name |
            | EmployeeList_LastName  | ColumnAlignmentCenter | Text Input | Last Name  |
            | EmployeeList_Phone     | ColumnAlignmentCenter | Text Input | Phone      |
            | EmployeeList_Email     | ColumnAlignmentCenter | Email      | Email      |

        And User create Onload Triggers with Response Mapping "addOnloadTrigger" in "onLoadTrigger" screen
            | Name                 | Description      | DataSource      | DataList                |
            | Get Employee Details | Employee Details | EmployeeDetails | Get All EmployeeDetails |

        Then User will create transformation rule for "Response Mapping" "Save EmployeeName" and connect Input and Output nodes in "transformation" screen
            | Destination            | Source    |
            | EmployeeList_Email     | Email     |
            | EmployeeList_Pin       | Pin       |
            | EmployeeList_FirstName | FirstName |
            | EmployeeList_LastName  | LastName  |
            | EmployeeList_Phone     | Phone     |

        Then User click on save button for "Get Employee Details" Response Mapping in "onLoadTrigger" screen
        Then User click on "tab" "Design" in "Page" screen

        Then User right click on "widget" "ActionsEdit" in "AdvanceTable" screen
        Then User click on "button" "EditWidget" in "UniqueWidgetFields" screen
        Then User click on "button" "ROWACTIONS" in "AdvanceTable" screen
        Then User click on "button" "EditDataConfiguration" in "AdvanceTable" screen
        And User "Edit" Data Configuration for "Advance Table" in "AdvanceTable" screen
            | Operations              | DataResources   | DataList                  | Type | UniqueField | Value            |
            | Get Record By Unique Id | EmployeeDetails | Get By Id EmployeeDetails | ref  | EmployeePin | EmployeeList_Pin |

        And User add Column and Response path for "Advance Table" in "UniqueWidgetFields" screen
            | Column                 | ResponsePath |
            | EmployeeList_FirstName | FirstName    |
            | EmployeeList_LastName  | LastName     |
            | EmployeeList_Phone     | Phone        |
            | EmployeeList_Email     | Email        |
            | EmployeeList_Pin       | Pin          |

        And User "Edit" Data Configuration for "Advance Table" in "AdvanceTable" screen
            | Operations                 | DataResources   | DataList                     | Type | UniqueField | Value            |
            | Update Record By Unique Id | EmployeeDetails | Update By Id EmployeeDetails | ref  | EmployeePin | EmployeeList_Pin |

        And User add Column and Response path for "Advance Table" in "UniqueWidgetFields" screen
            | Column                 | ResponsePath |
            | EmployeeList_FirstName | FirstName    |
            | EmployeeList_LastName  | LastName     |
            | EmployeeList_Phone     | Phone        |
            | EmployeeList_Email     | Email        |
            | EmployeeList_Pin       | Pin          |

        And User "Edit" Data Configuration for "Advance Table" in "AdvanceTable" screen
            | Operations      | DataResources   | DataList                |
            | Get All Records | EmployeeDetails | Get All EmployeeDetails |

        And User add Column and Response path for "Advance Table" in "UniqueWidgetFields" screen
            | Column                 | ResponsePath |
            | EmployeeList_FirstName | FirstName    |
            | EmployeeList_LastName  | LastName     |
            | EmployeeList_Phone     | Phone        |
            | EmployeeList_Email     | Email        |
            | EmployeeList_Pin       | Pin          |
        Then User click on "button" "DataConfigurationClose" in "AdvanceTable" screen

        # To Delete Data Configuration for an Advanced Table
        Then User click on "button" "DeleteDataConfiguration" in "AdvanceTable" screen
        And User "Delete" Data Configuration for "Advance Table" in "AdvanceTable" screen
            | Operations                 | DataResources   | DataList                     | Type | UniqueField | Value            |
            | Delete Record By Unique Id | EmployeeDetails | Delete By Id EmployeeDetails | ref  | EmployeePin | EmployeeList_Pin |

        And User add Column and Response path for "Advance Table" in "UniqueWidgetFields" screen
            | Column                 | ResponsePath |
            | EmployeeList_FirstName | FirstName    |
            | EmployeeList_LastName  | LastName     |
            | EmployeeList_Phone     | Phone        |
            | EmployeeList_Email     | Email        |
            | EmployeeList_Pin       | Pin          |
        Then User click on "button" "DataConfigurationClose" in "AdvanceTable" screen
        Then User click on "Button" "WidgetSave" in "UniqueWidgetFields" screen
        Then User click on "button" "CanvasSave" in "UniqueWidgetFields" screen
        # And User write "Front Office" widgets in "FrontOffice_Widgets" in "UniqueWidgetFields" screen
        # And User write "Back Office" widgets in "BackOffice_Widgets" in "UniqueWidgetFields" screen


        # Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 150 | 225 |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
            | Task   | 400 | 150 | Review   | Application Manager | 1           | Accept  | In Progress   | 1        | 0       |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | End    | 950 | 225 |
        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source | Action | Target |
            | Start  |        | Review |
            | Review | Accept | End    |

        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        #  To validate Preview
        And User validate Payload app opening in a new tab
        # Payload Validation
        Given user login to payload application with "Finlevit_payload" with "1" agent
        And User enter text "Sdale" in "FirstName" in "payload" screen
        Then User click on "button" "Submit_btn" in "payload" screen
        And User get Transaction Id and save it in json file

        # #WorkflowUI
        Given user login to workflow UI "Finlevit_workflow" with "1" "AppManager" credentials
        And User wait until the "Filter Transaction id" appears in "WorkFlow UI" screen
        Then User click on "Button" "Home" in "HomePage" screen
        Then User will open "GroupName" group in "HomePage" screen
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "5000"
        And User validate Transaction table header under "Team Task" in "WorkFlow UI" screen
            | SLA | Transaction Id | Task Name | Priority | Created At | Submitted By | Last Updated By | Last Updated At | Assigned To |
        And As "Agent" user verify Task "1" Details under "Team Task" in "WorkFlow UI" screen
        Then Based on the Task assigned to person logout or continue with the same user in "WorkFlow UI" screen for "Application_Name"
        And User validate Transaction table header under "My Task" in "WorkFlow UI" screen
            | SLA | Transaction Id | Task Name | Priority | Created At | Submitted By | Last Updated By | Last Updated At | Assigned To |
        And As "Application Manager" user verify Task "1" Details under "My Task" in "WorkFlow UI" screen
        Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
        And User validate left side menu options for the Task in "WorkFlow UI" screen
        And User Edit an Advanced table Columns in "payload" screen
            | WidgetName | WidgetType | ExpectedValue |
            | Phone      | Text Input |               |
            | Email      | Email      |               |
            | First Name | Text Input | Jack          |
            | Last Name  | Text Input | David         |
        And User Delete an Advanced table rows in "payload" screen
