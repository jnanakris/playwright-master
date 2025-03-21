Feature: Create Existing Application with Haltec API with No auth to Avro file
    # prerequisite: Enter Operation name, DatalistName in the CS74 test data json file
    # Manually create document configuration
    @HaltecAPIsetup @ChildScript74
    @ChildScript
    #Created By: Mary
    #Created on : 12/10/2023
    Scenario Outline: Create Existing Application with Haltec API with No auth to Avro file

        Given user login to "Finlevit_admin" with "Admin" credentials
        And User get the Test data from "Usecase_TestData/ChildScript74" json file in "WorkFlow UI" screen
         When User verify and create "Tririga Sites" serviceProvider in API generator "apiGenerator" screen
            | Name       | Description                                                    | EndPoint  | uniqueField | FilterField  | apiSchema       |
            | Tririga Sites | Api created  using AUTOMATION - Do not Modify / Delete / Clone | TririgaSites | StoreNumber          | SAPNumber | TririgaSitesSchema |

        When User verify "Tririga Sites" API and export service providers and DataSources to the group "GroupName" in "apiGenerator" screen
        Then User will open "GroupName" group in "HomePage" screen
        Then User click on "button" "group_settings" in "Groups" screen
        Then User click on "button" "apiSetup" in "GroupSetting" screen
        # Create Service Provider
        And User create service provider in "apiSetup" screen
            | SPName | Description                          | EndPointURL                        | AuthorizationType  |SPType|
            | Haltec | Haltec SP created through automation | http://discounttire.mytagtrack.com |  No Auth |External|
        # Create Service
        And User edit service provider and add service in "apiSetup" screen
            | SPName | ServiceName  | Description                      |
            | Haltec | AirCheckData | Service added through automation |

        And User Add below "Query Parameters" when create an Operation in "apiSetup" screen
            | Name  | DataType | Value               |
            | key   | STRING   | 7738F5CF953D47C58   |
            | cmd   | STRING   | JSON                |
            | start | STRING   | 2023-10-08T22:00:00 |
            | end   | STRING   | 2023-10-09T02:00:01 |
        # Create Operation
        And User edit service "AirCheckData" and add Operations with "REST" service, "GET" Request, "application/json" ContentType and "Query Parameters" in "apiSetup" screen
            | OperationName   | Path             | Description                        | Response |
            | #OperationName | /API/Custom.ashx | Operation added through automation | {}           |

        Then User click on "button" "dataSources" in "GroupSetting" screen
        Then User add the "Haltec","Rest API" Data resource name it as "Haltec" add DataList and "Select" ApplicationSourceSetup with below name service operation in "GroupSetting" screen
            | ListName   | Service      | Operation       |
            | #DatalistName | AirCheckData | #OperationName |

        And User test connection for the document in "document" screen
            | Type | Root | AccessKey            | SecretKey                                | BucketName         | AWSRegion      |
            | S3   | SIT/ | AKIAVVCS3TID6M6RK3IJ | jsFIpgk+l+duBLWzKUZ9n54haljxtnoDvRoqtIgL | qaautomationkonfig | US East (Ohio) |
        Then User click on "Menu" "fileSetupMenu" in "HomePage" screen
        Then User will create file setup with "AVRO" file in "fileSetup" screen
            | FileType   | FileUpload      |Destination|ProcessedFolder|SourceName|
            | Flat File  | Haltec_Schema.json |S3|#DocumentSourceName|New|

        And User use below "Request Parameters" when create app source setup in "appSourceSetup" screen
            | Name  | DataType | Option              | Value             | Format               |
            | key   | String   | Default             | 7738F5CF953D47C58 |                      |
            | cmd   | String   | Default             | JSON              |                      |
            # | start | Date     | SystemStartDateTime |                   | YYYY-MM-DDTHH:MM:SSZ |
            # | end   | Date     | SystemEndDateTime   |                   | YYYY-MM-DDTHH:MM:SSZ |
            | start | String   | Default | 2024-09-30T22:00:00.999Z ||
            | end   | String   | Default | 2024-09-30T22:00:01.999Z ||


        And User use below "Require Fields" when create app source setup in "appSourceSetup" screen
            | FieldName | DataType | WidgetType | IsRequired | MaxLength |
            | ChannelId | number   | Number     | Yes        | 10        |

        Then User will create app source setup with "Data List" in "appSourceSetup" screen
            | GroupName | DataResource | DataList   | SourceType  | SourceName |AppMode|BatchCategory|
            | GroupName | Haltec       | #DatalistName | Primary     | New        |Batch|VAIT|

        # # And User wait for "2000"
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
        Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X  | Y  | FieldName  | Title       |
            | Container | 50 | 50 | HaltecInfo | Haltec Info |
        When User expand below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget      | X    | Y   |
            | Haltec Info | 1040 | 300 |
        Then User click on "button" "Fields" in "UniqueWidgetFields" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget        | X   | Y   |
            | Name          | 75  | 125 |
            | ChannelId     | 300 | 125 |
            | lat           | 525 | 125 |
            | lon           | 75  | 250 |
            | TempC         | 300 | 250 |
            | CreatedOnUTC  | 525 | 250 |
            | ReceivedOnUTC | 750 | 250 |
        Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X  | Y   | FieldName | Title     |
            | Container | 50 | 375 | SiteInfo  | Site Info |
        When User expand below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X    | Y   |
            | Site Info | 1040 | 650 |
        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName     | FieldLabel    |
            | Text Input | 75  | 450 | city          | City          |
            | Text Input | 300 | 450 | zipCode       | ZipCode       |
            | Text Input | 525 | 450 | state         | State         |
            | Text Input | 750 | 450 | siteID        | SiteID        |
            | Text Input | 75  | 550 | legacyStoreId | LegacyStoreId |

        Then User click on "span" "Save" in "Page" screen
        # And User should contain text "Saved successfully" in "SavedSuccessfully" in "UniqueWidgetFields" screen
        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        # To Add the required tasks onto the workflow Designer
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 200 | 100 |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget        | TaskName        | FailureTaskRole     | X   | Y  |
            | Validate Task | CheckValidation | Application Manager | 317 | 55 |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget   | X   | Y   | TaskName | SuccesStatus | FailedStatus | FailureTaskRole     | DataSource    | DataList              |
            | API Task | 342 | 169 | GetSites | In Progress  | In Progress  | Application Manager | Tririga Sites | Get All Tririga Sites |
        #    Response Mapping
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget           | X   | Y   | TaskName          | SuccesStatus | FailedStatus | FailureTaskRole     | ResourcesCount | Resources1 | Resources2  |Process_Type|
            | Response Mapping | 559 | 167 | UpdateTransaction | In Progress  | In Progress  | Application Manager | 2              | GetSites   | Application |Distinct|

        When User Edit "Response task" "UpdateTransaction" field to Configure Service in "tasks" screen
        Then User click on "button" "addRuleButton" in "transformation" screen
        Then User enter text "Update" in "Name" in "transformation" screen

        #Rule-1
        Then User add the below conditions in "expressionBuilder" screen
            | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1     |
            | 1                  | 1                  | Konfig         | Bulk Update with 3rd party data |

        Then User delete the "1" default field from rule builder

        Then User implements conditions in execute area for below fields in "expressionBuilder" screen
            | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 | ConditionType2OperatorType3 |
            | 1        | 2                  | 1                  | String         | SubString                   | Operands       | 3                  | Number Constant             | Number Constant             | Destination Fields          |

        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | NumberConstant | Payloadfields | Source                                             |
            | 0              | Name          | GetSites->Success Response ->root->array element of root->StoreNumber |
            | 6              |               |                                                    |

        Then User implements conditions in execute area for below fields in "expressionBuilder" screen
            | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
            | 2        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Destination Fields          | Source Fields               |
            | 2        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Destination Fields          | Source Fields               |
            | 2        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Destination Fields          | Source Fields               |
            | 2        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Destination Fields          | Source Fields               |
            | 2        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Destination Fields          | Source Fields               |

        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | Payloadfields | Source                                                 |
            | city          | GetSites->Success Response ->root->array element of root->City            |
            | legacyStoreId | GetSites->Success Response ->root->array element of root->SAPNumber       |
            | siteID        | GetSites->Success Response ->root->array element of root->StoreNumber     |
            | state         | GetSites->Success Response ->root->array element of root->StateOrProvince |
            | zipCode       | GetSites->Success Response ->root->array element of root->ZipPostalCode   |

        Then User click on "Button" "Save" in "transformation" screen
        Then User click on "Button" "Close" in "transformation" screen
        # File Task with Konfig Function
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget   | X   | Y   | TaskName       | FileName             | SuccesStatus | FailedStatus | FailureTaskRole     |
            | FileTask | 785 | 165 | CreateAvroFile | #FileNameinFileSetup | In Progress  | In Progress  | Application Manager |
        When User Edit "File task" "CreateAvroFile" field to Configure Service in "tasks" screen
        And User wait for "5000"
        Then User click on "button" "addRuleButton" in "transformation" screen
        Then User enter text "inserttoAvro" in "Name" in "transformation" screen
        Then User add the below conditions in "expressionBuilder" screen
            | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 |
            | 1                  | 1                  | Konfig         | Create File                 |
        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | Source                                                             |
            | Application->root->Back_Office_Fields->SiteInfo->legacyStoreId     |
            | Application->root->Back_Office_Fields->SiteInfo->zipCode           |
            | Application->root->Back_Office_Fields->SiteInfo->city              |
            | Application->root->Single_Screen_Payload->#FileName->CreatedOnUTC  |
            | Application->root->Single_Screen_Payload->#FileName->CreatedOnUTC  |
            | Application->root->Single_Screen_Payload->#FileName->lat           |
            | Application->root->Single_Screen_Payload->#FileName->ReceivedOnUTC |
            | Application->root->Single_Screen_Payload->#FileName->ReceivedOnUTC |
            | Application->root->Back_Office_Fields->SiteInfo->siteID            |
            | Application->root->Single_Screen_Payload->#FileName->Name          |
            | Application->root->Back_Office_Fields->SiteInfo->state             |
            | Application->root->Single_Screen_Payload->#FileName->Name          |
            | Application->root->Single_Screen_Payload->#FileName->TempC         |
        # delete source dropdown and add string constant
        And User delete the "28" default field from rule builder
        Then User add the below conditions in "expressionBuilder" screen
            | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 |
            | 1                  | 1                  | Operands       | String Constant             |
        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | StringConstant |
            | Haltec         |
        # delete source dropdown and add number to string for channelid
        And User delete the "30" default field from rule builder
        Then User add the below conditions in "expressionBuilder" screen
            | ConditionTypeCount | OperatorTypeCount1 | ConditionType1   | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 |
            | 2                  | 1                  | Type Conversions | Number To String            | Operands       | 1                  | Source Fields               |
        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | Source                                                         |
            | Application->root->Single_Screen_Payload->#FileName->ChannelId |
            | Application->root->Single_Screen_Payload->#FileName->lon       |

        Then User click on "Button" "Save" in "transformation" screen
        And User wait for "2000"
        Then User click on "Button" "Close" in "transformation" screen
        And User wait for "2000"

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName                | To              | Sub     | Template | FailureTaskRole     |
            | Email  | 995 | 269 | SuccesstaskFailureEmail | qa@tabnergc.com | MailSub | MailBody | Application Manager |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X    | Y   |
            | End    | 1137 | 118 |
        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source                  | Action  | Target                  |
            | Start                   |         | CheckValidation         |
            | CheckValidation         |         | GetSites                |
            | GetSites                | Success | UpdateTransaction       |
            | UpdateTransaction       | Success | CreateAvroFile          |
            | CreateAvroFile          | Success | SuccesstaskFailureEmail |
            # | CreateAvroFile    | Failed  | FiletaskFailureEmail  |
            | SuccesstaskFailureEmail |         | End                     |
        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        Then User will "Logout" from "Page" the current session

# # Workflow
# And User wait for "60000"
# And User wait for "60000"
# And User wait for "60000"
# And User wait for "60000"
# And User wait for "80000"
# Given user login to workflow UI "Finlevit_workflow" with "1" "AppManager" credentials
# And User wait until the "Filter Transaction id" appears in "WorkFlow UI" screen
# Then User click on "Button" "Home" in "HomePage" screen
# Then User will open "GroupName" group in "HomePage" screen
# Then User will search for "Application_Name" in "Application" screen
# And User wait for "5000"
# Then User click on "Menu" "Team Task" in "WorkFlow UI" screen
# And User wait until the spinner disappears
# And User select "span" tag drop down option "Application Manager" in "Role Dropdown" in "WorkFlow UI" screen
# And User assign task to "1" user in "AppManager" in "WorkFlow UI" screen
# Then User click on "Menu" "My Task" in "WorkFlow UI" screen
# Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
# And User validate "Text Input" widget "Name" is not empty in "WorkFlow UI" screen
# And User validate "Number" widget "ChannelId" is not empty in "payload" screen
# And User validate "Text Input" widget "lat" is not empty in "payload" screen
# And User validate "Text Input" widget "lon" is not empty in "payload" screen
# And User validate "Text Input" widget "TempC" is not empty in "payload" screen
# And User validate "Text Input" widget "CreatedOnUTC" is not empty in "payload" screen
# And User validate "Text Input" widget "ReceivedOnUTC" is not empty in "payload" screen
# Then User validate Task "1" Actions and select "Accept" action in "WorkFlow UI" screen
# And User wait for "5000"
# Then User will "Logout" from "Page" the current session
# # # Validate Edit API setup and datalist
# Given user login to "Finlevit_admin" with "Admin" credentials
# Then User will open "GroupName" group in "HomePage" screen
# Then User click on "button" "group_settings" in "Groups" screen
# Then User click on "button" "apiSetup" in "GroupSetting" screen
# And User "Edit" "Service Provider" "Haltec" in "GroupSetting" screen and validate text contains "Updated Successfully"
# And User click on "Haltec" in "GroupSetting" screen
# And User "Edit" "Service" "AirCheckData" in "GroupSetting" screen and validate text contains ""
# And User click on "AirCheckData" in "GroupSetting" screen
# And User "Edit" "Operations" "GetAirCheckData" in "GroupSetting" screen and validate text contains "FL1409 : This Item is being used in DATA LIST : [GetAllData]"
# Then User click on "button" "dataSources" in "GroupSetting" screen
# And User "Edit" "Data Sources" "Haltec" in "GroupSetting" screen and validate text contains "The process could not be completed as the following data list(s) are currently in use."
# And User click on "Haltec" in "GroupSetting" screen
# And User "Edit" "Data Lists" "GetAllData" in "GroupSetting" screen and validate text contains " Update process cannot be completed at this time as the data list is currently in use"

# # Delete API setup and datalist
#  Then User click on "button" "apiSetup" in "GroupSetting" screen
# And User "Delete" "Service Provider" "Haltec" in "GroupSetting" screen and validate text contains "FL1409 : This Item is being used in DATA_RESOURCE"
# # And User "Edit" "Service Provider" "Haltec" in "GroupSetting" screen and validate text contains "FL1409 : This Item is being used"
# And User click on "Haltec" in "GroupSetting" screen
# And User "Delete" "Service" "AirCheckData" in "GroupSetting" screen and validate text contains "FL1409 : This Item is being used in DATA LIST"
# And User click on "AirCheckData" in "GroupSetting" screen
# And User "Delete" "Operations" "GetAirCheckData" in "GroupSetting" screen and validate text contains "FL1409 : This Item is being used in DATA LIST : [GetAllData]"
# Then User click on "button" "dataSources" in "GroupSetting" screen
# And User "Delete" "Data Sources" "Haltec" in "GroupSetting" screen and validate text contains " The process could not be completed as the following data list(s) are currently in use."
# And User click on "Haltec" in "GroupSetting" screen
# And User "Delete" "Data Lists" "GetAllData" in "GroupSetting" screen and validate text contains " The process could not be completed as the following data list(s) are currently in use."

# # Allow user to delete APi setup/Data sources if it is not used
# Then User click on "button" "apiSetup" in "GroupSetting" screen
# # Create Service Provider
# And User create service provider in "apiSetup" screen
#     | SPName | Description                          | EndPointURL                        | AuthorizationType  |
#     | World | World SP created through automation | http://webservices.oorsprong.org/ |  No Auth |
# # Create Service
# And User edit service provider and add service in "apiSetup" screen
#     | SPName | ServiceName  | Description                      |
#     | World | Continenets | Service added through automation |

# # Create Operation
# And User edit service "Continenets" and add Operations with "SOAP" service, "POST" Request, "text/xml" ContentType and "No Parameters" in "apiSetup" screen
#     | OperationName   | Path             | Description                        | Request|RequestTestOperation|Response|
#     | List of Continenets | /websamples.countryinfo/CountryInfoService.wso | Operation added through automation | #ContinentRequest           |#ContinentRequest|{}|

# Then User click on "button" "dataSources" in "GroupSetting" screen
# Then User add the "World","Rest API" Data resource name it as "Continents" add DataList and "Select" ApplicationSourceSetup with below name service operation in "GroupSetting" screen
#     | ListName   | Service      | Operation       |
#     | Get All continents | Continenets | List of Continenets |

# # Delete API setup and datalist
# Then User click on "button" "dataSources" in "GroupSetting" screen
# And User click on "Continents" in "GroupSetting" screen
# And User "Delete" "Data Lists" "Get All continents" in "GroupSetting" screen and validate text contains "Datalist Deleted Successfully"
# Then User click on "button" "dataSources" in "GroupSetting" screen
# And User "Delete" "Data Sources" "Continents" in "GroupSetting" screen and validate text contains "Resource Deleted Successfully"

# Then User click on "button" "apiSetup" in "GroupSetting" screen
# And User click on "World" in "GroupSetting" screen
# And User click on "Continenets" in "GroupSetting" screen
# And User "Delete" "Operations" "List of Continenets" in "GroupSetting" screen and validate text contains ""
# Then User click on "button" "apiSetup" in "GroupSetting" screen
# And User click on "World" in "GroupSetting" screen
# And User "Delete" "Service" "Continenets" in "GroupSetting" screen and validate text contains ""

# Then User click on "button" "apiSetup" in "GroupSetting" screen
# And User "Delete" "Service Provider" "World" in "GroupSetting" screen and validate text contains ""
