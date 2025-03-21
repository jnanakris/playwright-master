Feature: Use case to checkout the version and do necessary changes

    @versionManagement
    #Createdby: Mohan.s
    #CreatedDate:30Jan23
    #REsponseMapping_OptionsMapping
    Scenario Outline: Usecase to checkout the version

        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        When User enter create group with "GroupName" and "GroupDescription" in "Groups" screen
        Then User will search for "Application_Name" in "Application" screen
        Then User click on "button" "VersionControl" in "Version" screen
        When User checkout the version "latest version" for app modification