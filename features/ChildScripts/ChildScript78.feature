Feature: Usecase to demonstrate Create DataSource using MySql exisitn application to API task

    @ChildScript78
    @ChildScript
    Scenario: Usecase to demonstrate Create DataSource using MySql exisitn application to API task

        #CreateGroup
        Given user login to "Finlevit_admin" with "Admin" credentials
        And User get the Test data from "Usecase_TestData/ChildScript78" json file in "WorkFlow UI" screen
        When User enter create group with "GroupName" and "GroupDescription" in "Groups" screen
        When User verify and create "MDR_Output" serviceProvider in API generator "apiGenerator" screen
        | Name       | Description                                                    | EndPoint  | uniqueField | FilterField  | apiSchema       | Prefix | MaxLength |
        | MDR_Output | Api created  using AUTOMATION - Do not Modify / Delete / Clone | mdrOutput | id          | accountGroup | MdrOutputSchema | MD     | 000       |

        When User verify "MDR_Output" API and export service providers and DataSources to the group "GroupName" in "apiGenerator" screen
        Then User will open "GroupName" group in "HomePage" screen
        Then User click on "button" "group_settings" in "Groups" screen
        Then User add the "Generated APIs","MySQL" Data resource name it as "MDM_MYSQL_Automation" add DataList and "Select" ApplicationSourceSetup with below name service operation in "GroupSetting" screen
            | ListName     | Schema | Table | OperationType | ReturnSingleRecord | Query       | ResponseJson |
            | Get All Data | MDM    | MDR   | SELECT        | False               | GetByIdData | {}           |
        And User use below "Require Fields" when create app source setup in "appSourceSetup" screen
            |  |
        And User use below "Request Parameters" when create app source setup in "appSourceSetup" screen
            |  |
        Then User will create app source setup with "Data List" in "appSourceSetup" screen
            | GroupName | DataResource         | DataList     | SourceType | Frequency | CronExpression | SourceName |
            | GroupName | MDM_MYSQL_Automation | Get All Data | Primary    | Cron      | 0 0/5 * * * *  | New        |
        Then User will open "GroupName" group in "HomePage" screen
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
            | Widget    | X  | Y  | FieldName      | Title          |
            | Container | 50 | 50 | MDR_Automation | MDR_Automation |
        When User expand below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget         | X    | Y   |
            | MDR_Automation | 1100 | 850 |
        Then User click on "button" "FOFields" in "UniqueWidgetFields" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget          | X   | Y   |
            | KNA1_KTOKD      | 100 | 150 |
            | KNVV_FAKSD      | 300 | 150 |
            | KNA1_NAME1      | 500 | 150 |
            | KNA1_NAME2      | 700 | 150 |
            | KNA1_BRSCH      | 100 | 350 |
            | KNB1_ZTERM      | 300 | 350 |
            | KNA1_KATR7      | 500 | 350 |
            | KNA1_KATR3      | 700 | 350 |
            | KNB1_SPERR      | 100 | 550 |
            | ZE_KNVL_LICNR_1 | 300 | 550 |
            | KNA1_KATR10     | 500 | 550 |
            | KNA1_KATR1      | 700 | 550 |
        Then User click on "span" "Save" in "Page" screen

        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        # To Add the required tasks onto the workflow Designer
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 200 | 300 |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget   | X   | Y   | TaskName     | SuccesStatus | FailedStatus | FailureTaskRole     | DataSource | DataList        |
            | API Task | 400 | 300 | CreateRecord | In Progress  | In Progress  | Application Manager | MDR_Output | Save MDR_Output |
        When User Edit "API task" "CreateRecord" field to Configure Service in "tasks" screen
        Then User click on "button" "addRuleButton" in "transformation" screen
        Then User enter text "CreateRecord" in "Name" in "transformation" screen
        #Rule-1
        Then User add the below conditions in "expressionBuilder" screen
            | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType3 | OperatorTypeCount3 | ConditionType3OperatorType1 |
            | 3                  | 1                  | Conditions     | If                          | String         | 1                  | Is Not Empty                | Operands       | 1                  | Source Fields               |

        And User scrollIntoView of "DropFields" in "expressionBuilder" screen
        Then User implements conditions in execute area for below fields in "expressionBuilder" screen
            | Condition | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
            | IF        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Destination Fields          | Source Fields               |
        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | Condition | Destinationfields | Sourcefields |
            | IF        |                   | KNA1_KTOKD   |
            | IF        | accountGroup      | KNA1_KTOKD   |

        #Rule-2
        And User scrollIntoView of "DropFields" in "expressionBuilder" screen
        Then User add the below conditions in "expressionBuilder" screen
            | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType3 | OperatorTypeCount3 | ConditionType3OperatorType1 |
            | 3                  | 1                  | Conditions     | If                          | String         | 1                  | Is Not Empty                | Operands       | 1                  | Source Fields               |
        And User scrollIntoView of "Condition" in "expressionBuilder" screen
        Then User implements conditions in execute area for below fields in "expressionBuilder" screen
            | Condition | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
            | IF        | 2        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Destination Fields          | Source Fields               |
        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | Condition | Destinationfields | Sourcefields |
            | IF        |                   | KNVV_FAKSD   |
            | IF        | blockedReasonCode | KNVV_FAKSD   |


        #Rule-3
        And User scrollIntoView of "Spacer" in "expressionBuilder" screen
        Then User add the below conditions in "expressionBuilder" screen
            | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType3 | OperatorTypeCount3 | ConditionType3OperatorType1 |
            | 3                  | 1                  | Conditions     | If                          | String         | 1                  | Is Not Empty                | Operands       | 1                  | Source Fields               |
        And User scrollIntoView of "DropFields" in "expressionBuilder" screen
        Then User implements conditions in execute area for below fields in "expressionBuilder" screen
            | Condition | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
            | IF        | 3        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Destination Fields          | Source Fields               |
        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | Condition | Destinationfields | Sourcefields |
            | IF        |                   | KNA1_NAME1   |
            | IF        | companyName       | KNA1_NAME1   |

        #Rule-4
        And User scrollIntoView of "Spacer" in "expressionBuilder" screen
        Then User add the below conditions in "expressionBuilder" screen
            | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType3 | OperatorTypeCount3 | ConditionType3OperatorType1 |
            | 3                  | 1                  | Conditions     | If                          | String         | 1                  | Is Not Empty                | Operands       | 1                  | Source Fields               |
        And User scrollIntoView of "DropFields" in "expressionBuilder" screen
        Then User implements conditions in execute area for below fields in "expressionBuilder" screen
            | Condition | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
            | IF        | 4        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Destination Fields          | Source Fields               |
        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | Condition | Destinationfields | Sourcefields |
            | IF        |                   | KNA1_NAME2   |
            | IF        | companyName2      | KNA1_NAME2   |


        # #Rule-5
        # And User scrollIntoView of "DropFields" in "expressionBuilder" screen
        # Then User add the below conditions in "expressionBuilder" screen
        #     | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType3 | OperatorTypeCount3 | ConditionType3OperatorType1 |
        #     | 3                  | 1                  | Conditions     | If                          | String         | 1                  | Is Not Empty                | Operands       | 1                  | Source Fields               |
        # And User scrollIntoView of "DropFields" in "expressionBuilder" screen
        # Then User implements conditions in execute area for below fields in "expressionBuilder" screen
        #     | Condition | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
        #     | IF        | 5        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Destination Fields          | Source Fields               |
        # Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
        #     | Condition | Destinationfields | Sourcefields |
        #     | IF        |                   | KNA1_BRSCH   |
        #     | IF        | industryKey       | KNA1_BRSCH   |

        # #Rule-6
        # And User scrollIntoView of "DropFields" in "expressionBuilder" screen
        # Then User add the below conditions in "expressionBuilder" screen
        #     | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType3 | OperatorTypeCount3 | ConditionType3OperatorType1 |
        #     | 3                  | 1                  | Conditions     | If                          | String         | 1                  | Is Not Empty                | Operands       | 1                  | Source Fields               |
        # And User scrollIntoView of "DropFields" in "expressionBuilder" screen
        # Then User implements conditions in execute area for below fields in "expressionBuilder" screen
        #     | Condition | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
        #     | IF        | 6        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Destination Fields          | Source Fields               |
        # Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
        #     | Condition | Destinationfields | Sourcefields |
        #     | IF        |                   | KNB1_ZTERM   |
        #     | IF        | paymentTerms      | KNB1_ZTERM   |

        # #Rule-7
        # And User scrollIntoView of "DropFields" in "expressionBuilder" screen
        # Then User add the below conditions in "expressionBuilder" screen
        #     | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType3 | OperatorTypeCount3 | ConditionType3OperatorType1 |
        #     | 3                  | 1                  | Conditions     | If                          | String         | 1                  | Is Not Empty                | Operands       | 1                  | Source Fields               |
        # And User scrollIntoView of "DropFields" in "expressionBuilder" screen
        # Then User implements conditions in execute area for below fields in "expressionBuilder" screen
        #     | Condition | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
        #     | IF        | 7        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Destination Fields          | Source Fields               |
        # Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
        #     | Condition | Destinationfields | Sourcefields |
        #     | IF        |                   | KNA1_KATR7   |
        #     | IF        | paymentType       | KNA1_KATR7   |

        # #Rule-8
        # And User scrollIntoView of "DropFields" in "expressionBuilder" screen
        # Then User add the below conditions in "expressionBuilder" screen
        #     | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType3 | OperatorTypeCount3 | ConditionType3OperatorType1 |
        #     | 3                  | 1                  | Conditions     | If                          | String         | 1                  | Is Not Empty                | Operands       | 1                  | Source Fields               |
        # And User scrollIntoView of "DropFields" in "expressionBuilder" screen
        # Then User implements conditions in execute area for below fields in "expressionBuilder" screen
        #     | Condition | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
        #     | IF        | 8        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Destination Fields          | Source Fields               |
        # Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
        #     | Condition | Destinationfields | Sourcefields |
        #     | IF        |                   | KNA1_KATR3   |
        #     | IF        | poRequiredCode    | KNA1_KATR3   |

        # #Rule-9
        # And User scrollIntoView of "DropFields" in "expressionBuilder" screen
        # Then User add the below conditions in "expressionBuilder" screen
        #     | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType3 | OperatorTypeCount3 | ConditionType3OperatorType1 |
        #     | 3                  | 1                  | Conditions     | If                          | String         | 1                  | Is Not Empty                | Operands       | 1                  | Source Fields               |
        # And User scrollIntoView of "DropFields" in "expressionBuilder" screen
        # Then User implements conditions in execute area for below fields in "expressionBuilder" screen
        #     | Condition | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
        #     | IF        | 9        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Destination Fields          | Source Fields               |
        # Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
        #     | Condition | Destinationfields | Sourcefields |
        #     | IF        |                   | KNB1_SPERR   |
        #     | IF        | postingBlock      | KNB1_SPERR   |

        # #Rule-10
        # And User scrollIntoView of "DropFields" in "expressionBuilder" screen
        # Then User add the below conditions in "expressionBuilder" screen
        #     | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType3 | OperatorTypeCount3 | ConditionType3OperatorType1 |
        #     | 3                  | 1                  | Conditions     | If                          | String         | 1                  | Is Not Empty                | Operands       | 1                  | Source Fields               |
        # And User scrollIntoView of "DropFields" in "expressionBuilder" screen
        # Then User implements conditions in execute area for below fields in "expressionBuilder" screen
        #     | Condition | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
        #     | IF        | 10       | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Destination Fields          | Source Fields               |
        # Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
        #     | Condition | Destinationfields  | Sourcefields    |
        #     | IF        |                    | ZE_KNVL_LICNR_1 |
        #     | IF        | taxCertificateCode | ZE_KNVL_LICNR_1 |

        # #Rule-11
        # And User scrollIntoView of "DropFields" in "expressionBuilder" screen
        # Then User add the below conditions in "expressionBuilder" screen
        #     | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType3 | OperatorTypeCount3 | ConditionType3OperatorType1 |
        #     | 3                  | 1                  | Conditions     | If                          | String         | 1                  | Is Not Empty                | Operands       | 1                  | Source Fields               |
        # And User scrollIntoView of "DropFields" in "expressionBuilder" screen
        # Then User implements conditions in execute area for below fields in "expressionBuilder" screen
        #     | Condition | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
        #     | IF        | 11       | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Destination Fields          | Source Fields               |
        # Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
        #     | Condition | Destinationfields     | Sourcefields |
        #     | IF        |                       | KNVI_TAXKD_1 |
        #     | IF        | taxClassificationCode | KNVI_TAXKD_1 |

        # #Rule-12
        # And User scrollIntoView of "DropFields" in "expressionBuilder" screen
        # Then User add the below conditions in "expressionBuilder" screen
        #     | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType3 | OperatorTypeCount3 | ConditionType3OperatorType1 |
        #     | 3                  | 1                  | Conditions     | If                          | String         | 1                  | Is Not Empty                | Operands       | 1                  | Source Fields               |
        # And User scrollIntoView of "DropFields" in "expressionBuilder" screen
        # Then User implements conditions in execute area for below fields in "expressionBuilder" screen
        #     | Condition | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
        #     | IF        | 12       | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Destination Fields          | Source Fields               |
        # Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
        #     | Condition | Destinationfields      | Sourcefields |
        #     | IF        |                        | KNA1_KATR10  |
        #     | IF        | workOrderAuthorization | KNA1_KATR10  |

        # #Rule-13
        # And User scrollIntoView of "DropFields" in "expressionBuilder" screen
        # Then User add the below conditions in "expressionBuilder" screen
        #     | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType3 | OperatorTypeCount3 | ConditionType3OperatorType1 |
        #     | 3                  | 1                  | Conditions     | If                          | String         | 1                  | Is Not Empty                | Operands       | 1                  | Source Fields               |
        # And User scrollIntoView of "DropFields" in "expressionBuilder" screen
        # Then User implements conditions in execute area for below fields in "expressionBuilder" screen
        #     | Condition | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
        #     | IF        | 13       | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Destination Fields          | Source Fields               |
        # Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
        #     | Condition | Destinationfields    | Sourcefields |
        #     | IF        |                      | KNA1_KATR1   |
        #     | IF        | certificatesRequired | KNA1_KATR1   |

        Then User click on "Button" "Save" in "transformation" screen
        Then User click on "Button" "Close" in "transformation" screen
        # Then User click on "Button" "Save" in "tasks" screen

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName        | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
            | Task   | 700 | 300 | Review Response | Application Manager | 1           | Accept  | In Progress   | 1        | 0       |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X    | Y   |
            | End    | 1000 | 300 |

        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source          | Action  | Target          |
            | Start           |         | CreateRecord    |
            | CreateRecord    | Success | Review Response |
            | Review Response | Accept  | End             |

        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        Then User will "Logout" from "Page" the current session
        
        # Workflow
        And User wait for "60000"
        And User wait for "60000"
        And User wait for "60000"
        And User wait for "60000"
        And User wait for "60000"
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
        Then User click on "History" "TaskHistory" in "WorkFlow UI" screen
        Then User validates Tasks event and Action as "Success" in "WorkFlow UI" screen
            | Task         |
            | CreateRecord |
        Then User click on "Task" "My Task" in "WorkFlow UI" screen
        Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
        And User validate "Text Input" widget "KNA1_KTOKD" is not empty in "WorkFlow UI" screen
        And User validate "Text Input" widget "KNA1_NAME1" is not empty in "payload" screen
        And User validate "Text Input" widget "KNVV_FAKSD" is not empty in "payload" screen
        And User validate "Text Input" widget "ZE_KNVL_LICNR_1" is not empty in "payload" screen
        And User validate "Text Input" widget "KNA1_BRSCH" is not empty in "payload" screen
        Then User validate Task "1" Actions and select "Accept" action in "WorkFlow UI" screen

        Then User will "Logout" from "Page" the current session
