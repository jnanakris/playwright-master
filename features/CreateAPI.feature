Feature: API Generator

    #Created by: Mary
    #Created on: 30/01/2023
    @createAPI@personalInfo
    Scenario: Use case to Create and Export API from API Generator

        Given user login to "Finlevit_admin" with "Admin" credentials
        And User get the Test data from "resources/TestData" json file in "WorkFlow UI" screen
        When User enter create group with "GroupName" and "GroupDescription" in "Groups" screen
        When User verify and create "PersonalInfo-Automation" serviceProvider in API generator "apiGenerator" screen
            | Name                    | Description                                                    | EndPoint     | uniqueField | FilterField | apiSchema          |
            | PersonalInfo-Automation | Api created  using AUTOMATION - Do not Modify / Delete / Clone | personalInfo | Pin         | Pin         | PersonalInfoSchema |

        When User upload "PersonalInfoData" data to "PersonalInfo-Automation" serviceProvider in "apiGenerator" screen
        When User verify "PersonalInfo-Automation" API and export service providers and DataSources to the group "GroupName" in "apiGenerator" screen

    @createAPI@employeeDetails
    Scenario: Use case to Create and Export API from API Generator

        Given user login to "Finlevit_admin" with "Admin" credentials
        And User get the Test data from "resources/TestData" json file in "WorkFlow UI" screen
        When User enter create group with "GroupName" and "GroupDescription" in "Groups" screen
        When User verify and create "EmployeeDetails" serviceProvider in API generator "apiGenerator" screen
            | Name            | Description                                                    | EndPoint        | uniqueField | FilterField | apiSchema             |
            | EmployeeDetails | Api created  using AUTOMATION - Do not Modify / Delete / Clone | employeeDetails | Pin         | Pin         | EmployeeDetailsSchema |

        When User upload "EmployeeDetailsData" data to "EmployeeDetails" serviceProvider in "apiGenerator" screen
        When User verify "EmployeeDetails" API and export service providers and DataSources to the group "GroupName" in "apiGenerator" screen

    @createAPI@employerDetails
    Scenario: Use case to Create and Export API from API Generator

        Given user login to "Finlevit_admin" with "Admin" credentials
        And User get the Test data from "resources/TestData" json file in "WorkFlow UI" screen
        When User enter create group with "GroupName" and "GroupDescription" in "Groups" screen
        When User verify and create "EmployerDetails-Automation" serviceProvider in API generator "apiGenerator" screen
            | Name                       | Description                                                    | EndPoint        | uniqueField | FilterField | apiSchema             |
            | EmployerDetails-Automation | Api created  using AUTOMATION - Do not Modify / Delete / Clone | employerDetails | Pin         | Pin         | EmployerDetailsSchema |

        When User upload "EmployerDetailsData" data to "EmployerDetails-Automation" serviceProvider in "apiGenerator" screen
        When User verify "EmployerDetails-Automation" API and export service providers and DataSources to the group "GroupName" in "apiGenerator" screen


    @createAPI @pIAPIforAutomation
    Scenario: Use case to Create and Export API from API Generator

        Given user login to "Finlevit_admin" with "Admin" credentials
        And User get the Test data from "resources/TestData" json file in "WorkFlow UI" screen
        When User enter create group with "GroupName" and "GroupDescription" in "Groups" screen
        When User verify and create "PI API for Automation" serviceProvider in API generator "apiGenerator" screen
            | Name                  | Description                                                    | EndPoint | uniqueField | FilterField | apiSchema                |
            | PI API for Automation | Api created  using AUTOMATION - Do not Modify / Delete / Clone | piApi    | Pin         | Pin         | pIAPIforAutomationSchema |

        When User upload "piApiAutomationData" data to "PI API for Automation" serviceProvider in "apiGenerator" screen
        When User verify "PI API for Automation" API and export service providers and DataSources to the group "GroupName" in "apiGenerator" screen


    @createAPI @maryPIDetails
    Scenario: Use case to Create and Export API from API Generator

        Given user login to "Finlevit_admin" with "Admin" credentials
        And User get the Test data from "resources/TestData" json file in "WorkFlow UI" screen
        When User enter create group with "GroupName" and "GroupDescription" in "Groups" screen
        When User verify and create "Mary PI Details" serviceProvider in API generator "apiGenerator" screen
            | Name            | Description                                                    | EndPoint  | uniqueField | FilterField | apiSchema           |
            | Mary PI Details | Api created  using AUTOMATION - Do not Modify / Delete / Clone | maryPiApi | Pin         | Pin         | MaryPIDetailsSchema |

        When User upload "MaryPIDetailsSchema" data to "Mary PI Details" serviceProvider in "apiGenerator" screen
        When User verify "Mary PI Details" API and export service providers and DataSources to the group "GroupName" in "apiGenerator" screen

    @createAPI @Countries
    Scenario: Create the States Api using the Schema file and upload the Data
        Given user login to "Finlevit_admin" with "Admin" credentials
        And User get the Test data from "resources/TestData" json file in "WorkFlow UI" screen
        When User enter create group with "GroupName" and "GroupDescription" in "Groups" screen
        When User verify and create "Countries" serviceProvider in API generator "apiGenerator" screen
            | Name      | Description                                                    | EndPoint | uniqueField | FilterField | apiSchema       |
            | Countries | Api created  using AUTOMATION - Do not Modify / Delete / Clone | country  | iso2        | region      | CountriesSchema |
        When User upload "CountriesData" data to "Countries" serviceProvider in "apiGenerator" screen
        When User verify "Countries" API and export service providers and DataSources to the group "GroupName" in "apiGenerator" screen

    @createAPI @States
    Scenario: Create the States Api using the Schema file and upload the Data
        Given user login to "Finlevit_admin" with "Admin" credentials
        And User get the Test data from "resources/TestData" json file in "WorkFlow UI" screen
        When User enter create group with "GroupName" and "GroupDescription" in "Groups" screen
        When User verify and create "States" serviceProvider in API generator "apiGenerator" screen
            | Name   | Description                                                    | EndPoint | uniqueField | FilterField | apiSchema       |
            | States | Api created  using AUTOMATION - Do not Modify / Delete / Clone | state    | id          | countryCode | StatesSchema |
        When User upload "StatesData" data to "States" serviceProvider in "apiGenerator" screen
        When User verify "States" API and export service providers and DataSources to the group "GroupName" in "apiGenerator" screen

    @CreateGroupAndAPI
    Scenario: Create group and Export API for the use case execution
        # Create group and Export API
        Given user login to "Finlevit_admin" with "Admin" credentials
        And User get the Test data from "resources/TestData" json file in "WorkFlow UI" screen
        When User enter create group with "GroupName" and "GroupDescription" in "Groups" screen
        # Create and Export PersonalInfo API
        When User verify and create "PersonalInfo" serviceProvider in API generator "apiGenerator" screen
            | Name         | Description                                                    | EndPoint     | uniqueField | FilterField | apiSchema          |
            | PersonalInfo | Api created  using AUTOMATION - Do not Modify / Delete / Clone | personalInfo | Pin         | Pin         | PersonalInfoSchema |
        When User upload "PersonalInfoData" data to "PersonalInfo" serviceProvider in "apiGenerator" screen
        When User verify "PersonalInfo" API and export service providers and DataSources to the group "GroupName" in "apiGenerator" screen
        # Create and Export EmployeeDetails API
        When User verify and create "EmployeeDetails" serviceProvider in API generator "apiGenerator" screen
            | Name            | Description                                                    | EndPoint        | uniqueField | FilterField | apiSchema             |
            | EmployeeDetails | Api created  using AUTOMATION - Do not Modify / Delete / Clone | employeeDetails | Pin         | Pin         | EmployeeDetailsSchema |
        When User upload "EmployeeDetailsData" data to "EmployeeDetails" serviceProvider in "apiGenerator" screen
        When User verify "EmployeeDetails" API and export service providers and DataSources to the group "GroupName" in "apiGenerator" screen
        # Create and Export EmployerDetails API
        When User verify and create "EmployerDetails" serviceProvider in API generator "apiGenerator" screen
            | Name            | Description                                                    | EndPoint        | uniqueField | FilterField | apiSchema             |
            | EmployerDetails | Api created  using AUTOMATION - Do not Modify / Delete / Clone | employerDetails | Pin         | Pin         | EmployerDetailsSchema |
        When User upload "EmployerDetailsData" data to "EmployerDetails" serviceProvider in "apiGenerator" screen
        When User verify "EmployerDetails" API and export service providers and DataSources to the group "GroupName" in "apiGenerator" screen
        # Create and Export PI API for Automation API
        When User verify and create "PI API for Automation" serviceProvider in API generator "apiGenerator" screen
            | Name                  | Description                                                    | EndPoint | uniqueField | FilterField | apiSchema                |
            | PI API for Automation | Api created  using AUTOMATION - Do not Modify / Delete / Clone | piApi    | Pin         | Pin         | piAPIForAutomationSchema |
        When User upload "piApiAutomationData" data to "PI API for Automation" serviceProvider in "apiGenerator" screen
        When User verify "PI API for Automation" API and export service providers and DataSources to the group "GroupName" in "apiGenerator" screen
       #Create and Export States API
        When User verify and create "States" serviceProvider in API generator "apiGenerator" screen
            | Name   | Description                                                    | EndPoint | uniqueField | FilterField | apiSchema       |
            | States | Api created  using AUTOMATION - Do not Modify / Delete / Clone | state    | id          | countryCode | StatesSchema |
        When User upload "StatesData" data to "States" serviceProvider in "apiGenerator" screen
        When User verify "States" API and export service providers and DataSources to the group "GroupName" in "apiGenerator" screen
        # Create and Export Mary PI Details API
        When User verify and create "Mary PI Details" serviceProvider in API generator "apiGenerator" screen
            | Name            | Description                                                    | EndPoint  | uniqueField | FilterField | apiSchema           |
            | Mary PI Details | Api created  using AUTOMATION - Do not Modify / Delete / Clone | maryPiApi | Pin         | Pin         | MaryPIDetailsSchema |
        When User upload "MaryPIDetailsData" data to "Mary PI Details" serviceProvider in "apiGenerator" screen
        When User verify "Mary PI Details" API and export service providers and DataSources to the group "GroupName" in "apiGenerator" screen
        #Create and Export Countries API
        When User verify and create "Countries" serviceProvider in API generator "apiGenerator" screen
            | Name      | Description                                                    | EndPoint | uniqueField | FilterField | apiSchema       |
            | Countries | Api created  using AUTOMATION - Do not Modify / Delete / Clone | country  | iso2        | region      | CountriesSchema |
        When User upload "CountriesData" data to "Countries" serviceProvider in "apiGenerator" screen
        When User verify "Countries" API and export service providers and DataSources to the group "GroupName" in "apiGenerator" screen
        Then User will "Logout" from "Page" the current session
