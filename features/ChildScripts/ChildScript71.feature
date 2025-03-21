Feature: Existing application for XSD with API task and Response Task

    Background: Create File setup for Existing Application
        Given user login to "Finlevit_admin" with "Admin" credentials
        And User get the Test data from "Usecase_TestData/ChildScript71" json file in "WorkFlow UI" screen
        And User test connection for the queue in "queue" screen
        Then User click on "Menu" "fileSetupMenu" in "HomePage" screen
        And User use below "Require Fields" when create app source setup in "appSourceSetup" screen
            | FieldName          | DataType | WidgetType       | IsRequired | MaxLength |
            | FirstName          | string   | TextInput        | Yes        | 10        |
            | Email              | string   | Email            | Yes        |         |
            | SSN                | string   | SSNInput         | Yes        |         |
            | Phone              | string   | PhonenumberInput | Yes        |         |
            | CountryofResidence | string   | Dropdown         | Yes        |         |
            | State              | string   | Dropdown         |            |           |
            | Gender             | string   | RadioGroup       | Yes        |         |

        Then User will create app source setup with "File" in "appSourceSetup" screen
            | FileType | SourceType | QueueIdentifier | FileUpload            |
            | XML      | Primary    | 1QMF            | AutomationPrimary.xsd |

    @InvoiceApp
    @ChildScript71 
    # @ChildScript
    # @ChildScript
    Scenario: Existing application for XSD with API task and Response Task

        #CreateGroup
        # Given user login to "Finlevit_admin" with "Admin" credentials
        And User get the Test data from "Usecase_TestData/ChildScript71" json file in "WorkFlow UI" screen
        Then User will open "GroupName" group in "HomePage" screen
        And User wait for "5000"
        # App
        Then User will create "Existing" app "AppName" with "AppDescription" in "Application" screen
        And User copy "ProcessType" save "ProcessType" in "ChildScript71_Payload" json file
        And User copy "FileName" save "SourceID" in "ChildScript71_Payload" json file
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "3000"
        When User click on "FrontOffice" "Click_FrontOffice" in "Application" screen
        And User will modify "DropDown" on "UniqueWidgetFields" screen
            | FieldName          | OptionType    | InputType | ValueCount | Value1 | Value2  | Value3  |
            | CountryofResidence | ManualOptions | Values    | 3          | India  | Albania | Algeria |

        And User will modify "RadioGroup" on "UniqueWidgetFields" screen
            | FieldName | ValuesAlignment    | InputType | ValueCount | Value1 | Value2 |
            | Gender    | ValueAlignVertical | Values    | 2          | Male   | Female |

        And User will modify "DropDown" on "UniqueWidgetFields" screen
            | FieldName | OptionType    | InputType | ValueCount | Value1        | Value2     | Value3   |
            | State     | ManualOptions | Values    | 3          | NorthCarolina | California | Colorado |

        Then User click on "span" "Save" in "Page" screen
        #add FO agent role
        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
        # BO
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User see text "Back Office" in "BO" in "Page" screen
        Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X  | Y  | FieldName    | Title         |
            | Container | 50 | 50 | PersonalInfo | Personal Info |
        When User expand below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget        | X    | Y   |
            | Personal Info | 1100 | 475 |
        Then User click on "button" "Fields" in "UniqueWidgetFields" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget             | X   | Y   |
            | Pin                | 75  | 125 |
            | FirstName          | 300 | 125 |
            | LastName           | 525 | 125 |
            | Gender             | 75  | 250 |
        When User expand "Radio Group" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget               | X   | Y   |
            | Gender | 100 | 300 |
        Then User click on "span" "Save" in "Page" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen   
            | Widget             | X   | Y   | 
            | CountryofResidence | 300 | 250 |
            | Phone              | 525 | 250 |
            | Email              | 75  | 375 |
            | Salary             | 300 | 375 |
            | IsUSCitizen        | 525 | 375 |

        Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X  | Y   | FieldName | Title   |
            | Container | 50 | 550 | Address   | Address |
        And User wait for "3000"
        When User expand below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget  | X    | Y   |
            | Address | 1100 | 750 |
        Then User click on "button" "Fields" in "UniqueWidgetFields" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget   | X   | Y   |
            | Line1    | 75  | 625 |
            | Locality | 225 | 625 |
            | State    | 375 | 625 |
            | Zipcode  | 525 | 625 |
        Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName | FieldLabel |
            | Text Input | 750 | 250 | BOPin     | BO Pin     |

        Then User click on "button" "CanvasSave" in "UniqueWidgetFields" screen
    #     And User create Onload Triggers with "1" Rule Options Mapping "addOnloadTrigger" in "onLoadTrigger" screen
    #   | Name          | Description   | DataSource | DataList          | Rule1 | Ref1 | Field1  | Label1 | Value1 |  
    #   | Get Countries | Get Countries | Countries  | Get All Countries | Rule1 | CN   | CountryofResidence | name   | iso2   | 
        # Edit existing role
        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        # Add a new role
        Then User "Add" the "Operations" role and add "Operations" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        # To Add the required tasks onto the workflow Designer
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 182 | 231 |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName        | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
            | Task   | 399 | 126 | Review & Upload | Application Manager | 1           | Accept  | In Progress   | 1        | 0       |
        # Script to add API Task with Update By Id operation
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget   | X   | Y   | TaskName      | SuccesStatus | FailedStatus | FailureTaskRole     | DataSource            | DataList                   |
            | API Task | 671 | 131 | Create Record | In Progress  | In Progress  | Application Manager | PI API for Automation | Save PI API for Automation |
        When User Edit "API task" "Create Record" field to Configure Service in "tasks" screen
        Then User will create transformation rule for "API Task" "Save PI API Data" and connect Input and Output nodes in "transformation" screen
            | Destination        | Source             |
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

        And User wait for "2000"
        # Script to add Response Mapping Task
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget           | X   | Y   | TaskName | SuccesStatus | FailedStatus | FailureTaskRole     | Resources     |
            | Response Mapping | 871 | 131 | Response | In Progress  | In Progress  | Application Manager | Create Record |
        When User Edit "Response task" "Response" field to Configure Service in "tasks" screen
        Then User will create transformation rule for "Response Task" "Get Employee" and connect Input and Output nodes in "transformation" screen
            | Destination | Source |
            | BOPin       | Pin    |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X    | Y   | TaskName        | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
            | Task   | 1097 | 130 | Review Response | Application Manager | 1           | Accept  | In Progress   | 1        | 0       |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X    | Y   |
            | End    | 1100 | 328 |
        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source          | Action  | Target          |
            | Start           |         | Review & Upload |
            | Review & Upload | Accept  | Create Record   |
            | Create Record   | Success | Response        |
            | Response        | Success | Review Response |
            | Review Response | Accept  | End             |

        Then User click on "button" "Save" in "workflowDesigner" screen
        #  To validate Version Management
        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        Given User get the Test data from "Usecase_TestData/ChildScript71_Payload" json file in "API" screen
        And "Finlevit_admin" get the access token using "Access_Token" call
        Then User submits transaction for "ChildScript71_Payload"
        And User wait for "2000"
        And User get the Test data from "Usecase_TestData/ChildScript71" json file in "WorkFlow UI" screen
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
        Given User get the Test data from "Usecase_TestData/ChildScript71_Payload" json file in "API" screen
        And User validate "Text Input" widget "Pin" is not empty in "WorkFlow UI" screen
        And User validate "Text Input" widget "FirstName" is not empty in "WorkFlow UI" screen
        And User validate "Text Input" widget "LastName" is not empty in "WorkFlow UI" screen
        And User validate "Radio Group" widget "Gender" is not empty in "WorkFlow UI" screen
        And User validate "Dropdown" widget "CountryofResidence" is not empty in "payload" screen
        And User validate "Text Input" widget "Phone" is not empty in "WorkFlow UI" screen
        And User validate "Text Input" widget "Email" is not empty in "WorkFlow UI" screen
        And User validate "Number" widget "Salary" is not empty in "WorkFlow UI" screen
        # And User validate "Checkbox" widget "IsUSCitizen" is "#IsUSCitizen" in "WorkFlow UI" screen
        And User validate "Text Input" widget "Line1" is not empty in "WorkFlow UI" screen
        And User validate "Text Input" widget "Locality" is not empty in "WorkFlow UI" screen
        And User validate "Dropdown" widget "State" is not empty in "payload" screen
        And User validate "Text Input" widget "Zipcode" is not empty in "WorkFlow UI" screen
        And User get the Test data from "Usecase_TestData/ChildScript71" json file in "WorkFlow UI" screen
        Then User validate Task "1" Actions and select "Accept" action in "WorkFlow UI" screen
        And User wait for "5000"
        Then User click on "Menu" "Team Task" in "WorkFlow UI" screen
        And User assign task to "1" user in "AppManager" in "WorkFlow UI" screen
        And User should contain text "Assigned Successfully" in "Pagelevel_alert_messgae" in "WorkFlow UI" screen
        Then User click on "Menu" "My Task" in "WorkFlow UI" screen
        Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
        And User validate "Text Input" widget "BO Pin" is not empty in "payload" screen
        Then User validate Task "2" Actions and select "Accept" action in "WorkFlow UI" screen
        And User wait for "5000"


    @ApiCallInvoiceApp
    Scenario: Submit a Transaction to demonstrate the functionality of an Existing Application
        Given User get the Test data from "Usecase_TestData/ChildScript71_Payload" json file in "API" screen
        And "Finlevit_admin" get the access token using "Access_Token" call
        Then User submits transaction for "ChildScript71_Payload"

