Feature: Validate API Task - Data for the API task is from FO, including the Unique field

    @ChildScript
    @ChildScript5
    @APITaskFOData
    #Createdby: Manikanta
    #CreatedDate:04/26/2023
    Scenario: Use case to demonstrate API Task - Data for the API task is from FO, including the Unique field

        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "Usecase_TestData/ChildScript5" json file in "WorkFlow UI" screen
        Then User will open "GroupName" group in "HomePage" screen
        # To Create an Application
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "2000"
        And User wait until the spinner disappears
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X  | Y  | FieldName    | Title                                 |
            | Container | 25 | 25 | ChildScript5 | Child Script 5 - Personal Information |
        When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget         | X    | Y   |
            | Child Script 5 | 1050 | 600 |

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName | FieldLabel |
            | Text Input | 50  | 125 | Pin       | Pin        |
            | Text Input | 300 | 125 | FirstName | First Name |
            | Text Input | 550 | 125 | LastName  | Last Name  |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X  | Y   | FieldName | FieldLabel | PlaceHolder        |
            | Email  | 50 | 300 | Email     | Email      | example@domain.com |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget       | X   | Y   | FieldName   | FieldLabel   |
            | Phone Number | 300 | 300 | PhoneNumber | Phone Number |
        When User reloads the page
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget  | X   | Y   | FieldName | FieldLabel |
            | Address | 550 | 300 | Address   | Address    |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X   | Y   | FieldName | FieldLabel | Action | Status |
            | Button | 150 | 474 | Submit    | Submit     | Submit | Save   |
        Then User click on "span" "Save" in "Page" screen
        # # And User write "Front Office" widgets in "FrontOffice_Widgets" in "UniqueWidgetFields" screen
        # #add FO agent role
        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
        #Switch to BO
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName | FieldLabel |
            | Text Input | 300 | 300 | BOPin     | BO Pin     |
        # # And User write "Back Office" widgets in "BackOffice_Widgets" in "UniqueWidgetFields" screen

        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        # To Add the required tasks onto the workflow Designer
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 200 | 100 |
        # Create API task and Assign Destination and Source
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget   | X   | Y   | TaskName      | SuccesStatus | FailedStatus | FailureTaskRole     | DataSource      | DataList             |
            | API Task | 300 | 200 | Create Record | In Progress  | In Progress  | Application Manager | Mary PI Details | Save Mary PI Details |
        When User Edit "API task" "Create Record" field to Configure Service in "tasks" screen
        Then User will create transformation rule for "API Task" "Save Employee" and connect Input and Output nodes in "transformation" screen
            | Destination  | Source            |
            | Pin          | Pin               |
            | FN           | FirstName         |
            | LN           | LastName          |
            | Email        | Email             |
            | Phone        | PhoneNumber       |
            | AddressLine1 | Address           |
            | City  | Address_1_locality   |
            | State | Address_1_state      |
#            | Zip   | Address_1_postalCode |
        # Create Response MApping task and Assign Destination and Source
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget           | X   | Y   | TaskName     | SuccesStatus | FailedStatus | FailureTaskRole     | Resources     |
            | Response Mapping | 500 | 200 | Get Response | In Progress  | In Progress  | Application Manager | Create Record |

        When User Edit "Response task" "Get Response" field to Configure Service in "tasks" screen
        Then User will create transformation rule for "Response Task" "Get Employee" and connect Input and Output nodes in "transformation" screen
            | Destination | Source |
            | BOPin       | Pin    |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
            | Task   | 700 | 200 | Review   | Application Manager | 1           | Accept  | In Progress   | 1        | 0       |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | End    | 900 | 300 |

        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source        | Action  | Target        |
            | Start         |         | Create Record |
            | Create Record | Success | Get Response  |
            | Get Response  | Success | Review        |
            | Review        | Accept  | End           |

        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        #  To validate Preview
        And User validate Payload app opening in a new tab
        Then User will "Logout" from "Page" the current session
        # Payload
        Given user login to payload application with "Finlevit_payload" with "1" agent
        #Enter Data
        And User enter "text" in "Pin" with "5" characters
        And User enter "text" in "First Name" with "7" characters
        And User enter "text" in "Last Name" with "7" characters
        And User enter "email" in "Email" with "5" characters
        And User enter "phoneNumber" in "Phone Number" with "10" characters
        And User enter "number" in "Address" with "3" characters
        And User wait for "1000"
        Then User select on "Address" "SelectFirstAddress" in "payload" screen
        Then User click on "Button" widget "Submit" in "payload" screen
        And User get Transaction Id and save it in json file
        #WorkFlow UI
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
        And User validate "Text Input" widget "BO Pin" is not empty in "payload" screen
        Then User validate Task "1" Actions and select "Accept" action in "WorkFlow UI" screen
        And User wait for "5000"
#        And User validate Transaction details are removed from "Team Task" in "WorkFlow UI" screen
        Then User will "Logout" from "Page" the current session
