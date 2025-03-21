Feature:Enhanced use for Business rules with And OR ElseIf maximum operators covered-BO

  @ChildScript39 @ChildScript
  @enhanceBusinessRule
  #Createdby: Mohan S

  Scenario: Use case to cover maximum operators in Business rules with multiple widgets-BO
    Given user login to "Finlevit_admin" with "GroupAdmins" credentials
    And User get the Test data from "Usecase_TestData/ChildScript39" json file in "WorkFlow UI" screen
    Then User will open "GroupName" group in "HomePage" screen
    # To Create an Application
    Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
    Then User will search for "Application_Name" in "Application" screen
    And User wait for "2000"
    Then User see text "Front Office" in "FO" in "Page" screen
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget | X   | Y   | FieldName | FieldLabel | Action | Status |
      | Button | 550 | 150 | Submit    | Submit     | Submit | Save   |

    Then User click on "button" "CanvasSave" in "UniqueWidgetFields" screen
    Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
    Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
    Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget    | X  | Y  | FieldName          | Title               |
      | Container | 50 | 30 | HomeClassification | Home Classification |
    When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget              | X    | Y   |
      | Home Classification | 1100 | 975 |
    And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget      | X  | Y   | FieldName      | FieldLabel                                | ValuesAlignment    | ValueCount | Value1             | Value2    | Value3      |
      | Radio Group | 75 | 110 | TypeofProperty | What type of property are you purchasing? | ValueAlignVertical | 3          | Single Family Home | Town Home | Condominium |
    And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget      | X   | Y   | FieldName   | FieldLabel        | ValuesAlignment    | ValueCount | Value1       | Value2         | Value3          |
      | Radio Group | 500 | 110 | PropertyUse | Property Used As: | ValueAlignVertical | 3          | Primary Home | Secondary Home | Rental Property |

    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget     | X   | Y   | FieldName              | FieldLabel             |
      | Text Input | 800 | 110 | HomeType               | Home Type              |
      | Number     | 75  | 350 | EstimatedPurchasePrice | Purchase Price?        |
      | Number     | 500 | 350 | AnnualIncome           | Annual Income?         |
      | Number     | 800 | 350 | RequiredDownPayment    | Required Down Payment  |
      | Number     | 75  | 450 | CreditScore            | Estimated Credit Score |
      | Number     | 500 | 450 | Age                    | Age                    |
      | Text Input | 800 | 600 | PropertyTax            | Property Tax           |
      | Checkbox   | 500 | 600 | StateTaxineffect       | State Tax in effect?   |


    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget   | X  | Y   | FieldName     | FieldLabel      | OptionType    | ValueCount | Value1 | Value2 | Value3 | Value4 | Value5 |
      | Dropdown | 75 | 600 | PropertyState | Property State: | ManualOptions | 5          | AL     | NC     | SC     | VA     | CA     |

    # When User makes changes to "Purchase Price?" field format as in "UniqueWidgetFields" screen
    #   | TypeOfFormat | CurrencyCountry |
    #   | Currency     | United States   |

    # When User makes changes to "Annual Income?" field format as in "UniqueWidgetFields" screen
    #   | TypeOfFormat | CurrencyCountry |
    #   | Currency     | United States   |

    # When User makes changes to "Required Down Payment" field format as in "UniqueWidgetFields" screen
    #   | TypeOfFormat | CurrencyCountry |
    #   | Currency     | United States   |

    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget      | X   | Y   | FieldName         | FieldLabel         | ValuesAlignment      | ValueCount | Value1 | Value2 | Value3     |
      | Radio Group | 800 | 450 | AgeClassification | Age Classification | ValueAlignHorizontal | 3          | Major  | Minor  | Sr Citizen |

    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget      | X   | Y   | FieldName                       | FieldLabel             |
      | Date Picker | 50  | 800 | DateofApplication               | Date of Application    |
      | Date Picker | 450 | 800 | TentativeApplicationClosureDate | Tentative Closure Date |

    Then User click on "button" "Settings" in "frontOffice" screen
    Then User click on "button" "BusinessRules" in "expressionBuilder" screen
    Then User click on "button" "AddRule" in "expressionBuilder" screen

    #First Rule
    And User wait for "1000"
    Then User enter "HomeType" and choose the below trigger in "expressionBuilder" screen
      | Trigger        |
      | TypeofProperty |
      | PropertyUse    |
    #IF
    Then User add the below conditions in "expressionBuilder" screen
      | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType1OperatorType2 |
      | 1                  | 2                  | Conditions     | If                          | And                         |
    And User scrollIntoView of "Spacer" in "expressionBuilder" screen
    Then User add the functions in the "And" operator in "If" condition
      | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | DropField | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
      | 2                  | 1                  | Compare        | 1         | Equality                    | Operands       | 2                  | Payload Fields              | String Constant             |
      | 2                  | 1                  | Compare        | 1         | Equality                    | Operands       | 2                  | Payload Fields              | String Constant             |
    Then User implements conditions in execute area for below fields in "expressionBuilder" screen
      | Condition | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
      | IF        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Payload Fields              | String Constant             |
    Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
      | Condition | Payloadfields  | StringConstant             |
      | IF        | TypeofProperty | Single Family Home         |
      | IF        | PropertyUse    | Primary Home               |
      | IF        | HomeType       | Single Family Primary Home |
    # ELSEIF-1
    Then User add the below conditions in "expressionBuilder" screen
      | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType1OperatorType2 |
      | 1                  | 2                  | Conditions     | Else If                     | And                         |
    And User scrollIntoView of "Spacer" in "expressionBuilder" screen
    And User wait for "1000"
    Then User add the functions in the "And" operator in "Else If" condition
      | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | DropField | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
      | 2                  | 1                  | Compare        | 1         | Equality                    | Operands       | 2                  | Payload Fields              | String Constant             |
      | 2                  | 1                  | Compare        | 1         | Equality                    | Operands       | 2                  | Payload Fields              | String Constant             |
    Then User implements conditions in execute area for below fields in "expressionBuilder" screen
      | Condition | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
      | Else If   | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Payload Fields              | String Constant             |
    Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
      | Condition | Payloadfields  | StringConstant               |
      | Else If   | TypeofProperty | Single Family Home           |
      | Else If   | PropertyUse    | Secondary Home               |
      | Else If   | HomeType       | Single Family Secondary Home |
    # ELSEIF-2
    And User scrollIntoView of "Spacer" in "expressionBuilder" screen
    Then User add the below conditions in "expressionBuilder" screen
      | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType1OperatorType2 |
      | 1                  | 2                  | Conditions     | Else If                     | And                         |
    And User scrollIntoView of "Spacer" in "expressionBuilder" screen
    Then User add the functions in the "And" operator in "Else If" condition
      | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | DropField | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
      | 2                  | 1                  | Compare        | 1         | Equality                    | Operands       | 2                  | Payload Fields              | String Constant             |
      | 2                  | 1                  | Compare        | 1         | Equality                    | Operands       | 2                  | Payload Fields              | String Constant             |
    Then User implements conditions in execute area for below fields in "expressionBuilder" screen
      | Condition | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
      | Else If   | 2        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Payload Fields              | String Constant             |
    Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
      | Condition | Payloadfields  | StringConstant                |
      | Else If   | TypeofProperty | Single Family Home            |
      | Else If   | PropertyUse    | Rental Property               |
      | Else If   | HomeType       | Single Family Rental Property |
    # ELSEIF-3
    Then User add the below conditions in "expressionBuilder" screen
      | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType1OperatorType2 |
      | 1                  | 2                  | Conditions     | Else If                     | And                         |
    And User scrollIntoView of "Spacer" in "expressionBuilder" screen
    Then User add the functions in the "And" operator in "Else If" condition
      | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | DropField | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
      | 2                  | 1                  | Compare        | 1         | Equality                    | Operands       | 2                  | Payload Fields              | String Constant             |
      | 2                  | 1                  | Compare        | 1         | Equality                    | Operands       | 2                  | Payload Fields              | String Constant             |
    Then User implements conditions in execute area for below fields in "expressionBuilder" screen
      | Condition | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
      | Else If   | 3        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Payload Fields              | String Constant             |
    Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
      | Condition | Payloadfields  | StringConstant    |
      | Else If   | TypeofProperty | Town Home         |
      | Else If   | PropertyUse    | Primary Home      |
      | Else If   | HomeType       | Town Primary Home |
    # ELSEIF-4
    Then User add the below conditions in "expressionBuilder" screen
      | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType1OperatorType2 |
      | 1                  | 2                  | Conditions     | Else If                     | And                         |
    And User scrollIntoView of "Spacer" in "expressionBuilder" screen
    Then User add the functions in the "And" operator in "Else If" condition
      | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | DropField | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
      | 2                  | 1                  | Compare        | 1         | Equality                    | Operands       | 2                  | Payload Fields              | String Constant             |
      | 2                  | 1                  | Compare        | 1         | Equality                    | Operands       | 2                  | Payload Fields              | String Constant             |
    Then User implements conditions in execute area for below fields in "expressionBuilder" screen
      | Condition | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
      | Else If   | 4        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Payload Fields              | String Constant             |
    Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
      | Condition | Payloadfields  | StringConstant      |
      | Else If   | TypeofProperty | Town Home           |
      | Else If   | PropertyUse    | Secondary Home      |
      | Else If   | HomeType       | Town Secondary Home |
    # ELSEIF-5
    Then User add the below conditions in "expressionBuilder" screen
      | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType1OperatorType2 |
      | 1                  | 2                  | Conditions     | Else If                     | And                         |
    And User scrollIntoView of "Spacer" in "expressionBuilder" screen
    Then User add the functions in the "And" operator in "Else If" condition
      | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | DropField | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
      | 2                  | 1                  | Compare        | 1         | Equality                    | Operands       | 2                  | Payload Fields              | String Constant             |
      | 2                  | 1                  | Compare        | 1         | Equality                    | Operands       | 2                  | Payload Fields              | String Constant             |
    Then User implements conditions in execute area for below fields in "expressionBuilder" screen
      | Condition | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
      | Else If   | 5        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Payload Fields              | String Constant             |
    Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
      | Condition | Payloadfields  | StringConstant       |
      | Else If   | TypeofProperty | Town Home            |
      | Else If   | PropertyUse    | Rental Property      |
      | Else If   | HomeType       | Town Rental Property |
    # ELSEIF-6
    Then User add the below conditions in "expressionBuilder" screen
      | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType1OperatorType2 |
      | 1                  | 2                  | Conditions     | Else If                     | And                         |
    And User scrollIntoView of "Spacer" in "expressionBuilder" screen
    Then User add the functions in the "And" operator in "Else If" condition
      | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | DropField | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
      | 2                  | 1                  | Compare        | 1         | Equality                    | Operands       | 2                  | Payload Fields              | String Constant             |
      | 2                  | 1                  | Compare        | 1         | Equality                    | Operands       | 2                  | Payload Fields              | String Constant             |
    Then User implements conditions in execute area for below fields in "expressionBuilder" screen
      | Condition | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
      | Else If   | 6        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Payload Fields              | String Constant             |
    Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
      | Condition | Payloadfields  | StringConstant           |
      | Else If   | TypeofProperty | Condominium              |
      | Else If   | PropertyUse    | Primary Home             |
      | Else If   | HomeType       | Condominium Primary Home |
    # ELSEIF-7
    Then User add the below conditions in "expressionBuilder" screen
      | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType1OperatorType2 |
      | 1                  | 2                  | Conditions     | Else If                     | And                         |
    And User scrollIntoView of "Spacer" in "expressionBuilder" screen
    Then User add the functions in the "And" operator in "Else If" condition
      | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | DropField | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
      | 2                  | 1                  | Compare        | 1         | Equality                    | Operands       | 2                  | Payload Fields              | String Constant             |
      | 2                  | 1                  | Compare        | 1         | Equality                    | Operands       | 2                  | Payload Fields              | String Constant             |
    Then User implements conditions in execute area for below fields in "expressionBuilder" screen
      | Condition | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
      | Else If   | 7        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Payload Fields              | String Constant             |
    Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
      | Condition | Payloadfields  | StringConstant             |
      | Else If   | TypeofProperty | Condominium                |
      | Else If   | PropertyUse    | Secondary Home             |
      | Else If   | HomeType       | Condominium Secondary Home |
    # ELSEIF-8
    Then User add the below conditions in "expressionBuilder" screen
      | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType1OperatorType2 |
      | 1                  | 2                  | Conditions     | Else If                     | And                         |
    And User scrollIntoView of "Spacer" in "expressionBuilder" screen
    Then User add the functions in the "And" operator in "Else If" condition
      | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | DropField | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
      | 2                  | 1                  | Compare        | 1         | Equality                    | Operands       | 2                  | Payload Fields              | String Constant             |
      | 2                  | 1                  | Compare        | 1         | Equality                    | Operands       | 2                  | Payload Fields              | String Constant             |
    Then User implements conditions in execute area for below fields in "expressionBuilder" screen
      | Condition | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
      | Else If   | 8        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Payload Fields              | String Constant             |
    Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
      | Condition | Payloadfields  | StringConstant              |
      | Else If   | TypeofProperty | Condominium                 |
      | Else If   | PropertyUse    | Rental Property             |
      | Else If   | HomeType       | Condominium Rental Property |
    And User wait for "1000"
    Then User click on "button" "Save" in "expressionBuilder" screen
    And User should contain text "Saved Successfully" in "Pagelevel_alert_messgae" in "expressionBuilder" screen

    # SecondRule
    Then User click on "button" "AddRule" in "expressionBuilder" screen
    Then User enter "PropertyTax" and choose the below trigger in "expressionBuilder" screen
      | Trigger       |
      | PropertyState |
    # IF
    Then User add the below conditions in "expressionBuilder" screen
      | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType1OperatorType2 |
      | 1                  | 2                  | Conditions     | If                          | Or                          |
    And User scrollIntoView of "Spacer" in "expressionBuilder" screen
    Then User add the functions in the "OR" operator in "If" condition
      | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | DropField | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
      | 2                  | 1                  | Compare        | 1         | Equality                    | Operands       | 2                  | Payload Fields              | String Constant             |
      | 2                  | 1                  | Compare        | 1         | Equality                    | Operands       | 2                  | Payload Fields              | String Constant             |
    And User scrollIntoView of "Spacer" in "expressionBuilder" screen
    Then User implements conditions in execute area for below fields in "expressionBuilder" screen
      | Condition | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
      | IF        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Payload Fields              | String Constant             |
      | IF        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Payload Fields              | Boolean Constant            |
    Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
      | Condition | Payloadfields    | StringConstant | BooleanConstant |
      | IF        | PropertyState    | NC             |                 |
      | IF        | PropertyState    | SC             |                 |
      | IF        | PropertyTax      | 7.11           |                 |
      | IF        | StateTaxineffect |                | True            |
    # ElseIf1
    And User scrollIntoView of "Spacer" in "expressionBuilder" screen
    Then User add the below conditions in "expressionBuilder" screen
      | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType3 | OperatorTypeCount3 | ConditionType3OperatorType1 | ConditionType3OperatorType2 |
      | 3                  | 1                  | Conditions     | Else If                     | Compare        | 1                  | Equality                    | Operands       | 2                  | Payload Fields              | String Constant             |
    And User scrollIntoView of "Spacer" in "expressionBuilder" screen
    Then User implements conditions in execute area for below fields in "expressionBuilder" screen
      | Condition | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
      | Else If   | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Payload Fields              | String Constant             |
      | Else If   | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Payload Fields              | Boolean Constant            |
    And User scrollIntoView of "Spacer" in "expressionBuilder" screen
    Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
      | Condition | Payloadfields    | StringConstant | BooleanConstant |
      | Else If   | PropertyState    | AL             |                 |
      | Else If   | PropertyTax      | 8.78           |                 |
      | Else If   | StateTaxineffect |                | True            |
    # ElseIf2
    And User scrollIntoView of "Spacer" in "expressionBuilder" screen
    Then User add the below conditions in "expressionBuilder" screen
      | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType3 | OperatorTypeCount3 | ConditionType3OperatorType1 | ConditionType3OperatorType2 |
      | 3                  | 1                  | Conditions     | Else If                     | Compare        | 1                  | Equality                    | Operands       | 2                  | Payload Fields              | String Constant             |
    Then User implements conditions in execute area for below fields in "expressionBuilder" screen
      | Condition | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
      | Else If   | 2        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Payload Fields              | String Constant             |
      | Else If   | 2        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Payload Fields              | Boolean Constant            |
    And User scrollIntoView of "Spacer" in "expressionBuilder" screen
    Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
      | Condition | Payloadfields    | StringConstant | BooleanConstant |
      | Else If   | PropertyState    | VA             |                 |
      | Else If   | PropertyTax      | 9.54           |                 |
      | Else If   | StateTaxineffect |                | True            |
    # ElseIf3
    And User scrollIntoView of "Spacer" in "expressionBuilder" screen
    Then User add the below conditions in "expressionBuilder" screen
      | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType3 | OperatorTypeCount3 | ConditionType3OperatorType1 | ConditionType3OperatorType2 |
      | 3                  | 1                  | Conditions     | Else If                     | Compare        | 1                  | Equality                    | Operands       | 2                  | Payload Fields              | String Constant             |
    Then User implements conditions in execute area for below fields in "expressionBuilder" screen
      | Condition | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
      | Else If   | 3        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Payload Fields              | String Constant             |
      | Else If   | 3        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Payload Fields              | Boolean Constant            |
    And User scrollIntoView of "Spacer" in "expressionBuilder" screen
    Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
      | Condition | Payloadfields    | StringConstant | BooleanConstant |
      | Else If   | PropertyState    | CA             |                 |
      | Else If   | PropertyTax      | 12.22          |                 |
      | Else If   | StateTaxineffect |                | False           |
    And User wait for "1000"
    Then User click on "button" "Save" in "expressionBuilder" screen

    #ThirdRule
    Then User click on "button" "AddRule" in "expressionBuilder" screen
    Then User enter "DownPayment" and choose the below trigger in "expressionBuilder" screen
      | Trigger                |
      | EstimatedPurchasePrice |
      | AnnualIncome           |
    # IF
    And User scrollIntoView of "Spacer" in "expressionBuilder" screen
    Then User add the below conditions in "expressionBuilder" screen
      | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType1OperatorType2 |
      | 1                  | 2                  | Conditions     | If                          | And                         |
    Then User add the functions in the "And" operator in "If" condition
      | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | DropField | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
      | 2                  | 1                  | Compare        | 1         | Greater Than                | Operands       | 2                  | Payload Fields              | Number Constant             |
      | 2                  | 1                  | Compare        | 1         | Less Than                   | Operands       | 2                  | Payload Fields              | Number Constant             |
    And User scrollIntoView of "Spacer" in "expressionBuilder" screen
    Then User implements conditions in execute area for below fields in "expressionBuilder" screen
      | Condition | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
      | IF        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Payload Fields              | Number Constant             |
    And User scrollIntoView of "Spacer" in "expressionBuilder" screen
    Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
      | Condition | Payloadfields          | NumberConstant |
      | IF        | EstimatedPurchasePrice | 1000000        |
      | IF        | AnnualIncome           | 250000         |
      | IF        | RequiredDownPayment    | 100000         |
    #ELSE IF
    And User wait for "2000"
    And User scrollIntoView of "Spacer" in "expressionBuilder" screen
    Then User add the below conditions in "expressionBuilder" screen
      | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType1OperatorType2 |
      | 1                  | 2                  | Conditions     | Else If                     | And                         |
    And User scrollIntoView of "Spacer" in "expressionBuilder" screen
    Then User add the functions in the "And" operator in "Else If" condition
      | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | DropField | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
      | 2                  | 1                  | Compare        | 1         | Less Than                   | Operands       | 2                  | Payload Fields              | Number Constant             |
      | 2                  | 1                  | Compare        | 1         | Greater Than                | Operands       | 2                  | Payload Fields              | Number Constant             |
    And User scrollIntoView of "Spacer" in "expressionBuilder" screen
    Then User implements conditions in execute area for below fields in "expressionBuilder" screen
      | Condition | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
      | Else If   | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Payload Fields              | Number Constant             |
    And User scrollIntoView of "Spacer" in "expressionBuilder" screen
    Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
      | Condition | Payloadfields          | NumberConstant |
      | Else If   | EstimatedPurchasePrice | 1000000        |
      | Else If   | AnnualIncome           | 250000         |
      | Else If   | RequiredDownPayment    | 50000          |
    And User wait for "1000"
    Then User click on "button" "Save" in "expressionBuilder" screen


    #BusinessRule-4
    Then User click on "button" "AddRule" in "expressionBuilder" screen
    Then User enter "AgeClassification" and choose the below trigger in "expressionBuilder" screen
      | Trigger |
      | Age     |

    # IF
    And User scrollIntoView of "Spacer" in "expressionBuilder" screen
    Then User add the below conditions in "expressionBuilder" screen
      | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType3 | OperatorTypeCount3 | ConditionType3OperatorType1 | ConditionType3OperatorType2 |
      | 3                  | 1                  | Conditions     | If                          | Compare        | 1                  | LTE                         | Operands       | 2                  | Payload Fields              | Number Constant             |
    Then User implements conditions in execute area for below fields in "expressionBuilder" screen
      | Condition | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
      | IF        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Payload Fields              | String Constant             |
    Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
      | Condition | Payloadfields     | NumberConstant | StringConstant |
      | IF        | Age               | 18             |                |
      | IF        | AgeClassification |                | Minor          |

    #ELSE IF
    And User scrollIntoView of "Spacer" in "expressionBuilder" screen
    Then User add the below conditions in "expressionBuilder" screen
      | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType1OperatorType2 |
      | 1                  | 2                  | Conditions     | Else If                     | And                         |
    And User scrollIntoView of "Spacer" in "expressionBuilder" screen
    Then User add the functions in the "And" operator in "Else If" condition
      | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | DropField | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
      | 2                  | 1                  | Compare        | 1         | GTE                         | Operands       | 2                  | Payload Fields              | Number Constant             |
      | 2                  | 1                  | Compare        | 1         | Less Than                   | Operands       | 2                  | Payload Fields              | Number Constant             |
    Then User implements conditions in execute area for below fields in "expressionBuilder" screen
      | Condition | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
      | Else If   | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Payload Fields              | String Constant             |
    Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
      | Condition | Payloadfields     | NumberConstant | StringConstant |
      | Else If   | Age               | 18             |                |
      | Else If   | Age               | 60             |                |
      | Else If   | AgeClassification |                | Major          |


    #ELSE IF
    And User scrollIntoView of "Spacer" in "expressionBuilder" screen
    Then User add the below conditions in "expressionBuilder" screen
      | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType3 | OperatorTypeCount3 | ConditionType3OperatorType1 | ConditionType3OperatorType2 |
      | 3                  | 1                  | Conditions     | Else If                     | Compare        | 1                  | GTE                         | Operands       | 2                  | Payload Fields              | Number Constant             |
    Then User implements conditions in execute area for below fields in "expressionBuilder" screen
      | Condition | DropArea | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
      | Else If   | 2        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Payload Fields              | String Constant             |
    Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
      | Condition | Payloadfields     | NumberConstant | StringConstant |
      | Else If   | Age               | 60             |                |
      | Else If   | AgeClassification |                | Sr Citizen     |
    Then User click on "button" "Save" in "expressionBuilder" screen
    And User wait for "1000"

    # # BusinessRule-5
    # Then User click on "button" "AddRule" in "expressionBuilder" screen
    # Then User enter "DateofApplication" and choose the below trigger in "expressionBuilder" screen
    #   | Trigger           |
    #   | DateofApplication |
    # # IF

    # Then User add the below conditions in "expressionBuilder" screen
    #   | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType3 | OperatorTypeCount3 | ConditionType3OperatorType1 | ConditionType3OperatorType2 |
    #   | 3                  | 1                  | Conditions     | If                          | Compare        | 1                  | Greater Than                | Operands       | 2                  | Payload Fields              | Date Constant               |
    # And User scrollIntoView of "Spacer" in "expressionBuilder" screen
    # Then User implements conditions in execute area for below fields in "expressionBuilder" screen
    #   | Condition | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
    #   | IF        | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Payload Fields              | Date Constant               |
    # Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
    #   | Condition | Payloadfields                   | DateConstant |
    #   | IF        | DateofApplication               | 03/08/2023   |
    #   | IF        | TentativeApplicationClosureDate | 03/08/2024   |
    # Then User click on "button" "Save" in "expressionBuilder" screen
    And User wait until the toast message disappears
    Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
    Then User click on "tab" "Workflow Design" in "backOffice" screen
    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
      | Widget | X   | Y   |
      | Start  | 150 | 225 |
    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
      | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status |
      | Task   | 400 | 150 | Review   | Application Manager | 1           | Accept  | In Progress   |

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

    Given user login to payload application with "Finlevit_payload" with "1" agent
    And User wait for "5000"
    Then User click on "button" "Submit_btn" in "payload" screen
    And User get Transaction Id and save it in json file

    Given user login to workflow UI "Finlevit_workflow" with "1" "AppManager" credentials
    And User wait until the "Filter Transaction id" appears in "WorkFlow UI" screen
    Then User click on "Button" "Home" in "HomePage" screen
    Then User will open "GroupName" group in "HomePage" screen
    Then User will search for "Application_Name" in "Application" screen
    And User wait for "5000"
    And As "Agent" user verify Task "1" Details under "Team Task" in "WorkFlow UI" screen
    Then Based on the Task assigned to person logout or continue with the same user in "WorkFlow UI" screen for "Application_Name"
    And As "Application Manager" user verify Task "1" Details under "My Task" in "WorkFlow UI" screen
    Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen

    Then User validate Business rules for Home Type in "payload" screen
      | WidgetName1        | WidgetName2      | WidgetName3                   |
      | type of property   | Property Used As | Home Type                     |
      | Single Family Home | Primary Home     | Single Family Primary Home    |
      | Single Family Home | Secondary Home   | Single Family Secondary Home  |
      | Single Family Home | Rental Property  | Single Family Rental Property |
      | Town Home          | Primary Home     | Town Primary Home             |
      | Town Home          | Secondary Home   | Town Secondary Home           |
      | Town Home          | Rental Property  | Town Rental Property          |
      | Condominium        | Primary Home     | Condominium Primary Home      |
      | Condominium        | Secondary Home   | Condominium Secondary Home    |
      | Condominium        | Rental Property  | Condominium Rental Property   |

    Then User validate Business rules for DownPayment in "payload" screen
      | WidgetName1    | WidgetName2   | WidgetName3           |
      | Purchase Price | Annual Income | Required Down Payment |
      | 1000001        | 249999        | 100000                |
      | 999999         | 250001        | 50000                 |

    Then User validate Business rules for Age Classification in "payload" screen
      | WidgetName1 | WidgetName2        |
      | Age         | Age Classification |
      | 18          | Minor              |
      | 17          | Minor              |
      | 59          | Major              |
      | 60          | Sr Citizen         |
      | 61          | Sr Citizen         |

    Then User validate Business rules for Property Tax in "payload" screen
      | WidgetName1    | WidgetName2  | WidgetName3         |
      | Property State | Property Tax | State Tax in effect |
      | CA             | 12.22        | false               |
      | NC             | 7.11         | true                |
      | SC             | 7.11         | true                |
      | AL             | 8.78         | true                |
      | VA             | 9.54         | true                |



    # Then User validate Business rules for Application Date in "payload" screen
    #   | WidgetName1         | WidgetName2            |
    #   | Date of Application | Tentative Closure Date |
    #   | 03/08/2023          |                        |
    #   | 03/09/2023          | 03/08/2024             |
    And User Fill "729" in "Text Input" widget "Estimated Credit Score" in "payload" screen
    Then User click on "DOA" "Date of Application" in "payload" screen
    Then User validate Task "1" Actions and select "Accept" action in "WorkFlow UI" screen
    And User wait for "1000"
    Then User will "Logout" from "Page" the current session

