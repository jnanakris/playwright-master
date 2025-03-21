Feature: Validate Lock functionality in Version Management

    @ChildScript
    @ChildScript62
    #Created By: Mary
    Scenario: Usecase to Validate Lock functionality in Version Management screen

        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "Usecase_TestData/ChildScript62" json file in "WorkFlow UI" screen
        Then User will open "GroupName" group in "HomePage" screen
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        And User wait until the spinner disappears 
        # search for applicaion
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
            | Text Input   | 150 | 300 | FirstName  | First Name  |                    |            |        |        |
            | Text Input   | 400 | 300 | LastName    | LastName    |                    |            |        |        |
            | Text Input   | 650 | 300 | Pin         | Pin         |                    |            |        |        |
            | Email        | 150 | 500 | Email       | Email       | example@domain.com |            |        |        |
            | Phone Number | 400 | 500 | PhoneNumber | PhoneNumber |                    |            |        |        |
            | SSN          | 650 | 500 | SSN_ITIN    | SSN/ITIN    |                    |            |        |        |
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
        # Lock screen
        Then User click on "button" "Lock" in "Version" screen
        Then User see text "Success" in "Success" in "Version" screen
        Then User will "Logout" from "Page" the current session

        # Login to the Admin app as Secondary user and check not able to edit any fields
        Given user login to "Finlevit_admin" with "SecondGroupAdmins" credentials
        Then User will open "GroupName" group in "HomePage" screen
        # search for application
        Then User will search for "Application_Name" in "Application" screen
        Then User see text "Front Office" in "FO" in "Page" screen
        When User mouseover "Lock Image" in "frontOffice" screen
        And User wait for "5000"
        # Then User see text "This application is locked, you can not make any modifications" in "Lock Image Tooltip" in "frontOffice" screen
        # validate widget save button is not present in FO Design
        And User edit "First Name" field in "UniqueWidgetFields" screen
        And User should not see an element "WidgetSave" in "UniqueWidgetFields" screen
        
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        When User mouseover "Lock Image" in "frontOffice" screen
        And User wait for "5000"
        # Then User see text "This application is locked, you can not make any modifications" in "Lock Image Tooltip" in "frontOffice" screen
        # validate widget save button is not present in BO Design
        And User edit "First Name" field in "UniqueWidgetFields" screen
        And User should not see an element "WidgetSave" in "UniqueWidgetFields" screen
        # validate widget save button is not present in workflow designer 
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        Then User click on "button" "Review Task" in "tasks" screen
        Then User click on "button" "View Widget" in "tasks" screen
        And User should not see an element "Save" in "tasks" screen
        Then User click on "button" "Cancel" in "UniqueWidgetFields" screen
        # validate version management
        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        And User verify error message for "Verify & Publish" in "Pagelevel_alert_message" in "Version" screen
        Then User click on "button" "Cancel" in "UniqueWidgetFields" screen
        Then User click on "button" "Unlock" in "Version" screen
        And User verify error message for "Unlock" in "Pagelevel_alert_message" in "Version" screen
        Then User should contain text "Locked By" in "Locked by User" in "Version" screen
        Then User will "Logout" from "Page" the current session

        # As a Locked user, unlock the app
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        Then User will open "GroupName" group in "HomePage" screen
        # search for application
        Then User will search for "Application_Name" in "Application" screen
        Then User see text "Front Office" in "FO" in "Page" screen
        And User should not see an element "Lock Image" in "frontOffice" screen
        Then User click on "button" "VersionControl" in "Version" screen
        Then User click on "button" "Unlock" in "Version" screen
        Then User see text "Success" in "Success" in "Version" screen
        Then User will "Logout" from "Page" the current session

        # Login  to the Admin app as Secondary user and check able to edit fields in canvas
        Given user login to "Finlevit_admin" with "SecondGroupAdmins" credentials
        Then User will open "GroupName" group in "HomePage" screen
        # search for application
        Then User will search for "Application_Name" in "Application" screen
        Then User see text "Front Office" in "FO" in "Page" screen
        And User should not see an element "Lock Image" in "frontOffice" screen
        # validate widget save button is present in FO and BO Design
        And User edit "First Name" field in "UniqueWidgetFields" screen
        And User should see an element "WidgetSave" in "UniqueWidgetFields" screen
        
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        And User should not see an element "Lock Image" in "frontOffice" screen
        And User edit "First Name" field in "UniqueWidgetFields" screen
        # Then User right click on "widget" "FirstName" in "payload" screen
        # Then User click on "button" "EditWidget" in "UniqueWidgetFields" screen
        And User should see an element "WidgetSave" in "UniqueWidgetFields" screen
        # validate widget save button is present in workflow designer 
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        Then User click on "button" "Review Task" in "tasks" screen
        Then User click on "button" "EditWidget" in "UniqueWidgetFields" screen
        And User should see an element "Save" in "tasks" screen
        Then User click on "button" "Cancel" in "UniqueWidgetFields" screen
        # As a Secondary user, Publish the app
        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        # And User should contain text "pupblished successfully" in "publishedSuccessfully" in "publishedSuccessfully" screen
        
       
