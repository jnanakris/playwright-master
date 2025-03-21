Feature: Existing application,button with service provider as save operation and in bo workflow with simple task,API task with update operation,API task with delete operation,Response mapping task

    @sanityTestSuite
    @ExistingApp
    #Created By: Mohan.S
    #Created on : 02/10/2023
    Scenario: Usecase to demonstrate the workflow of an Existing App functionality

        #CreateGroup
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "Usecase_TestData/ExistingApplication" json file in "WorkFlow UI" screen
        # #VerifySourcePath
        # Then User click on "tab" "Source" in "HomePage" screen
        # And User verify path is present in "SourcePath" in "PayloadSetup" page
        #OpenGroup
        Then User will open "GroupName" group in "HomePage" screen
        # App
        Then User will create "Existing" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        # #UploadPayload
        # And User select "AutomationPrimary" as source and upload the payload in "UniqueWidgetFields" screen
        # When User save "Process Type" identifiers and fill "ProcessType" value in screen
        # And User save "Request Type" identifiers and fill "RequestType" value in screen
        # And User save "TransactionID" in "PrimarySource" json file
        # And User wait for "1000"
        # Then User click on "button" "PayloadSave" in "UniqueWidgetFields" screen
        # And User wait for "1000"
        # Then User click on "button" "Next" in "UniqueWidgetFields" screen
        # And User wait for "3000"
        # When User click the "ExpandObjects" and expand all the objects in screen
        # When User choose field "CountryofResidence" the type "string" and the widget is "Dropdown" in screen
        #     | FieldName          | options | options2 |
        #     | CountryofResidence | string  | Dropdown |
        #     | State              | string  | Dropdown |
        # Then User click on "button" "PayloadSave" in "UniqueWidgetFields" screen
        And User wait for "3000"
        # BO
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User see text "Back Office" in "BO" in "Page" screen
        Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X  | Y  | FieldName     | Title         |
            | Container | 50 | 50 | Personal Info | Personal Info |
        When User expand below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget        | X    | Y   |
            | Personal Info | 1100 | 475 |
        Then User click on "button" "Fields" in "UniqueWidgetFields" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget             | X   | Y   |
            | Pin                | 100 | 175 |
            | FirstName          | 150 | 175 |
            | LastName           | 610 | 175 |
            | Gender             | 850 | 175 |
            | CountryofResidence | 100 | 300 |
            | Phone              | 150 | 300 |
            | Email              | 610 | 300 |
            | Salary             | 850 | 300 |
            | IsUSCitizen        | 100 | 425 |
        Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X  | Y   | FieldName | Title   |
            | Container | 50 | 550 | Address   | Address |

        When User expand below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget  | X    | Y   |
            | Address | 1100 | 750 |
        Then User click on "button" "Fields" in "UniqueWidgetFields" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget   | X   | Y   |
            | Line1    | 75  | 625 |
            | Locality | 200 | 625 |
            | State    | 610 | 625 |
            | Zipcode  | 800 | 625 |
        Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName | FieldLabel |
            | Text Input | 200 | 800 | BOPin     | BO Pin     |
        When User make "BO Pin" field in BO as prePopulate in "UniqueWidgetFields" screen
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X   | Y   | FieldName    | FieldLabel   | Action | Status          |
            | Button | 500 | 800 | CreateRecord | Create Record | None   | ServiceProvider |
        When User makes changes to "Create Record" field to Configure API in "UniqueWidgetFields" screen
            | Action            | Category | Service               | Operation                  |
            | Service Providers | Internal | PI API for Automation | Save PI API for Automation |
        Then User will connect Input and Output nodes in "transformationUI" screen
            | Input              | Output             |
            | FirstName          | FirstName          |
            | Line1              | Line1              |
            | Locality           | Locality           |
            | State              | State              |
            | Zipcode            | Zipcode            |
            | CountryofResidence | CountryofResidence |
            | Email              | Email              |
            | Gender             | Gender             |
            | IsUSCitizen        | IsUSCitizen        |
            | LastName           | LastName           |
            | Phone              | Phone              |
            | Salary             | Salary             |
            | Pin                | Pin                |
        # Then User click on "button" "WidgetSave" in "UniqueWidgetFields" screen
        #  To add Back Office roles
        # Edit existing role
        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        # Add a new role
        Then User "Add" the "Operations" role and add "Operations" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        # To Add the required tasks onto the workflow Designer
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y  |
            | Start  | 167 | 71 |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status |SLAHours | SLADays |
            | Task   | 200 | 169 | Review   | Application Manager | 1           | Accept  | In Progress   |1        | 0       |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName        | Role                | noOfActions | Action1 | Action1Status | Action2 | Action2Status |SLAHours | SLADays |
            | Task   | 428 | 169 | Review & Upload | Application Manager | 2           | Accept  | In Progress   | Reject  | In Progress   |1        | 0       |
        # Script to add API Task with Update By Id operation
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget   | X   | Y   | TaskName      | SuccesStatus | FailedStatus | FailureTaskRole     |DataSource      | DataList             |
            | API Task | 671 | 131 | Update Record | In Progress  | In Progress  | Application Manager |PI API for Automation | Update By Id PI API for Automation |
        When User Edit "API task" "Update Record" field to Configure Service in "tasks" screen
        Then User will create transformation rule for "API Task" "Save Employee" and connect Input and Output nodes in "transformation" screen
            | Destination        | Source             | UniqueField |
            | FirstName          | FirstName          |             |
            | Line1              | Line1              |             |
            | Locality           | Locality           |             |
            | State              | State              |             |
            | Zipcode            | Zipcode            |             |
            | CountryofResidence | CountryofResidence |             |
            | Email              | Email              |             |
            | Gender             | Gender             |             |
            | IsUSCitizen        | IsUSCitizen        |             |
            | LastName           | LastName           |             |
            | Phone              | Phone              |             |
            | Salary             | Salary             |             |
            | Pin                | Pin                |             |
            | Pin                | Pin                | Yes         |

        # When User makes changes to the API task "Update Record" field to Configure Service in "tasks" screen
        #     | Category | Service               | Operation                          |
        #     | Internal | PI API for Automation | Update By Id PI API for Automation |
        # Then User will connect Unique Field nodes in "transformationUI" screen
        #     | Input | Output |
        #     | Pin   | Pin    |
        # Then User will connect Input and Output nodes in "transformationUI" screen
        #     | Input              | Output             |
        #     | FirstName          | FirstName          |
        #     | Line1              | Line1              |
        #     | Locality           | Locality           |
        #     | State              | State              |
        #     | Zipcode            | Zipcode            |
        #     | CountryofResidence | CountryofResidence |
        #     | Email              | Email              |
        #     | Gender             | Gender             |
        #     | IsUSCitizen        | IsUSCitizen        |
        #     | LastName           | LastName           |
        #     | Phone              | Phone              |
        #     | Salary             | Salary             |
        #     | Pin                | Pin                |

        And User wait for "2000"
        # Script to add Response Mapping Task
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget           | X   | Y   | TaskName | SuccesStatus | FailedStatus | FailureTaskRole     |Resources|
            | Response Mapping | 871 | 131 | Response | In Progress  | In Progress  | Application Manager |Update Record|
        When User Edit "API task" "Response" field to Configure Service in "tasks" screen
        Then User will create transformation rule for "Response Task" "Get Employee" and connect Input and Output nodes in "transformation" screen
            | Destination | Source |
            | BOPin       | Pin    |

        # When User makes changes to the Response task "Response" field to Configure Service in "tasks" screen
        #     | ResponseInput |
        #     | Update Record |
        # Then User will connect Input and Output nodes in "transformationUI" screen
        #     | Input | Output |
        #     | Pin   | BOPin  |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X    | Y   | TaskName     | To     | Sub      | Template  | FailureTaskRole     |
            | Email  | 1071 | 131 | Update Email | @Email | MailSub1 | MailBody1 | Application Manager |
        # Script to add API Task with Delete By Id operation
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget   | X   | Y   | TaskName      | SuccesStatus | FailedStatus | FailureTaskRole     |DataSource      | DataList             |
            | API Task | 600 | 328 | Delete Record | In Progress  | In Progress  | Application Manager |PI API for Automation | Delete By Id PI API for Automation |
        When User Edit "API task" "Delete Record" field to Configure Service in "tasks" screen
        Then User will create transformation rule for "API Task" "Delete Employee" and connect Input and Output nodes in "transformation" screen
            | Destination | Source |
            | Pin         | Pin    |
           
        # When User makes changes to the API task "Delete Record" field to Configure Service in "tasks" screen
        #     | Category | Service               | Operation                          |
        #     | Internal | PI API for Automation | Delete By Id PI API for Automation |
        # Then User will connect Input and Output nodes in "transformationUI" screen
        #     | Input | Output |
        #     | Pin   | Pin    |
        And User see text "API" in "API Task" in "tasks" screen
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName     | To     | Sub      | Template  | FailureTaskRole     |
            | Email  | 900 | 328 | Delete Email | @Email | MailSub2 | MailBody2 | Application Manager |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X    | Y   | TaskName        | Role                | noOfActions | Action1 | Action1Status |SLAHours | SLADays |
            | Task   | 1350 | 117 | Review Response | Application Manager | 1           | Accept  | In Progress   |1        | 0       |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X    | Y   |
            | End    | 1100 | 328 |
        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source          | Action  | Target          |
            | Start           |         | Review          |
            | Review          | Accept  | Review & Upload |
            | Review & Upload | Accept  | Update Record   |
            | Review & Upload | Reject  | Delete Record   |
            | Update Record   | Success | Response        |
            | Response        | Success | Update Email    |
            | Update Email    |         | Review Response |
            | Delete Record   | Success | Delete Email    |
            | Delete Email    |         | End             |
            | Review Response | Accept  | End             |
        Then User click on "button" "Save" in "workflowDesigner" screen
        #  To validate Version Management
        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen


@ApiCall @ExistingAppTransaction
    Scenario: Submit a Transaction to demonstrate the functionality of an Existing Application
        Given User get the Test data from "Usecase_TestData/PrimarySource" json file in "API" screen
        And "Finlevit_admin" get the access token using "Access_Token" call
        Then User submits transaction for "PrimarySource"







