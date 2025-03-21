Feature: Use case to validate payload widget properties/features

    @payloadAssertions1
    @payloadAssertions


    Scenario: Usecase to checkout the version

        # Given user login to "Finlevit_admin" with "Admin" credentials
        And User get the Test data from "Usecase_TestData/PayloadAssertion" json file in "WorkFlow UI" screen
        # When User enter create group with "GroupName" and "GroupDescription" in "Groups" screen
        # Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        # Then User will search for "Application_Name" in "Application" screen

        # #payload
        # And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
        #     | Widget     | X   | Y  | FieldName | FieldLabel | Action | Status | OptionType    | ValueCount | Value1    | Value2    |
        #     | Text Input | 100 | 50 | FirstName | FirstName  |        |        |               |            |           |           |
        #     | Number     | 350 | 50 | Salary    | Salary     |        |        |               |            |           |           |
        #     | Dropdown   | 600 | 50 | Emp Type  | Emp Type   |        |        | ManualOptions | 2          | Full Time | Part Time |
        #     | SSN        | 850 | 50 | SSN/ITIN  | SSN/ITIN   |        |        |               |            |           |           |
        # And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
        #     | Widget      | X   | Y   | FieldName | FieldLabel | ValuesAlignment    | ValueCount | Value1 | Value2 |
        #     | Radio Group | 100 | 250 | Gender    | Gender     | ValueAlignVertical | 2          | Male   | Female |
        # And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
        #     | Widget      | X   | Y   | FieldName | FieldLabel |
        #     | Date Picker | 350 | 250 | DOB       | DOB        |
        #     | Text Area   | 600 | 250 | SurName   | SurName    |
        # And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
        #     | Widget       | X   | Y   | FieldName      | FieldLabel     | PlaceHolder        |
        #     | Checkbox     | 850 | 250 | I Accept terms | I Accept terms |                    |
        #     | Email        | 100 | 450 | Email          | Email          | example@domain.com |
        #     | Phone Number | 350 | 450 | PhoneNumber    | PhoneNumber    |                    |
        # And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
        #     | Widget | X   | Y   | FieldName | FieldLabel | Action | Status |
        #     | Button | 600 | 450 | Submit    | Submit     | Submit | Save   |

        # And User Drag and Drop below widgets in "CanvasBody" in "AdvanceTable" screen
        #     | Widget        | X   | Y   | Name             |
        #     | Advance Table | 350 | 650 | Employee Records |
        # When User expand "Advance Table" widgets in "CanvasBody" in "UniqueWidgetFields" screen
        #     | Widget  | X    | Y   |
        #     | Actions | 1000 | 600 |
        # And User wait for "3000"
        # Then User double click on "widget" "AdvanceTableEdit" in "AdvanceTable" screen
        # Then User click on "button" "COLUMNS" in "AdvanceTable" screen

        # When User click "Advance Table" and add below columns in "AdvanceTable" screen
        #     | Name      | Alignment             | ColumnType | FieldLabel |
        #     | Full Name | ColumnAlignmentCenter | Text Input | Full Name  |
        # When User click "Advance Table" and add below columns in "AdvanceTable" screen
        #     | Name | Alignment             | ColumnType | FieldLabel |
        #     | DOJ  | ColumnAlignmentCenter | Date       | DOJ        |
        # When User click "Advance Table" and add below columns in "AdvanceTable" screen
        #     | Name         | Alignment             | ColumnType | FieldLabel   | TypeOfFormat | CurrencyCountry |
        #     | AnnualIncome | ColumnAlignmentCenter | Number     | AnnualIncome | Currency     | United States   |

        # Then User click on "button" "PAGINATION" in "AdvanceTable" screen
        # Then User click on "button" "ShowFilter" in "AdvanceTable" screen
        # Then User click on "Button" "WidgetSave" in "UniqueWidgetFields" screen

        # Then User add toast message to "Submit" button as "Transaction Submitted" in "UniqueWidgetFields" pageScreen
        # Then User add required field validation msg to the fields in payload page "UniqueWidgetFields" pageScreen
        #     | fieldName      | validationMessage        |
        #     | FirstName      | FirstName field is empty |
        #     | Salary         | Salary field is empty      |
        #     | Emp Type       | Emp Type  field is empty |
        #     | Gender         | Gender Field is empty    |
        #     | DOB            | DOB field is empty       |
        #     | I Accept terms | terms field empty        |
        #     | SurName        | SurName field empty      |
        #     | Email          | Email field is empty     |
        #     | PhoneNumber    | PhoneNumber field is empty |
        #     | SSN/ITIN       | SSN/ITIN field is empty  |
        # When User makes changes to "Salary" field format as in "UniqueWidgetFields" screen
        #     | TypeOfFormat | CurrencyCountry |
        #     | Currency     | United States   |

        # # Then User "FirstName" field with "MaximumValue" characters of "10" in "UniqueWidgetFields" pageScreen
        # # Then User "Salary" field with "MaximumValue" characters of "10" in "UniqueWidgetFields" pageScreen

        # Then User "FirstName" field with "MinimumValue" characters of "3" in "UniqueWidgetFields" pageScreen
        # Then User "Salary" field with "MinimumValue" characters of "3" in "UniqueWidgetFields" pageScreen

        # Then User add default value to "Salary" field as "1234567890" in "UniqueWidgetFields" pageScreen
        # Then User add default value to "SSN/ITIN" field as "123456789" in "UniqueWidgetFields" pageScreen
        # Then User add default value to "PhoneNumber" field as "1234567890" in "UniqueWidgetFields" pageScreen

        # Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
        # # To Design Front Office
        # Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        # Then User see text "Back Office" in "BO" in "Page" screen
        # Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        # Then User click on "tab" "Workflow Design" in "backOffice" screen
        # #To Add the required tasks onto the workflow Designer
        # Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
        #     | Widget | X   | Y   |
        #     | Start  | 230 | 250 |
        #     | End    | 845 | 250 |

        # #  To Configure the Task Name
        # Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
        #     | Widget | X   | Y   | TaskName           | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
        #     | Task   | 500 | 250 | Review Transaction | Application Manager | 1           | Accept  | In Progress   | 1        | 0       |
        # # To connect the tasks present on the workflow designer canvas
        # Then User will connect "tasks" in "BackOfficeCanvas"
        #     | Source             | Action | Target             |
        #     | Start              |        | Review Transaction |
        #     | Review Transaction | Accept | End                |
        # Then User click on "button" "Save" in "workflowDesigner" screen
        # #  To validate Version Management
        # Then User click on "button" "VersionControl" in "Version" screen
        # Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        # # #  To validate Preview
        # And User validate Payload app opening in a new tab
        Given user login to payload application with "Finlevit_payload" with "1" agent

        And User enter "text" in "FirstName" with "10" characters
        # And User see text "Characters left 0" in "FirstNameCharValidate" in "PayloadValidate" screen
        When User enter "134567890" text in "Salary" field
        # And User see text "Characters left 0" in "SalaryCharValidate" in "PayloadValidate" screen
        # And User select drop down option "Full Time" in "Emp Type" widget in "payload" screen
        And User enter "SSN" in "SSN/ITIN" with "9" characters
        # And User Fill "Male" in "Radio Group" widget "Gender" in "payload" screen
        And User Fill "01/01/1999" in "Date" widget "DOB" in "payload" screen
        And User Fill "Fill Sur Name" in "TextArea" widget "SurName" in "payload" screen
        And User Fill "I Accept terms" in "Checkbox" widget "I Accept terms" in "payload" screen
        And User enter "email" in "Email" with "5" characters
        And User enter "phoneNumber" in "PhoneNumber" with "10" characters

        # #AdvanceTable Validation
        # When User should have visible "FilterIconCanvas" in "AdvanceTable" screen
        # When User should have visible "AddRowCanvas" in "AdvanceTable" screen
        # Then User click on "button" "AddRowCanvas" in "AdvanceTable" screen
        # When User should have visible "DeleteIconPayload" in "AdvanceTable" screen
        # When User click on "Save" "Advanced table first row save icon" in "payload" screen
        # When User should have visible "EditIconPayload" in "AdvanceTable" screen
        # # Then User click on "button" "Submit_btn" in "payload" screen

        #Text Input
        And User wait for "5000"
        When User enter "" text in "FirstName" field
        Then User click on "button" "Submit_btn" in "payload" screen
        And User see text "FirstName field is empty" in "FirstName" widget in "PayloadValidate" screen
        When User enter "Te" text in "FirstName" field
        # And User see text "Expected atleast length 3 but got 2" in "LeastValValidationMsg" in "PayloadValidate" screen
        When User enter "Test123456" text in "FirstName" field
        And User see text "Characters left 0" in "CharacterValidationMsg" in "PayloadValidate" screen

        # # Number
        # When User enter "" text in "Salary" field
        # Then User click on "button" "Submit_btn" in "payload" screen
        # # And User see text "Salary field is empty" in "Salary" widget in "PayloadValidate" screen
        # When User enter "12" text in "Salary" field
        # And User see text "Please enter any value greater than  3" in "LeastValValidationMsg" in "PayloadValidate" screen
        # When User enter "1234567890" text in "Salary" field

        # DropDown
        Then User click on "button" "Submit_btn" in "payload" screen
        And User see text "Emp Type  field is empty" in "Emp Type" widget in "PayloadValidate" screen
        And User select drop down option "Full Time" in "Emp Type" widget in "payload" screen

        # SSN/ITIN
        When User Widget should have attribute "ng-reflect-model" value of "123456789" in "SsnDefault" in "payload" screen
        When User enter "" text in "SSN/ITIN" field
        Then User click on "button" "Submit_btn" in "payload" screen
        And User see text "SSN/ITIN field is empty" in "SSN/ITIN" widget in "PayloadValidate" screen
        # When User see text "SSN/ITIN field is empty" in "ValidationCutomMsg" in "PayloadValidate" screen
        When User enter "123456789" text in "SSN/ITIN" field

        # RadioGroup
        Then User click on "button" "Submit_btn" in "payload" screen
        And User see text "Gender Field is empty" in "Gender" widget in "PayloadValidate" screen
        And User Fill "Male" in "Radio Group" widget "Gender" in "payload" screen

        # DOB
        When User enter "" text in "DOB" field
        # When User should have visible "HourPicker" in "PayloadValidate" screen
        Then User click on "button" "Submit_btn" in "payload" screen
        And User see text "DOB field is empty" in "DOB" widget in "PayloadValidate" screen
        # When User see text "DOB field is empty" in "ValidationCutomMsg" in "PayloadValidate" screen
        And User Fill "01/01/1999" in "Date" widget "DOB" in "payload" screen

        # Text Area
        And User Fill "" in "TextArea" widget "SurName" in "payload" screen
        Then User click on "button" "Submit_btn" in "payload" screen
        And User see text "SurName field empty" in "SurName" widget in "PayloadValidate" screen
        # When User see text "SurName field empty" in "ValidationCutomMsg" in "PayloadValidate" screen
        And User Fill "Fill Sur Name" in "TextArea" widget "SurName" in "payload" screen

        # Check Box
        And User Fill "I Accept terms" in "Checkbox" widget "I Accept terms" in "payload" screen
        Then User click on "button" "Submit_btn" in "payload" screen
        And User see text "terms field empty" in "I Accept terms" widget in "PayloadValidate" screen
        # When User see text "terms field empty" in "ValidationCutomMsg" in "PayloadValidate" screen
        And User Fill "I Accept terms" in "Checkbox" widget "I Accept terms" in "payload" screen

        # Email
        When User enter "" text in "Email" field
        Then User click on "button" "Submit_btn" in "payload" screen
        And User see text "Email field is empty" in "Email" widget in "PayloadValidate" screen
        # When User see text "Email field is empty" in "ValidationCutomMsg" in "PayloadValidate" screen
        And User enter "email" in "Email" with "5" characters

        # # PhoneNumber
        # When User Widget should have attribute "ng-reflect-model" value of "123-456-7890" in "PhoneNumberDefault" in "PayloadValidate" screen
        # When User enter "" text in "PhoneNumber" field
        # Then User click on "button" "Submit_btn" in "payload" screen
        # And User see text "PhoneNumber field is empty" in "PhoneNumber" widget in "PayloadValidate" screen
        # # When User see text "PhoneNumber field is empty" in "ValidationCutomMsg" in "PayloadValidate" screen
        # When User enter "9823948567" text in "PhoneNumber" field

        Then User click on "button" "Submit_btn" in "payload" screen
        And User see text "Transaction Submitted" in "Pagelevel_alert_messgae" in "payload" screen
        And User wait for "5000"



    # @payloadAssertions2
    # @payloadAssertions
    # Scenario: Usecase to validate wiget in payload

    #     # Given user login to "Finlevit_admin" with "Admin" credentials
    #     And User get the Test data from "Usecase_TestData/PayloadAssertion" json file in "WorkFlow UI" screen
    #     # When User enter create group with "GroupName" and "GroupDescription" in "Groups" screen
    #     # # Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
    #     # Then User will search for "Application_Name" in "Application" screen

    #     # #payload
    #     # # And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
    #     # #     | Widget     | X   | Y  | FieldName | FieldLabel | Action | Status | OptionType    | ValueCount | Value1    | Value2    |
    #     # #     | Text Input | 150 | 50 | FirstName | FirstName  |        |        |               |            |           |           |
    #     # #     | Number     | 400 | 50 | Salary    | Salary     |        |        |               |            |           |           |
    #     # #     | Dropdown   | 650 | 50 | Emp Type  | Emp Type   |        |        | ManualOptions | 2          | Full Time | Part Time |
    #     # #     | SSN        | 450 | 50 | SSN/ITIN  | SSN/ITIN   |        |        |               |            |           |           |
    #     # # And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
    #     # #     | Widget      | X   | Y   | FieldName | FieldLabel | ValuesAlignment    | ValueCount | Value1 | Value2 |
    #     # #     | Radio Group | 150 | 250 | Gender    | Gender     | ValueAlignVertical | 2          | Male   | Female |
    #     # # And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
    #     # #     | Widget      | X   | Y   | FieldName | FieldLabel |
    #     # #     | Date Picker | 400 | 250 | DOB       | DOB        |
    #     # #     | Text Area   | 650 | 250 | SurName   | SurName    |
    #     # # And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
    #     # #     | Widget       | X   | Y   | FieldName      | FieldLabel     | PlaceHolder        |
    #     # #     | Checkbox     | 150 | 450 | I Accept terms | I Accept terms |                    |
    #     # #     | Email        | 400 | 450 | Email          | Email          | example@domain.com |
    #     # #     | Phone Number | 900 | 450 | PhoneNumber    | PhoneNumber    |                    |
    #     # # And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
    #     # #     | Widget | X   | Y   | FieldName | FieldLabel | Action | Status |
    #     # #     | Button | 800 | 650 | Submit    | Submit     | Submit | Save   |


    #     # # Then User add placeholder value to "FirstName" field as "Name" in "UniqueWidgetFields" pageScreen
    #     # # Then User add placeholder value to "Salary" field as "123456789" in "UniqueWidgetFields" pageScreen
    #     # # Then User add placeholder value to "Emp Type" field as "1234567890" in "UniqueWidgetFields" pageScreen
    #     # # Then User add placeholder value to "DOB" field as "DD/MM/YYYY" in "UniqueWidgetFields" pageScreen
    #     # # Then User add placeholder value to "SurName" field as "FillSurName" in "UniqueWidgetFields" pageScreen


    #     # Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
    #     # # To Design Front Office
    #     # Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
    #     # Then User see text "Back Office" in "BO" in "Page" screen
    #     # Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
    #     # Then User click on "tab" "Workflow Design" in "backOffice" screen
    #     # #To Add the required tasks onto the workflow Designer
    #     # Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
    #     #     | Widget | X   | Y   |
    #     #     | Start  | 230 | 250 |
    #     #     | End    | 845 | 250 |

    #     # #  To Configure the Task Name
    #     # Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
    #     #     | Widget | X   | Y   | TaskName           | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
    #     #     | Task   | 500 | 250 | Review Transaction | Application Manager | 1           | Accept  | In Progress   | 1        | 0       |
    #     # # To connect the tasks present on the workflow designer canvas
    #     # Then User will connect "tasks" in "BackOfficeCanvas"
    #     #     | Source             | Action | Target             |
    #     #     | Start              |        | Review Transaction |
    #     #     | Review Transaction | Accept | End                |
    #     # Then User click on "button" "Save" in "workflowDesigner" screen
    #     # #  To validate Version Management
    #     # Then User click on "button" "VersionControl" in "Version" screen
    #     # Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
    #     # # #  To validate Preview
    #     # And User validate Payload app opening in a new tab
    #     Given user login to payload application with "Finlevit_payload" with "1" agent

    #     When  User should validate in payload placeholder value of "Name" in "FirstName" in "PayloadValidate" screen
    #     When User should validate in payload placeholder value of "123456789" in "Salary" in "PayloadValidate" screen
    #     When User Widget should have attribute "ng-reflect-placeholder" value of "1234567890" in "DropDownPlaceholder" in "PayloadValidate" screen
    #     When User should validate in payload placeholder value of "***-**-****" in "SSN/ITIN" in "PayloadValidate" screen
    #     When User should validate in payload placeholder value of "DD/MM/YYYY" in "DOB" in "PayloadValidate" screen
    #     When User should validate in payload placeholder value of "FillSurName" in "SurName" in "PayloadValidate" screen
    #     When User should validate in payload placeholder value of "example@domain.com" in "Email" in "PayloadValidate" screen
    #     When User should validate in payload placeholder value of "000-000-0000" in "PhoneNumber" in "PayloadValidate" screen


    # @payloadAssertions3
    # @payloadAssertions
    # Scenario: Usecase to validate widgets in payload

    #     Given user login to "Finlevit_admin" with "Admin" credentials
    #     And User get the Test data from "Usecase_TestData/PayloadAssertion" json file in "WorkFlow UI" screen
    #     When User enter create group with "GroupName" and "GroupDescription" in "Groups" screen
    #     Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
    #     Then User will search for "Application_Name" in "Application" screen

    #     #payload
    #     And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
    #         | Widget     | X   | Y  | FieldName | FieldLabel | Action | Status | OptionType | ValueCount | Value1 | Value2 |
    #         | Text Input | 150 | 50 | FirstName | FirstName  |        |        |            |            |        |        |
    #         | Number     | 400 | 50 | Salary    | Salary     |        |        |            |            |        |        |

    #     And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
    #         | Widget | X   | Y   | FieldName | FieldLabel | Action | Status |
    #         | Button | 800 | 650 | Submit    | Submit     | Submit | Save   |

    #     Then User "FirstName" field with "MaximumValue" characters of "10" in "UniqueWidgetFields" pageScreen
    #     Then User "Salary" field with "MaximumValue" characters of "10" in "UniqueWidgetFields" pageScreen

    #     Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
    #     # To Design Front Office
    #     Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
    #     Then User see text "Back Office" in "BO" in "Page" screen
    #     Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
    #     Then User click on "tab" "Workflow Design" in "backOffice" screen
    #     #To Add the required tasks onto the workflow Designer
    #     Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
    #         | Widget | X   | Y   |
    #         | Start  | 230 | 250 |
    #         | End    | 845 | 250 |

    #     #  To Configure the Task Name
    #     Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
    #         | Widget | X   | Y   | TaskName           | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
    #         | Task   | 500 | 250 | Review Transaction | Application Manager | 1           | Accept  | In Progress   | 1        | 0       |
    #     # To connect the tasks present on the workflow designer canvas
    #     Then User will connect "tasks" in "BackOfficeCanvas"
    #         | Source             | Action | Target             |
    #         | Start              |        | Review Transaction |
    #         | Review Transaction | Accept | End                |
    #     Then User click on "button" "Save" in "workflowDesigner" screen
    #     #  To validate Version Management
    #     Then User click on "button" "VersionControl" in "Version" screen
    #     Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
    #     # #  To validate Preview
    #     And User validate Payload app opening in a new tab
    #     Given user login to payload application with "Finlevit_payload" with "1" agent

    #     And User enter "text" in "FirstName" with "10" characters
    #     And User see text "Characters left 0" in "CharacterValidationMsg" in "PayloadValidate" screen
    #     And User enter "" in "FirstName" with "10" characters

    #     When User enter "134567890" text in "Salary" field
    #     And User see text "Characters left 0" in "CharacterValidationMsg" in "PayloadValidate" screen














































































