Feature: Super Script phase 1

    @sanityTestSuite
    @SuperScriptFO @SuperScript
    Scenario: Create an app to demonstrate functionalities of Container, Advance Table and onload triggers on multiple types of widgets
        # # Export Required API's to Service Providers and Data Sources
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "Usecase_TestData/SuperScriptfeature" json file in "WorkFlow UI" screen
        # # Verify Data Resources required for execution are present
        Then User will open "GroupName" group in "HomePage" screen
        Then User click on "button" "group_settings" in "Groups" screen
        Then User click on "button" "dataSources" in "onLoadTrigger" screen
        And User get unique field in Data Source "Countries" in "onLoadTrigger" screen and save it in "CountryId"
        # And User clone Data Source "States" in "onLoadTrigger" screen
        And User get unique field in Data Source "PersonalInfo" in "onLoadTrigger" screen and save it in "PIId"
        And User get unique field in Data Source "EmployeeDetails" in "onLoadTrigger" screen and save it in "EmployeePin"
        And User get unique field in Data Source "EmployerDetails" in "onLoadTrigger" screen and save it in "EmployerPin"
        Then User will open "GroupName" group in "HomePage" screen

        # # Create Application
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen

        # Drag Widgets onto the Canvas in Front Office
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X  | Y  | FieldName           | Title                |
            | Container | 25 | 10 | EmployerInformation | Employer Information |
        When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget               | X    | Y   |
            | Employer Information | 1200 | 225 |
        Then User click on "span" "Save" in "Page" screen
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName    | FieldLabel    |
            | Text Input | 50  | 100 | EmployerID   | Employer ID   |
            | Text Input | 275 | 100 | EmployerName | Employer Name |
        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget      | X   | Y   | FieldName | FieldLabel | ValuesAlignment      | ValueCount | Value1    | Value2    |
            | Radio Group | 500 | 100 | JobType   | Job Type   | ValueAlignHorizontal | 2          | Full Time | Part Time |

        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget   | X   | Y   | FieldName | FieldLabel | OptionType       |
            | Dropdown | 725 | 100 | Country   | Country    | ConfigureOptions |
            | Dropdown | 950 | 100 | State     | State      | ConfigureOptions |

        And User Drag and Drop below widgets in "CanvasBody" in "AdvanceTable" screen
            | Widget        | X  | Y   | Name          |
            | Advance Table | 25 | 245 | Employee List |

        When User expand "Advance Table" widgets in "CanvasBody" in "UniqueWidgetFields" screen
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

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName       | FieldLabel      | Action | Status |
            | Text Input | 75  | 500 | EmpPin          | Pin             |        |        |
            | Button     | 425 | 515 | Get Emp Details | Get Emp Details | Submit | Save   |
            | Button     | 675 | 515 | Submit          | Submit          | Submit | Save   |

        When User expand "Button" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget          | X   | Y   |
            | Get Emp Details | 575 | 550 |
            | Submit          | 825 | 550 |

        Then User click on "span" "Save" in "Page" screen
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X  | Y   | FieldName       | Title            |
            | Container | 25 | 600 | EmployeeDetails | Employee Details |

        When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget           | X    | Y   |
            | Employee Details | 1200 | 900 |

        Then User click on "span" "Save" in "Page" screen

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget       | X   | Y   | FieldName      | FieldLabel     |
            | Text Input   | 50  | 675 | EmployeePin    | Employee Pin   |
            | Text Input   | 275 | 675 | EmployeeFN     | Emp First Name |
            | Text Input   | 525 | 675 | EmployeeLN     | Emp Last Name  |
            | SSN          | 775 | 675 | EmployeeSSN    | SSN/ITIN       |
            | Number       | 775 | 775 | EmployeeSalary | Salary         |
            | Phone Number | 275 | 775 | EmployeePhone  | Employee Phone |

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget      | X   | Y   | FieldName | FieldLabel      | ValuesAlignment      | ValueCount | Value1 | Value2 |
            | Radio Group | 525 | 775 | EmpGender | Employee Gender | ValueAlignHorizontal | 2          | Male   | Female |

        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X  | Y   | FieldName | FieldLabel     | PlaceHolder            |
            | Email  | 50 | 775 | EmpEmail  | Employee Email | email@tabnerglobal.com |

        When User makes changes to "Salary" field format as in "UniqueWidgetFields" screen
            | TypeOfFormat | CurrencyCountry |
            | Currency     | United States   |

        Then User click on "span" "Save" in "Page" screen

        And User scroll to an element "Employer Information" in "UniqueWidgetFields" screen
        # # Create Onload triggers
        And User create Onload Triggers with "1" Options Mapping "addOnloadTrigger" in "onLoadTrigger" screen
            | Name          | Description   | DataSource | DataList          | Field1  | Label1 | Value1 |
            | Get Countries | Get Countries | Countries  | Get All Countries | Country | name   | iso2   |

        And User create Onload Triggers with Response Mapping "addOnloadTrigger" in "onLoadTrigger" screen
            | Name                 | Description      | DataSource      | DataList                  | Type    | Pin    | uniqueField | uniqueFieldValue |
            | Get Employer Details | Employer Details | EmployerDetails | Get By Id EmployerDetails | session | userId | EmployerPin | userId           |

        Then User will create transformation rule for "Response Mapping" "Save EmployeeName" and connect Input and Output nodes in "transformation" screen
            | Destination  | Source       |
            | EmployerID   | EmployerId   |
            | EmployerName | EmployerName |
            | JobType      | JobType      |
            | Country      | Country      |
            | State        | State        |

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

        Then User click on "tab" "Design" in "Page" screen
        Then User see text "Front Office" in "FO" in "Page" screen
        # Create on change triggers
        And User Configuring a Trigger on a "Dropdown" "Country" in "UniqueWidgetFields" screen
            | Title      | OnChangeAction | DataResources | DataList                         | Type | UniqueField | Value   |
            | Get States | Populate       | States        | Get By Filter Field: countryCode | ref  | CountryId   | Country |

        And User Configuring Options mapping for a dropdown "State" in "UniqueWidgetFields" screen from "Get States" trigger in "Country"
            | Title      | OptionLabel | OptionValue | Defaultkey |
            | Get States | name        | name        |            |
        # # Create on click trigger
        And User Configuring a Trigger on a "Button" "Get Emp Details" in "UniqueWidgetFields" screen
            | Title      | ClickAction | DataResources   | DataList                  | Type | UniqueField | Value  |
            | EmpDetails | Populate    | EmployeeDetails | Get By Id EmployeeDetails | ref  | EmployeePin | EmpPin |

        And User scroll to an element "Actions" in "UniqueWidgetFields" screen
        And User wait for "2000"

        # #  To Edit Data Configuration for an Advanced Table
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
        Then User see text "Front Office" in "FO" in "Page" screen

        When User makes changes to below field's to Configure Data Population for "DropDown" in "UniqueWidgetFields" screen
            | Field          | Title      | Trigger                      | ResponseField |
            | Employee Pin   | Get EmpPIN | Get Emp Details : EmpDetails | Pin           |
            | Emp First Name | Get EmpFN  | Get Emp Details : EmpDetails | FirstName     |
            | Emp Last Name  | Get EmpLN  | Get Emp Details : EmpDetails | LastName      |
            | SSN/ITIN     | Get SSN    | Get Emp Details : EmpDetails | SSN           |

        When User makes changes to below field's to Configure Data Population for "DropDown" in "UniqueWidgetFields" screen
            | Field           | Title          | Trigger                      | ResponseField |
            | Employee Email  | Get Email      | Get Emp Details : EmpDetails | Email         |
            | Employee Phone  | Get Emp Phone  | Get Emp Details : EmpDetails | Phone         |
            | Employee Gender | Get Emp Gender | Get Emp Details : EmpDetails | Gender        |
            | Salary          | Get Salary     | Get Emp Details : EmpDetails | Salary        |
        # # Add Front Office Agent Role
        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        # # Drag the Front Office widgets onto Back office Canavas
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget              | X   | Y   |
            | EmployerInformation | 50  | 25  |
            | Employee List       | 50  | 250 |
            | EmpPin              | 75  | 500 |
            | Get Emp Details     | 425 | 515 |
            | EmployeeDetails     | 50  | 625 |
        Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
        And User scroll to an element "Job Type" in "UniqueWidgetFields" screen
        And User scroll to an element "Showing" in "UniqueWidgetFields" screen
        And User scroll to an element "Salary" in "UniqueWidgetFields" screen
        # # Add Backoffice Field
        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X   | Y   | FieldName | FieldLabel |
            | Number | 950 | 515 | BOSalary  | BO Salary  |

        When User makes changes to "BO Salary" field format as in "UniqueWidgetFields" screen
            | TypeOfFormat | CurrencyCountry |
            | Currency     | United States   |
        When User make "BO Salary" field in BO as prePopulate in "UniqueWidgetFields" screen

        # And User write "Front Office" widgets in "FrontOffice_Widgets" in "UniqueWidgetFields" screen
        # And User write "Back Office" widgets in "BackOffice_Widgets" in "UniqueWidgetFields" screen


        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen

        # To Add the required tasks onto the workflow Designer
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 196 | 152 |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | Role                | NoofActions | Action1 | Action1Status |SLAHours | SLADays |
            | Task   | 225 | 233 | Review   | Application Manager | 1           | Accept  | In Progress   |1        | 0       |
        # Script to add API Task
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget   | X   | Y   | TaskName                      | SuccesStatus | FailedStatus | FailureTaskRole     |DataSource      | DataList             |
            | API Task | 445 | 153 | Created Record - PersonalInfo | In Progress  | In Progress  | Application Manager | PersonalInfo | Save PersonalInfo |
        When User Edit "API task" "Created Record - PersonalInfo" field to Configure Service in "tasks" screen
        Then User will create transformation rule for "API Task" "Save Employee" and connect Input and Output nodes in "transformation" screen
            | Destination | Source         |
            | Pin         | EmpPin         |
            | Email       | EmpEmail       |
            | FirstName   | EmployeeFN     |
            | LastName    | EmployeeLN     |
            | SSN         | EmployeeSSN    |
            | Salary      | EmployeeSalary |
            | Phone       | EmployeePhone  |
            | Gender      | EmpGender      |
        
        # When User makes changes to the API task "Created Record - PersonalInfo" field to Configure Service in "tasks" screen
        #     | Category | Service      | Operation         |
        #     | Internal | PersonalInfo | Save PersonalInfo |
        # Then User will connect Input and Output nodes in "transformationUI" screen
        #     | Input          | Output    |
        #     | EmpPin         | Pin       |
        #     | EmpEmail       | Email     |
        #     | EmployeeFN     | FirstName |
        #     | EmployeeLN     | LastName  |
        #     | EmployeeSSN    | SSN       |
        #     | EmployeeSalary | Salary    |
        #     | EmployeePhone  | Phone     |
        #     | EmpGender      | Gender    |

        # Script to add API Task
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget   | X   | Y   | TaskName                | SuccesStatus | FailedStatus | FailureTaskRole     |DataSource      | DataList             |
            | API Task | 445 | 361 | Update Employee Records | In Progress  | In Progress  | Application Manager |EmployeeDetails | Update By Id EmployeeDetails |
        When User Edit "API task" "Update Employee Records" field to Configure Service in "tasks" screen
        Then User will create transformation rule for "API Task" "Update Employee" and connect Input and Output nodes in "transformation" screen
            | Destination | Source         | UniqueField |
            | Pin         | EmpPin         |             |
            | Email       | EmpEmail       |             |
            | FirstName   | EmployeeFN     |             |
            | LastName    | EmployeeLN     |             |
            | SSN         | EmployeeSSN    |             |
            | Salary      | EmployeeSalary |             |
            | Phone       | EmployeePhone  |             |
            | Gender      | EmpGender      |             |
            | Pin         | EmpPin         | Yes         |
        
        # When User makes changes to the API task "Update Employee Records" field to Configure Service in "tasks" screen
        #     | Category | Service         | Operation                    |
        #     | Internal | EmployeeDetails | Update By Id EmployeeDetails |
        # Then User will connect Unique Field nodes in "transformationUI" screen
        #     | Input  | Output |
        #     | EmpPin | Pin    |
        # Then User will connect Input and Output nodes in "transformationUI" screen
        #     | Input          | Output    |
        #     | EmpPin         | Pin       |
        #     | EmpEmail       | Email     |
        #     | EmployeeFN     | FirstName |
        #     | EmployeeLN     | LastName  |
        #     | EmployeeSSN    | SSN       |
        #     | EmployeeSalary | Salary    |
        #     | EmployeePhone  | Phone     |
        #     | EmpGender      | Gender    |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | Status      |
            | Merge  | 679 | 278 | Merge    | In Progress |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | To        | Sub                | Template            | FailureTaskRole     |
            | Email  | 770 | 278 | Email    | @EmpEmail | MailSubSuperscript | MailBodySuperscript | Application Manager |

        #  Script to add Response Mapping Task
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget           | X   | Y   | TaskName     | SuccesStatus | FailedStatus | FailureTaskRole     |Resources     |
            | Response Mapping | 862 | 283 | Get Response | In Progress  | In Progress  | Application Manager |Created Record - PersonalInfo|
        When User Edit "API task" "Get Response" field to Configure Service in "tasks" screen
        Then User will create transformation rule for "Response Task" "Get Employee" and connect Input and Output nodes in "transformation" screen
            | Destination | Source |
            | BOSalary    | Salary |
    
        # When User makes changes to the Response task "Get Response" field to Configure Service in "tasks" screen
        #     | ResponseInput                 |
        #     | Created Record - PersonalInfo |
        # Then User will connect Input and Output nodes in "transformationUI" screen
        #     | Input  | Output   |
        #     | Salary | BOSalary |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X    | Y   | TaskName        | Role                | NoofActions | Action1 | Action1Status |SLAHours | SLADays |
            | Task   | 1050 | 317 | Review Response | Application Manager | 1           | Accept  | In Progress   |1        | 0       |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X    | Y   |
            | End    | 1248 | 400 |

        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source                        | Action  | Target                        |
            | Start                         |         | Review                        |
            | Review                        | Accept  | Created Record - PersonalInfo |
            | Review                        | Accept  | Update Employee Records       |
            | Created Record - PersonalInfo | Success | Merge                         |
            | Update Employee Records       | Success | Merge                         |
            | Merge                         |         | Email                         |
            | Email                         |         | Get Response                  |
            | Get Response                  | Success | Review Response               |
            | Review Response               | Accept  | End                           |

        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        #  To validate Preview
        And User validate Payload app opening in a new tab
        Then User will "Logout" from "Page" the current session

    @SSPhase2 @SuperScriptph2
    Scenario: Super script scenario phase 2

        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "Usecase_TestData/SuperScriptfeature" json file in "WorkFlow UI" screen
        Then User will open "GroupName" group in "HomePage" screen
        # # Clone Data Resources
        Then User click on "button" "group_settings" in "Groups" screen
        Then User click on "button" "dataSources" in "onLoadTrigger" screen

        And User clone Data Source "Countries" in "onLoadTrigger" screen
        And User get unique field in Data Source "Countries" in "onLoadTrigger" screen and save it in "CountryId"

        And User clone Data Source "States" in "onLoadTrigger" screen

        And User clone Data Source "PersonalInfo" in "onLoadTrigger" screen
        And User get unique field in Data Source "PersonalInfo" in "onLoadTrigger" screen and save it in "PIId"

        And User clone Data Source "EmployeeDetails" in "onLoadTrigger" screen
        And User get unique field in Data Source "EmployeeDetails" in "onLoadTrigger" screen and save it in "EmployeePin"

        And User clone Data Source "EmployerDetails" in "onLoadTrigger" screen
        And User get unique field in Data Source "EmployerDetails" in "onLoadTrigger" screen and save it in "EmployerPin"
        Then User will open "GroupName" group in "HomePage" screen
        Then User will search for "Application_Name" in "Application" screen
        Then User click on "button" "VersionControl" in "Version" screen
        When User checkout the version "latest version" for app modification
        Then User click on "FrontOffice" "Click_FrontOffice" in "Application" screen
        And User scroll to an element "Submit" in "UniqueWidgetFields" screen

        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X   | Y   | FieldName   | Title       |
            | Container | 700 | 625 | Emp Address | Emp Address |

        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget  | X   | Y   |
            | Address | 750 | 700 |

        And User create Onload Triggers with Response Mapping "addOnloadTrigger" in "onLoadTrigger" screen
            | Name                 | Description      | DataSource   | DataList               | Type | Pin |
            | Get Employee Address | Employee Address | PersonalInfo | Get By Id PersonalInfo | ref  | Pin |
        
        Then User will create transformation rule for "Response Mapping" "Save EmployeeName" and connect Input and Output nodes in "transformation" screen
            | Destination         | Source   |
            | address_1           | Line1    |
            | Address_1_locality   | Locality |
            | Address_1_state      | State    |
            | Address_1_postalCode | Zipcode  |

        Then User click on "tab" "Design" in "Page" screen
        Then User see text "Front Office" in "FO" in "Page" screen

        # Get Address
        And User Configuring a Trigger on a "Button" "Get Emp Details" in "UniqueWidgetFields" screen
            | Title       | ClickAction | DataResources | DataList               | Type | UniqueField | Value  |
            | Get Address | Populate    | PersonalInfo  | Get By Id PersonalInfo | ref  | EmployeePin | EmpPin |


        When User makes changes to below field's to Configure Data Population for "DropDown" in "UniqueWidgetFields" screen
            | Field   | Title       | Trigger                       | ResponseField |
            | Address | Get Address | Get Emp Address : Get Address | Line1         |
            | City    | Get City    | Get Emp Details : Get Address | Locality      |
            | State   | Get State   | Get Emp Details : Get Address | State         |
            | Zip     | Get Zip     | Get Emp Details : Get Address | Zipcode       |


    @SuperScriptPayload
    #Created by: Mary
    #Created on : 03/28/2023
    Scenario Outline: Payload Validation
        And User get the Test data from "resources/ExpectedData" json file in "WorkFlow UI" screen
        Given user login to payload application with "Finlevit_payload" with "1" agent
        And User validate "Text Input" widget "Employer Name" is not empty in "payload" screen
        And User validate "Radio Group" widget "Job Type" is not empty in "payload" screen
        # Then User click on "Dropdown" widget "Country" in "payload" screen
        # And User wait for "1000"
        # Then User should have count "250" in "DropdownValues" in "payload" screen
        # Then User click on "Dropdown" widget "Country" in "payload" screen
        And User select drop down option "India" in "Country" widget in "payload" screen
        And User wait for "5000"
        # Then User click on "Dropdown" widget "States" in "payload" screen
        # And User wait for "1000"
        # Then User should have count "66" in "DropdownValues" in "payload" screen
        # Then User click on "Dropdown" widget "States" in "payload" screen
        And User select drop down option "Tamil Nadu" in "States" widget in "payload" screen
        And User wait for "3000"
        And User Fill "<Pin>" in "Text Input" widget "Pin" in "payload" screen
        Then User click on "Button" widget "Get Emp Details" in "payload" screen
        And User validate "Text Input" widget "Employee Pin" is not empty in "payload" screen
        And User validate "SSN / ITIN" widget "SSN/ITIN" is not empty in "payload" screen
        And User validate "Number" widget "Salary" is not empty in "payload" screen
        And User validate "Text Input" widget "Address" is not empty in "payload" screen
        And User validate "Text Input" widget "City" is not empty in "payload" screen
        And User validate "Dropdown" widget "State" is not empty in "payload" screen
        And User validate "Text Input" widget "Zip" is not empty in "payload" screen

        And User Edit an Advanced table Columns in "payload" screen
            | WidgetName | WidgetType | ExpectedValue |
            | Phone      | Text Input |               |
            | Email      | Email      |               |
            | First Name | Text Input | Mani          |

        # And User Delete an Advanced table rows in "payload" screen
        And User Add a new row in Advanced table in "payload" screen
            | WidgetName | WidgetType | ExpectedValue          |
            | Pin        | Text Input | sdale                  |
            | First Name | Text Input | Scott                  |
            | Last Name  | Text Input | Dale                   |
            | Phone      | Text Input | 704-988-1989           |
            | Email      | Email      | sdale@tabnerglobal.com |

        # Then User click on "button" "Submit_btn" in "payload" screen
        And User wait for "5000"

        Examples:
            | Pin   | LastName | Father Name | Mother Name | Gender | Number    |
            | marul | Dale     | Father      | Mother      | Male   | 987654321 |

    # Old SuperScript
    @SuperScriptAdminApp1 @SuperScriptFO @SuperScript1
    Scenario: Create an app to demonstarte functiionalities of Container, Advance Table and

        #CreateGroup
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "resources/ExpectedData" json file in "WorkFlow UI" screen
        When User enter create group with "GroupName" and "GroupDescription" in "Groups" screen
        # # # Clone Data Resources
        Then User click on "button" "group_settings" in "Groups" screen
        Then User click on "button" "dataSources" in "onLoadTrigger" screen

        And User clone Data Source "Countries" in "onLoadTrigger" screen
        And User get unique field in Data Source "Countries" in "onLoadTrigger" screen and save it in "CountryId"

        And User clone Data Source "States" in "onLoadTrigger" screen

        And User clone Data Source "PersonalInfo" in "onLoadTrigger" screen
        And User get unique field in Data Source "PersonalInfo" in "onLoadTrigger" screen and save it in "PIId"

        And User clone Data Source "EmployeeDetails" in "onLoadTrigger" screen
        And User get unique field in Data Source "EmployeeDetails" in "onLoadTrigger" screen and save it in "EmployeePin"

        And User clone Data Source "EmployerDetails" in "onLoadTrigger" screen
        And User get unique field in Data Source "EmployerDetails" in "onLoadTrigger" screen and save it in "EmployerPin"

        Then User will open "GroupName" group in "HomePage" screen
        # #CreateApplication
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen

        # Drag Widgets onto the Canvas
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X  | Y  | FieldName           | Title                |
            | Container | 50 | 60 | EmployerInformation | Employer Information |
        When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget               | X    | Y   |
            | Employer Information | 1100 | 400 |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget       | X   | Y   | FieldName       | FieldLabel       |
            | Text Input   | 75  | 140 | EmployerName    | Employer Name    |
            | Text Input   | 300 | 140 | EmployerAddress | Employer Address |
            | Phone Number | 550 | 140 | EmployerPhone   | Employer Phone   |

        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X   | Y   | FieldName     | FieldLabel     | PlaceHolder        |
            | Email  | 775 | 140 | EmployerEmail | Employer Email | example@domain.com |
        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget   | X   | Y   | FieldName | FieldLabel | OptionType       |
            | Dropdown | 75  | 250 | Country   | Country    | ConfigureOptions |
            | Dropdown | 300 | 250 | State     | State      | ConfigureOptions |
        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget      | X   | Y   | FieldName | FieldLabel | ValuesAlignment      | ValueCount | Value1    | Value2    |
            | Radio Group | 550 | 250 | JobType   | Job Type   | ValueAlignHorizontal | 2          | Full Time | Part Time |

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X  | Y   | FieldName       | Title            |
            | Container | 50 | 450 | EmployeeDetails | Employee Details |

        When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget           | X    | Y   |
            | Employee Details | 1100 | 850 |

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget       | X   | Y   | FieldName      | FieldLabel     |
            | Text Input   | 75  | 520 | EmpFirstName   | Emp First Name |
            | Text Input   | 300 | 520 | EmpLastName    | Emp Last Name  |
            | Phone Number | 300 | 640 | EmployeePhone  | Employee Phone |
            | Text Input   | 300 | 750 | EmployeePin    | Employee Pin   |
            | Number       | 75  | 750 | EmployeeSalary | Salary         |
            | SSN          | 775 | 640 | EmployeeSSN    | SSN/ITIN       |

        When User makes changes to "Salary" field format as in "UniqueWidgetFields" screen
            | TypeOfFormat | CurrencyCountry |
            | Currency     | United States   |

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget      | X   | Y   | FieldName | FieldLabel | ValuesAlignment    | ValueCount | Value1 | Value2 |
            | Radio Group | 575 | 520 | EmpGender | Emp Gender | ValueAlignVertical | 2          | Male   | Female |

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X  | Y   | FieldName     | FieldLabel     | PlaceHolder        |
            | Email  | 75 | 640 | EmployeeEmail | Employee Email | example@domain.com |

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget   | X   | Y   | FieldName        | FieldLabel           | OptionType       | ValueCount | Value1 | Value2  |
            | Dropdown | 575 | 640 | EmpCountry       | Country of Residence | ConfigureOptions |            |        |         |
            | Dropdown | 775 | 520 | EmpMaritalStatus | Marital Status       | ManualOptions    | 2          | Single | Married |
        And User scroll to an element "Employee Pin" in "UniqueWidgetFields" screen
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName            | FieldLabel           | Action | Status |
            | Text Input | 200 | 950 | EmpPin               | Pin                  |        |        |
            | Button     | 550 | 950 | Get Employee Details | Get Employee Details | Submit | Save   |
            | Button     | 900 | 950 | Submit               | Submit               | Submit | Save   |

        # Add Onload triggers and response mapping

        And User create Onload Triggers with "2" Options Mapping "addOnloadTrigger" in "onLoadTrigger" screen
            | Name          | Description   | DataSource | DataList          | Field1  | Label1 | Value1 | Field2               | Label2 | Value2 |
            | Get Countries | Get Countries | Countries  | Get All Countries | Country | name   | iso2   | Country of Residence | name   | iso2   |

        And User create Onload Triggers with Response Mapping "addOnloadTrigger" in "onLoadTrigger" screen
            | Name                 | Description      | DataSource      | DataList                  | Type    | Pin    | uniqueField | uniqueFieldValue |
            | Get Employer Details | Employer Details | EmployerDetails | Get By Id EmployerDetails | session | userId | EmployerPin | userId           |
        
        Then User will create transformation rule for "Response Mapping" "Save EmployeeName" and connect Input and Output nodes in "transformation" screen
            | Destination     | Source          |
            | EmployerName    | EmployerName    |
            | EmployerAddress | EmployerAddress |
            | EmployerPhone   | EmployerPhone   |
            | EmployerEmail   | EmployerEmail   |
            | JobType         | JobType         |
            | Country         | Country         |
            | State           | State           |

        Then User click on "tab" "Design" in "Page" screen
        Then User see text "Front Office" in "FO" in "Page" screen

        # To Configure a Trigger on a Dropdown (On Change Populate)
        And User Configuring a Trigger on a "Dropdown" "Country" in "UniqueWidgetFields" screen
            | Title      | OnChangeAction | DataResources | DataList                         | Type | UniqueField | Value   |
            | Get States | Populate       | States        | Get By Filter Field: countryCode | ref  | CountryId   | Country |

        And User Configuring Options mapping for a dropdown "State" in "UniqueWidgetFields" screen from "Get States" trigger in "Country"
            | Title      | OptionLabel | OptionValue | Defaultkey |
            | Get States | name        | name        |            |

        And User Configuring a Trigger on a "Container" "Employer Information" in "UniqueWidgetFields" screen
            | Title                | Status | ClickAction | DataResources   | DataList                  | Type    | UniqueField | Value  |
            | Get Employer Details | Save   | Populate    | EmployerDetails | Get By Id EmployerDetails | session | EmployerPin | userId |

        And User Configuring a Trigger on a "Button" "Get Employee Details" in "UniqueWidgetFields" screen
            | Title      | ClickAction | DataResources   | DataList                  | Type | UniqueField | Value  |
            | EmpDetails | Populate    | EmployeeDetails | Get By Id EmployeeDetails | ref  | EmployeePin | EmpPin |

        And User scroll to an element "Emp First Name" in "UniqueWidgetFields" screen

        When User makes changes to below field's to Configure Data Population for "DropDown" in "UniqueWidgetFields" screen
            | Field                | Title       | Trigger                           | ResponseField      |
            | Emp First Name       | Get FN      | Get Employee Details : EmpDetails | FirstName          |
            | Emp Last Name        | Get LN      | Get Employee Details : EmpDetails | LastName           |
            | Emp Gender           | Get Gender  | Get Employee Details : EmpDetails | Gender             |
            | Employee Email       | Get Email   | Get Employee Details : EmpDetails | Email              |
            | Employee Phone       | Get Phone   | Get Employee Details : EmpDetails | Phone              |
            | SSN / ITIN           | Get SSN     | Get Employee Details : EmpDetails | SSN                |
            | Salary               | Get Salary  | Get Employee Details : EmpDetails | Salary             |
            | Employee Pin         | Get EmpPIN  | Get Employee Details : EmpDetails | Pin                |
            | Country of Residence | Get country | Get Employee Details : EmpDetails | CountryofResidence |

        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
        Then User will "Logout" from "Page" the current session

    @SuperScriptBO @SuperScript1
    Scenario: Superscript app phase 1 BO

        #CreateGroup
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "resources/ExpectedData" json file in "WorkFlow UI" screen
        When User enter create group with "GroupName" and "GroupDescription" in "Groups" screen
        Then User will search for "Application_Name" in "Application" screen
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget               | X   | Y   |
            | EmployerInformation  | 50  | 60  |
            | EmpPin               | 250 | 480 |
            | Get Employee Details | 550 | 480 |
            | EmployeeDetails      | 50  | 650 |
        Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
        And User scroll to an element "Employee Pin" in "UniqueWidgetFields" screen
        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X  | Y    | FieldName   | Title       |
            | Container | 50 | 1200 | BOContainer | BOContainer |

        # When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
        #     | Widget      | X   | Y    |
        #     | BOContainer | 500 | 1500 |
        # And User scroll to an element "BOContainer" in "UniqueWidgetFields" screen
        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y    | FieldName   | FieldLabel    |
            | Text Input | 150 | 1300 | BOFirstName | BO First Name |
            | Number     | 300 | 1300 | BOSalary    | BO Salary     |

        When User makes changes to "BO Salary" field format as in "UniqueWidgetFields" screen
            | TypeOfFormat | CurrencyCountry |
            | Currency     | United States   |
        When User make "BO First Name" field in BO as prePopulate in "UniqueWidgetFields" screen
        When User make "BO Salary" field in BO as prePopulate in "UniqueWidgetFields" screen
        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen

        # To Add the required tasks onto the workflow Designer
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 196 | 152 |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | Role                | NoofActions | Action1 | Action1Status |SLAHours | SLADays |
            | Task   | 225 | 233 | Review   | Application Manager | 1           | Accept  | In Progress   |1        | 0       |
        # Script to add API Task
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget   | X   | Y   | TaskName                      | SuccesStatus | FailedStatus | FailureTaskRole     |DataSource      | DataList             |
            | API Task | 445 | 153 | Created Record - PersonalInfo | In Progress  | In Progress  | Application Manager |PersonalInfo | Save PersonalInfo |
        When User Edit "API task" "Created Record - PersonalInfo" field to Configure Service in "tasks" screen
        Then User will create transformation rule for "API Task" "Save Employee" and connect Input and Output nodes in "transformation" screen
            | Destination        | Source         |
            | Pin                | EmpPin         |
            | CountryofResidence | EmpCountry     |
            | Email              | EmployeeEmail  |
            | FirstName          | EmpFirstName   |
            | Gender             | EmpGender      |
            | LastName           | EmpLastName    |
            | Phone              | EmployeePhone  |
            | SSN                | EmployeeSSN    |
            | Salary             | EmployeeSalary |
        # | Line1              | address_3           |
        # | Locality           | address3_locality   |
        # | Zipcode            | address3_postalcode |
        # | State              | address3_state      |
           
        
        # When User makes changes to the API task "Created Record - PersonalInfo" field to Configure Service in "tasks" screen
        #     | Category | Service      | Operation         |
        #     | Internal | PersonalInfo | Save PersonalInfo |
        # Then User will connect Input and Output nodes in "transformationUI" screen
        #     | Input          | Output             |
        #     | EmpPin         | Pin                |
        #     | EmpCountry     | CountryofResidence |
        #     | EmployeeEmail  | Email              |
        #     | EmpFirstName   | FirstName          |
        #     | EmpGender      | Gender             |
        #     | EmpLastName    | LastName           |
        #     | EmployeePhone  | Phone              |
        #     | EmployeeSSN    | SSN                |
        #     | EmployeeSalary | Salary             |
        # # | address_3          | Line1              |
        # # | address3_locality  | Locality           |
        # # | address3_postalcode| Zipcode            |
        # # | address3_state     | State              |

        # Script to add API Task
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget   | X   | Y   | TaskName                | SuccesStatus | FailedStatus | FailureTaskRole     |DataSource      | DataList             |
            | API Task | 445 | 361 | Update Employee Records | In Progress  | In Progress  | Application Manager |EmployeeDetails | Update By Id EmployeeDetails |
        When User Edit "API task" "Update Employee Records" field to Configure Service in "tasks" screen
        Then User will create transformation rule for "API Task" "Update Employee" and connect Input and Output nodes in "transformation" screen
            | Destination        | Source              | UniqueField |
            | Pin                | EmpPin              |             |
            | CountryofResidence | EmpCountry          |             |
            | Email              | EmployeeEmail       |             |
            | FirstName          | EmpFirstName        |             |
            | Gender             | EmpGender           |             |
            | LastName           | EmpLastName         |             |
            | Phone              | EmployeePhone       |             |
            | SSN                | EmployeeSSN         |             |
            | Salary             | EmployeeSalary      |             |
            # | Line1              | address_3           |             |
            # | Locality           | address3_locality   |             |
            # | Zipcode            | address3_postalcode |             |
            # | State              | address3_state      |             |
            | Pin                | EmpPin              | Yes         |
        
        # When User makes changes to the API task "Update Employee Records" field to Configure Service in "tasks" screen
        #     | Category | Service         | Operation                    |
        #     | Internal | EmployeeDetails | Update By Id EmployeeDetails |
        # Then User will connect Unique Field nodes in "transformationUI" screen
        #     | Input  | Output |
        #     | EmpPin | Pin    |
        # Then User will connect Input and Output nodes in "transformationUI" screen
        #     | Input          | Output             |
        #     | EmpPin         | Pin                |
        #     | EmpCountry     | CountryofResidence |
        #     | EmployeeEmail  | Email              |
        #     | EmpFirstName   | FirstName          |
        #     | EmpGender      | Gender             |
        #     | EmpLastName    | LastName           |
        #     | EmployeePhone  | Phone              |
        #     | EmployeeSSN    | SSN                |
        #     | EmployeeSalary | Salary             |
        # # | address_3          | Line1              |
        # # | address3_locality  | Locality           |
        # # | address3_postalcode| Zipcode            |
        # # | address3_state     | State              |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | Status      |
            | Merge  | 679 | 278 | Merge    | In Progress |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | To        | Sub                | Template            | FailureTaskRole     |
            | Email  | 770 | 278 | Email    | @empEmail | MailSubSuperscript | MailBodySuperscript | Application Manager |

        #  Script to add Response Mapping Task
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget           | X   | Y   | TaskName     | SuccesStatus | FailedStatus | FailureTaskRole     |
            | Response Mapping | 862 | 283 | Get Response | In Progress  | In Progress  | Application Manager |
        When User makes changes to the Response task "Get Response" field to Configure Service in "tasks" screen
            | ResponseInput                 |
            | Created Record - PersonalInfo |
        Then User will connect Input and Output nodes in "transformationUI" screen
            | Input     | Output      |
            | Salary    | BOSalary    |
            | FirstName | BOFirstName |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X    | Y   | TaskName        | Role                | NoofActions | Action1 | Action1Status |SLAHours | SLADays |
            | Task   | 1050 | 317 | Review Response | Application Manager | 1           | Accept  | In Progress   |1        | 0       |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X    | Y   |
            | End    | 1248 | 400 |

        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source                        | Action  | Target                        |
            | Start                         |         | Review                        |
            | Review                        | Accept  | Created Record - PersonalInfo |
            | Review                        | Accept  | Update Employee Records       |
            | Created Record - PersonalInfo | Success | Merge                         |
            | Update Employee Records       | Success | Merge                         |
            | Merge                         |         | Email                         |
            | Email                         |         | Get Response                  |
            | Get Response                  | Success | Review Response               |
            | Review Response               | Accept  | End                           |

        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        #  To validate Preview
        And User validate Payload app opening in a new tab
        Then User will "Logout" from "Page" the current session

    @SuperScriptAdminApp2 @SuperScriptFO2
    Scenario: Super script scenario phase 2

        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "resources/ExpectedData" json file in "WorkFlow UI" screen
        When User enter create group with "GroupName" and "GroupDescription" in "Groups" screen
        # Goto API Generator
        # export it to group and then service provider
        # Clone serivce provider and Data resources from API generator
        When User verify "PersonalInfo" API and export service providers and DataSources to the group "GroupName" in "apiGenerator" screen
        When User verify "EmployeeDetails" API and export service providers and DataSources to the group "GroupName" in "apiGenerator" screen
        When User verify "EmployerDetails" API and export service providers and DataSources to the group "GroupName" in "apiGenerator" screen
        When User verify "Countries" API and export service providers and DataSources to the group "GroupName" in "apiGenerator" screen
        When User verify "State" API and export service providers and DataSources to the group "GroupName" in "apiGenerator" screen

        # Clone Data Resources
        Then User will open "GroupName" group in "HomePage" screen
        Then User click on "button" "group_settings" in "Groups" screen
        Then User click on "button" "dataSources" in "onLoadTrigger" screen
        And User get unique field in Data Source "Countries" in "onLoadTrigger" screen and save it in "CountryId"
        And User clone Data Source "States" in "onLoadTrigger" screen
        And User get unique field in Data Source "PersonalInfo" in "onLoadTrigger" screen and save it in "PIId"
        And User get unique field in Data Source "EmployeeDetails" in "onLoadTrigger" screen and save it in "EmployeePin"
        And User get unique field in Data Source "EmployerDetails" in "onLoadTrigger" screen and save it in "EmployerPin"

        Then User will open "GroupName" group in "HomePage" screen
        Then User will search for "Application_Name" in "Application" screen
        Then User click on "button" "VersionControl" in "Version" screen
        When User checkout the version "latest version" for app modification
        Then User click on "FrontOffice" "Click_FrontOffice" in "Application" screen
        And User scroll to an element "Submit" in "UniqueWidgetFields" screen

        And User Drag and Drop below widgets in "CanvasBody" in "AdvanceTable" screen
            | Widget        | X  | Y    | Name          |
            | Advance Table | 50 | 1100 | Employee List |

        When User expand "Advance Table" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget  | X    | Y    |
            | Actions | 1500 | 1000 |

        When User click "Advance Table" and add columns in "AdvanceTable" screen
            | Name                   | Alignment             | ColumnType | FieldLabel |
            | EmployeeList_Pin       | ColumnAlignmentCenter | Text Input | Pin        |
            | EmployeeList_FirstName | ColumnAlignmentCenter | Text Input | First Name |
            | EmployeeList_LastName  | ColumnAlignmentCenter | Text Input | Last Name  |
            | EmployeeList_Phone     | ColumnAlignmentCenter | Text Input | Phone      |
            | EmployeeList_Email     | ColumnAlignmentCenter | Email      | Email      |

        And User wait for "2000"
        # #  To Edit Data Configuration for an Advanced Table
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
        Then User see text "Front Office" in "FO" in "Page" screen
        # address widget

        And User scroll to an element "Submit" in "UniqueWidgetFields" screen

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X  | Y    | FieldName      | Title          |
            | Container | 50 | 1300 | AddressDetails | AddressDetails |

        And User scroll to an element "AddressDetails" in "UniqueWidgetFields" screen

        When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget          | X   | Y    |
            | Address Details | 750 | 2000 |

        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget  | X   | Y    |
            | Address | 200 | 1800 |


        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        And User scroll to an element "BO Salary" in "UniqueWidgetFields" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget        | X  | Y    |
            | Employee List | 50 | 1450 |
        Then User click on "span" "Save" in "Page" screen
        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        #  To validate Preview
        And User validate Payload app opening in a new tab
        Then User will "Logout" from "Page" the current session