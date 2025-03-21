Feature: Business Rules

    @BusinessRuleAdminApp @BusinessRule
    Scenario: Build an app in Konfig admin to validate the Business Rules functionality in Front Office and Back Office
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "Usecase_TestData/BusinessRulePOC" json file in "WorkFlow UI" screen
        Then User will open "GroupName" group in "HomePage" screen
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X  | Y  | FieldName          | Title               |
            | Container | 50 | 30 | HomeClassification | Home Classification |
        When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget              | X    | Y   |
            | Home Classification | 1100 | 275 |
        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget      | X  | Y   | FieldName      | FieldLabel                                | ValuesAlignment    | ValueCount | Value1             | Value2    | Value3      |
            | Radio Group | 75 | 110 | TypeofProperty | What type of property are you purchasing? | ValueAlignVertical | 3          | Single Family Home | Town Home | Condominium |
        When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget                                    | X   | Y   |
            | What type of property are you purchasing? | 450 | 235 |

        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget      | X   | Y   | FieldName   | FieldLabel        | ValuesAlignment    | ValueCount | Value1       | Value2         | Value3          |
            | Radio Group | 500 | 110 | PropertyUse | Property Used As: | ValueAlignVertical | 3          | Primary Home | Secondary Home | Rental Property |

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X  | Y   | FieldName | Title                  |
            | Container | 50 | 300 | Finance   | Finance Classification |

        When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget                 | X    | Y   |
            | Finance Classification | 1100 | 725 |

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName              | FieldLabel             |
            | Text Input | 800 | 110 | HomeType               | Home Type              |
            | Text Input | 800 | 625 | PropertyTax            | Property Tax           |
            | Checkbox   | 500 | 625 | StateTaxineffect       | State Tax in effect?   |
            | Number     | 75  | 375 | EstimatedPurchasePrice | Purchase Price?        |
            | Number     | 500 | 375 | AnnualIncome           | Annual Income?         |
            | Number     | 800 | 375 | RequiredDownPayment    | Required Down Payment  |
            | Number     | 75  | 475 | CreditScore            | Estimated Credit Score |
            | Number     | 500 | 475 | Age                    | Age                    |

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget   | X  | Y   | FieldName     | FieldLabel      | OptionType    | ValueCount | Value1 | Value2 | Value3 | Value4 | Value5 |
            | Dropdown | 75 | 625 | PropertyState | Property State: | ManualOptions | 5          | AL     | NC     | SC     | VA     | CA     |

        When User makes changes to "Purchase Price?" field format as in "UniqueWidgetFields" screen
            | TypeOfFormat | CurrencyCountry |
            | Currency     | United States   |

        When User makes changes to "Annual Income?" field format as in "UniqueWidgetFields" screen
            | TypeOfFormat | CurrencyCountry |
            | Currency     | United States   |

        When User makes changes to "Required Down Payment" field format as in "UniqueWidgetFields" screen
            | TypeOfFormat | CurrencyCountry |
            | Currency     | United States   |

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget      | X   | Y   | FieldName         | FieldLabel         | ValuesAlignment      | ValueCount | Value1 | Value2 | Value3     |
            | Radio Group | 800 | 475 | AgeClassification | Age Classification | ValueAlignHorizontal | 3          | Major  | Minor  | Sr Citizen |

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget      | X  | Y   | FieldName         | FieldLabel          |
            | Date Picker | 50 | 825 | DateofApplication | Date of Application |

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X   | Y   | FieldName | FieldLabel | Action | Status |
            | Button | 400 | 825 | Submit    | Submit     | Submit | Save   |

        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen

        Then User click on "span" "Save" in "Page" screen
        Then User click on "button" "Settings" in "Page" screen
        Then User click on "menu" "businessRulesMenu" in "BusinessRules" screen
        # Set Business rule 1 for Home Type
        And User create Business Rules with "If" Condition and name it as "Home Type" in "BusinessRules" screen
            | FilterCondition | IfCount | IfFields1      | IfCondition1 | IfValue1           | IfFields2   | IfCondition2 | IfValue2     | ThenCount | ThenField1 | ThenValue1                 |
            | 1&&2            | 2       | TypeofProperty | Equals       | Single Family Home | PropertyUse | Equals       | Primary Home | 1         | HomeType   | Single Family Primary Home |
        And User create Business Rules with "Else" Condition in "BusinessRules" screen
            | FilterCondition | ElseCount | ElseFields1    | ElseCondition1 | ElseValue1         | ElseFields2    | ElseCondition2 | ElseValue2      | ThenCount | ThenField1 | ThenValue1                    |
            | 1&&2            | 2         | TypeofProperty | Equals         | Single Family Home | PropertyUse    | Equals         | Secondary Home  | 1         | HomeType   | Single Family Secondary Home  |
            | 1&&2            | 2         | TypeofProperty | Equals         | Single Family Home | PropertyUse    | Equals         | Rental Property | 1         | HomeType   | Single Family Rental Property |
            | 1&&2            | 2         | PropertyUse    | Equals         | Primary Home       | TypeofProperty | Equals         | Townhome        | 1         | HomeType   | Townhome Primary              |
            | 1&&2            | 2         | TypeofProperty | Equals         | Townhome           | PropertyUse    | Equals         | Secondary Home  | 1         | HomeType   | Townhome Secondary            |
            | 1&&2            | 2         | TypeofProperty | Equals         | Townhome           | PropertyUse    | Equals         | Rental Property | 1         | HomeType   | Townhome Rental               |
            | 1&&2            | 2         | TypeofProperty | Equals         | Condominium        | PropertyUse    | Equals         | Primary Home    | 1         | HomeType   | Condominium Primary Home      |
            | 1&&2            | 2         | TypeofProperty | Equals         | Condominium        | PropertyUse    | Equals         | Secondary Home  | 1         | HomeType   | Condominium Secondary Home    |
            | 1&&2            | 2         | TypeofProperty | Equals         | Condominium        | PropertyUse    | Equals         | Rental Property | 1         | HomeType   | Condominium Rental Home       |
        And User save Business Rules in "BusinessRules" screen
        # Set Business rule 2 for Property Tax
        And User create Business Rules with "If" Condition and name it as "Property Tax" in "BusinessRules" screen
            | FilterCondition | IfCount | IfFields1     | IfCondition1 | IfValue1 | IfFields2     | IfCondition2 | IfValue2 | ThenCount | ThenField1  | ThenValue1 | ThenField2       | ThenValue2 |
            | 1\|\|2          | 2       | PropertyState | Equals       | NC       | PropertyState | Equals       | SC       | 2         | PropertyTax | 7.11       | StateTaxineffect | true       |
        And User create Business Rules with "Else" Condition in "BusinessRules" screen
            | FilterCondition | ElseCount | ElseFields1   | ElseCondition1 | ElseValue1 | ThenCount | ThenField1  | ThenValue1 | ThenField2       | ThenValue2 |
            | 1               | 1         | PropertyState | Equals         | AL         | 2         | PropertyTax | 8.78       | StateTaxineffect | true       |
            | 1               | 1         | PropertyState | Equals         | VA         | 2         | PropertyTax | 9.54       | StateTaxineffect | true       |
            | 1               | 1         | PropertyState | Equals         | CA         | 2         | PropertyTax | 12.22      | StateTaxineffect | false      |
        And User save Business Rules in "BusinessRules" screen
        # Set Business rule 2 for DownPayment
        And User create Business Rules with "If" Condition and name it as "DownPayment" in "BusinessRules" screen
            | FilterCondition | IfCount | IfFields1              | IfCondition1        | IfValue1 | IfFields2    | IfCondition2 | IfValue2 | ThenCount | ThenField1          | ThenValue1 |
            | 1&&2            | 2       | EstimatedPurchasePrice | Greater than equals | 1000000  | AnnualIncome | Less than    | 250000   | 1         | RequiredDownPayment | 100000     |
        And User create Business Rules with "Else" Condition in "BusinessRules" screen
            | FilterCondition | ElseCount | ElseFields1            | ElseCondition1 | ElseValue1 | ElseFields2  | ElseCondition2      | ElseValue2 | ThenCount | ThenField1          | ThenValue1 |
            | 1&&2            | 2         | EstimatedPurchasePrice | Less than      | 1000000    | AnnualIncome | Greater than equals | 250000     | 1         | RequiredDownPayment | 50000      |
        And User save Business Rules in "BusinessRules" screen
        # Set Business rule 2 for Age Classification
        And User create Business Rules with "If" Condition and name it as "Age Classification" in "BusinessRules" screen
            | FilterCondition | IfCount | IfFields1 | IfCondition1     | IfValue1 | ThenCount | ThenField1        | ThenValue1 |
            | 1               | 1       | Age       | Less than equals | 18       | 1         | AgeClassification | Minor      |
        And User create Business Rules with "Else" Condition in "BusinessRules" screen
            | FilterCondition | ElseCount | ElseFields1 | ElseCondition1      | ElseValue1 | ElseFields2 | ElseCondition2 | ElseValue2 | ThenCount | ThenField1        | ThenValue1 |
            | 1&&2            | 2         | Age         | Greater than        | 18         | Age         | Less than      | 60         | 1         | AgeClassification | Major      |
            | 1               | 1         | Age         | Greater than equals | 60         |             |                |            | 1         | AgeClassification | Sr Citizen |
        And User save Business Rules in "BusinessRules" screen
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget             | X  | Y   |
            | HomeClassification | 50 | 10  |
            | Finance            | 50 | 350 |
            | DateofApplication  | 50 | 825 |
        Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
        And User scroll to an element "Date of Application" in "UniqueWidgetFields" screen
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget      | X   | Y   | FieldName   | FieldLabel   | ValuesAlignment      | ValueCount | Value1    | Value2       | Value3   |
            | Radio Group | 750 | 825 | RiskProfile | Risk Profile | ValueAlignHorizontal | 3          | Agressive | Conservative | Moderate |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget      | X   | Y   | FieldName                       | FieldLabel              |
            | Date Picker | 450 | 825 | TentativeApplicationClosureDate | Tentative Closure Date  |
            | Text Input  | 50  | 950 | Interest Amount                 | BO Interest Rate        |
            | TextInput   | 450 | 950 | ApprovalStatus                  | BO Loan Approval Status |
        Then User click on "span" "Save" in "Page" screen
        Then User click on "button" "Settings" in "Page" screen
        Then User click on "menu" "businessRulesMenu" in "BusinessRules" screen
        And User validate only BO fields are listed under select fields dropdown in "BusinessRules" screen
            | FieldName                       |
            | RiskProfile                     |
            | TentativeApplicationClosureDate |
            | Interest Amount                 |
        # Set Business rule 1 for Risk Profile
        And User create Business Rules with "If" Condition and name it as "Risk Profile" in "BusinessRules" screen
            | FilterCondition | IfCount | IfFields1   | IfCondition1 | IfValue1 | IfFields2 | IfCondition2 | IfValue2 | ThenCount | ThenField1  | ThenValue1 |
            | 1&&2            | 2       | CreditScore | Greater than | 730      | Age       | Less than    | 50       | 1         | RiskProfile | Moderate   |
        And User create Business Rules with "Else" Condition in "BusinessRules" screen
            | FilterCondition | ElseCount | ElseFields1 | ElseCondition1 | ElseValue1 | ElseFields2 | ElseCondition2      | ElseValue2 | ThenCount | ThenField1  | ThenValue1   |
            | 1&&2            | 2         | CreditScore | Greater than   | 730        | Age         | Greater than equals | 50         | 1         | RiskProfile | Agressive    |
            | 1&&2            | 2         | CreditScore | Less than      | 730        | Age         | Less than           | 50         | 1         | RiskProfile | Agressive    |
            | 1&&2            | 2         | CreditScore | Less than      | 730        | Age         | Greater than        | 50         | 1         | RiskProfile | Conservative |
        And User save Business Rules in "BusinessRules" screen
        # Set Business rule 2 for Application Date
        And User create Business Rules with "If" Condition and name it as "Application Date" in "BusinessRules" screen
            | FilterCondition | IfCount | IfFields1         | IfCondition1 | IfValue1   | ThenCount | ThenField1                      | ThenValue1 |
            | 1               | 1       | DateofApplication | Greater than | 03/08/2023 | 1         | TentativeApplicationClosureDate | 03/08/2024 |
        And User save Business Rules in "BusinessRules" screen
        # Set Business rule 1 for Interest Amount
        And User create Business Rules with "If" Condition and name it as "Interest Amount" in "BusinessRules" screen
            | FilterCondition | IfCount | IfFields1         | IfCondition1 | IfValue1 | IfFields2   | IfCondition2 | IfValue2 | ThenCount | ThenField1      | ThenValue1 |
            | 1&&2            | 2       | AgeClassification | Equals       | Minor    | RiskProfile | Contains     | Moderate | 1         | Interest Amount | 8%         |
        And User create Business Rules with "Else" Condition in "BusinessRules" screen
            | FilterCondition | ElseCount | ElseFields1       | ElseCondition1 | ElseValue1 | ElseFields2 | ElseCondition2 | ElseValue2   | ThenCount | ThenField1      | ThenValue1 |
            | 1&&2            | 2         | AgeClassification | Equals         | Minor      | RiskProfile | Contains       | Agressive    | 1         | Interest Amount | 10%        |
            | 1&&2            | 2         | AgeClassification | Equals         | Minor      | RiskProfile | Contains       | Conservative | 1         | Interest Amount | 7%         |
            | 1&&2            | 2         | AgeClassification | Equals         | Major      | RiskProfile | Contains       | Agressive    | 1         | Interest Amount | 11%        |
            | 1&&2            | 2         | AgeClassification | Equals         | Major      | RiskProfile | Contains       | Conservative | 1         | Interest Amount | 9%         |
            | 1&&2            | 2         | AgeClassification | Equals         | Major      | RiskProfile | Contains       | Moderate     | 1         | Interest Amount | 10%        |
            | 1&&2            | 2         | AgeClassification | Equals         | Sr Citizen | RiskProfile | Contains       | Conservative | 1         | Interest Amount | 4%         |
            | 1&&2            | 2         | AgeClassification | Equals         | Sr Citizen | RiskProfile | Contains       | Agressive    | 1         | Interest Amount | 6%         |
            | 1&&2            | 2         | AgeClassification | Equals         | Sr Citizen | RiskProfile | Contains       | Moderate     | 1         | Interest Amount | 5%         |

        And User save Business Rules in "BusinessRules" screen
        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 150 | 250 |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status | Action2 | Action2Status |
            | Task   | 300 | 300 | Review   | Application Manager | 2           | Accept  | In Progress   | Reject  | In Progress   |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | End    | 500 | 400 |
        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source | Action | Target |
            | Start  |        | Review |
            | Review | Accept | End    |
            | Review | Reject | End    |

        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        And User validate Payload app opening in a new tab
        Then User will "Logout" from "Page" the current session
        And User wait for "5000"
        # Business rule payload validation
        Given user login to payload application with "Finlevit_payload" with "1" agent
        And User wait for "5000"
        Then User validate Business rules for Home Type in "payload" screen
        | WidgetName1        |WidgetName2       |WidgetName3    |
        | type of property   |Property Used As  |Home Type|
        |Single Family Home  |Primary Home      |Single Family Primary Home|
        |Single Family Home  |Secondary Home    |Single Family Secondary Home|
        |Single Family Home  |Rental Property   |Single Family Rental Property|
        # |Town Home           |Primary Home      |Townhome Primary |
        # |Town Home           |Secondary Home    |Townhome Secondary |
        # |Town Home           |Rental Property   |Townhome Rental|
        # |Condominium         |Primary Home      |Condominium Primary Home|
        # |Condominium         |Secondary Home    |Condominium Secondary Home|
        # |Condominium         |Rental Property   |Condominium Rental Home|

        Then User validate Business rules for Property Tax in "payload" screen
            | WidgetName1    | WidgetName2  | WidgetName3         |
            | Property State | Property Tax | State Tax in effect |
            # | CA                 |12.22            |false               |
            | NC             | 7.11         | true                |
            | SC             | 7.11         | true                |
            | AL             | 8.78         | true                |
            | VA             | 9.54         | true                |

        Then User validate Business rules for DownPayment in "payload" screen
            | WidgetName1    | WidgetName2   | WidgetName3           |
            | Purchase Price | Annual Income | Required Down Payment |
            | 1000001        | 249999        | 100000                |
        # | 999999                       |250001            |50000                |

        Then User validate Business rules for Age Classification in "payload" screen
            | WidgetName1 | WidgetName2        |
            | Age         | Age Classification |
            | 18          | Minor              |
            | 17          | Minor              |
            | 59          | Major              |
            | 60          | Sr Citizen         |
            | 61          | Sr Citizen         |
        And User Fill "729" in "Text Input" widget "Estimated Credit Score" in "payload" screen
        Then User click on "DOA" "Date of Application" in "payload" screen
        And User enter text "03/09/2023" in "Date of Application" in "payload" screen
        Then User click on "button" "Submit_btn" in "payload" screen
        And User get Transaction Id and save it in json file

        # Business Rule workflow UI validation
        Given user login to workflow UI "Finlevit_workflow" with "1" "AppManager" credentials
        Then User will open "GroupName" group in "HomePage" screen
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "8000"
        And User validate Transaction table header under "Team Task" in "WorkFlow UI" screen
        | SLA | Transaction Id | Task Name | Priority | Created At | Submitted By | Last Updated By | Last Updated At | Assigned To |
        And As "Agent" user verify Task "1" Details under "Team Task" in "WorkFlow UI" screen
    Then Based on the Task assigned to person logout or continue with the same user in "WorkFlow UI" screen for "Application_Name"
        And User validate Transaction table header under "My Task" in "WorkFlow UI" screen
        | SLA | Transaction Id | Task Name | Priority | Created At | Submitted By | Last Updated By | Last Updated At | Assigned To |
        And As "Application Manager" user verify Task "1" Details under "My Task" in "WorkFlow UI" screen
        Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
        And User validate left side menu options for the Task in "WorkFlow UI" screen
        # And User should see all the "Back office" fields "BackOffice_Widgets" in payload screen
        And User wait for "5000"
        Then User validate Business rules for Risk Profile in "payload" screen
        | WidgetName1                  |WidgetName2       |WidgetName3        |
        | Estimated Credit Score       |Age               |Risk Profile       |
        | 731                          |49                |Moderate           |
        | 731                          |51                |Agressive          |
        | 731                          |50                |Agressive          |
        # | 729                          |49                |Agressive          |
        # | 729                          |51                |Conservative       |

        # Then User validate Business rules for Application Date in "payload" screen
        # | WidgetName1                  |WidgetName2                 |
        # | Date of Application          |Tentative Closure Date      |
        # |                              |                            |
        # | 03/08/2023                   |                            |
        # | 03/09/2023                   |03/08/2024                  |

        Then User validate Business rules for Interest Rate in "payload" screen
        | WidgetName1        |WidgetName2       |WidgetName3     |
        | Age Classification |Risk Profile      |BO Interest Rate|
        | Minor              |Conservative      |7%              |
        | Minor              |Moderate          |8%             |
        | Minor              |Agressive         |10%             |
        # | Major              |Agressive         |11%             |
        # | Major              |Conservative      |9%              |
        # | Major              |Moderate          |10%             |
        # | Sr Citizen         |Conservative      |4%              |
        # | Sr Citizen         |Agressive         |6%              |
        # | Sr Citizen         |Moderate          |5%              |
        
        Then User validate Task "1" Actions and select "Accept" action in "WorkFlow UI" screen
        And User wait for "5000"
        And User validate Transaction details are removed from "Team Task" and it is displaying under "History" on the successful workflow completion in "WorkFlow UI" screen
        And User validate Transaction table header under "History" in "WorkFlow UI" screen
        | Transaction Id | Created At | Submitted By | Last Updated By | Last Updated At |

@businessRulePayload
    Scenario: Validate Business Rule payload
        And User get the Test data from "Usecase_TestData/BusinessRulePOC" json file in "WorkFlow UI" screen
        Given user login to payload application with "Finlevit_payload" with "1" agent
        And User wait for "5000"
        Then User validate Business rules for Home Type in "payload" screen
        | WidgetName1        |WidgetName2       |WidgetName3    |
        | type of property   |Property Used As  |Home Type|
        |Single Family Home  |Primary Home      |Single Family Primary Home|
        |Single Family Home  |Secondary Home    |Single Family Secondary Home|
        |Single Family Home  |Rental Property   |Single Family Rental Property|
        # |Town Home           |Primary Home      |Townhome Primary |
        # |Town Home           |Secondary Home    |Townhome Secondary |
        # |Town Home           |Rental Property   |Townhome Rental|
        # |Condominium         |Primary Home      |Condominium Primary Home|
        # |Condominium         |Secondary Home    |Condominium Secondary Home|
        # |Condominium         |Rental Property   |Condominium Rental Home|

        Then User validate Business rules for Property Tax in "payload" screen
            | WidgetName1    | WidgetName2  | WidgetName3         |
            | Property State | Property Tax | State Tax in effect |
            # | CA                 |12.22            |false               |
            | NC             | 7.11         | true                |
            | SC             | 7.11         | true                |
            | AL             | 8.78         | true                |
            | VA             | 9.54         | true                |

        Then User validate Business rules for DownPayment in "payload" screen
            | WidgetName1    | WidgetName2   | WidgetName3           |
            | Purchase Price | Annual Income | Required Down Payment |
            | 1000001        | 249999        | 100000                |
        # | 999999                       |250001            |50000                |

        Then User validate Business rules for Age Classification in "payload" screen
            | WidgetName1 | WidgetName2        |
            | Age         | Age Classification |
            | 18          | Minor              |
            | 17          | Minor              |
            | 59          | Major              |
            | 60          | Sr Citizen         |
            | 61          | Sr Citizen         |
        And User Fill "729" in "Text Input" widget "Estimated Credit Score" in "payload" screen
        Then User click on "DOA" "Date of Application" in "payload" screen
        And User enter text "03/09/2023" in "Date of Application" in "payload" screen
        Then User click on "button" "Submit_btn" in "payload" screen
        And User get Transaction Id and save it in json file

@BusinessRule1workflow
Scenario: Verify konfig workflow UI with Accept scenario
    And User get the Test data from "Usecase_TestData/BusinessRulePOC" json file in "WorkFlow UI" screen
        Given user login to workflow UI "Finlevit_workflow" with "1" "AppManager" credentials
        Then User will open "GroupName" group in "HomePage" screen
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "8000"
        And User validate Transaction table header under "Team Task" in "WorkFlow UI" screen
        | SLA | Transaction Id | Task Name | Priority | Created At | Submitted By | Last Updated By | Last Updated At | Assigned To |
        And As "Agent" user verify Task "1" Details under "Team Task" in "WorkFlow UI" screen
    Then Based on the Task assigned to person logout or continue with the same user in "WorkFlow UI" screen for "Application_Name"
        And User validate Transaction table header under "My Task" in "WorkFlow UI" screen
        | SLA | Transaction Id | Task Name | Priority | Created At | Submitted By | Last Updated By | Last Updated At | Assigned To |
        And As "Application Manager" user verify Task "1" Details under "My Task" in "WorkFlow UI" screen
        Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
        And User validate left side menu options for the Task in "WorkFlow UI" screen
        # And User should see all the "Back office" fields "BackOffice_Widgets" in payload screen
        And User wait for "5000"
        Then User validate Business rules for Risk Profile in "payload" screen
        | WidgetName1                  |WidgetName2       |WidgetName3        |
        | Estimated Credit Score       |Age               |Risk Profile       |
        | 731                          |49                |Moderate           |
        | 731                          |51                |Agressive          |
        | 731                          |50                |Agressive          |
        # | 729                          |49                |Agressive          |
        # | 729                          |51                |Conservative       |

        # Then User validate Business rules for Application Date in "payload" screen
        # | WidgetName1                  |WidgetName2                 |
        # | Date of Application          |Tentative Closure Date      |
        # |                              |                            |
        # | 03/08/2023                   |                            |
        # | 03/09/2023                   |03/08/2024                  |

        Then User validate Business rules for Interest Rate in "payload" screen
        | WidgetName1        |WidgetName2       |WidgetName3     |
        | Age Classification |Risk Profile      |BO Interest Rate|
        | Minor              |Conservative      |7%              |
        | Minor              |Moderate          |8%             |
        | Minor              |Agressive         |10%             |
        # | Major              |Agressive         |11%             |
        # | Major              |Conservative      |9%              |
        # | Major              |Moderate          |10%             |
        # | Sr Citizen         |Conservative      |4%              |
        # | Sr Citizen         |Agressive         |6%              |
        # | Sr Citizen         |Moderate          |5%              |
        
        Then User validate Task "1" Actions and select "Accept" action in "WorkFlow UI" screen
        And User wait for "5000"
        And User validate Transaction details are removed from "Team Task" and it is displaying under "History" on the successful workflow completion in "WorkFlow UI" screen
        And User validate Transaction table header under "History" in "WorkFlow UI" screen
        | Transaction Id | Created At | Submitted By | Last Updated By | Last Updated At |
