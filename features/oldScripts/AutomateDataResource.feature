Feature: Application to automate the data resources

    @dataResources @employerDetails
    #Created By: Mohan.S
    #Created on : 02/10/2023
    Scenario Outline: Use case to demonstrate automation of data resource

        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "resources/ExpectedData" json file in "WorkFlow UI" screen
        When User enter create group with "GroupName" and "GroupDescription" in "Groups" screen
        Then User click on "button" "group_settings" in "Groups" screen
        Then User click on "button" "apiSetup" in "GroupSetting" screen
        When User clone Service Provider "Rest Group APIs" in "GroupSetting" screen
        Then User click on "button" "dataSources" in "GroupSetting" screen
        Then User add the "Rest Group APIs" provider and name Data resource as "Employer Details" add DataList with below name service operation in "GroupSetting" screen
            | ListName                     | Service         | Operation            |
            | Get All EmployerDetails      | EmployerDetails | Get All              |
            | Save All EmployerDetails     | EmployerDetails | Save                 |
            | Get By Id EmployerDetails    | EmployerDetails | Get By Id            |
            | Get By Filter Field:Pin      | EmployerDetails | Get By Filter Field: |
            | Delete By Id EmployerDetails | EmployerDetails | Delete By            |
            | Update By Id EmployerDetails | EmployerDetails | Update By            |
        And User wait for "2000"

    @dataResources @CountriesForAutomation
    #Created By: Mohan.S
    #Created on : 02/10/2023
    Scenario Outline: Use case to demonstrate automation of data resource

        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "resources/ExpectedData" json file in "WorkFlow UI" screen
        When User enter create group with "GroupName" and "GroupDescription" in "Groups" screen
        Then User click on "button" "group_settings" in "Groups" screen
        Then User click on "button" "apiSetup" in "GroupSetting" screen
        When User clone Service Provider "Rest Group APIs" in "GroupSetting" screen
        Then User click on "button" "dataSources" in "GroupSetting" screen
        Then User add the "Rest Group APIs" provider and name Data resource as "Countries for Automation" add DataList with below name service operation in "GroupSetting" screen
            | ListName                   | Service   | Operation            |
            | Get All Countries          | Countries | Get All              |
            | Save All Countries         | Countries | Save                 |
            | Get By Id Countries        | Countries | Get By Id            |
            | Get By Filter Field:region | Countries | Get By Filter Field: |
            | Delete By Id Countries     | Countries | Delete By            |
            | Update By Id Countries     | Countries | Update By            |
        And User wait for "2000"

    @dataResources @StatesForAutomation
    #Created By: Mohan.S
    #Created on : 02/10/2023
    Scenario Outline: Use case to demonstrate automation of data resource

        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "resources/ExpectedData" json file in "WorkFlow UI" screen
        When User enter create group with "GroupName" and "GroupDescription" in "Groups" screen
        Then User click on "button" "group_settings" in "Groups" screen
        Then User click on "button" "apiSetup" in "GroupSetting" screen
        When User clone Service Provider "Rest Group APIs" in "GroupSetting" screen
        Then User click on "button" "dataSources" in "GroupSetting" screen
        Then User add the "Rest Group APIs" provider and name Data resource as "States For Automation" add DataList with below name service operation in "GroupSetting" screen
            | ListName                          | Service | Operation            |
            | Get All State                     | States   | Get All              |
            | Save All State                    | States   | Save                 |
            | Get By Id State                   | States   | Get By Id            |
            | Get By Filter Field: country_code | States   | Get By Filter Field: |
            | Delete By Id State                | States   | Delete By            |
            | Update By Id State                | States   | Update By            |
        And User wait for "2000"
