Feature: Onload Triggers and Widget Triggers

    #Created by: Mary
    #Created on: 31/01/2023
    @onloadTrigger
    Scenario Outline: Set Onload Trigger for Country Drop down and Response Mapping for Advanced table
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get number of records in "Mary PI Details" API and store it in "apiDataCount"
        Then User click on "tab" "Group" in "HomePage" screen
        When User enter create group with "GroupName" and "GroupDescription" in "Groups" screen
        # Clone Data sources for a group
        Then User click on "button" "group_settings" in "Groups" screen
        Then User click on "button" "dataSources" in "onLoadTrigger" screen
        And User clone Data Source "Countries for Automation" in "onLoadTrigger" screen
        And User get unique field in Data Source "Countries for Automation" in "onLoadTrigger" screen and save it in "CountryId"
        And User clone Data Source "Mary PI Details" in "onLoadTrigger" screen
        And User get unique field in Data Source "PI API for Automation" in "onLoadTrigger" screen and save it in "PIId"
        Then User will open "GroupName" group in "HomePage" screen
        #To Create an Application
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen

        # To set Onload Triggers for Options Mapping Country dropdown
        And User wait for "5000"
        And User create Onload Triggers with "1" Options Mapping "addOnloadTrigger" in "onLoadTrigger" screen
            | Name          | Description   | DataSource               | DataList                | Field1  | Label1 | Value1 |
            | Get Countries | Get Countries | Countries for Automation | Get All Countries       | Country | name   | iso3   |
            | PI Details    | PI Details    | Mary PI Details          | Get All Mary PI Details | userid  | Pin    | Pin    |

        # To set Onload Triggers for Response Mapping
        And User create Onload Triggers with Response Mapping "addOnloadTrigger" in "onLoadTrigger" screen
            | Name                         | Description          | DataSource      | DataList                  | Type    | uniqueField | uniqueFieldValue |
            | PersonalInfo Details         | PersonalInfo Details | Mary PI Details | Get By Id Mary PI Details | session | PIId        | userId           |
            | Get All PersonalInfo Details | PersonalInfo Details | Mary PI Details | Get All Mary PI Details   |         |             |                  |
        Then User will create transformation rule for "Response Mapping" "Save EmployeeName" and connect Input and Output nodes in "transformation" screen
            | Destination | Source |
            | ER_Email    | Email  |
            | ER_FN       | FN     |
            | ER_LN       | LN     |
            | ER_Phone    | Phone  |
            | ER_Pin      | Pin    |

        And User wait for "1000"
        And User see text "Onload Triggers" in "onLoadTriggerTitle" in "onLoadTrigger" screen
        Then User click on save button for "Get Employer Details" Response Mapping in "onLoadTrigger" screen
        And User wait for "1000"
        #  To Payload Validation
        Given user login to payload application with "Finlevit_payload" with "1" agent
        # And User should see all the "Front office" fields "FrontOffice_Widgets" in payload screen
        And User wait for "1000"
        Then User click on "button" "countyDropdown" in "payload" screen
        And User wait for "1000"
        Then User should have count "251" in "DropdownValues" in "payload" screen
        # Then User click on "button" "useridDropdown" in "payload" screen
        # And User wait for "1000"
        And User should see "apiCount" in "tablePagination" in "payload" screen


    #Created by: Mary
    #Created on: 20/02/2023
    @OnChangePopulate
    Scenario Outline: Configuring a Trigger on a Dropdown (On Change Populate), To set Options Mapping for a Dropdown, Configure Data Population for Widgets
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        When User enter create group with "GroupName" and "GroupDescription" in "Groups" screen

        # Clone Data sources for a group
        Then User click on "button" "group_settings" in "Groups" screen
        Then User click on "button" "dataSources" in "onLoadTrigger" screen
        And User clone Data Source "Countries for Automation" in "onLoadTrigger" screen
        And User get unique field in Data Source "Countries for Automation" in "onLoadTrigger" screen and save it in "CountryId"
        # And User clone Data Source "States For Automation" in "onLoadTrigger" screen
        And User clone Data Source "PI API for Automation" in "onLoadTrigger" screen
        And User get unique field in Data Source "PI API for Automation" in "onLoadTrigger" screen and save it in "PIId"
        Then User will open "GroupName" group in "HomePage" screen

        # To Create an Application
        # Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        # To set Onload Triggers for Country dropdown
        And User wait for "5000"
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        And User create Onload Triggers with "1" Options Mapping "addOnloadTrigger" in "onLoadTrigger" screen
            | Name          | Description   | DataSource               | DataList                      | Field1               | Label1 | Value1 | UniqueField | Type  | UniqueFieldValue |
            | Get Countries | Get Countries | Countries for Automation | Get All Countries             | Country of Residence | name   | iso3   | CountryId   | value | United States    |
            | Get Pins      | Get Pins      | PI API for Automation    | Get All PI API for Automation | Pin                  | Pin    | Pin    |             |       |                  |
            | Get States    | Get States    | States For Automation    | Get All State                 | Residence State      | name   | name   |             |       |                  |

        # To Configure a Trigger on a Dropdown (On Change Populate)
        Then User click on "tab" "Design" in "Page" screen
        And User Configuring a Trigger on a "Dropdown" "Country of Residence" in "UniqueWidgetFields" screen
            | Title      | OnChangeAction | DataResources         | DataList                          | Type | UniqueField | Value                |
            | Get States | Populate       | States For Automation | Get By Filter Field: country_code | ref  | CountryId   | Country of Residence |
        # To set Options Mapping for a Dropdown
        And User Configuring Options mapping for a dropdown "Residence State" in "UniqueWidgetFields" screen from "Get States" trigger in "Country Of Residence"
            | Title      | OptionLabel | OptionValue | Defaultkey |
            | Get States | name        | name        |            |
        # To Configure a Trigger on a Dropdown (On Change Populate)
        And User Configuring a Trigger on a "Dropdown" "Pin" in "UniqueWidgetFields" screen
            | Title           | OnChangeAction | DataResources         | DataList                        | Type | UniqueField | Value |
            | Get PII Details | Populate       | PI API for Automation | Get By Id PI API for Automation | ref  | PIId        | Pin   |
        # To Configure Data Population based on the API Configured for a Drop down
        When User makes changes to below field's to Configure Data Population for "DropDown" in "UniqueWidgetFields" screen
            | Field         | Title            | Trigger               | ResponseField |
            | Pin / NPIN    | Get Pin          | Pin : Get PII Details | Pin           |
            | First Name    | Get FN           | Pin : Get PII Details | FirstName     |
            | Last Name     | Get LN           | Pin : Get PII Details | LastName      |
            | Gender        | Get Gender       | Pin : Get PII Details | Gender        |
            | Email         | Get Email        | Pin : Get PII Details | Email         |
            | Phone Number  | Get Phone number | Pin : Get PII Details | Phone         |
            | Is US Citizen | Get Citizenship  | Pin : Get PII Details | IsUSCitizen   |
        When User makes changes to below field's to Configure Data Population for "DropDown" in "UniqueWidgetFields" screen
            | Field                | Title       | Trigger               | ResponseField      |
            | Salary               | Get Salary  | Pin : Get PII Details | Salary             |
            | Country of Residence | Get Country | Pin : Get PII Details | CountryofResidence |
            | Address              | Get Line1   | Pin : Get PII Details | Line1              |
            | City                 | Get City    | Pin : Get PII Details | Locality           |
            | State                | Get State   | Pin : Get PII Details | State              |
            | Zip                  | Get Zip     | Pin : Get PII Details | Zipcode            |


    @DataConfiguration
    #Created By: Mary
    #Created on : 02/28/2023
    Scenario Outline: Application with Edit and Delete Data Configuration in Advanced Table, To Populate Action for a Button and Configure Data Population for an Advanced Table

        #CreateGroup
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        When User enter create group with "GroupName" and "GroupDescription" in "Groups" screen
        # Clone Data sources for a group
        Then User click on "button" "group_settings" in "Groups" screen
        Then User click on "button" "dataSources" in "onLoadTrigger" screen
        And User clone Data Source "PI API for Automation" in "onLoadTrigger" screen
        And User get unique field in Data Source "PI API for Automation" in "onLoadTrigger" screen and save it in "PIId"
        Then User will open "GroupName" group in "HomePage" screen
        #To Create an Application
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        # # widget
        And User Drag and Drop below widgets in "CanvasBody" in "AdvanceTable" screen
            | Widget        | X   | Y   | Name             |
            | Advance Table | 180 | 200 | Employee Records |
        When User expand "Advance Table" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget  | X    | Y   |
            | Actions | 1000 | 600 |
        And User wait for "3000"
        Then User double click on "widget" "AdvanceTableEdit" in "AdvanceTable" screen
        Then User click on "button" "COLUMNS" in "AdvanceTable" screen
        When User click "Advance Table" and add below columns in "AdvanceTable" screen
            | Name       | Alignment             | ColumnType | FieldLabel |
            | Pin        | ColumnAlignmentCenter | Text Input | Pin        |
            | First Name | ColumnAlignmentCenter | Text Input | First Name |
            | Last Name  | ColumnAlignmentCenter | Text Input | Last Name  |
        When User click "Advance Table" and add below columns in "AdvanceTable" screen
            | Name   | Alignment             | ColumnType  | FieldLabel | NoofInput | Value1 | Value2 |
            | Gender | ColumnAlignmentCenter | Radio Group | Gender     | 2         | Male   | Female |
        When User click "Advance Table" and add below columns in "AdvanceTable" screen
            | Name   | Alignment             | ColumnType | FieldLabel | TypeOfFormat | CurrencyCountry |
            | Salary | ColumnAlignmentCenter | Number     | Salary     | Currency     | United States   |
        When User click "Advance Table" and add below columns in "AdvanceTable" screen
            | Name           | Alignment             | ColumnType | FieldLabel     |
            | Is US Resident | ColumnAlignmentCenter | Checkbox   | Is US Resident |
            | Email          | ColumnAlignmentCenter | Email      | Email          |
        When User click "Advance Table" and add below columns in "AdvanceTable" screen
            | Name            | Alignment             | ColumnType | FieldLabel      | NoofPages | Page1Name      | Page1Title     |
            | Address Details | ColumnAlignmentCenter | Modal      | Address Details | 1         | AddressDetails | AddressDetails |
        Then User click on "Button" "WidgetSave" in "UniqueWidgetFields" screen
        And User wait for "5000"
        Then User click on "button" "AddressDetail" in "UniqueWidgetFields" screen
        # When User expand "Modal" widgets in "CanvasBody" in "UniqueWidgetFields" screen
        # | Widget | X   | Y   |
        # | Modal  | 700 | 600 |
        And User Drag and Drop below widgets in "ModalBody" in "UniqueWidgetFields" screen
            | Widget  | X   | Y  | FieldName | FieldLabel |
            | Address | 100 | 50 | Address   | Address    |
        Then User click on "Button" "ModalClose" in "AdvanceTable" screen
        Then User click on "Button" "CanvasSave" in "UniqueWidgetFields" screen
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X   | Y   | FieldName        | FieldLabel       | Action | Status |
            | Button | 300 | 200 | Get All Accounts | Get All Accounts | None   | Save   |
        And User wait for "2000"
        # To Populate Action for a Button
        And User Configuring a Trigger on a "Button" "Get All Accounts" in "UniqueWidgetFields" screen
            | Title       | ClickAction | DataResources         | DataList                      |
            | Get All PII | Populate    | PI API for Automation | Get All PI API for Automation |
        And User wait for "5000"
        # To Configure Data Population for Advanced Table
        When User makes changes to below field's to Configure Data Population for "Advance Table" in "UniqueWidgetFields" screen
            | Field   | Title   | Trigger                        |
            | Actions | Get Pin | Get All Accounts : Get All PII |
        And User add Column and Response path for "Advance Table" in "UniqueWidgetFields" screen
            | Column               | ResponsePath |
            | Pin                  | Pin          |
            | First Name           | FirstName    |
            | Last Name            | LastName     |
            | Gender               | Gender       |
            | Salary               | Salary       |
            | Email                | Email        |
            | Address              | Line1        |
            | Address_1_locality   | Locality     |
            | Address_1_state      | State        |
            | Address_1_postalCode | Zipcode      |
            | Is US Resident       | IsUSCitizen  |
        Then User click on "Button" "WidgetSave" in "UniqueWidgetFields" screen
        And User wait for "2000"
        # To Edit Data Configuration for an Advanced Table
        Then User double click on "widget" "ActionsEdit" in "AdvanceTable" screen
        Then User click on "button" "ROWACTIONS" in "AdvanceTable" screen
        Then User click on "button" "EditDataConfiguration" in "AdvanceTable" screen
        And User "Edit" Data Configuration for "Advance Table" in "AdvanceTable" screen
            | Operations              | DataResources         | DataList                        | Type | UniqueField | Value |
            | Get Record By Unique Id | PI API for Automation | Get By Id PI API for Automation | ref  | PIId        | Pin   |

        And User add Column and Response path for "Advance Table" in "UniqueWidgetFields" screen
            | Column               | ResponsePath |
            | Pin                  | Pin          |
            | First Name           | FirstName    |
            | Last Name            | LastName     |
            | Gender               | Gender       |
            | Salary               | Salary       |
            | Email                | Email        |
            | Address              | Line1        |
            | Address_1_locality   | Locality     |
            | Address_1_state      | State        |
            | Address_1_postalCode | Zipcode      |
            | Is US Resident       | IsUSCitizen  |

        And User "Edit" Data Configuration for "Advance Table" in "AdvanceTable" screen
            | Operations                 | DataResources         | DataList                           | Type | UniqueField | Value |
            | Update Record By Unique Id | PI API for Automation | Update By Id PI API for Automation | ref  | PIId        | Pin   |

        And User add Column and Response path for "Advance Table" in "UniqueWidgetFields" screen
            | Column               | ResponsePath |
            | Pin                  | Pin          |
            | First Name           | FirstName    |
            | Last Name            | LastName     |
            | Gender               | Gender       |
            | Salary               | Salary       |
            | Email                | Email        |
            | Address              | Line1        |
            | Address_1_locality   | Locality     |
            | Address_1_state      | State        |
            | Address_1_postalCode | Zipcode      |
            | Is US Resident       | IsUSCitizen  |
        And User "Edit" Data Configuration for "Advance Table" in "AdvanceTable" screen
            | Operations      | DataResources         | DataList                      | Type | UniqueField | Value |
            | Get All Records | PI API for Automation | Get All PI API for Automation |      | PIId        | Pin   |
        And User add Column and Response path for "Advance Table" in "UniqueWidgetFields" screen
            | Column               | ResponsePath |
            | Pin                  | Pin          |
            | First Name           | FirstName    |
            | Last Name            | LastName     |
            | Gender               | Gender       |
            | Salary               | Salary       |
            | Email                | Email        |
            | Address              | Line1        |
            | Address_1_locality   | Locality     |
            | Address_1_state      | State        |
            | Address_1_postalCode | Zipcode      |
            | Is US Resident       | IsUSCitizen  |
        Then User click on "button" "DataConfigurationClose" in "AdvanceTable" screen
        # To Delete Data Configuration for an Advanced Table
        Then User click on "button" "DeleteDataConfiguration" in "AdvanceTable" screen
        And User "Delete" Data Configuration for "Advance Table" in "AdvanceTable" screen
            | Operations                 | DataResources         | DataList                           | Type | UniqueField | Value |
            | Delete Record By Unique Id | PI API for Automation | Delete By Id PI API for Automation | ref  | PIId        | Pin   |

        And User add Column and Response path for "Advance Table" in "UniqueWidgetFields" screen
            | Column               | ResponsePath |
            | Pin                  | Pin          |
            | First Name           | FirstName    |
            | Last Name            | LastName     |
            | Gender               | Gender       |
            | Salary               | Salary       |
            | Email                | Email        |
            | Address              | Line1        |
            | Address_1_locality   | Locality     |
            | Address_1_state      | State        |
            | Address_1_postalCode | Zipcode      |
            | Is US Resident       | IsUSCitizen  |
        Then User click on "button" "DataConfigurationClose" in "AdvanceTable" screen
        Then User click on "Button" "WidgetSave" in "UniqueWidgetFields" screen






