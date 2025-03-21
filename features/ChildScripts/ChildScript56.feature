Feature: Validate API Task and Response Task

    # @ChildScript
    @ChildScript56
    @APITask
    #Createdby: Mary
    Scenario: Use case to demonstrate API Task and Response Task
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "Usecase_TestData/ChildScript56" json file in "WorkFlow UI" screen
        Then User will open "GroupName" group in "HomePage" screen
        # To Create an Application
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "2000"
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X  | Y  | FieldName     | Title                                  |
            | Container | 25 | 25 | ChildScript72 | Child Script 72 - Personal Information |
        When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget                                 | X   | Y   |
            | Child Script 72 - Personal Information | 930 | 500 |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName | FieldLabel |
            | Text Input | 50  | 125 | Pin       | Pin        |
            | Text Input | 300 | 125 | FirstName | First Name |
            | Text Input | 550 | 125 | LastName  | Last Name  |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X   | Y   | FieldName | FieldLabel | PlaceHolder        |
            | Email  | 750 | 125 | Email     | Email      | example@domain.com |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget       | X  | Y   | FieldName   | FieldLabel   |
            | Phone Number | 50 | 300 | PhoneNumber | Phone Number |
        When User reloads the page
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget  | X   | Y   | FieldName | FieldLabel |
            | Address | 300 | 300 | Address   | Address    |

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X  | Y   | FieldName | FieldLabel | Action | Status |
            | Button | 50 | 600 | Submit    | Submit     | Submit | Save   |
        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User see text "Back Office" in "BO" in "Page" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget        | X  | Y  |
            | ChildScript72 | 50 | 50 |
        Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X  | Y   | FieldName | FieldLabel |
            | Text Input | 50 | 600 | BOPin     | BO Pin     |

        Then User click on "button" "CanvasSave" in "UniqueWidgetFields" screen
        # And User write "Back Office" widgets in "BackOffice_Widgets" in "UniqueWidgetFields" screen

        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        # To Add the required tasks onto the workflow Designer
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 200 | 200 |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
            | Task   | 226 | 351 | Review   | Application Manager | 1           | Save    | In Progress   | 1        | 0       |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget   | X   | Y   | TaskName      | SuccesStatus | FailedStatus | FailureTaskRole     | DataSource      | DataList                 |
            | API Task | 456 | 255 | Create Record | In Progress  | In Progress  | Application Manager | Mary PI Details | Save All Mary PI Details |
        When User Edit "API task" "Create Record" field to Configure Service in "tasks" screen
        Then User click on "button" "addRuleButton" in "transformation" screen
        Then User enter text "CreateRecord" in "Name" in "transformation" screen

        Then User add the below conditions in "expressionBuilder" screen
            | Variable       |
            | userCollection |
            | userObject     |


        # ToArray
        Then User add the below conditions in "expressionBuilder" screen
            | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
            | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | User Defined Variables      | Object Constant             |
            | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
            | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | User Defined Variables      | Object Constant             |

        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | ObjectConstant | UserVariablefields |
            | []             | userCollection     |
            | {}             | userObject         |

        # Set key #1
        Then User add the below conditions in "expressionBuilder" screen
            | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
            | 2                  | 1                  | Loops          | Set Key                     | Operands       | 2                  | User Defined Variables      | Source Fields               |
        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | UserVariablefields | Sourcefields | SetKey |
            | userObject         | Pin          | Pin    |

        # Set key #2
        Then User add the below conditions in "expressionBuilder" screen
            | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
            | 2                  | 1                  | Loops          | Set Key                     | Operands       | 2                  | User Defined Variables      | Source Fields               |
        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | UserVariablefields | Sourcefields | SetKey |
            | userObject         | FirstName    | FN     |

        # Set key #3
        Then User add the below conditions in "expressionBuilder" screen
            | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
            | 2                  | 1                  | Loops          | Set Key                     | Operands       | 2                  | User Defined Variables      | Source Fields               |
        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | UserVariablefields | Sourcefields | SetKey |
            | userObject         | LastName     | LN     |

        # Set key #4
        Then User add the below conditions in "expressionBuilder" screen
            | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
            | 2                  | 1                  | Loops          | Set Key                     | Operands       | 2                  | User Defined Variables      | Source Fields               |
        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | UserVariablefields | Sourcefields | SetKey |
            | userObject         | Email        | Email  |

        # Set key #5
        Then User add the below conditions in "expressionBuilder" screen
            | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
            | 2                  | 1                  | Loops          | Set Key                     | Operands       | 2                  | User Defined Variables      | Source Fields               |
        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | UserVariablefields | Sourcefields | SetKey |
            | userObject         | PhoneNumber  | Phone  |

        # Push
        Then User add the below conditions in "expressionBuilder" screen
            | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
            | 2                  | 1                  | Loops          | Push                        | Operands       | 2                  | User Defined Variables      | User Defined Variables      |
        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | UserVariablefields |
            | userCollection     |
            | userObject         |

        Then User add the below conditions in "expressionBuilder" screen
            | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 | ConditionType2 | OperatorTypeCount2 | ConditionType2OperatorType1 | ConditionType2OperatorType2 |
            | 2                  | 1                  | Compare        | Assign                      | Operands       | 2                  | Destination Fields          | User Defined Variables      |

        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | Destinationfields |
            | root              |

        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | UserVariablefields |
            | userCollection     |

        Then User click on "Button" "Save" in "transformation" screen
        And User wait for "2000"
        Then User click on "Button" "Close" in "transformation" screen
        And User wait for "2000"

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
            | Task   | 917 | 255 | Verify   | Application Manager | 1           | Accept  | In Progress   | 1        | 0       |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | End    | 686 | 380 |

        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source        | Action  | Target        |
            | Start         |         | Review        |
            | Review        | Save    | Create Record |
            | Create Record | Success | Verify        |
            | Verify        | Accept  | End           |

        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        #  To validate Preview
        And User validate Payload app opening in a new tab
        Then User will "Logout" from "Page" the current session
        # Payload
        Given user login to payload application with "Finlevit_payload" with "1" agent
        #Enter Data
        And User enter "text" in "Pin" with "5" characters
        And User enter "text" in "First Name" with "7" characters
        And User enter "text" in "Last Name" with "7" characters
        And User enter "email" in "Email" with "5" characters
        And User enter "phoneNumber" in "Phone Number" with "10" characters
        And User enter "number" in "Address" with "3" characters
        And User wait for "1000"
        Then User select on "Address" "SelectFirstAddress" in "payload" screen
        Then User click on "Button" widget "Submit" in "payload" screen
        And User get Transaction Id and save it in json file
        #WorkFlow UI
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
        Then User validate Task "1" Actions and select "Save" action in "WorkFlow UI" screen
        And As "Agent" user verify Task "2" Details under "Team Task" in "WorkFlow UI" screen
        Then Based on the Task assigned to person logout or continue with the same user in "WorkFlow UI" screen for "Application_Name"
        And As "Application Manager" user verify Task "2" Details under "My Task" in "WorkFlow UI" screen
        Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
        # And User validate "Text Input" widget "BO Pin" is "#Pin" in "WorkFlow UI" screen
        # And User validate "Text Input" widget "BO Pin" is not empty in "payload" screen
        Then User validate Task "2" Actions and select "Accept" action in "WorkFlow UI" screen
        And User wait for "5000"
        And User validate Transaction details are removed from "Team Task" in "WorkFlow UI" screen
        Then User will "Logout" from "Page" the current session
