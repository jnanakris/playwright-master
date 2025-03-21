Feature: Application with data population(options and response mapping with trigger),merge task and Email task

    @sanityTestSuite
    @dataPopulation
    #Created By: Mohan.S
    #Created on : 02/10/2023
    Scenario: Use case to demonstrate onload triggers with onchange action,data population,merge task and Email task

        #CreateGroup
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "Usecase_TestData/DataPopulation" json file in "WorkFlow UI" screen
        # GroupSetting
        Then User will open "GroupName" group in "HomePage" screen
        Then User click on "button" "group_settings" in "Groups" screen
        Then User click on "button" "dataSources" in "onLoadTrigger" screen
        And User get unique field in Data Source "Countries" in "onLoadTrigger" screen and save it in "CountryId"
        And User get unique field in Data Source "PI API for Automation" in "onLoadTrigger" screen and save it in "PIId"
        Then User will open "GroupName" group in "HomePage" screen
        # To Create an Application
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        # widget
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X   | Y   | FieldName     | Title         |
            | Container | 180 | 120 | Personal Info | Personal Info |
        When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget        | X    | Y   |
            | Personal Info | 1100 | 900 |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName  | FieldLabel | PlaceHolder        | OptionType       | Action | Status |
            | Dropdown   | 400 | 110 | Pin        | Pin        |                    | ConfigureOptions |        |        |
            | Text Input | 210 | 200 | First Name | First Name |                    |                  |        |        |
            | Text Input | 400 | 200 | Last Name  | Last Name  |                    |                  |        |        |
            | Text Input | 600 | 200 | PinNPIN    | PinNPIN    |                    |                  |        |        |
            | Email      | 210 | 350 | Email      | Email      | example@domain.com |                  |        |        |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget      | X   | Y   | FieldName | FieldLabel | ValuesAlignment      | ValueCount | Value1 | Value2 |
            | Radio Group | 800 | 200 | Gender    | Gender     | ValueAlignHorizontal | 2          | Male   | Female |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget       | X   | Y   | FieldName      | FieldLabel     | ValuesAlignment | Value1 | Value2 | PlaceHolder | OptionType | Action | Status |
            | Phone Number | 400 | 350 | Phone Number   | Phone Number   |                 |        |        |             |            |        |        |
            | Checkbox     | 600 | 350 | Is US Citizen  | Is US Citizen  |                 |        |        |             |            |        |        |
            | Number       | 800 | 350 | Current Salary | Current Salary |                 |        |        |             |            |        |        |
        When User makes changes to "Current Salary" field format as in "UniqueWidgetFields" screen
            | TypeOfFormat | CurrencyCountry |
            | Currency     | United States   |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget   | X   | Y   | FieldName            | FieldLabel           | ValuesAlignment | Value1 | Value2 | PlaceHolder | OptionType       | Action | Status |
            | Dropdown | 210 | 500 | Country Of Residence | Country Of Residence |                 |        |        |             | ConfigureOptions |        |        |
            | Dropdown | 410 | 500 | States               | States               |                 |        |        |             | ConfigureOptions |        |        |
            | Divider  | 200 | 600 |                      |                      |                 |        |        |             |                  |        |        |
            | Address  | 210 | 650 | Address              | Address              |                 |        |        |             |                  |        |        |
            | Dropdown | 470 | 740 | State                | State                |                 |        |        |             | ConfigureOptions |        |        |
            | Button   | 800 | 800 | Submit               | Submit               |                 |        |        |             |                  | Submit | Save   |
        When User expand "Divider" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget  | X   | Y   |
            | Divider | 900 | 100 |
        When User make below field as Read only in "UniqueWidgetFields" screen
            | Widget     |
            | First Name |
            | Last Name  |
            | PinNPIN    |
            | Gender     |
            | Email      |
        When User make below field as Read only in "UniqueWidgetFields" screen
            | Widget         |
            | Phone Number   |
            | Is US Citizen  |
            | Current Salary |
            # | Country Of Residence |
            | Address        |
        # To set Onload Triggers
        And User create Onload Triggers with "1" Options Mapping "addOnloadTrigger" in "onLoadTrigger" screen
            | Name          | Description   | DataSource            | DataList                      | Field1               | Label1 | Value1 |
            | Get Countries | Get Countries | Countries             | Get All Countries             | Country Of Residence | name   | iso2   |
            | Get Pins      | Get Pins      | PI API for Automation | Get All PI API for Automation | Pin                  | Pin    | Pin    |
        # And User wait for "2000"
        # To Configure a Trigger on a Dropdown
        Then User click on "tab" "Design" in "Page" screen
        Then User see text "Front Office" in "FO" in "Page" screen
        And User Configuring a Trigger on a "Dropdown" "Pin" in "UniqueWidgetFields" screen
            | Title           | OnChangeAction | DataResources         | DataList                        | Type | UniqueField | Value |
            | Get PII Details | Populate       | PI API for Automation | Get By Id PI API for Automation | ref  | PIId        | Pin   |
        # To set Data Population for multiple widgets
        When User makes changes to below field's to Configure Data Population for "DropDown" in "UniqueWidgetFields" screen
            | Field      | Title      | Trigger               | ResponseField |
            | PinNPIN    | Get Pin    | Pin : Get PII Details | Pin           |
            | First Name | Get FN     | Pin : Get PII Details | FirstName     |
            | Last Name  | Get LN     | Pin : Get PII Details | LastName      |
            | Gender     | Get Gender | Pin : Get PII Details | Gender        |
        When User makes changes to below field's to Configure Data Population for "DropDown" in "UniqueWidgetFields" screen
            | Field          | Title            | Trigger               | ResponseField |
            | Email          | Get Email        | Pin : Get PII Details | Email         |
            | Phone Number   | Get Phone number | Pin : Get PII Details | Phone         |
            | Is US Citizen  | Get Citizenship  | Pin : Get PII Details | IsUSCitizen   |
            | Current Salary | Get Salary       | Pin : Get PII Details | Salary        |
        When User makes changes to below field's to Configure Data Population for "DropDown" in "UniqueWidgetFields" screen
            | Field                | Title       | Trigger               | ResponseField      |
            | Country Of Residence | Get Country | Pin : Get PII Details | CountryofResidence |
            | Address              | Get Line1   | Pin : Get PII Details | Line1              |
            | City                 | Get City    | Pin : Get PII Details | Locality           |
            | State                | Get State   | Pin : Get PII Details | State              |
            | Zip                  | Get Zip     | Pin : Get PII Details | Zipcode            |
        # To Configure a Trigger on a Dropdown (On Change Populate)
        And User Configuring a Trigger on a "Dropdown" "Country Of Residence" in "UniqueWidgetFields" screen
            | Title      | OnChangeAction | DataResources | DataList                         | Type | UniqueField | Value                |
            | Get States | Populate       | States        | Get By Filter Field: countryCode | ref  | CountryId   | Country Of Residence |

        And User Configuring Options mapping for a dropdown "States" in "UniqueWidgetFields" screen from "Get States" trigger in "Country Of Residence"
            | Title      | OptionLabel | OptionValue | Defaultkey |
            | Get States | name        | name        |            |
        #  To add Front Office Agent
        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget        | X   | Y  |
            | Personal Info | 200 | 90 |

        # # And User write "Front Office" widgets in "FrontOffice_Widgets" in "UniqueWidgetFields" screen
        # # And User write "Back Office" widgets in "BackOffice_Widgets" in "UniqueWidgetFields" screen


        # To add Back Office roles
        # Edit existing role
        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 150 | 225 |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status |SLAHours | SLADays |
            | Task   | 400 | 150 | Review 1 | Application Manager | 1           | Accept  | In Progress   |1        | 0       |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status |SLAHours | SLADays |
            | Task   | 400 | 300 | Review 2 | Application Manager | 1           | Accept  | In Progress   |1        | 0       |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName           | Status      |
            | Merge  | 600 | 225 | Merge After Review | In Progress |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | To     | Sub     | Template | FailureTaskRole     |
            | Email  | 800 | 225 | Email    | @Email | MailSub | MailBody | Application Manager |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | End    | 950 | 225 |
        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source   | Action | Target   |
            | Start    |        | Review 1 |
            | Start    |        | Review 2 |
            | Review 1 | Accept | Merge    |
            | Review 2 | Accept | Merge    |
            | Merge    |        | Email    |
            | Email    |        | End      |
        #  To validate Version Management
        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        #  To validate Preview
        And User validate Payload app opening in a new tab
        # Payload Validation
        Given user login to payload application with "Finlevit_payload" with "1" agent
        Then User click on "button" "countryDropdown" in "payload" screen
        And User wait for "1000"
        # Then User should have count "250" in "DropdownValues" in "payload" screen
        Then User click on "button" "countryDropdown" in "payload" screen
        And User select "Afghanistan" in "countryDropdown" dropdown in "payload" screen
        And User wait for "2000"
        Then User click on "button" "States" in "payload" screen
        And User wait for "1000"
        # Then User should have count "33" in "DropdownValues" in "payload" screen
        And User select "sdale" in "Pin" dropdown in "payload" screen
        And User wait for "2000"
        # And User select " " in "States" dropdown in "payload" screen
        Then User click on "button" "Submit_btn" in "payload" screen
        And User wait for "1000"
        And User get Transaction Id and save it in json file

