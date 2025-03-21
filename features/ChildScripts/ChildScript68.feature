Feature: App with Business Rules
    @ChildScript68 @ChildScript
    @BusinessRules
    #Createdby: Mohan S

    Scenario: Use case to cover Business rules with simple use case
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "Usecase_TestData/ChildScript68" json file in "WorkFlow UI" screen
        Then User will open "GroupName" group in "HomePage" screen
        # To Create an Application
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "1000"

        # widget
        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName   | FieldLabel  | OptionType    | ValueCount | Value1 | Value2 |
            | Dropdown   | 200 | 350 | States      | States      | ManualOptions | 2          | AP     | TN     |
            | Text Input | 450 | 350 | CapitalCity | CapitalCity |               |            |        |        |
        Then User click on "Button" "CanvasSave" in "UniqueWidgetFields" screen

        Then User click on "button" "Settings" in "frontOffice" screen
        Then User click on "button" "BusinessRules" in "expressionBuilder" screen
        Then User click on "button" "AddRule" in "expressionBuilder" screen

        And User wait for "1000"
        Then User enter "State" and choose the below trigger in "expressionBuilder" screen
            | Trigger |
            | States  |


        # IF
        Then User add the below conditions in "expressionBuilder" screen
            | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType3 | OperatorTypeCount3 | ConditionType3OperatorType1 | ConditionType3OperatorType2 |
            | 3                  | 1                  | Conditions     | If                          | Compare        | 1                  | Equality                    | Operands       | 2                  | Payload Fields              | String Constant             |

        Then User implements conditions in execute area for below fields in "expressionBuilder" screen
            | Condition | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
            | IF        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Payload Fields              | String Constant             |


        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | Condition | Payloadfields | StringConstant |
            | IF        | States        | TN             |
            | IF        | CapitalCity   | Chennai        |

        # ElseIf
        Then User add the below conditions in "expressionBuilder" screen
            | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType3 | OperatorTypeCount3 | ConditionType3OperatorType1 | ConditionType3OperatorType2 |
            | 3                  | 1                  | Conditions     | Else If                     | Compare        | 1                  | Equality                    | Operands       | 2                  | Payload Fields              | String Constant             |

        Then User implements conditions in execute area for below fields in "expressionBuilder" screen
            | Condition | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
            | Else If   | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Payload Fields              | String Constant             |

        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | Condition | Payloadfields | StringConstant |
            | Else If   | States        | AP             |
            | Else If   | CapitalCity   | Hyderabad      |


        And User wait for "1000"
        Then User click on "button" "Save" in "expressionBuilder" screen
        And User should contain text "Saved Successfully" in "Pagelevel_alert_messgae" in "expressionBuilder" screen
        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 150 | 225 |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
            | Task   | 400 | 150 | Review   | Application Manager | 1           | Accept  | In Progress   | 1        | 0       |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | End    | 950 | 225 |
        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source | Action | Target |
            | Start  |        | Review |
            | Review | Accept | End    |

        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        #  To validate Preview
        And User validate Payload app opening in a new tab
        # Payload
        Given user login to payload application with "Finlevit_payload" with "1" agent
        And User select drop down option "TN" in "States" widget in "payload" screen
        And User wait for "2000"
        And User wait until the spinner disappears
        When User Widget should have attribute "ng-reflect-model" value of "Chennai" in "CapitalCity" in "PayloadValidate" screen
        And User select drop down option "AP" in "States" widget in "payload" screen
        And User wait for "2000"
        And User wait until the spinner disappears
        When User Widget should have attribute "ng-reflect-model" value of "Hyderabad" in "CapitalCity" in "PayloadValidate" screen










