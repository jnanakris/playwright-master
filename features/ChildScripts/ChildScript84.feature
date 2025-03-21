Feature: Create Application to insert record to Salesforce and SQL

   @HaltecAPIsetup @ChildScript84 
#    @ChildScript
    #Created By: Mary
    #Created on : 12/10/2023
    Scenario Outline: Create Application to insert record to Salesforce and SQL

        Given user login to "Finlevit_admin" with "Admin" credentials
        And User get the Test data from "Usecase_TestData/ChildScript84" json file in "WorkFlow UI" screen
        # Then User delete group "#GroupName" in "Groups" screen
        # When User create group "#GroupName" with description "Group - Created by Automation" in "Groups" screen
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
        And User edit service "Accounts" and add Operations with "REST" service, "POST" Request, "application/json" ContentType and "No Parameters" in "apiSetup" screen
            | OperationName | Path  | Description                        | Request            | RequestTestOperation | Response |
            | Save Accounts | #Path | Operation added through automation | #SalesforceRequest | #SalesforceRequest   | {}       |

        # Create SalesForce DataSource
        Then User click on "button" "dataSources" in "GroupSetting" screen
        Then User add the "Salesforce","Rest API" Data resource name it as "Salesforce" add DataList and "UnSelect" ApplicationSourceSetup with below name service operation in "GroupSetting" screen
            | ListName     | Service  | Operation     |
            | Save Account | Accounts | Save Accounts |

        Then User add the "Generated APIs","MySQL" Data resource name it as "Create_SQL_Record" add DataList and "UnSelect" ApplicationSourceSetup with below name service operation in "GroupSetting" screen
            | ListName    | Schema | Table | OperationType | ReturnSingleRecord | Query          | ResponseJson | Parameters | DataType1       | SqlDataType1       | Value1              |
            | Save Record | MDM    | MDR   | INSERT        | True               | InsertByIdData | {}           | 29         | #InsertDataType | #InsertSQLDataType | #InsertAccountValue |

        Then User will open "GroupName" group in "HomePage" screen
        # # To Create an Application
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "2000"

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X  | Y  | FieldName | Title     |
            | Container | 50 | 30 | SQL_TABLE | SQL TABLE |
        When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X    | Y   |
            | SQL TABLE | 1350 | 975 |

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName  | FieldLabel |
            | Text Input | 50  | 155 | KNA1_LAND1 | KNA1_LAND1 |
            | Text Input | 285 | 155 | C_REGIO    | C_REGIO    |
            | Text Input | 520 | 155 | C_PSTLZ    | C_PSTLZ    |
            | Text Input | 760 | 155 | KNA1_NAME2 | KNA1_NAME2 |
            | Text Input | 995 | 155 | KNA1_NAME1 | KNA1_NAME1 |
            | Text Input | 50  | 245 | KNA1_PSTL2 | KNA1_PSTL2 |
            | Text Input | 285 | 245 | KNA1_TELF1 | KNA1_TELF1 |
            | Text Input | 520 | 245 | KNA1_PFACH | KNA1_PFACH |
            | Text Input | 760 | 245 | KNA1_KATR3 | KNA1_KATR3 |
            | Text Input | 995 | 245 | KNB1_SPERR | KNB1_SPERR |
            | Text Input | 50  | 340 | KNB1_ZSABE | KNB1_ZSABE |
            | Text Input | 285 | 340 | KNA1_KATR1 | KNA1_KATR1 |

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName    | FieldLabel   |
            | Text Input | 520 | 340 | KNA1_KATR7   | KNA1_KATR7   |
            | Text Input | 760 | 340 | AUSP_ATWRT   | AUSP_ATWRT   |
            | Text Input | 995 | 340 | KNB1_KVERM   | KNB1_KVERM   |
            | Text Input | 50  | 430 | KNA1_KATR10  | KNA1_KATR10  |
            | Text Input | 285 | 430 | KNA1_KTOKD   | KNA1_KTOKD   |
            | Text Input | 520 | 430 | C_ORT01      | C_ORT01      |
            | Text Input | 760 | 430 | KNA1_BRSCH   | KNA1_BRSCH   |
            | Text Input | 995 | 430 | KNA1_KUNNR   | KNA1_KUNNR   |
            | Text Input | 50  | 520 | KNVI_TAXKD_1 | KNVI_TAXKD_1 |
            | Text Input | 285 | 520 | KNVV_FAKSD   | KNVV_FAKSD   |
            | Text Input | 520 | 520 | KNB1_ZTERM   | KNB1_ZTERM   |
            | Text Input | 760 | 520 | C_STRAS      | C_STRAS      |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName          | FieldLabel         |
            | Text Input | 995 | 520 | KNB1_ALTKN         | KNB1_ALTKN         |
            | Text Input | 50  | 610 | ZE_ADR6_SMTP_ADDR  | ZE_ADR6_SMTP_ADDR  |
            | Text Input | 285 | 610 | ZE_ADRC_STR_SUPPL3 | ZE_ADRC_STR_SUPPL3 |
            | Text Input | 520 | 610 | ZE_ADRC_TEL_EXTENS | ZE_ADRC_TEL_EXTENS |
            | Text Input | 760 | 610 | ZE_KNVL_LICNR_1    | ZE_KNVL_LICNR_1    |

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName         | FieldLabel        |
            | Text Input | 995 | 610 | Name              | Name              |
            | Text Input | 50  | 700 | BillingStreet     | BillingStreet     |
            | Text Input | 285 | 700 | BillingCity       | BillingCity       |
            | Text Input | 520 | 700 | BillingState      | BillingState      |
            | Text Input | 760 | 700 | BillingPostalCode | BillingPostalCode |
            | Text Input | 995 | 700 | BillingCountry    | BillingCountry    |
            | Text Input | 50  | 790 | Phone             | Phone             |
            | Text Input | 285 | 790 | AccountNumber     | AccountNumber     |
            | Text Input | 520 | 790 | Website           | Website           |
            | Text Input | 760 | 790 | Industry          | Industry          |
            | Text Input | 995 | 790 | AnnualRevenue     | AnnualRevenue     |
            | Text Input | 50  | 870 | Rating            | Rating            |
            | Text Input | 285 | 870 | AccountSource     | AccountSource     |

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X   | Y   | FieldName | FieldLabel | Action | Status |
            | Button | 950 | 900 | Submit    | Submit     | Submit | Save   |


        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen

        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X  | Y  |
            | SQL_TABLE | 50 | 30 |

        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 150 | 300 |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget   | X   | Y   | TaskName   | SuccesStatus | FailedStatus | FailureTaskRole     | DataSource        | DataList    |
            | API Task | 400 | 300 | Create SQL | In Progress  | In Progress  | Application Manager | Create_SQL_Record | Save Record |
        When User Edit "API task" "Create SQL" field to Configure Service in "tasks" screen
        Then User will create transformation rule for "API Task" "Save Employee" and connect Input and Output nodes in "transformation" screen
            | DataType | Destination        | Source             |
            | MySQL    | KNA1_LAND1         | KNA1_LAND1         |
            |          | C_REGIO            | C_REGIO            |
            |          | C_PSTLZ            | C_PSTLZ            |
            |          | KNA1_NAME2         | KNA1_NAME2         |
            |          | KNA1_NAME1         | KNA1_NAME1         |
            |          | KNA1_PSTL2         | KNA1_PSTL2         |
            |          | KNA1_TELF1         | KNA1_TELF1         |
            |          | KNA1_PFACH         | KNA1_PFACH         |
            |          | KNA1_KATR3         | KNA1_KATR3         |
            |          | KNB1_SPERR         | KNB1_SPERR         |
            |          | KNB1_ZSABE         | KNB1_ZSABE         |
            |          | KNA1_KATR1         | KNA1_KATR1         |
            |          | KNA1_KATR7         | KNA1_KATR7         |
            |          | AUSP_ATWRT         | AUSP_ATWRT         |
            |          | KNB1_KVERM         | KNB1_KVERM         |
            |          | KNA1_KATR10        | KNA1_KATR10        |
            |          | KNA1_KTOKD         | KNA1_KTOKD         |
            |          | C_ORT01            | C_ORT01            |
            |          | KNA1_BRSCH         | KNA1_BRSCH         |
            |          | KNA1_KUNNR         | KNA1_KUNNR         |
            |          | KNVI_TAXKD_1       | KNVI_TAXKD_1       |
            |          | KNVV_FAKSD         | KNVV_FAKSD         |
            |          | KNB1_ZTERM         | KNB1_ZTERM         |
            |          | C_STRAS            | C_STRAS            |
            |          | KNB1_ALTKN         | KNB1_ALTKN         |
            |          | ZE_ADR6_SMTP_ADDR  | ZE_ADR6_SMTP_ADDR  |
            |          | ZE_ADRC_STR_SUPPL3 | ZE_ADRC_STR_SUPPL3 |
            |          | ZE_ADRC_TEL_EXTENS | ZE_ADRC_TEL_EXTENS |
            |          | ZE_KNVL_LICNR_1    | ZE_KNVL_LICNR_1    |

        And User wait for "2000"
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget   | X   | Y   | TaskName          | SuccesStatus | FailedStatus | FailureTaskRole     | DataSource | DataList    |
            | API Task | 700 | 300 | Create Salesforce | In Progress  | In Progress  | Application Manager | Salesforce | Save Account |
        When User Edit "API task" "Create Salesforce" field to Configure Service in "tasks" screen
        Then User will create transformation rule for "API Task" "SaveAccount" and connect Input and Output nodes in "transformation" screen
            | Destination       | Source            |
            | Name              | Name              |
            | BillingStreet     | BillingStreet     |
            | BillingCity       | BillingCity       |
            | BillingState      | BillingState      |
            | BillingPostalCode | BillingPostalCode |
            | BillingCountry    | BillingCountry    |
            | Phone             | Phone             |
            | AccountNumber     | AccountNumber     |
            | Website           | Website           |
            | Industry          | Industry          |
            | AnnualRevenue     | AnnualRevenue     |
            | Rating            | Rating            |
            | AccountSource     | AccountSource     |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName |
            | End    | 900 | 300 | End Task |

        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source            | Action  | Target            |
            | Start             |         | Create SQL        |
            | Create SQL        | Success | Create Salesforce |
            | Create Salesforce | Success | End Task          |


        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        # To validate Preview
        And User validate Payload app opening in a new tab
        # Payload Validation
        Given user login to payload application with "Finlevit_payload" with "1" agent
        #Enter Data
        And User enter "text" in "KNA1_LAND1" with "5" characters
        And User enter "text" in "C_REGIO" with "5" characters
        And User enter "text" in "C_PSTLZ" with "5" characters
        And User enter "text" in "KNA1_NAME2" with "5" characters
        And User enter "text" in "KNA1_NAME1" with "5" characters
        And User enter "text" in "KNA1_PSTL2" with "5" characters
        And User enter "text" in "KNA1_TELF1" with "5" characters
        And User enter "text" in "KNA1_PFACH" with "5" characters
        And User enter "text" in "KNA1_KATR3" with "5" characters
        And User enter "text" in "KNB1_SPERR" with "5" characters
        And User enter "text" in "KNB1_ZSABE" with "5" characters
        And User enter "text" in "KNA1_KATR1" with "5" characters
        And User enter "text" in "KNA1_KATR7" with "5" characters
        And User enter "text" in "AUSP_ATWRT" with "5" characters
        And User enter "text" in "KNB1_KVERM" with "5" characters
        And User enter "text" in "KNA1_KATR10" with "5" characters
        And User enter "text" in "KNA1_KTOKD" with "5" characters
        And User enter "text" in "C_ORT01" with "5" characters
        And User enter "text" in "KNA1_BRSCH" with "5" characters
        And User enter "text" in "KNA1_KUNNR" with "5" characters
        And User enter "text" in "KNVI_TAXKD_1" with "5" characters
        And User enter "text" in "KNVV_FAKSD" with "5" characters
        And User enter "text" in "KNB1_ZTERM" with "5" characters
        And User enter "text" in "C_STRAS" with "5" characters
        And User enter "text" in "KNB1_ALTKN" with "5" characters
        And User enter "text" in "ZE_ADR6_SMTP_ADDR" with "5" characters
        And User enter "text" in "ZE_ADRC_STR_SUPPL3" with "5" characters
        And User enter "text" in "ZE_ADRC_TEL_EXTENS" with "5" characters
        And User enter "text" in "ZE_KNVL_LICNR_1" with "5" characters
        # SaleForce
        And User enter "text" in "Name" with "5" characters
        And User enter "text" in "BillingStreet" with "5" characters
        And User enter "text" in "BillingCity" with "5" characters
        And User enter "text" in "BillingState" with "5" characters
        And User enter "text" in "BillingPostalCode" with "5" characters
        And User enter "text" in "BillingCountry" with "5" characters
        And User enter "text" in "Phone" with "5" characters
        And User enter "text" in "AccountNumber" with "5" characters
        And User enter "text" in "Website" with "5" characters
        And User enter "text" in "Industry" with "5" characters
        And User enter "67890" text in "AnnualRevenue" field
        And User enter "text" in "Rating" with "5" characters
        And User enter "text" in "AccountSource" with "5" characters


        Then User click on "Button" widget "Submit" in "payload" screen

        And User get Transaction Id and save it in json file

        #WorkFlow UI
        Given user login to workflow UI "Finlevit_workflow" with "1" "AppManager" credentials
        And User wait until the "Filter Transaction id" appears in "WorkFlow UI" screen
        Then User click on "Button" "Home" in "HomePage" screen
        Then User will open "GroupName" group in "HomePage" screen
        Then User will search for "Application_Name" in "Application" screen
        #Task1
        And User validate Transaction table header under "Team Task" in "WorkFlow UI" screen
            | SLA | Transaction Id | Task Name | Priority | Created At | Submitted By | Last Updated By | Last Updated At | Assigned To |
        And User validate Transaction details are removed from "Team Task" and it is displaying under "History" on the successful workflow completion in "WorkFlow UI" screen
        Then User click on "History" "History" in "WorkFlow UI" screen
        Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
        Then User click on "History" "Task History" in "WorkFlow UI" screen
        Then User validates Tasks event and Action as "Success" in "WorkFlow UI" screen
            | Task              |
            | Create SQL        |
            | Create Salesforce |

        And User wait for "5000"

