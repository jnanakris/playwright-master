
Feature: Application to check require field validation in payload for all applicable widgets

  @App @ChildScript
  @ChildScript25
  #Createdby: Mary
  #CreatedDate:05/16/2023
  Scenario: Use case to check require field validation in payload for all applicable widgets

    Given user login to "Finlevit_admin" with "GroupAdmins" credentials
    And User get the Test data from "Usecase_TestData/ChildScript25" json file in "WorkFlow UI" screen
    Then User will open "GroupName" group in "HomePage" screen
    # To Create an Application
    Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
    Then User will search for "Application_Name" in "Application" screen
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
    | Widget         | X  | Y  | FieldName            | AddTabFieldName      | AddTabTabLabel       |
    | Tabs Container | 50 | 50 | EmployeeInformation | PersonalInformation | Personal Information |
    When User expand "Tabs Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
    | Widget               | X   | Y   |
    | Personal Information | 950 | 550 |
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
    | Widget       | X   | Y   | FieldName    | FieldLabel   |
    | Text Input   | 80  | 150 | FirstName   | First Name   |
    | Text Area    | 280 | 150 | SurName      | SurName      |
    | Phone Number | 480 | 150 | PhoneNumber | Phone Number |
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
    | Widget | X   | Y   | FieldName | FieldLabel | PlaceHolder        |
    | Email  | 680 | 150 | Email     | Email      | example@domain.com |
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
    | Widget      | X  | Y   | FieldName | FieldLabel    |
    | Date Picker | 80 | 300 | DOB       | Date of Birth |
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
    | Widget      | X   | Y   | FieldName | FieldLabel | ValuesAlignment    | ValueCount | Value1 | Value2 |
    | Radio Group | 280 | 300 | Gender    | Gender     | ValueAlignVertical | 2          | Male   | Female |
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
    | Widget | X   | Y   | FieldName | FieldLabel |
    | SSN    | 480 | 300 | ssnNumber  | SSN/ITIN   |
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
    | Widget         | X   | Y   | FieldName       | FieldLabel      | ValuesAlignment    | ValueCount | Value1  | Value2 | Value3 |
    | Checkbox Group | 680 | 300 | LanguagesKnown | Languages Known | ValueAlignVertical | 3          | English | Tamil  | Telugu |
    When User expand "Checkbox Group" widgets in "CanvasBody" in "UniqueWidgetFields" screen
    | Widget          | X   | Y   |
    | Languages Known | 800 | 500 |
And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget   | X  | Y   | FieldName     | FieldLabel    |
      | Checkbox | 80 | 490 | IsUSCitizen | Is US Citizen |
    # And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
    #   | Widget   | X  | Y   | FieldName     | FieldLabel    |
    #   | Upload | 60 | 620 | Attach Document | Attach Document |
    And User make "First Name" field as require field in "UniqueWidgetFields" screen
    And User make "SurName" field as require field in "UniqueWidgetFields" screen
    And User make "Phone Number" field as require field in "UniqueWidgetFields" screen
    And User make "Email" field as require field in "UniqueWidgetFields" screen
    And User make "Date of Birth" field as require field in "UniqueWidgetFields" screen
    And User make "Gender" field as require field in "UniqueWidgetFields" screen
    And User make "SSN/ITIN" field as require field in "UniqueWidgetFields" screen
    And User make "Languages Known" field as require field in "UniqueWidgetFields" screen
    And User make "Is US Citizen" field as require field in "UniqueWidgetFields" screen
    # And User make "Attach Document" field as require field in "UniqueWidgetFields" screen
    And User wait for "1000"
    When User add a Tab to "Personal Information" Container in "UniqueWidgetFields" screen
    | AddTabFieldName        | AddTabTabLabel         |
    | EmploymentInformation | Employment Information |
    Then User click on "Button" widget "Employment Information" in "payload" screen
    And User wait for "1000"
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
    | Widget     | X   | Y   | FieldName | FieldLabel |
    | Text Input | 80  | 150 | UserName | User Name  |
    | Password   | 280 | 150 | Password  | Password   |
    | Number     | 480 | 150 | Salary    | Salary     |
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
    | Widget   | X   | Y   | FieldName | FieldLabel | OptionType    | ValueCount | Value1    | Value2    |
    | Dropdown | 680 | 150 | EmpType  | Emp Type   | ManualOptions | 2          | Full Time | Part Time |
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
    | Widget  | X  | Y   | FieldName | FieldLabel |
    | Address | 80 | 250 | Address   | Address    |

    # When User makes changes to "Salary" field format as in "UniqueWidgetFields" screen
    # | TypeOfFormat | CurrencyCountry |
    # | Currency     | United States   |
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
    | Widget | X   | Y   | FieldName | FieldLabel | Action | Status |
    | Button | 800 | 620 | Submit    | Submit     | Submit | Save   |
    And User make "User Name" field as require field in "UniqueWidgetFields" screen
    And User make "Password" field as require field in "UniqueWidgetFields" screen
    And User make "Salary" field as require field in "UniqueWidgetFields" screen
    And User make "Emp Type" field as require field in "UniqueWidgetFields" screen
    And User make "Address" field as require field in "UniqueWidgetFields" screen
    And User make "City" field as require field in "UniqueWidgetFields" screen
    # And User make "State" field as require field in "UniqueWidgetFields" screen
    And User make "Zip" field as require field in "UniqueWidgetFields" screen
    And User wait for "1000"
    Then User click on "span" "Save" in "Page" screen
    # Edit existing role
    Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
    # To Design Back Office
    Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
    Then User see text "Back Office" in "BO" in "Page" screen
    Then User click on "button" "Fields" in "UniqueWidgetFields" screen
    Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
    | Widget               | X  | Y  |
    | EmployeeInformation | 50 | 50 |
    # # And User write "Front Office" widgets in "FrontOffice_Widgets" in "UniqueWidgetFields" screen
    # # And User write "Back Office" widgets in "BackOffice_Widgets" in "UniqueWidgetFields" screen

    # Edit existing role
    Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
    Then User click on "tab" "Workflow Design" in "backOffice" screen
    # To Add the required tasks onto the workflow Designer
    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
    | Widget | X   | Y   |
    | Start  | 230 | 250 |
    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
    | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
    | Task   | 500 | 250 | Review   | Application Manager | 1           | Accept | In Progress   | 1        | 0       |
    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
    | Widget | X   | Y   |
    | End    | 845 | 250 |
    Then User will connect "tasks" in "BackOfficeCanvas"
    | Source | Action  | Target |
    | Start  |         | Review |
    | Review | Accept | End    |
    Then User click on "button" "Save" in "workflowDesigner" screen
    #  To validate Version Management
    Then User click on "button" "VersionControl" in "Version" screen
    Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
    #  To validate Preview
    And User validate Payload app opening in a new tab
    # Payload
    Given user login to payload application with "Finlevit_payload" with "1" agent
    Then User click on "button" "Submit_btn" in "payload" screen
    And User see text "Failed to validate:  First Name" in "Pagelevel_alert_messgae" in "payload" screen
    And User see text "First Name is required" in "First Name" widget in "payload" screen
    And User enter "text" in "First Name" with "5" characters
    Then User click on "button" "Submit_btn" in "payload" screen
    And User see text "Failed to validate:  SurName" in "Pagelevel_alert_messgae" in "payload" screen
    And User see text "SurName is required" in "SurName" widget in "payload" screen
    And User Fill "Test Surname" in "TextArea" widget "SurName" in "payload" screen
    Then User click on "button" "Submit_btn" in "payload" screen
    And User see text "Failed to validate:  Phone Number" in "Pagelevel_alert_messgae" in "payload" screen
    And User see text "Phone Number is required" in "Phone Number" widget in "payload" screen
    And User enter "phoneNumber" in "Phone Number" with "5" characters
    Then User click on "button" "Submit_btn" in "payload" screen
    And User see text "Failed to validate:  Email" in "Pagelevel_alert_messgae" in "payload" screen
    And User see text "Email is required" in "Email" widget in "payload" screen
    And User enter "email" in "Email" with "5" characters
    Then User click on "button" "Submit_btn" in "payload" screen
    And User see text "Failed to validate:  Date of Birth" in "Pagelevel_alert_messgae" in "payload" screen
    And User see text "Date of Birth is required" in "Date of Birth" widget in "payload" screen
    And User Fill "01/01/1999" in "Date" widget "Date of Birth" in "payload" screen
    Then User click on "button" "Submit_btn" in "payload" screen
    And User see text "Failed to validate:  Gender" in "Pagelevel_alert_messgae" in "payload" screen
    And User see text "Gender is required" in "Gender" widget in "payload" screen
    And User Fill "Male" in "Radio Group" widget "Gender" in "payload" screen
    Then User click on "button" "Submit_btn" in "payload" screen
    And User see text "Failed to validate:  SSN/ITIN" in "Pagelevel_alert_messgae" in "payload" screen
    And User see text "SSN/ITIN is required" in "SSN/ITIN" widget in "payload" screen
    And User enter "SSN" in "SSN/ITIN" with "9" characters
    Then User click on "button" "Submit_btn" in "payload" screen
    And User see text "Failed to validate:  Languages Known" in "Pagelevel_alert_messgae" in "payload" screen
    And User see text "Languages Known is required" in "Languages Known" widget in "payload" screen
    And User Fill "English" in "Checkbox Group" widget "Languages Known" in "payload" screen
    And User Fill "Tamil" in "Checkbox Group" widget "Languages Known" in "payload" screen
    Then User click on "button" "Submit_btn" in "payload" screen
    And User see text "Failed to validate:  Is US Citizen" in "Pagelevel_alert_messgae" in "payload" screen
    And User see text "Is US Citizen is required" in "Is US Citizen" widget in "payload" screen
    And User Fill "Is US Citizen" in "Checkbox" widget "Is US Citizen" in "payload" screen
    Then User click on "Button" widget "Employment Information" in "payload" screen
    Then User click on "button" "Submit_btn" in "payload" screen
    And User see text "Failed to validate:  User Name" in "Pagelevel_alert_messgae" in "payload" screen
    And User see text "User Name is required" in "User Name" widget in "payload" screen
    And User enter "text" in "User Name" with "5" characters
    Then User click on "button" "Submit_btn" in "payload" screen
    And User see text "Failed to validate:  Password" in "Pagelevel_alert_messgae" in "payload" screen
    And User see text "Password is required" in "Password" widget in "payload" screen
    And User Fill "Test@1234" in "Text Input" widget "Password" in "payload" screen
    Then User click on "button" "Submit_btn" in "payload" screen
    And User see text "Failed to validate:  Salary" in "Pagelevel_alert_messgae" in "payload" screen
    And User see text "Salary is required" in "Salary" widget in "payload" screen
    And User enter "number" in "Salary" with "5" characters
    Then User click on "button" "Submit_btn" in "payload" screen
    And User see text "Failed to validate:  Emp Type" in "Pagelevel_alert_messgae" in "payload" screen
    And User see text "Emp Type is required" in "Emp Type" widget in "payload" screen
    And User select drop down option "Full Time" in "Emp Type" widget in "payload" screen
    And User wait for "1000"
    Then User click on "button" "Submit_btn" in "payload" screen
    And User wait for "1000"
    And User see text "Failed to validate:  Address" in "Pagelevel_alert_messgae" in "payload" screen
    And User see text "Address is required" in "Address" widget in "payload" screen
    # And User enter "number" in "Address" with "5" characters
    And User enter text "11020" in "Address" in "payload" screen
    And User wait for "1000"
    Then User select on "Address" "SelectFirstAddress" in "payload" screen
    # Then User click on "button" "Submit_btn" in "payload" screen
    # And User see text "Failed to validate:  Attach Document" in "Pagelevel_alert_messgae" in "payload" screen
    # # And User see text "Attach Document is required" in "Attach Document" widget in "payload" screen
    # And User select and upload a file "Sample PDF Document.pdf"
    # And User wait for "1000"
    Then User click on "button" "Submit_btn" in "payload" screen
    # And User wait until the spinner disappears
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
    # And User validate Transaction table header under "Team Task" in "WorkFlow UI" screen
 #     | SLA | Transaction Id | Task Name | Priority | Created At | Submitted By | Last Updated By | Last Updated At | Assigned To |
    And As "Application Manager" user verify Task "1" Details under "My Task" in "WorkFlow UI" screen
    Then User click on "Task" "My Task" in "WorkFlow UI" screen
    Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
    And User validate left side menu options for the Task in "WorkFlow UI" screen
    Then User validate Task "1" Actions and select "Accept" action in "WorkFlow UI" screen
    And User wait for "5000"

