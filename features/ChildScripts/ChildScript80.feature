Feature: Create Existing Application with Ebay API with No auth to API task and Queue
    # prerequisite: Enter Operation name, DatalistName in the CS80 test data json file
    # Make sure the date entered for CreateTimeFrom and CreateTimeTo are not more than 90days from current date
    # Make sure queue is manually created in the respective environment, environment specific queue is mentioned in CS80 test data json file 
    @EbayAPIsetup @ChildScript80 
    @ChildScript
    #Created By: Mary
    #Created on : 12/10/2023
    Scenario Outline: Create Existing Application with Ebay API with No auth to API task and Queue

        Given user login to "Finlevit_admin" with "Admin" credentials
        And User get the Test data from "Usecase_TestData/ChildScript80" json file in "WorkFlow UI" screen
        When User verify and create "EbayAutomation" serviceProvider in API generator "apiGenerator" screen
            | Name           | Description                                                    | EndPoint | uniqueField | FilterField | apiSchema            |
            | EbayAutomation | Api created  using AUTOMATION - Do not Modify / Delete / Clone | eorder   | OrderID     | OrderID     | EbayAutomationSchema |

        When User verify "EbayAutomation" API and export service providers and DataSources to the group "GroupName" in "apiGenerator" screen
        
        Then User will open "GroupName" group in "HomePage" screen
        Then User click on "button" "group_settings" in "Groups" screen
        # Then User will create AuthProvider name as "Automation No Auth" with description and authType as "No Auth" in "GroupSetting" screen
        Then User click on "button" "apiSetup" in "GroupSetting" screen
        # Create Service Provider
        And User create service provider in "apiSetup" screen
            | SPName | Description                          | EndPointURL                        | AuthorizationType  |SPType|
            | Ebay | Ebay SP created through automation | https://api.ebay.com/ws | No Auth |External|
        # Create Service
        And User edit service provider and add service in "apiSetup" screen
            | SPName | ServiceName  | Description                      |
            | Ebay | Ebay Service | Service added through automation |

        And User Add below "Additional Parameters" when create an Operation in "apiSetup" screen
            | Type  | Key | Value               |
            | Headers   | X-EBAY-API-SITEID   | 1   |
            | Headers   | X-EBAY-API-COMPATIBILITY-LEVEL   | 1165                |
            | Headers | X-EBAY-API-CALL-NAME   | GetOrders |
        # Create Operation
        And User edit service "Ebay Service" and add Operations with "REST" service, "POST" Request, "application/xml" ContentType and "Additional Parameters" in "apiSetup" screen
            | OperationName   | Path             | Description                    |Request|RequestTestOperation|Response|
            | #OperationName | /api.dll | Operation added through automation | #EbayRequest           |#EbayRequest|{}|

        Then User click on "button" "dataSources" in "GroupSetting" screen
        Then User add the "Ebay","Rest API" Data resource name it as "Ebay" add DataList and "Select" ApplicationSourceSetup with below name service operation in "GroupSetting" screen
            | ListName   | Service      | Operation       |
            | #DatalistName| Ebay Service | #OperationName |

        And User use below "Request Parameters" when create app source setup in "appSourceSetup" screen
            | Name           | DataType | Option  | Value                                                                                            | Format |
            | EntriesPerPage | Number   | Limit   | 5                                                                                                |        |
            | PageNumber     | Number   | Page    | 1                                                                                                |        |
            | xmlns          | String   | Default | urn:ebay:apis:eBLBaseComponents                                                                  |        |
            | eBayAuthToken  | String   | Default | v^1.1#i^1#p^3#r^1#I^3#f^0#t^Ul4xMF8xMTpGREIwRUJFMTEzOEY4OUQwNkY1QUYxQzkwODQwMDdDOV8zXzEjRV4yNjA= |        |
            | OrderRole      | String   | Default | Seller                                                                                           |        |
            # | CreateTimeFrom | Date     | SystemStartDateTime |                                                                                                  | YYYY-MM-DDTHH:MM:SSZ |
            # | CreateTimeTo   | Date     | SystemEndDateTime   |                                                                                                  | YYYY-MM-DDTHH:MM:SSZ |
            | CreateTimeFrom | String   | Default | 2024-09-25T11:30:44.000Z                                                                         |        |
            | CreateTimeTo   | String   | Default | 2024-09-25T14:34:44.000Z                                                                         |        |

        And User use below "Require Fields" when create app source setup in "appSourceSetup" screen
            | FieldName | DataType | WidgetType | IsRequired | MaxLength |Split|
            | Order | object   | Container     |         |        |Yes|
            # | ShipmentTrackingDetails | object   | Container     |         |        ||

        Then User will create app source setup with "Data List" in "appSourceSetup" screen
            | GroupName | DataResource | DataList       | SourceType | Frequency | CronExpression | SourceName | AppMode |
            | GroupName | Ebay         | #DatalistName | Primary    | Cron      | 0 0/5 * * * *  | New        | Transactional   |

        And User test connection for the queue in "queue" screen
        Then User click on "Menu" "fileSetupMenu" in "HomePage" screen
        Then User will create file setup with "JSON" file in "fileSetup" screen
            | FileType   | FileUpload      |Destination|SourceName|
            | JSON       | EbayAutomationSchema.json |Queue|New|
        # # And User wait for "2000"
        Then User will open "GroupName" group in "HomePage" screen
        And User wait for "5000"
        # # # App
        Then User will create "Existing" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "3000"
        Then User see text "Front Office" in "FO" in "Page" screen
        # Then User click on "span" "Save" in "Page" screen
        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User see text "Back Office" in "BO" in "Page" screen
        And User wait for "3000"
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X  | Y  |
            | #FileName | 50 | 50 |
        And User wait for "5000"
        Then User click on "span" "Save" in "Page" screen
        # And User should contain text "Saved successfully" in "SavedSuccessfully" in "UniqueWidgetFields" screen
        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen

        # To Add the required tasks onto the workflow Designer
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 200 | 100 |
       
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget   | X   | Y   | TaskName | SuccesStatus | FailedStatus | FailureTaskRole     | DataSource     | DataList            |
            | API Task | 376 | 152 | PostAPI  | In Progress  | In Progress  | Application Manager | EbayAutomation | Save EbayAutomation |

        When User Edit "API task" "PostAPI" field to Configure Service in "tasks" screen
        Then User will create transformation rule for "API Task" "SaveOrders" in "transformation" screen
        | Destination        | Source             |
        | OrderID          | Single_Screen_Payload->#FileName->GetOrdersResponse->OrderArray->Order->OrderID          |
        | OrderStatus          | Single_Screen_Payload->#FileName->GetOrdersResponse->OrderArray->Order->OrderStatus          |
        | AmountPaid          | Single_Screen_Payload->#FileName->GetOrdersResponse->OrderArray->Order->AmountPaid->content        |
        | PaymentMethod          | Single_Screen_Payload->#FileName->GetOrdersResponse->OrderArray->Order->CheckoutStatus->PaymentMethod          |
        | ShippingService          | Single_Screen_Payload->#FileName->GetOrdersResponse->OrderArray->Order->ShippingDetails->ShippingServiceOptions->ShippingService         |
        # | Name          | Single_Screen_Payload->#FileName->GetOrdersResponse->OrderArray->Order->OrderID          |
        # | CityName          | Single_Screen_Payload->#FileName->GetOrdersResponse->OrderArray->Order->OrderID          |
        # | CountryName          | Single_Screen_Payload->#FileName->GetOrdersResponse->OrderArray->Order->OrderID          |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget    | X   | Y   |FileName| TaskName  | SuccesStatus | FailedStatus | FailureTaskRole     |Resources|
            | QueueTask | 626 | 140 | #FileNameinFileSetup|EbayQueue     | In Progress  | In Progress  | Application Manager |PostAPI|
        When User Edit "Queue task" "EbayQueue" field to Configure Service in "tasks" screen
        Then User will create transformation rule for "QueueTask" "Save Employee" in "transformation" screen
        | Destination        | Source             |
        | OrderID          | Single_Screen_Payload->#FileName->GetOrdersResponse->OrderArray->Order->OrderID          |
        | OrderStatus          | Single_Screen_Payload->#FileName->GetOrdersResponse->OrderArray->Order->OrderStatus          |
        | AmountPaid          | Single_Screen_Payload->#FileName->GetOrdersResponse->OrderArray->Order->AmountPaid->content        |
        | PaymentMethod          | Single_Screen_Payload->#FileName->GetOrdersResponse->OrderArray->Order->CheckoutStatus->PaymentMethod          |
        | ShippingService          | Single_Screen_Payload->#FileName->GetOrdersResponse->OrderArray->Order->ShippingDetails->ShippingServiceOptions->ShippingService         |
      
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | End    | 892 | 290 |
        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source | Action | Target |
            | Start  |        | PostAPI |
            |PostAPI | Success | EbayQueue    |
            | EbayQueue | Success | End    |
        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        Then User will "Logout" from "Page" the current session

        # Workflow
        And User wait for "60000"
        And User wait for "60000"
        And User wait for "60000"
        And User wait for "60000"
        And User wait for "80000"
        And User wait for "60000"
        And User wait for "60000"
        And User wait for "60000"
        And User wait for "60000"
        And User wait for "80000"
        Given user login to workflow UI "Finlevit_workflow" with "1" "AppManager" credentials
        And User wait until the "Filter Transaction id" appears in "WorkFlow UI" screen
        Then User click on "Button" "Home" in "HomePage" screen
        Then User will open "GroupName" group in "HomePage" screen
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "5000"
        Then User click on "Menu" "Team Task" in "WorkFlow UI" screen
        And User wait until the spinner disappears
        Then User click on "Button" "History" in "WorkFlow UI" screen
        And User wait until the spinner disappears
        Then User click on "Button" "Reload" in "WorkFlow UI" screen
        And User wait until the spinner disappears
        And User wait for "5000"
        And User should see an element "History Transaction id Column Data" in "WorkFlow UI" screen
        And User wait for "5000"
        Then User will "Logout" from "Page" the current session
