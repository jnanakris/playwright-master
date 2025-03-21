Feature: Existing application with secondary source,button with service provider as save operation and in bo workflow with simple task,API task with update operation,API task with delete operation,Response mapping task

    @sanityTestSuite
    @existAppSecondary
    #Created By: Mohan.S
    #Created on : 02/10/2023
    Scenario: Usecase to demonstrate the workflow of an Existing App with Primary and Secondary source functionality

        #CreateGroup
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "Usecase_TestData/ExistAppSecondarySource" json file in "WorkFlow UI" screen
        Then User click on "tab" "Source" in "HomePage" screen
        And User verify path is present in "SourcePath" in "PayloadSetup" page
        Then User will open "GroupName" group in "HomePage" screen
        Then User will create "Existing" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        #UploadPayload
        Then User select the below source and upload the payload with identifiers in "UniqueWidgetFields" screen
            | SelectSource        | fileName            | ValueCount | Key1         | Identifiers1 | Key2         | Identifiers2 |
            | AutomationPrimary   | AutomationPrimary   | 2          | Process Type | ProcessType  | Request Type | RequestType  |
            | AutomationSecondary | AutomationSecondary |            |              |              |              |              |
        And User wait for "1000"
        When User click the "ExpandObjects" and expand all the objects in screen
        When User choose field "CountryofResidence" the type "string" and the widget is "Dropdown" in screen
            | FieldName          | options | options2 |
            | CountryofResidence | string  | Dropdown |
            | State              | string  | Dropdown |
        Then User click on "button" "PayloadSave" in "UniqueWidgetFields" screen
        And User wait for "3000"
        # BO
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User see text "Back Office" in "BO" in "Page" screen
        Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X   | Y   | FieldName     | Title         |
            | Container | 150 | 100 | Personal Info | Personal Info |
        When User expand below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget        | X   | Y   |
            | Personal Info | 950 | 600 |
        Then User click on "button" "Fields" in "UniqueWidgetFields" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget             | X   | Y   |
            | Pin                | 210 | 200 |
            | FirstName          | 410 | 200 |
            | LastName           | 610 | 200 |
            | Gender             | 800 | 200 |
            | CountryofResidence | 210 | 400 |
            | Email              | 410 | 400 |
            | Phone              | 610 | 400 |
            | Salary             | 800 | 400 |
            | IsUSCitizen        | 400 | 520 |
        Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X   | Y   | FieldName | Title   |
            | Container | 150 | 650 | Address   | Address |
        Then User click on "button" "Fields" in "UniqueWidgetFields" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget   | X   | Y   |
            | Line1    | 300 | 700 |
            | Locality | 450 | 700 |
            | State    | 300 | 800 |
            | Zipcode  | 450 | 800 |
        And User scroll to an element "Address" in "UniqueWidgetFields" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget              | X   | Y   |
            | AutomationSecondary | 700 | 650 |
        # To add Back Office roles
        # Edit existing role
        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        # Add a new role
        Then User "Add" the "Operations" role and add "Operations" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        # To Add the required tasks onto the workflow Designer
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y  |
            | Start  | 167 | 69 |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName        | Role                | noOfActions | Action1 | Action1Status |SLAHours | SLADays |
            | Task   | 300 | 169 | Review & Upload | Application Manager | 1           | Accept  | In Progress   |1        | 0       |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget     | X   | Y   | TaskName | Role                | Source              | SuccesStatus | FailedStatus |
            | SystemTask | 600 | 169 | System   | Application Manager | AutomationSecondary | In Progress  | In Progress  |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status |SLAHours | SLADays |
            | Task   | 900 | 169 | Review   | Application Manager | 1           | Accept  | In Progress   |1        | 0       |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName |
            | End    | 900 | 369 | Success  |
            | End    | 600 | 369 | Failure  |
        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source          | Action  | Target          |
            | Start           |         | Review & Upload |
            | Review & Upload | Accept  | System          |
            | System          | Success | Review          |
            | Review          | Accept  | SuccessEnd      |
            | System          | Failed  | FailureEnd      |
        Then User click on "button" "Save" in "workflowDesigner" screen
        #  To validate Version Management
        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen














