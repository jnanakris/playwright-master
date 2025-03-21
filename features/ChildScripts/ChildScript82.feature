Feature: Create Existing Application using Salesforce with OAuth2.0 to Manual task
    @HaltecAPIsetup @ChildScript82 @ChildScript
    #Created By: Mary
    #Created on : 12/10/2023
    Scenario Outline: Create Existing Application using Salesforce with OAuth2.0 to Manual task
        Given user login to "Finlevit_admin" with "Admin" credentials
        And User get the Test data from "Usecase_TestData/ChildScript82" json file in "WorkFlow UI" screen
        Then User will open "GroupName" group in "HomePage" screen
        Then User click on "button" "group_settings" in "Groups" screen
        Then User will create AuthProvider name as "Salesforce Oauth2.0" with description and authType as "OAuth 2.0" in "GroupSetting" screen
        Then User click on "button" "apiSetup" in "GroupSetting" screen
        # Create Service Provider
        And User create service provider in "apiSetup" screen
            | SPName     | Description                              | EndPointURL                                         | AuthorizationType   | SPType   |
            | Salesforce | Salesforce SP created through automation | https://tabnerinc4-dev-ed.develop.my.salesforce.com | Salesforce Oauth2.0 | External |
        # Create Service
        And User edit service provider and add service in "apiSetup" screen
            | SPName     | ServiceName | Description                      |
            | Salesforce | Accounts    | Service added through automation |

        # Create Operation
        And User edit service "Accounts" and add Operations with "REST" service, "GET" Request, "application/json" ContentType and "No Parameters" in "apiSetup" screen
            | OperationName | Path  | Description                        | Response |
            | #OperationName   | #Path | Operation added through automation | {}       |

        Then User click on "button" "dataSources" in "GroupSetting" screen
        Then User add the "Salesforce","Rest API" Data resource name it as "Salesforce" add DataList and "Select" ApplicationSourceSetup with below name service operation in "GroupSetting" screen
            | ListName | Service  | Operation   |
            | #DatalistName  | Accounts | #OperationName |

        And User use below "Request Parameters" when create app source setup in "appSourceSetup" screen
            |  |
        And User use below "Require Fields" when create app source setup in "appSourceSetup" screen
            | FieldName     | DataType | WidgetType | IsRequired | MaxLength | Split | Index |
            | records       | object   | Container  |            |           | Yes   |       |
            | attributes    | object   | Modal      |            |           |       | 1     |
            | Opportunities | object   | Modal      |            |           |       |       |
            | attributes    | object   | Modal      |            |           |       | 2     |


        # Then User click on "button" "dataSources" in "GroupSetting" screen
        # Then User add the "Generated APIs","Amazon DynamoDB" Data resource name it as "Dynamo_Salesforce" add DataList and "UnSelect" ApplicationSourceSetup with below name service operation in "GroupSetting" screen
        #     | ListName                 | DataBase | CollectionName    | OperationType | Query          | ResponseJson | Parameters | ParameterName1              | DataType1              | Value1              |
        #     | Salesforce_InsertAccount | KON_API  | PI_API_AUTOMATION | INSERT        | InsertQuery_DB | {}           | 10         | #InsertAccountParameterName | #InsertAccountDataType | #InsertAccountValue |

        Then User will create app source setup with "Data List" in "appSourceSetup" screen
            | GroupName | DataResource | DataList | SourceType |AppMode |SourceName|
            | GroupName | Salesforce   | #DatalistName  | Primary    |Transactional   |New|

        And User wait for "2000"
        Then User will open "GroupName" group in "HomePage" screen
        And User wait for "5000"
        # App
        Then User will create "Existing" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "3000"
        When User click on "FrontOffice" "Click_FrontOffice" in "Application" screen
        Then User see text "Front Office" in "FO" in "Page" screen

        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User see text "Back Office" in "BO" in "Page" screen
         And User wait for "3000"
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X  | Y  |
            | #FileName | 50 | 50 |
        And User wait for "5000"
        Then User click on "span" "Save" in "Page" screen
        And User should contain text "Saved successfully" in "SavedSuccessfully" in "UniqueWidgetFields" screen

        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        # To Add the required tasks onto the workflow Designer
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 200 | 100 |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
            | Task   | 300 | 300 | Review   | Application Manager | 1           | Accept  | In Progress   | 1        | 0       |

        # Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
        # | Widget   | X   | Y   | TaskName      | SuccesStatus | FailedStatus | FailureTaskRole     | DataSource            | DataList                   |
        # | API Task | 491 | 137 | Create Record | In Progress  | In Progress  | Application Manager | Cloud DB | Get Data by BatCh id |

        # When User Edit "API task" "Create Record" field to Configure Service in "tasks" screen
        # Then User will create transformation rule for "API Task" "Save PI API Data" and connect Input and Output nodes in "transformation" screen
        # | Destination        | Source             |UniqueField|
        # | batchId          | BatchId          |Yes|
        # Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
        #     | Widget    | X   | Y   | TaskName | Mode     | SuccesStatus | FailedStatus | FailureTaskRole     |
        #     | File Task | 739 | 137 | Create File    | OutBound | In Progress  | In Progress  | Application Manager |
        # When User Edit "API task" "Queue" field to Configure Service in "tasks" screen

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | End    | 900 | 300 |
        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source | Action | Target |
            | Start  |        | Review |
            | Review | Accept | End    |
        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        Then User will "Logout" from "Page" the current session
