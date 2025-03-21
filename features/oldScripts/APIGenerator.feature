Feature: API Generator

    #Created by: Mary
    #Created on: 30/01/2023
    @apiGenerator
    Scenario Outline: Use case to Create and Export API from API Generator
        Given user login to "<url>" with "<user>" credentials
        Then User click on "tab" "API Generator" in "HomePage" screen
        Then User click on "button" "createAPI_btn" in "apiGenerator" screen
        And User Drag "String" and Drop in "schemaContainer" in "apiGenerator" screen with "90" and "90" coordinator and name it as "Userid"
        And User Drag "String" and Drop under "Userid" in "apiGenerator" screen and name it as "FirstName"
        And User Drag "String" and Drop under "FirstName" in "apiGenerator" screen and name it as "LastName"
        And User Drag "Object" and Drop under "LastName" in "apiGenerator" screen and name it as "AddressDetail"
        And User Drag "String" and Drop under "Object" "AddressDetail" in "apiGenerator" screen and name it as "AddressDetail1"
        And User enter text "<API Name>" in "createAPINameInputBox" in "apiGenerator" screen
        And User enter text "<API Name>" in "createAPIDescInputBox" in "apiGenerator" screen
        And User enter text "<API Name>" in "createAPIEndPointInputBox" in "apiGenerator" screen
        And User select "div" tag drop down option "Userid" in "createAPIUniqueFieldInputBox" in "apiGenerator" screen
        And User select "div" tag drop down option "Userid" in "createAPIFilterInputBox" in "apiGenerator" screen
        Then User click on "button" "createAPIGenerateButton" in "apiGenerator" screen
        Then User click on "tab" "API Generator" in "HomePage" screen
        Then User click on "button" "searchAPIGenerator" in "apiGenerator" screen
        And User enter text "<API Name>" in "searchAPIGenerator" in "apiGenerator" screen
        Then User click on "button" "select_first_api" in "apiGenerator" screen
        And User see text "STRING" in "String" in "apiGenerator" screen
        And User select and upload a file "<File to upload>"
        And User select "span" tag drop down option "<groupName to Export>" in "Export To Service Providers" in "apiGenerator" screen
        And User select "span" tag drop down option "<groupName to Export>" in "Export To Data Resources" in "apiGenerator" screen


        Examples:
            | url            | user       | API Name              | groupName to Export | File to upload         |
            | Finlevit_admin | admin_user | Automation PI Details | QA Automation       | APIGeneratorInput.json |


