Feature: QuickBook API with OAUTH 2.0 with Authorization Code grant type

    @APIsetup @ChildScript72
    #  @ChildScript
    #Created By: Mary
    #Created on : 12/10/2023
    Scenario Outline: QuickBook API with OAUTH 2.0 with Authorization Code grant type

        Given user login to "Finlevit_admin" with "Admin" credentials
        And User get the Test data from "Usecase_TestData/ChildScript72" json file in "WorkFlow UI" screen
        # Then User delete group "#GroupName" in "Groups" screen
        # When User create group "Automation-APIsetup" with description "Group - Created by Automation" in "Groups" screen
        Then User will open "GroupName" group in "HomePage" screen
        Then User click on "button" "group_settings" in "Groups" screen
        Then User will create AuthProvider name as "Intuit Oauth2.0" with description and authType as "OAuth 2.0" in "GroupSetting" screen
        Then User click on "button" "apiSetup" in "GroupSetting" screen
        # Create Service Provider
        And User create service provider in "apiSetup" screen
            | SPName | Description                           | EndPointURL                               | AuthorizationType |
            | Intuit | Intutit SP created through automation | https://sandbox-quickbooks.api.intuit.com | Intuit Oauth2.0     |
        # Create Service
        And User edit service provider and add service in "apiSetup" screen
            | SPName | ServiceName | Description                      |
            | Intuit | Customer    | Service added through automation |

        And User write unique field "GivenName" in parent "CreateCustomerReq_Fields" with "#uniqueName" in "apiSetup" screen
        And User Add below "Additional Parameters" when create an Operation in "apiSetup" screen
            | Type    | Key          | Value            |
            | Headers | Accept       | application/json |
            | Headers | Content-Type | application/json |
        # Create Operation
        And User edit service "Customer" and add Operations with "REST" service, "POST" Request, "application/json" ContentType and "Additional Parameters" in "apiSetup" screen
            | OperationName   | Path                                                     | Description                        | Request        | Response | RequestTestOperation | UniqueField |
            | Create Customer | /v3/company/4620816365340540400/customer?minorversion=69 | Operation added through automation | #CreateCustomerReq | {}           | CreateCustomerReq_Fields | Id          |

        And User write unique field "Id" in parent "UpdateCustomerReq" with "uniqueData" in "apiSetup" screen
        And User write unique field "Id" in parent "DeleteCustomerReq" with "uniqueData" in "apiSetup" screen
        And User edit service "Customer" and add Operations with "REST" service, "GET" Request, "application/json" ContentType and "Additional Parameters" in "apiSetup" screen
            | OperationName                       | Path                                                                  | Description                        | RequestType | Request | Response | RequestTestOperation | Parameter1 |
            | Get Customer details by Customer id | /v3/company/4620816365340540400/customer/{customerId}?minorversion=69 | Operation added through automation | GET         |             | {}           |                          | customerId |
        And User wait for "2000"

        And User edit service "Customer" and add Operations with "REST" service, "POST" Request, "application/json" ContentType and "Additional Parameters" in "apiSetup" screen
            | OperationName   | Path                                                     | Description                        | Request        | Response | RequestTestOperation |
            | Update Customer | /v3/company/4620816365340540400/customer?minorversion=69 | Operation added through automation | #UpdateCustomerReq | {}           | #UpdateCustomerReq       |

        And User edit service "Customer" and add Operations with "REST" service, "POST" Request, "application/json" ContentType and "Additional Parameters" in "apiSetup" screen
            | OperationName   | Path                                     | Description                        | Request        | Response | RequestTestOperation |
            | Delete Customer | /v3/company/4620816365340540400/customer | Operation added through automation | #DeleteCustomerReq | {}           | #DeleteCustomerReq       |

        Then User click on "button" "dataSources" in "GroupSetting" screen
        Then User add the "Intuit","Rest API" Data resource name it as "Customer API for Automation" add DataList and "UnSelect" ApplicationSourceSetup with below name service operation in "GroupSetting" screen
            | ListName                              | Service  | Operation                           |
            | Save Customer API for Automation      | Customer | Create Customer                     |
            | Delete Customer API for Automation    | Customer | Delete Customer                     |
            | Get By Id Customer API for Automation | Customer | Get Customer details by Customer id |
            | UpdateCustomer API for Automation     | Customer | Update Customer                     |
        # | Get All Customer API for Automation   | Customer  | Get all Customer                     |
        And User wait for "2000"
        Then User click on "button" "dataSources" in "onLoadTrigger" screen
        And User get unique field in Data Source "Customer API for Automation" in "onLoadTrigger" screen and save it in "customerID"
        Then User will open "GroupName" group in "HomePage" screen
        # To Create an Application
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "2000"
        Then User see text "Front Office" in "FO" in "Page" screen
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget   | X  | Y  | FieldName | FieldLabel | OptionType    | ValueCount | Value1 | Value2 | Value3 | Value4 |
            | Dropdown | 50 | 50 | ID        | ID         | ManualOptions | 4          | 58     | 1      | 2      | 3      |
        And User wait for "2000"
        And User set Default value "58" to the "Dropdown" field "ID" in "UniqueWidgetFields" screen
        # Drag Widgets onto the Canvas in Front Office
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X  | Y   | FieldName     | Title          |
            | Container | 50 | 200 | ChildScript72 | ChildScript 72 |
        When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget         | X   | Y   |
            | ChildScript 72 | 900 | 500 |
        Then User click on "span" "Save" in "Page" screen
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName    | FieldLabel    |
            | Text Input | 60  | 300 | firstName    | First Name    |
            | Text Input | 275 | 300 | middleName   | Middle Name   |
            | Text Input | 500 | 300 | lastName     | Last Name     |
            | Text Input | 60  | 420 | displayName  | Display Name  |
            | Number     | 275 | 420 | balance      | Balance       |
            | Checkbox   | 500 | 420 | taxable      | Taxable       |
            | Text Input | 725 | 420 | R_MiddleName | R_Middle Name |

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X   | Y   | FieldName | FieldLabel | Action | Status |
            | Button | 60  | 600 | Submit    | Submit     | Submit | Save   |
            | Button | 175 | 600 | refresh   | Refresh    | None   | Save   |
            | Button | 350 | 600 | create    | Create     | None   | Save   |
            | Button | 500 | 600 | update    | Update     | None   | Save   |
            | Button | 650 | 600 | delete    | Delete     | None   | Save   |

        # Create on load trigger for Response Mapping
        And User create Onload Triggers with Response Mapping "addOnloadTrigger" in "onLoadTrigger" screen
            | Name                   | Description          | DataSource                  | DataList                              | Type | uniqueField | uniqueFieldValue |
            | Get By Id Customer API | Get Customer Details | Customer API for Automation | Get By Id Customer API for Automation | ref  | customerID  | ID               |
        Then User will create transformation rule for "Response Mapping" "Save Customer" and connect Input and Output nodes in "transformation" screen
            | Destination | Source      |
            | firstName   | GivenName   |
            | middleName  | MiddleName  |
            | lastName    | FamilyName  |
            | displayName | DisplayName |
            | balance     | Balance     |
            | taxable     | Taxable     |
        And User wait for "1000"
        And User see text "Onload Triggers" in "onLoadTriggerTitle" in "onLoadTrigger" screen

        # ServiceProvider-Save
        And User create an Event Configuration in "EventConfigurations" screen
            | EventName     | EventType         | Widget | DataSource                  | DataList                         |
            | Save API Data | Service Providers | create | Customer API for Automation | Save Customer API for Automation |
        Then User will create transformation rule for "Service Provider" "Save API Data" and connect Input and Output nodes in "transformation" screen
            | Destination | Source      |
            | GivenName   | firstName   |
            | MiddleName  | middleName  |
            | FamilyName  | lastName    |
            | DisplayName | displayName |

        #ServiceProvider-Update
        And User create an Event Configuration in "EventConfigurations" screen
            | EventName       | EventType         | Widget | DataSource                  | DataList                          |
            | Update API Data | Service Providers | update | Customer API for Automation | UpdateCustomer API for Automation |
        Then User will create transformation rule for "Service Provider" "Update API Data" and connect Input and Output nodes in "transformation" screen
            | Destination | Source     |
            | MiddleName  | middleName |

        Then User "ResponsePopulate" "Update API Data" event in "EventConfigurations" screen
        Then User will create transformation rule for "Response Populate" "Update API Data" and connect Input and Output nodes in "transformation" screen
            | Destination  | Source     |
            | R_MiddleName | MiddleName |
        # Onchange
        And User create an Event Configuration in "EventConfigurations" screen
            | EventName              | EventType         | Widget | DataSource                  | DataList                              | Type | UniqueField | Value |
            | Get By Id Customer API | On Change Actions | ID     | Customer API for Automation | Get By Id Customer API for Automation | ref  | customerID  | ID    |
        Then User will create transformation rule for "Populate" "Get By Id PI API" and connect Input and Output nodes in "transformation" screen
            | Destination | Source      |
            | firstName   | GivenName   |
            | middleName  | MiddleName  |
            | lastName    | FamilyName  |
            | displayName | DisplayName |
            | balance     | Balance     |
            | taxable     | Taxable     |

        And User wait for "1000"

        # ServiceProvider-Delete
        And User create an Event Configuration in "EventConfigurations" screen
            | EventName       | EventType         | Widget | DataSource                  | DataList                           |
            | Delete API Data | Service Providers | delete | Customer API for Automation | Delete Customer API for Automation |
        Then User will create transformation rule for "Service Provider" "Delete API Data" and connect Input and Output nodes in "transformation" screen
            | Destination | Source |
            | Id          | ID     |


        Then User click on "Design" "Design" in "Page" screen
        And User edit "Save" action and set "Reset Field Values" on widget "Refresh" in "UniqueWidgetFields" screen
            | Widgets     |
            | ID          |
            | firstName   |
            | middleName  |
            | lastName    |
            | displayName |
            | balance     |
            | taxable     |

        Then User click on "button" "WidgetSave" in "UniqueWidgetFields" screen
        Then User click on "span" "Save" in "Page" screen
        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User see text "Back Office" in "BO" in "Page" screen
        Then User click on "button" "Fields" in "UniqueWidgetFields" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget        | X  | Y  |
            | ChildScript72 | 50 | 50 |
        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        # To Add the required tasks onto the workflow Designer
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 200 | 100 |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
            | Task   | 300 | 300 | Review   | Application Manager | 1           | Accept  | In Progress   | 1        | 0       |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | End    | 900 | 300 |
        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source | Action | Target |
            | Start  |        | Review |
            | Review | Accept | End    |
        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        #  To validate Preview
        And User validate Payload app opening in a new tab
        Then User will "Logout" from "Page" the current session
        # Payload
        Given user login to payload application with "Finlevit_payload" with "1" agent
        And User validate "Text Input" widget "First Name" is not empty in "payload" screen
        # And User validate "Text Input" widget "Middle Name" is not empty in "payload" screen
        And User validate "Text Input" widget "Last Name" is not empty in "payload" screen
        And User validate "Text Input" widget "Display Name" is not empty in "payload" screen
        # And User validate "Number" widget "Balance" is not empty in "payload" screen
        # And User validate "Checkbox" widget "Taxable" is "True" in "WorkFlow UI" screen
        Then User click on "Button" widget "Refresh" in "payload" screen
        And User select drop down option "1" in "ID" widget in "payload" screen
        And User wait for "3000"
        And User wait until the spinner disappears
        And User validate "Text Input" widget "First Name" is not empty in "payload" screen
        # And User validate "Text Input" widget "Middle Name" is not empty in "payload" screen
        And User validate "Text Input" widget "Last Name" is not empty in "payload" screen
        And User validate "Text Input" widget "Display Name" is not empty in "payload" screen
        And User validate "Number" widget "Balance" is not empty in "payload" screen
        # And User validate "Checkbox" widget "Taxable" is "True" in "WorkFlow UI" screen
        Then User click on "button" "Submit_btn" in "payload" screen
        And User get Transaction Id and save it in json file
        # Workflow
        Given user login to workflow UI "Finlevit_workflow" with "1" "AppManager" credentials
        And User wait until the "Filter Transaction id" appears in "WorkFlow UI" screen
        Then User click on "Button" "Home" in "HomePage" screen
        Then User will open "GroupName" group in "HomePage" screen
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "5000"
        And As "Application Manager" user verify Task "1" Details under "Team Task" in "WorkFlow UI" screen
        Then Based on the Task assigned to person logout or continue with the same user in "WorkFlow UI" screen for "Application_Name"
        And As "Application Manager" user verify Task "1" Details under "My Task" in "WorkFlow UI" screen
        Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
        And User validate "Text Input" widget "First Name" is not empty in "payload" screen
        # And User validate "Text Input" widget "Middle Name" is not empty in "payload" screen
        And User validate "Text Input" widget "Last Name" is not empty in "payload" screen
        And User validate "Text Input" widget "Display Name" is not empty in "payload" screen
        # And User validate "Number" widget "Balance" is not empty in "payload" screen
        # And User validate "Checkbox" widget "Taxable" is "True" in "WorkFlow UI" screen
        Then User validate Task "1" Actions and select "Accept" action in "WorkFlow UI" screen
        Then User will "Logout" from "Page" the current session
