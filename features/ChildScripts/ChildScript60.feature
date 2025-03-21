Feature: Validation for group admin,app

    @ChildScript60
    @ChildScript
    #Createdby: Mohan S

    Scenario: Use case to demonstrate login as group admin create an app,clone and Delete the root app,then verify the cloned app is app still working and delete group,Then verify the validation msg that only super admin will delete the app

        And User get the Test data from "Usecase_TestData/ChildScript60" json file in "WorkFlow UI" screen
        Given user login to "Finlevit_admin" with "Admin" credentials
        Then User delete group "#GroupName" in "Groups" screen
        When User create group "#GroupName" with description "Group - Created by Automation" in "Groups" screen
        And User wait for "5000"
        Then User will "Logout" from "Page" the current session

        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        Then User will open "#GroupName" group in "HomePage" screen
        And User wait for "5000"
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        And User wait for "5000"
        Then User will search for "Application_Name" in "Application" screen
        Then User see text "Front Office" in "FO" in "Page" screen

        #  To Design Front Office
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X   | Y  | FieldName           | FieldLabel | Title                | Action | Status |
            | Container | 125 | 90 | PersonalInformation |            | Personal Information |        |        |
        When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget        | X   | Y   |
            | Personal Info | 850 | 500 |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName | FieldLabel | Action | Status |
            | Text Input | 275 | 200 | FirstName | First Name |        |        |
            | Text Input | 475 | 200 | LastName  | Last Name  |        |        |
            | Number     | 275 | 450 | Number    | Number     |        |        |
            | Button     | 675 | 450 | Submit    | Submit     | Submit | Save   |

        # To add Front Office Agent
        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
        # To Design Front Office
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User see text "Back Office" in "BO" in "Page" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget              | X   | Y  |
            | PersonalInformation | 200 | 90 |
        Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen

        # To add Back Office roles
        # Edit existing role
        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        # Add a new role
        Then User "Add" the "Operations" role and add "Operations" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        #To Add the required tasks onto the workflow Designer
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 230 | 250 |
            | End    | 845 | 250 |
        #  To Configure the Task Name
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName           | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
            | Task   | 500 | 250 | Review Transaction | Application Manager | 1           | Accept  | In Progress   | 1        | 0       |
        # To connect the tasks present on the workflow designer canvas
        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source             | Action | Target             |
            | Start              |        | Review Transaction |
            | Review Transaction | Accept | End                |
        Then User click on "button" "Save" in "workflowDesigner" screen
        #  To validate Version Management
        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen


        #login to FA as group Admin and clone the created APP
        Then User will "Logout" from "Page" the current session
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        Then User should have visible "Logo" in "HomePage" screen
        Then User will open "#GroupName" group in "HomePage" screen
        And User wait for "5000"
        Then user will clone "Application_Name" and save "ClonedApplicationName" in "Application" screen

        #Delete the Parent application
        Then User will "Logout" from "Page" the current session
        Given user login to "Finlevit_admin" with "Admin" credentials
        Then User will open "#GroupName" group in "HomePage" screen
        When User reloads the page
        And User wait for "8000"
        And User wait until the spinner disappears
        Then User delete app "#Application_Name" in "Application" screen

        #Verify Payload for the cloned APP
        Then User will "Logout" from "Page" the current session
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        Then User will open "#GroupName" group in "HomePage" screen
        And User wait for "8000"
        Then User will search for "ClonedApplicationName" in "Application" screen
        And User validate Payload app opening in a new tab
        #payload
        Given user login to payload application with "Finlevit_payload" with "1" agent
        And User enter text "Test" in "FirstName" in "payload" screen
        And User enter text "Test" in "LastName" in "payload" screen
        Then User click on "button" "Submit_btn" in "payload" screen
        And User get Transaction Id and save it in json file
        And User wait for "2000"
        # WorkflowUI
        Given user login to workflow UI "Finlevit_workflow" with "1" "AppManager" credentials
        And User wait until the "Filter Transaction id" appears in "WorkFlow UI" screen
        Then User click on "Button" "Home" in "HomePage" screen
        Then User will open "#GroupName" group in "HomePage" screen
        Then User will search for "ClonedApplicationName" in "Application" screen
        And User wait for "5000"
        And As "Agent" user verify Task "1" Details under "Team Task" in "WorkFlow UI" screen
        Then Based on the Task assigned to person logout or continue with the same user in "WorkFlow UI" screen for "ClonedApplicationName"
        And As "Application Manager" user verify Task "1" Details under "My Task" in "WorkFlow UI" screen
        Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
        Then User validate Task "1" Actions and select "Accept" action in "WorkFlow UI" screen
        And User wait for "1000"
        And User validate Transaction details are removed from "Team Task" and it is displaying under "History" on the successful workflow completion in "WorkFlow UI" screen
        Then User will "Logout" from "Page" the current session

        # #deleteClonedAppAndGroup
        # Then user will clear browser cookies
        # Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        # Then User should have visible "Logo" in "HomePage" screen
        # Then User will open "#GroupName" group in "HomePage" screen
        # And User wait for "5000"
        # Then User delete app "ClonedApplicationName" in "Application" screen
        # When User reloads the page
        # Then User delete group as group admin "#GroupName" in "Groups" screen
        # When User should contain text "Sorry, only System Admin has permission to do this." in "SystemAdminValidation" in "HomePage" screen
        # When User reloads the page
        # Then User will "Logout" from "Page" the current session
        # Given user login to "Finlevit_admin" with "Admin" credentials
        # Then User delete group as group admin "#GroupName" in "Groups" screen
        # And User wait for "5000"







