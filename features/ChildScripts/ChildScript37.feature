Feature: Existing application with manual configuration in FO and Manual task

    Background: Create File setup for Existing Application
        Given user login to "Finlevit_admin" with "Admin" credentials
        And User get the Test data from "Usecase_TestData/ChildScript37" json file in "WorkFlow UI" screen
        And User test connection for the queue in "queue" screen
       Then User click on "Menu" "fileSetupMenu" in "HomePage" screen
        And User use below "Require Fields" when create app source setup in "appSourceSetup" screen
            | FieldName       | DataType | WidgetType       | IsRequired | MaxLength |
            | OrderType       | string   | Dropdown         | Yes        |         |
            | Email           | string   | Email            | Yes        |         |
            | SSN             | string   | SSNInput         | Yes        |         |
            | Phone           | string   | PhonenumberInput | Yes        |         |
            | Status          | string   | RadioGroup       | Yes        |         |
            | CountryOfOrigin | string   | Dropdown         | Yes        |         |
            | Url             | string   | URL              |            |           |

        #  And User use below "Require Fields" when create app source setup in "appSourceSetup" screen
        #     | FieldName       | DataType | WidgetType       | IsRequired | MaxLength |
        #     | OrderType       | string   | Dropdown         | Yes        | 10        |
        #     | Email           | string   | Email            | Yes        | 25        |
        #     | SSN             | string   | SSNInput         | Yes        | 11        |
        #     | Phone           | string   | PhonenumberInput | Yes        | 12        |
        #     | Status          | string   | RadioGroup       | Yes        | 10        |
        #     | CountryOfOrigin | string   | Dropdown         | Yes        | 10        |
        #     | Url             | string   | URL              |            |           |

        Then User will create app source setup with "File" in "appSourceSetup" screen
            | FileType | SourceType | QueueIdentifier | FileUpload      |
            | JSON     | Primary    | 1QMF            | InvoiceApp.json |


    @InvoiceApp
    @ChildScript37
    # @ChildScript
   Scenario: Usecase to demonstrate the workflow of an Existing App functionality where FO has manual configrations and BO has OLT and manual task as part of ist workflow

        #CreateGroup
        # Given user login to "Finlevit_admin" with "Admin" credentials
        And User get the Test data from "Usecase_TestData/ChildScript37" json file in "WorkFlow UI" screen
        Then User will open "GroupName" group in "HomePage" screen
        And User wait for "5000"
        # App
        Then User will create "Existing" app "AppName" with "AppDescription" in "Application" screen
        And User copy "ProcessType" save "ProcessType" in "ChildScript37_Payload" json file
        And User copy "FileName" save "SourceID" in "ChildScript37_Payload" json file
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "3000"
        When User click on "FrontOffice" "Click_FrontOffice" in "Application" screen
        And User will modify "DropDown" on "UniqueWidgetFields" screen
            | FieldName | OptionType    | InputType | ValueCount | Value1 | Value2  | Value3 |
            | OrderType | ManualOptions | Values    | 3          | Online | InStore | Vendor |

        And User will modify "RadioGroup" on "UniqueWidgetFields" screen
            | FieldName | ValuesAlignment    | InputType | ValueCount | Value1  | Value2    |
            | Status    | ValueAlignVertical | Values    | 2          | Shipped | Delivered |

        When User makes changes to "OrderValue" field format as in "UniqueWidgetFields" screen
            | TypeOfFormat | CurrencyCountry |
            | Currency     | United States   |

        Then User click on "span" "Save" in "Page" screen
        And User should contain text "Saved successfully" in "SavedSuccessfully" in "UniqueWidgetFields" screen
        # # And User write "Front Office" widgets in "FrontOffice_Widgets" in "UniqueWidgetFields" screen
        # #add FO agent role
        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User see text "Back Office" in "BO" in "Page" screen
        Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X  | Y  | FieldName | Title        |
            | Container | 50 | 50 | Invoice   | Invoice Info |
        When User expand below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget       | X    | Y   |
            | Invoice Info | 1100 | 650 |
        Then User click on "button" "FOFields" in "UniqueWidgetFields" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget        | X   | Y   |
            | TransactionId | 100 | 150 |
            | OrderType     | 375 | 150 |
            | SourceID      | 650 | 150 |
            | ProcessType   | 900 | 150 |
            | Name          | 100 | 300 |
            | SSN           | 375 | 300 |
            | Email         | 650 | 300 |
            | Phone         | 900 | 300 |
             | Status        | 100 | 450 |
        When User expand "Radio Group" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget               | X   | Y   |
            | Status | 350 | 500 |
        Then User click on "span" "Save" in "Page" screen
         Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget        | X   | Y   |   
            | OrderInsured  | 375 | 450 |
            | Url           | 650 | 450 |
            | OrderValue    | 900 | 450 |
        Then User click on "span" "Save" in "Page" screen
        And User should contain text "Saved successfully" in "SavedSuccessfully" in "UniqueWidgetFields" screen
        # # And User write "Back Office" widgets in "BackOffice_Widgets" in "UniqueWidgetFields" screen

        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
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
        And User wait for "1000"
        # When User checkout the version "latest version" for app modification
        # Then User click on "tab" "Design" in "Page" screen
        # Then User click on "FrontOffice" "Click_FrontOffice" in "Application" screen
        # And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
        # | Widget | X   | Y   | FieldName | FieldLabel |
        # | Number | 375 | 450 | amount    | Amount     |
        # Then User click on "button" "CanvasSave" in "UniqueWidgetFields" screen
        # Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        # Then User see text "Back Office" in "BO" in "Page" screen
        # Then User click on "button" "FOFields" in "UniqueWidgetFields" screen
        # Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
        #     | Widget        | X   | Y   |
        #     | amount | 375 | 550 |
        # Then User click on "button" "CanvasSave" in "UniqueWidgetFields" screen
        # Then User click on "button" "VersionControl" in "Version" screen
        # Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        # And User wait for "1000"
        # Then User will "Logout" from "Page" the current session
        # # Validate New field in File setup UI
        # Given user login to "Finlevit_admin" with "Admin" credentials
        # Then User click on "Menu" "fileSetupMenu" in "HomePage" screen
        # And User will search for file setup "FileName" in "fileSetup" screen
        # Then User click on "Button" "next" in "fileSetup" screen
        # And User check text "amount" in "amountField" in "fileSetup" screen
        # Then User click on "Button" "cancel" in "fileSetup" screen
        # Then User will "Logout" from "Page" the current session
        #Submit Transaction
        Given User get the Test data from "Usecase_TestData/ChildScript37_Payload" json file in "API" screen
        And "Finlevit_admin" get the access token using "Access_Token" call
        Then User submits transaction for "ChildScript37_Payload"
         And User wait for "2000"
        And User get the Test data from "Usecase_TestData/ChildScript37" json file in "WorkFlow UI" screen
        Given user login to workflow UI "Finlevit_workflow" with "1" "AppManager" credentials
        And User wait until the "Filter Transaction id" appears in "WorkFlow UI" screen
        Then User click on "Button" "Home" in "HomePage" screen
        Then User will open "GroupName" group in "HomePage" screen
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "5000"
        Then User click on "Menu" "Team Task" in "WorkFlow UI" screen
        And User wait until the spinner disappears
        And User select "span" tag drop down option "Application Manager" in "Role Dropdown" in "WorkFlow UI" screen
        And User assign task to "1" user in "AppManager" in "WorkFlow UI" screen
        Then User click on "Menu" "My Task" in "WorkFlow UI" screen
        Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
        Given User get the Test data from "Usecase_TestData/ChildScript37_Payload" json file in "API" screen
        And User validate "Text Input" widget "TransactionId" is "#TransactionId" in "WorkFlow UI" screen
        And User validate "Text Input" widget "SourceID" is "#SourceID" in "WorkFlow UI" screen
        And User validate "Text Input" widget "ProcessType" is "#ProcessType" in "WorkFlow UI" screen
        And User validate "Text Input" widget "Name" is "#Name" in "WorkFlow UI" screen
        And User validate "SSN / ITIN" widget "SSN" is not empty in "WorkFlow UI" screen
        And User validate "Text Input" widget "Email" is "#Email" in "WorkFlow UI" screen
        And User validate "Text Input" widget "Phone" is "#Phone" in "WorkFlow UI" screen
        And User validate "Radio Group" widget "Status" is "#Status" in "WorkFlow UI" screen
        And User validate "Checkbox" widget "OrderInsured" is "#OrderInsured" in "WorkFlow UI" screen
        And User validate "Number" widget "OrderValue" is not empty in "WorkFlow UI" screen
        # And User validate "Number" widget "Amount" is not empty in "WorkFlow UI" screen
        And User validate "Dropdown" widget "OrderType" is not empty in "payload" screen
        And User get the Test data from "Usecase_TestData/ChildScript37" json file in "WorkFlow UI" screen
        Then User validate Task "1" Actions and select "Accept" action in "WorkFlow UI" screen
        And User wait for "5000"
    # And User validate Transaction details are removed from "Team Task" in "WorkFlow UI" screen
    # # Delete newly added field from Admin app
    # Given user login to "Finlevit_admin" with "Admin" credentials
    # And User get the Test data from "Usecase_TestData/ChildScript37" json file in "WorkFlow UI" screen
    # Then User will open "GroupName" group in "HomePage" screen
    # And User wait for "5000"
    # # App
    # Then User will search for "Application_Name" in "Application" screen
    # And User wait for "2000"
    # Then User see text "Front Office" in "FO" in "Page" screen
    # Then User click on "button" "VersionControl" in "Version" screen
    # When User checkout the version "latest version" for app modification
    # Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
    # Then User see text "Back Office" in "BO" in "Page" screen
    # And User wait for "2000"
    # When User click "Amount" field and delete "UniqueWidgetFields" screen
    # Then User click on "span" "Save" in "Page" screen
    # Then User click on "FrontOffice" "Click_FrontOffice" in "Application" screen
    # Then User see text "Front Office" in "FO" in "Page" screen
    # When User click "Amount" field and delete "UniqueWidgetFields" screen
    # Then User click on "span" "Save" in "Page" screen
    # Then User click on "button" "VersionControl" in "Version" screen
    # Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
    # And User wait for "1000"

    @ApiCallInvoiceApp
    Scenario: Submit a Transaction to demonstrate the functionality of an Existing Application
        Given User get the Test data from "Usecase_TestData/ChildScript37_Payload" json file in "API" screen
        And "Finlevit_admin" get the access token using "Access_Token" call
        Then User submits transaction for "ChildScript37_Payload"





