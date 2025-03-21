Feature: Create Existing Application with ACH flatfile with Basic Auth to CSV file
    # prerequisite: Enter FileName, Operation name, DatalistName, Source document, Destination document in the CS83 test data json file
    # Manually create document configuration
    @AVHAPIsetup @ChildScript83 
    @ChildScript
    #Created By: Mary
    #Created on : 07/25/2024
    Scenario Outline: Create Existing Application with ACH with Basic Auth

        Given user login to "Finlevit_admin" with "Admin" credentials
        And User get the Test data from "Usecase_TestData/ChildScript83" json file in "WorkFlow UI" screen
         When User verify and create "AvsVerification" serviceProvider in API generator "apiGenerator" screen
            | Name           | Description                                                    | EndPoint | uniqueField | FilterField | apiSchema            |
            | AvsVerification | Api created  using AUTOMATION - Do not Modify / Delete / Clone | AvsVerification   | Last_Name     | Last_Name     | Avs_Schema |
        When User upload "Avs_Data" data to "AvsVerification" serviceProvider in "apiGenerator" screen
        When User verify "AvsVerification" API and export service providers and DataSources to the group "GroupName" in "apiGenerator" screen
        Then User will open "GroupName" group in "HomePage" screen
        Then User click on "button" "group_settings" in "Groups" screen
        Then User will create AuthProvider name as "Stripe_BasicAuth" with description and authType as "Basic Auth" in "GroupSetting" screen
        Then User click on "button" "apiSetup" in "GroupSetting" screen
        # Create Service Provider
        And User create service provider in "apiSetup" screen
            | SPName | Description                          | EndPointURL                        | AuthorizationType  |SPType|
            | Stripe | Stripe SP created through automation | https://api.stripe.com/ |  Stripe_BasicAuth |External|
        # Create Service
        And User edit service provider and add service in "apiSetup" screen
            | SPName | ServiceName  | Description                      |
            | Stripe | Stripe | Service added through automation |

        And User Add below "Form URL Parameters" when create an Operation in "apiSetup" screen
            | Name                              | DataType | Value        |
            | bank_account[country]             | STRING   | US           |
            | bank_account[currency]            | STRING   | usd          |
            | bank_account[account_holder_name] | STRING   | mike rose    |
            | bank_account[account_holder_type] | STRING   | individual   |
            | bank_account[routing_number]      | STRING   | 110000000    |
            | bank_account[account_number]      | STRING   | 000123456789 |

        And User Add below "Error Codes" when create an Operation in "apiSetup" screen
            | HttpCode | Type   |
            | 400      | User   |
            | 500      | System |

        And User Add below "Error Data" when create an Operation in "apiSetup" screen
            | Name                              | DataType | Value        |
            | bank_account[country]             | STRING   | US           |
            | bank_account[currency]            | STRING   | usd          |
            | bank_account[account_holder_name] | STRING   | mike rose    |
            | bank_account[account_holder_type] | STRING   | individual   |
            | bank_account[routing_number]      | STRING   | 110000000    |
            | bank_account[account_number]      | STRING   | 123456789 |

        # Create Operation
        And User edit service "Stripe" and add Operations with "REST" service, "POST" Request, "Form URL Encoded" ContentType and "Form URL Parameters" in "apiSetup" screen
            | OperationName   | Path             | Description                        | Response |ErrorCodes|
            | #OperationName | v1/tokens | Operation added through automation | {}           |Yes|

        Then User click on "button" "dataSources" in "GroupSetting" screen
        Then User add the "Stripe","Rest API" Data resource name it as "Account Validation" add DataList and "UnSelect" ApplicationSourceSetup with below name service operation in "GroupSetting" screen
            | ListName   | Service      | Operation       |
            | #DatalistName | Stripe | #OperationName |

        And User test connection for the document in "document" screen
            | Type | Root | AccessKey            | SecretKey                                | BucketName         | AWSRegion      |
            | S3   | SIT/ | AKIAVVCS3TID6M6RK3IJ | jsFIpgk+l+duBLWzKUZ9n54haljxtnoDvRoqtIgL | qaautomationkonfig | US East (Ohio) |

        And User use below "Require Fields" when create app source setup in "appSourceSetup" screen
            | FieldName | DataType | WidgetType | IsRequired | MaxLength |
            | Routing Number | string   | TextInput     |         |         |
            | Account Number | string   | TextInput     |         |         |

        Then User will create app source setup with "File" in "appSourceSetup" screen
            | FileType  | AppMode | FileSeparator | FolderType | SourceFolder        | ProcessedFolder          | FileUpload       |BatchCategory|SourceName|
            | Flat File | Batch   | \|            | S3         | #DocumentSourceName | #DocumentDestinationName | ACH_Payments.csv |VOT|New|

        Then User click on "Menu" "fileSetupMenu" in "HomePage" screen

        And User use below "Require Fields" when create app source setup in "fileSetup" screen
            | FieldName      | DataType | IsRequired | MaxLength |
            | Postal Code    | string   |            |           |
            | Account Number | string   |            |           |
            | Routing Number | string   |            |           |
        Then User will create file setup with "Flat File" file in "fileSetup" screen
            | FileType  | FileSeparator | FileUpload                       | Destination | ProcessedFolder          | SourceName |
            | Flat File | ,             | ACH_Payments_Response.csv | S3          | #DocumentDestinationName | New        |

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
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X  | Y  |
            | #FileName | 50 | 50 |
        Then User click on "span" "Save" in "Page" screen
        Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName    | FieldLabel   |
            | Text Input | 75  | 650 | Stripe_Error | Stripe_Error |
            | Text Input | 350 | 650 | Status       | Status       |
            | Text Input | 625 | 650 | AVS_Error    | AVS_Error    |
    

        Then User click on "span" "Save" in "Page" screen
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
            | Widget   | X   | Y   | TaskName         | FailureTaskRole     | DataSource      | DataList                  |Transaction_Mode|Process_all_transactions|
            | API Task | 206 | 189 | AVS Verification | Application Manager | AvsVerification | Get By Id AvsVerification |Yes|Yes|

        When User Edit "API task" "AVS Verification" field to Configure Service in "tasks" screen
        
        Then User will create transformation rule for "API Task" "AVS Verification" and connect Input and Output nodes in "transformation" screen
            | Destination | Source      |UniqueField|
            | Last_Name   | Last Name   |Yes|

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget   | X   | Y   | TaskName           | FailureTaskRole        | DataSource      | DataList                  |Transaction_Mode|Process_all_transactions|
            | API Task | 414 | 223 | Validate Account | Application Manager |Account Validation |Account Validation |Yes|Yes|

        When User Edit "API task" "Validate Account" field to Configure Service in "tasks" screen
        
        Then User click on "button" "addRuleButton" in "transformation" screen
        Then User enter text "Update" in "Name" in "transformation" screen
        #Rule-1
        Then User add the below conditions in "expressionBuilder" screen
            | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
            | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Destination Fields          | Source Fields               |
        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | Source                                                           |
            |Account Validation->Parameters->bank_account[country]          |
            | Application ->root->Single_Screen_Payload->#FileName->Country |

        #Rule-2
    Then User add the below conditions in "expressionBuilder" screen
        | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Destination Fields          | String Constant             |
    Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
        | Source                                                   | StringConstant |
        |Account Validation->Parameters->bank_account[currency] | USD            |

    #Rule-3
    Then User add the below conditions in "expressionBuilder" screen
        | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Destination Fields          | Source Fields               |
    Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
        | Source                                                                 |
        |Account Validation -> Parameters ->bank_account[account_holder_type] |
        | Application ->root->Single_Screen_Payload->#FileName-> Account Type |

    #Rule-4
    Then User add the below conditions in "expressionBuilder" screen
        | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Destination Fields          | Source Fields               |
    Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
        | Source                                                                  |
        |Account Validation -> Parameters ->bank_account[routing_number]       |
        | Application ->root->Single_Screen_Payload->#FileName->Routing Number |

    #Rule-5
    Then User add the below conditions in "expressionBuilder" screen
        | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Destination Fields          | Source Fields               |
    Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
        | Source                                                                  |
        |Account Validation -> Parameters ->bank_account[account_number]       |
        | Application ->root->Single_Screen_Payload->#FileName->Account Number |


    #Rule-6
    Then User add the below conditions in "expressionBuilder" screen
        | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType3 | OperatorTypeCount3 | ConditionType3OperatorType1 |
        | 3                  | 1                  | Compare        | Assign                      | Operands       | 1                  | Destination Fields          | String         | 1                  | Concat                      |

    Then User implements conditions in execute area for below fields in "expressionBuilder" screen
        | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType1OperatorType2 | ConditionType1OperatorType3 |
        | 1        | 1                  | 3                  | Operands       | Source Fields               | String Constant             | Source Fields               |

    Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
        | Source                                                              | StringConstant |
        |Account Validation->Parameters->bank_account[account_holder_name] |                |
        | Application ->root->Single_Screen_Payload->#FileName->First Name |  " "           |
        | Application ->root->Single_Screen_Payload->#FileName->Last Name  |                |
    Then User click on "Button" "Save" in "transformation" screen
    Then User click on "Button" "Close" in "transformation" screen
    #    Response task
    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget           | X   | Y   | TaskName      | SuccesStatus | FailedStatus | FailureTaskRole     | ResourcesCount | Resources1       | Resources2         |
            | Response Mapping | 615 | 219 | AVS Response | In Progress  | In Progress  | Application Manager | 2              | AVS Verification | Validate Account |

        When User Edit "Response task" "AVS Response" field to Configure Service in "tasks" screen
        Then User click on "button" "addRuleButton" in "transformation" screen
        Then User enter text "Response" in "Name" in "transformation" screen

        #Function-1
        Then User add the below conditions in "expressionBuilder" screen
            | Functions | parameterCount | Paramvalue1 | Paramvalue2 |
            | Status    | 2              | AVS         | CVS         |


        Then User implements conditions in execute area for below fields in "expressionBuilder" screen
            | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType1OperatorType2 |
            | 1        | 1                  | 2                  | Conditions     | If                          | And                         |

        Then User implements conditions in execute area for below fields in "expressionBuilder" screen
            | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | DropField | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType3 | OperatorTypeCount3 | ConditionType3OperatorType1 |
            | 1        | 3                  | 1                  | Compare        | 1         | Equality                    | Functions      | 1                  | Function Param              | Operands       | 1                  | String Constant             |
            | 1        | 3                  | 1                  | Compare        | 1         | Equality                    | Functions      | 1                  | Function Param              | Operands       | 1                  | String Constant             |

        Then User implements conditions in execute area for below fields in "expressionBuilder" screen
            | Condition | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 |
            | IF        | 2                  | 1                  | Functions      | Return Value                | Operands       | 1                  | String Constant             |

        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | FunctionsParams | StringConstant |
            | AVS             | ARC50008       |
            | CVS             | CRC20001       |
            |                 | Success        |

        #  Function-1_Else_IF_1
        And User scrollIntoView of "Condition" in "expressionBuilder" screen
        And User scrollIntoView of "Spacer" in "expressionBuilder" screen
        And User wait for "1000"
        Then User add the below conditions in "expressionBuilder" screen
            | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 |
            | 1                  | 1                  | Conditions     | Else If                     |

        Then User implements conditions in execute area for below fields in "expressionBuilder" screen
            | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 |
            | 2        | 1                  | 1                  | Conditions     | And                         |
        Then User implements conditions in execute area for below fields in "expressionBuilder" screen
            | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | DropField | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType3 | OperatorTypeCount3 | ConditionType3OperatorType1 |
            | 2        | 3                  | 1                  | Compare        | 1         | Equality                    | Functions      | 1                  | Function Param              | Operands       | 1                  | String Constant             |
            | 2        | 3                  | 1                  | Compare        | 1         | Equality                    | Functions      | 1                  | Function Param              | Operands       | 1                  | String Constant             |

        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | FunctionsParams | StringConstant |
            | AVS             | ARC50008       |
            | CVS             | CRC20000       |

        Then User implements conditions in execute area for below fields in "expressionBuilder" screen
            | DropArea | Condition | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 |
            | 2        | IF        | 2                  | 1                  | Functions      | Return Value                | Operands       | 1                  | String Constant             |

        # And User scrollIntoView of "FooterSave" in "expressionBuilder" screen
        And User wait for "2000"
        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | StringConstant |
            | Pending        |

        #    Function-1_Else_IF_2
        And User scrollIntoView of "Spacer" in "expressionBuilder" screen
        And User wait for "1000"
        Then User add the below conditions in "expressionBuilder" screen
            | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 |
            | 1                  | 1                  | Conditions     | Else If                     |

        Then User implements conditions in execute area for below fields in "expressionBuilder" screen
            | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 |
            | 3        | 1                  | 1                  | Conditions     | And                         |

        Then User implements conditions in execute area for below fields in "expressionBuilder" screen
            | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | DropField | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType3 | OperatorTypeCount3 | ConditionType3OperatorType1 |
            | 3        | 3                  | 1                  | Compare        | 1         | Equality                    | Functions      | 1                  | Function Param              | Operands       | 1                  | String Constant             |
            | 3        | 3                  | 1                  | Compare        | 1         | Equality                    | Functions      | 1                  | Function Param              | Operands       | 1                  | String Constant             |

        Then User implements conditions in execute area for below fields in "expressionBuilder" screen
            | DropArea | Condition | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 |
            | 3        | IF        | 2                  | 1                  | Functions      | Return Value                | Operands       | 1                  | String Constant             |

        And User scrollIntoView of "FooterSave" in "expressionBuilder" screen
        And User wait for "2000"
        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | FunctionsParams | StringConstant |
            | AVS             | ARC50007       |
            | CVS             | CRC20018       |
            |                 | Failed         |


        # Function-1_Else
        Then User add the below conditions in "expressionBuilder" screen
            | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 |
            | 1                  | 1                  | Conditions     | Else                        |

        Then User implements conditions in execute area for below fields in "expressionBuilder" screen
            | DropArea | Condition | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 |
            | 3        | Else      | 2                  | 1                  | Functions      | Return Value                | Operands       | 1                  | String Constant             |

        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | StringConstant |
            | Pending        |
        Then User click on "button" "FooterSave" in "expressionBuilder" screen
        And User wait for "2000"
        And User collapse rule name "Status" in "expressionBuilder" screen
        # #Function-2
        # Then User add the below conditions in "expressionBuilder" screen
        #     | Functions   | parameterCount | Paramvalue1 | Paramvalue2 |
        #     | AVS Message | 2              | AVS         | CVS         |

        # #Function-2_IF
        # Then User implements conditions in execute area for below fields in "expressionBuilder" screen
        #     | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType1OperatorType2 |
        #     | 7        | 1                  | 2                  | Conditions     | If                          | And                         |

        # Then User implements conditions in execute area for below fields in "expressionBuilder" screen
        #     | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | DropField | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType3 | OperatorTypeCount3 | ConditionType3OperatorType1 |
        #     | 7        | 3                  | 1                  | Compare        | 1         | Equality                    | Functions      | 1                  | Function Param              | Operands       | 1                  | String Constant             |
        #     | 7        | 3                  | 1                  | Compare        | 1         | Equality                    | Functions      | 1                  | Function Param              | Operands       | 1                  | String Constant             |

        # Then User implements conditions in execute area for below fields in "expressionBuilder" screen
        #     | DropArea | Condition | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 |
        #     | 5        | IF        | 2                  | 1                  | Functions      | Return Value                | Operands       | 1                  | String Constant             |

        # Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
        #     | FunctionsParams | StringConstant     |
        #     | AVS             | ARC50008           |
        #     | CVS             | CRC20001           |
        #     |                 | Ready for Payments |


        # # #Function-2_Else_IF_1
        # And User scrollIntoView of "Condition" in "expressionBuilder" screen
        # And User scrollIntoView of "Spacer" in "expressionBuilder" screen
        # And User wait for "2000"
        # Then User add the below conditions in "expressionBuilder" screen
        #    | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 |DropArea|
        #     | 1                  | 1                  | Conditions     | Else If                     |2|

        # And User wait for "1000"
        # Then User implements conditions in execute area for below fields in "expressionBuilder" screen
        #     | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 |
        #     | 8        | 1                  | 1                  | Conditions     | And                         |

        # Then User implements conditions in execute area for below fields in "expressionBuilder" screen
        #     | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | DropField | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType3 | OperatorTypeCount3 | ConditionType3OperatorType1 |
        #     | 8        | 3                  | 1                  | Compare        | 1         | Equality                    | Functions      | 1                  | Function Param              | Operands       | 1                  | String Constant             |
        #     | 8        | 3                  | 1                  | Compare        | 1         | Equality                    | Functions      | 1                  | Function Param              | Operands       | 1                  | String Constant             |

        # Then User implements conditions in execute area for below fields in "expressionBuilder" screen
        #     | DropArea | Condition | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 |
        #     | 3        | Else If   | 2                  | 1                  | Functions      | Return Value                | Operands       | 1                  | String Constant             |

        # # And User scrollIntoView of "FooterSave" in "expressionBuilder" screen
        # Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
        #     | FunctionsParams | StringConstant                                                                                                            |
        #     | AVS             | ARC50008                                                                                                                  |
        #     | CVS             | CRC20000                                                                                                                  |
        #     |                 | We're reviewing this account and will update you here within 2 business days. There's nothing for you to do at this time. |

        # #Function-2_Else_IF_2
        # # And User scrollIntoView of "Condition" in "expressionBuilder" screen
        # And User scrollIntoView of "Spacer" in "expressionBuilder" screen
        # And User wait for "1000"
        # Then User add the below conditions in "expressionBuilder" screen
        #     | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 |
        #     | 2        | 1                  | 1                  | Conditions     | Else If                     |

        # Then User implements conditions in execute area for below fields in "expressionBuilder" screen
        #     | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 |
        #     | 9        | 1                  | 1                  | Conditions     | And                         |

        # Then User implements conditions in execute area for below fields in "expressionBuilder" screen
        #     | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | DropField | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType3 | OperatorTypeCount3 | ConditionType3OperatorType1 |
        #     | 9        | 3                  | 1                  | Compare        | 1         | Equality                    | Functions      | 1                  | Function Param              | Operands       | 1                  | String Constant             |
        #     | 9        | 3                  | 1                  | Compare        | 1         | Equality                    | Functions      | 1                  | Function Param              | Operands       | 1                  | String Constant             |

        # Then User implements conditions in execute area for below fields in "expressionBuilder" screen
        #     | DropArea | Condition | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 |
        #     | 4        | Else If   | 2                  | 1                  | Functions      | Return Value                | Operands       | 1                  | String Constant             |

        # And User scrollIntoView of "FooterSave" in "expressionBuilder" screen
        # Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
        #     | FunctionsParams | StringConstant                                                                                       |
        #     | AVS             | ARC50007                                                                                             |
        #     | CVS             | CRC20018                                                                                             |
        #     |                 | No customer information was found for the data submitted. Please try again with a different account. |

        # Then User add the below conditions in "expressionBuilder" screen
        #     | DropArea  | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 |
        #     | 2         | 1                  | 1                  | Conditions     | Else                        |

        # Then User implements conditions in execute area for below fields in "expressionBuilder" screen
        #     | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 |
        #     | 10       | 2                  | 1                  | Functions      | Return Value                | Operands       | 1                  | String Constant             |

        # Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
        #     | StringConstant                                                                                       |
        #     | No customer information was found for the data submitted. Please try again with a different account. |
        # Then User click on "button" "FooterSave" in "expressionBuilder" screen

        # Then User click on "button" "Functions" in "expressionBuilder" screen
        And User wait for "1000"

        Then User implements conditions in execute area for below fields in "expressionBuilder" screen
            | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1         | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 |
            | 7       | 2                  | 1                  | Konfig         | Bulk Update with Transactional data | Compare        | 1                  | Assign                      |

        Then User implements conditions in execute area for below fields in "expressionBuilder" screen
            | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 |
            | 7       | 2                  | 1                  | Operands       | Destination Fields          | Functions      | 1                  | Call Function               |

        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | CallFunction | Payloadfields |
            | Status       | Status        |

        Then User implements conditions in execute area for below fields in "expressionBuilder" screen
            |Condition| DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType1OperatorType2 |
            |Function| 7       | 1                  | 2                  | Operands       | Source Fields               | Source Fields               |

        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | Source                                                |
            | AVS Verification -> Success Response ->root->ARC_Code |
            | AVS Verification -> Success Response ->root->CRC_Code |

        # Then User implements conditions in execute area for below fields in "expressionBuilder" screen
        #     | DropArea | ConditionTypeCount | ConditionType1 | OperatorTypeCount1 | ConditionType1OperatorType1 |
        #     | 13       | 1                  | Compare        | 1                  | Assign                      |

        # Then User implements conditions in execute area for below fields in "expressionBuilder" screen
        #     | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 |
        #     | 13       | 2                  | 1                  | Operands       | Destination Fields          | Functions      | 1                  | Call Function               |

        # Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
        #     | CallFunction | Payloadfields |
        #     | AVS Message  | AVS_Error     |

        # Then User implements conditions in execute area for below fields in "expressionBuilder" screen
        #     |Condition| DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType1OperatorType2 |
        #     |Function| 13       | 1                  | 2                  | Operands       | Source Fields               | Source Fields               |

        # Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
        #     | Source                                                |
        #     | AVS Verification -> Success Response ->root->ARC_Code |
        #     | AVS Verification -> Success Response ->root->CRC_Code |
        And User wait for "2000"
        Then User implements conditions in execute area for below fields in "expressionBuilder" screen
            | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
            | 7        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Destination Fields          | Source Fields               |
            
        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | Payloadfields | Source                                                 |
            | Stripe_Error          | Validate Account -> Error Response ->root->error->message            |
           
        Then User click on "Button" "Save" in "transformation" screen
        Then User click on "Button" "Close" in "transformation" screen

        # File Task with Konfig Function
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget   | X   | Y   | TaskName       | FileName             | SuccesStatus | FailedStatus | FailureTaskRole     |TransactionType|
            | FileTask | 800 | 87 | CreateAvroFile | #FileNameinFileSetup | In Progress  | In Progress  | Application Manager |Both|
        When User Edit "File task" "CreateAvroFile" field to Configure Service in "tasks" screen
        Then User click on "button" "addRuleButton" in "transformation" screen
        Then User enter text "inserttoAvro" in "Name" in "transformation" screen
        Then User add the below conditions in "expressionBuilder" screen
            | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 |
            | 1                  | 1                  | Konfig         | Create File                 |
        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | Source                                                             |
            | Application->root->Single_Screen_Payload->#FileName->First Name  |
            | Application->root->Single_Screen_Payload->#FileName->Last Name  |
            | Application->root->Single_Screen_Payload->#FileName->Address Line 1           |
            | Application->root->Single_Screen_Payload->#FileName->Address Line 2 |
            | Application->root->Single_Screen_Payload->#FileName->City |
            | Application->root->Single_Screen_Payload->#FileName->State |
            | Application->root->Single_Screen_Payload->#FileName->Country |
            | Application->root->Single_Screen_Payload->#FileName->Postal Code |
            | Application->root->Single_Screen_Payload->#FileName->Account Type |
            | Application->root->Single_Screen_Payload->#FileName->Routing Number |
            | Application->root->Single_Screen_Payload->#FileName->Account Number |
            | Application->root->Back_Office_Fields->Status             |
            | Application->root->Back_Office_Fields->Stripe_Error             |
        # delete source dropdown and add string constant
        And User delete the "28" default field from rule builder
        Then User add the below conditions in "expressionBuilder" screen
            | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 |
            | 1                  | 1                  | Operands       | String Constant             |
        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | StringConstant |
            | No Message         |

        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | Source                                                             |
            | Application->root->Back_Office_Fields->AVS_Error   |

        Then User click on "Button" "Save" in "transformation" screen
        And User wait for "2000"
        Then User click on "Button" "Close" in "transformation" screen
        And User wait for "2000"

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName                | To              | Sub     | Template | FailureTaskRole     |Attach_a_File|
            | Email  | 954 | 243 | Email Task | #To | MailSub | MailBody | Application Manager |Yes|

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X    | Y   |
            | End    | 1137 | 118 |
        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source             | Action  | Target             |
            | Start              |         | CheckValidation    |
            | CheckValidation    |         | AVS Verification   |
            | AVS Verification   | Success | Validate Account |
            | Validate Account | Success | AVS Response      |
            | AVS Response      | Success | CreateAvroFile     |
            | CreateAvroFile     | Success | Email Task         |
            | Email Task         |         | End                |
        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        Then User will "Logout" from "Page" the current session

