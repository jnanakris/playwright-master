
Feature: Application with multiple widgets and onloadtriggers for options mapping and response mapping

  @sanityTestSuite
  @widgetTest
  #Createdby: Mohan.s
  #CreatedDate:30Jan23
  #REsponseMapping_OptionsMapping
  Scenario Outline: Use case to demonstrate onload triggers using option mapping and response mapping

    Given user login to "Finlevit_admin" with "GroupAdmins" credentials
    And User get the Test data from "Usecase_TestData/Widgetfeature" json file in "WorkFlow UI" screen
    And User get number of records in "Mary PI Details" API and store it in "apiDataCount"
    Then User will open "GroupName" group in "HomePage" screen

    # To Create an Application
    Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
    Then User will search for "Application_Name" in "Application" screen
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget | X   | Y | FieldName |
      | Header | 475 | 0 | ER_Header |
    # When User Change "ER_Header" Widget backgroundcolor with "#03beff" in "UniqueWidgetFields" screen

    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget | X   | Y  | FieldName            | Value                | Style | HorizontalAlign  | VerticalAlign  |
      | Text   | 500 | 20 | EmployeeRegistration | EmployeeRegistration | h2    | HorizontalCenter | VerticalMiddle |
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget         | X   | Y   | FieldName | AddTabFieldName      | AddTabTabLabel       |
      | Tabs Container | 180 | 150 | PII       | Personal Information | Personal Information |

    When User expand "Tabs Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget               | X   | Y   |
      | Personal Information | 950 | 700 |
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget     | X   | Y   | FieldName  | FieldLabel |
      | Text Input | 210 | 250 | First Name | First Name |
      | Text Input | 400 | 250 | Last Name  | Last Name  |
    And User make "First Name" field as require field in "UniqueWidgetFields" screen
    And User make "Last Name" field as require field in "UniqueWidgetFields" screen
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget      | X   | Y   | FieldName | FieldLabel    |
      | Date Picker | 600 | 250 | DOB       | Date of Birth |
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget   | X   | Y   | FieldName            | FieldLabel           | OptionType       |
      | Dropdown | 800 | 250 | Country Of Residence | Country Of Residence | ConfigureOptions |
    And User make "Country Of Residence" field as require field in "UniqueWidgetFields" screen
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget      | X   | Y   | FieldName | FieldLabel | ValuesAlignment    | ValueCount | Value1 | Value2 |
      | Radio Group | 210 | 370 | Gender    | Gender     | ValueAlignVertical | 2          | Male   | Female |
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget | X   | Y   | FieldName | FieldLabel |
      | SSN    | 400 | 370 | SSN/ITIN  | SSN/ITIN   |
    And User make "SSN/ITIN" field as require field in "UniqueWidgetFields" screen
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget | X   | Y   | FieldName | FieldLabel | PlaceHolder        |
      | Email  | 600 | 370 | Email     | Email      | example@domain.com |
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget       | X   | Y   | FieldName    | FieldLabel   |
      | Phone Number | 800 | 370 | Phone Number | Phone Number |
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget   | X   | Y   | FieldName     | FieldLabel    |
      | Checkbox | 250 | 550 | Is US Citizen | Is US Citizen |
    And User make "Is US Citizen" field as require field in "UniqueWidgetFields" screen
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget         | X   | Y   | FieldName       | FieldLabel        | ValuesAlignment      | ValueCount | Value1 | Value2 |
      | Checkbox Group | 450 | 550 | AreaofExpertise | Area of Expertise | ValueAlignHorizontal | 2          | UI     | BA     |
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget | X   | Y   | FieldName      | FieldLabel     |
      | Number | 650 | 550 | Current Salary | Current Salary |
    When User makes changes to "Current Salary" field format as in "UniqueWidgetFields" screen
      | TypeOfFormat | CurrencyCountry |
      | Currency     | United States   |
    When User add a Tab to "Personal Information" Container in "UniqueWidgetFields" screen
      | AddTabFieldName | AddTabTabLabel  |
      | Address Details | Address Details |
    Then User click on "button" "AddressDetail" in "UniqueWidgetFields" screen
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget  | X   | Y   | FieldName | FieldLabel |
      | Address | 400 | 350 | Address   | Address    |
    And User Drag and Drop below widgets in "CanvasBody" in "AdvanceTable" screen
      | Widget        | X   | Y   | Name             |
      | Advance Table | 180 | 800 | Employee Records |
    When User expand "Advance Table" widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget  | X   | Y   |
      | Actions | 900 | 400 |
    When User click "Advance Table" and add columns in "AdvanceTable" screen
      | Name     | Alignment             | ColumnType | FieldLabel   |
      | ER_Pin   | ColumnAlignmentCenter | Text Input | Pin          |
      | ER_FN    | ColumnAlignmentCenter | Text Input | First Name   |
      | ER_LN    | ColumnAlignmentCenter | Text Input | Last Name    |
      | ER_Email | ColumnAlignmentCenter | Text Input | Email        |
      | ER_Phone | ColumnAlignmentCenter | Text Input | Phone Number |
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget | X    | Y   | FieldName | FieldLabel | Action | Status |
      | Button | 1100 | 800 | Submit    | Submit     | Submit | Save   |
    # Edit existing role
    Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
    #To set Onload Triggers for Country dropdown
    And User create Onload Triggers with "1" Options Mapping "addOnloadTrigger" in "onLoadTrigger" screen
      | Name          | Description   | DataSource | DataList          | Field1               | Label1 | Value1 |
      | Get Countries | Get Countries | Countries  | Get All Countries | Country Of Residence | name   | iso3   |
    And User create Onload Triggers with Response Mapping "addOnloadTrigger" in "onLoadTrigger" screen
      | Name                         | Description          | DataSource      | DataList                | Type | Userid | Value |
      | Get All PersonalInfo Details | PersonalInfo Details | Mary PI Details | Get All Mary PI Details |      |        |       |
    Then User will create transformation rule for "Response Mapping" "Save EmployeeName" and connect Input and Output nodes in "transformation" screen
      | Destination | Source |
      | ER_Email    | Email  |
      | ER_FN       | FN     |
      | ER_LN       | LN     |
      | ER_Phone    | Phone  |
      | ER_Pin      | Pin    |

    And User wait for "1000"
    And User see text "Onload Triggers" in "onLoadTriggerTitle" in "onLoadTrigger" screen
    Then User click on save button for "Get All PersonalInfo Details" Response Mapping in "onLoadTrigger" screen
    And User wait for "1000"
    # To Design Back Office
    Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
    Then User see text "Back Office" in "BO" in "Page" screen
    Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
    And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget    | X   | Y   | FieldName     | Title         |
      | Container | 180 | 150 | Personal Info | Personal Info |
    When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget        | X   | Y   |
      | Personal Info | 900 | 700 |
    Then User click on "button" "Fields" in "UniqueWidgetFields" screen
    Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
      | Widget               | X   | Y   |
      | First Name           | 210 | 200 |
      | Last Name            | 400 | 200 |
      | DOB                  | 600 | 200 |
      | Country Of Residence | 800 | 200 |
      | Gender               | 210 | 350 |
      | SSN/ITIN             | 400 | 350 |
      | Email                | 600 | 350 |
      | Phone Number         | 800 | 350 |
      | Is US Citizen        | 200 | 520 |
      | AreaofExpertise      | 450 | 500 |
      | Current Salary       | 700 | 500 |
    Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
      | Widget          | X   | Y   |
      | Address Details | 500 | 800 |

    # And User write "Front Office" widgets in "FrontOffice_Widgets" in "UniqueWidgetFields" screen
    # And User write "Back Office" widgets in "BackOffice_Widgets" in "UniqueWidgetFields" screen


    # Edit existing role
    Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
    # Add a new role
    Then User "Add" the "Operations" role and add "Operations" in "Roles" screen
    Then User click on "tab" "Workflow Design" in "backOffice" screen
    # To Add the required tasks onto the workflow Designer
    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
      | Widget | X   | Y   |
      | Start  | 230 | 250 |

    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
      | Widget | X   | Y   | TaskName | Role            | NoofActions | Action1 | Action1Status |SLAHours | SLADays |
      | Task   | 500 | 250 | Review   | Agent | 1           | Approve | In Progress   |1        | 0       |
    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
      | Widget | X   | Y   |
      | End    | 845 | 250 |

    Then User will connect "tasks" in "BackOfficeCanvas"
      | Source | Action  | Target |
      | Start  |         | Review |
      | Review | Approve | End    |
    Then User click on "button" "Save" in "workflowDesigner" screen
    #  To validate Version Management
    Then User click on "button" "VersionControl" in "Version" screen
    Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
    #  To validate Preview
    And User validate Payload app opening in a new tab
    # Payload
    Given user login to payload application with "Finlevit_payload" with "1" agent
    Then User click on "button" "countryDropdown" in "payload" screen
    And User wait for "1000"
    # Then User should have count "251" in "DropdownValues" in "payload" screen
    Then User click on "button" "countryDropdown" in "payload" screen
    And User should see "apiCount" in "tablePagination" in "payload" screen
    # And User should see all the "Front office" fields "FrontOffice_Widgets" in payload screen
    And User enter text "<First Name>" in "FirstName" in "payload" screen
    And User enter text "<Last Name>" in "LastName" in "payload" screen
    Then User click on "DOB" "DOB" in "payload" screen
    And User enter text "01/01/1999" in "DOB" in "payload" screen
    # Then User click on "TodayDate" "TodayDate" in "payload" screen
    And User select "Afghanistan" in "countryDropdown" dropdown in "payload" screen
    Then User click on "Gender" "Male" in "payload" screen
    And User enter text "<SSN>" in "SSN" in "payload" screen
    And User enter text "<Email>" in "Email" in "payload" screen
    And User enter text "<PhoneNumber>" in "PhoneNumber" in "payload" screen
    Then User click on "yes" "IsUsCitizen" in "payload" screen
    Then User click on "AreaOfExpertise" "BA" in "payload" screen
    And User enter text "<CurrentSalary>" in "CurrentSalary" in "payload" screen
    Then User click on "Address" "AddressDetails" in "payload" screen
    And User enter text "<Address>" in "Address" in "payload" screen
    And User wait for "1000"
    Then User select on "Address" "SelectFirstAddress" in "payload" screen
    Then User click on "button" "Submit_btn" in "payload" screen
   And User get Transaction Id and save it in json file
    Examples:
      | First Name | Last Name | tooltip | SSN       | Email             | PhoneNumber | CurrentSalary | Address | Country     |
      | Tom        | Hanks     | Check   | 111223333 | thanks@tabner.com | 4255554455  | 1000000       | 11020   | Afghanistan |
