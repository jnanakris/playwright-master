Feature: Application to test conditional task in BO workflow

    @ChildScript70 @ChildScript
    # @dataResources
    # #Created By: Mohan.S
    # #Created on : 02/10/2023
    Scenario Outline: Use case to demonstrate the conditional task using checkbox

        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "Usecase_TestData/ChildScript70" json file in "WorkFlow UI" screen
        Then User will open "GroupName" group in "HomePage" screen
        # To Create an Application
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X  | Y  | FieldName     | Title           |
            | Container | 25 | 25 | ChildScript70 | Child Script 70 |
        When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget          | X    | Y   |
            | Child Script 70 | 1050 | 600 |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName | FieldLabel |
            | Text Input | 50  | 125 | pin       | Pin        |
            | Text Input | 300 | 125 | firstName | First Name |
            | Text Input | 550 | 125 | lastName  | Last Name  |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X  | Y   | FieldName | FieldLabel | PlaceHolder        |
            | Email  | 50 | 300 | email     | Email      | example@domain.com |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget       | X   | Y   | FieldName   | FieldLabel   |
            | Phone Number | 300 | 300 | phoneNumber | Phone Number |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget   | X  | Y   | FieldName   | FieldLabel    |
            | Checkbox | 50 | 490 | IsUSCitizen | Is US Citizen |
        And User wait for "1000"
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget  | X   | Y   | FieldName | FieldLabel |
            | Address | 550 | 300 | Address   | Address    |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X   | Y   | FieldName | FieldLabel | Action | Status |
            | Button | 800 | 620 | Submit    | Submit     | Submit | Save   |
            | Button | 475 | 620 | Logout    | Logout     | Logout | Save   |

        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User see text "Back Office" in "BO" in "Page" screen
        Then User click on "button" "Fields" in "UniqueWidgetFields" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget        | X  | Y  |
            | ChildScript70 | 50 | 50 |
        # # And User write "Front Office" widgets in "FrontOffice_Widgets" in "UniqueWidgetFields" screen
        # # And User write "Back Office" widgets in "BackOffice_Widgets" in "UniqueWidgetFields" screen

        # # # Edit existing role
        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        # To Add the required tasks onto the workflow Designer
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 230 | 250 |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget           | X   | Y   | TaskName           | FailureTaskRole     | Email           |
            | Conditions Check | 550 | 250 | ValidateCountry | Application Manager | qa@tabnergc.com |

        Then User add the below conditions in "expressionBuilder" screen
            | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType3 | OperatorTypeCount3 | ConditionType3OperatorType1 | ConditionType3OperatorType2 |
            | 3                  | 1                  | Conditions     | If                          | Compare        | 1                  | Equality                    | Operands       | 2                  | Source Fields               | Boolean Constant            |

        Then User implements conditions check in execute area for below fields in "expressionBuilder" screen
            | Condition | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 |
            | IF        | 1                  | 1                  | Task Actions   | Set Action                  |

        Then User add the below conditions in "expressionBuilder" screen
            | Type          | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 |
            | ConditionTask | 1                  | 1                  | Conditions     | Else                        |

        Then User implements conditions check in execute area for below fields in "expressionBuilder" screen
            | Condition | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 |
            | Else      | 1                  | 1                  | Task Actions   | Set Action                  |

        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | Type          | Condition | Payloadfields | BooleanConstant | StringConstant |
            | ConditionTask | IF        | IsUSCitizen   | True            | Approve        |
            | ConditionTask | Else      |               |                 | Reject         |

        Then User click on "button" "TransformationSave" in "expressionBuilder" screen
        Then User click on "button" "Save" in "tasks" screen
        Then User click on "button" "WorkflowSave" in "tasks" screen

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName                | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
            | Task   | 750 | 180 | Address Verification-US | Application Manager | 1           | Approve | In Progress   | 1        | 0       |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName               | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
            | Task   | 750 | 320 | BG Verification-Non US | Application Manager | 1           | Approve | In Progress   | 1        | 0       |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | End    | 950 | 250 |

        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source                  | Action  | Target                  |
            | Start                   |         | ValidateCountry      |
            # | Review                  | Approve | ValidateCountry      |
            | ValidateCountry      | Approve | Address Verification-US |
            | ValidateCountry      | Reject  | BG Verification-Non US  |
            | Address Verification-US | Approve | End                     |
            | BG Verification-Non US  | Approve | End                     |

        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        #  To validate Preview
        And User validate Payload app opening in a new tab
        # Payload
        Given user login to payload application with "Finlevit_payload" with "1" agent
        And User enter "text" in "Pin" with "5" characters
        And User enter "text" in "First Name" with "5" characters
        And User enter "text" in "Last Name" with "5" characters
        And User enter "email" in "Email" with "5" characters
        And User enter text "11020" in "Address" in "payload" screen
        And User wait for "1000"
        Then User select on "Address" "SelectFirstAddress" in "payload" screen
        And User Fill "Is US Citizen" in "Checkbox" widget "Is US Citizen" in "payload" screen
        Then User click on "button" "Submit_btn" in "payload" screen
        And User get Transaction Id and save it in json file
        Then user will clear browser cookies
        When User refresh the page screen

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
        And User validate "Text Input" widget "Last Name" is not empty in "payload" screen
        And User validate "Email" widget "Email" is not empty in "payload" screen
        And User wait for "2000"
        Then User validate Task "1" Actions and select "Approve" action in "WorkFlow UI" screen
        # Then User will "Logout" from "Page" the current session


        # # Payload
        # Given user login to payload application with "Finlevit_payload" with "1" agent
        # And User enter "text" in "Pin" with "5" characters
        # And User enter "text" in "First Name" with "5" characters
        # And User enter "text" in "Last Name" with "5" characters
        # And User enter "email" in "Email" with "5" characters
        # And User enter text "11020" in "Address" in "payload" screen
        # And User wait for "1000"
        # Then User select on "Address" "SelectFirstAddress" in "payload" screen
        # Then User click on "button" "Submit_btn" in "payload" screen
        # And User get Transaction Id and save it in json file

        # # Workflow
        # And User get Transaction Id and save it in json file
        # Given user login to workflow UI "Finlevit_workflow" with "1" "AppManager" credentials
        # And User wait until the "Filter Transaction id" appears in "WorkFlow UI" screen
        # Then User click on "Button" "Home" in "HomePage" screen
        # Then User will open "GroupName" group in "HomePage" screen
        # Then User will search for "Application_Name" in "Application" screen
        # And User wait for "5000"
        # And As "Application Manager" user verify Task "2" Details under "Team Task" in "WorkFlow UI" screen
        # Then Based on the Task assigned to person logout or continue with the same user in "WorkFlow UI" screen for "Application_Name"
        # And As "Application Manager" user verify Task "2" Details under "My Task" in "WorkFlow UI" screen
        # Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
        # And User validate "Text Input" widget "First Name" is not empty in "payload" screen
        # And User validate "Text Input" widget "Last Name" is not empty in "payload" screen
        # And User validate "Email" widget "Email" is not empty in "payload" screen
        # Then User validate Task "2" Actions and select "Approve" action in "WorkFlow UI" screen