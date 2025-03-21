Feature: Application with multiple task in BO.Button with service provider of save operation,API task with update operation,API task with delete operation,Response task

  @workflowDesignerApp @workflowDesigner
  #Createdby: Mary
  #Created on: 09/02/2023
  Scenario Outline: Validate Service Provider from Button Action
    Given user login to "Finlevit_admin" with "GroupAdmins" credentials
    When User enter create group with "GroupName" and "GroupDescription" in "Groups" screen
    # Clone Data sources for a group
    Then User click on "button" "group_settings" in "Groups" screen
    Then User click on "button" "dataSources" in "onLoadTrigger" screen
    And User clone Data Source "PI API for Automation" in "onLoadTrigger" screen
    Then User will open "GroupName" group in "HomePage" screen
    #To Create an Application
    Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
    Then User will search for "Application_Name" in "Application" screen
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget | X   | Y  | FieldName             | Value                |
      | Text   | 500 | 20 | Employee Registration | EmployeeRegistration |
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget         | X   | Y   | FieldName | AddTabFieldName      | AddTabTabLabel       |
      | Tabs Container | 180 | 100 | PII       | Personal Information | Personal Information |
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget     | X   | Y   | FieldName  | FieldLabel |
      | Text Input | 210 | 200 | Userid     | Userid |
      | Text Input | 400 | 200 | First Name | First Name |
      | Text Input | 600 | 200 | Last Name  | Last Name  |
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget | X   | Y   | FieldName | FieldLabel | PlaceHolder        |
      | Email  | 800 | 200 | Email     | Email      | example@domain.com |
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget       | X   | Y   | FieldName    | FieldLabel   |
      | Phone Number | 210 | 350 | Phone Number | Phone Number |

    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget  | X   | Y   | FieldName | FieldLabel |
      | Address | 210 | 500 | Address   | Address    |

    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget | X    | Y   | FieldName | FieldLabel | Action | Status |
      | Button | 210 | 700 | Submit    | Submit     | Submit | Save   |
    # Script to add service provider for a button
    Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
    When User makes changes to "Create Record" field to Configure API in "UniqueWidgetFields" screen
      | Action            | Category | Service               | Operation                  |
      | Service Providers | Internal | PI API for Automation | Save PI API for Automation |
    Then User will connect Input and Output nodes in "transformationUI" screen
      | Input              | Output             |
      | FirstName          | FirstName          |
      | Line1              | Line1              |
      | Locality           | Locality           |
      | State              | State              |
      | Zipcode            | Zipcode            |
      | CountryofResidence | CountryofResidence |
      | Email              | Email              |
      | Gender             | Gender             |
      | IsUSCitizen        | IsUSCitizen        |
      | LastName           | LastName           |
      | Phone              | Phone              |
      | Salary             | Salary             |
      | Pin                | Pin                |
    Then User click on "button" "WidgetSave" in "UniqueWidgetFields" screen
    Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
    Then User click on "tab" "Workflow Design" in "backOffice" screen
    # To Add the required tasks onto the workflow Designer
    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
      | Widget | X   | Y   |
      | Start  | 230 | 250 |

    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
      | Widget | X   | Y   |
      | End    | 845 | 250 |
    # Script to add API Task with Update By Id operation
    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
      | Widget   | X   | Y   | TaskName      | SuccesStatus | FailedStatus | FailureTaskRole     |DataSource      | DataList             |
      | API Task | 671 | 131 | Update Record | In Progress    | In Progress    | Application Manager |PI API for Automation | Update By Id PI API for Automation |
    When User Edit "API task" "Update Record" field to Configure Service in "tasks" screen
    Then User will create transformation rule for "API Task" "Save Employee" and connect Input and Output nodes in "transformation" screen
      | Destination        | Source             | UniqueField |
      | FirstName          | FirstName          |             |
      | Line1              | Line1              |             |
      | Locality           | Locality           |             |
      | State              | State              |             |
      | Zipcode            | Zipcode            |             |
      | CountryofResidence | CountryofResidence |             |
      | Email              | Email              |             |
      | Gender             | Gender             |             |
      | IsUSCitizen        | IsUSCitizen        |             |
      | LastName           | LastName           |             |
      | Phone              | Phone              |             |
      | Salary             | Salary             |             |
      | Pin                | Pin                |             |
      | Pin                | Pin                | Yes         |

    # Script to add API Task with Delete By Id operation
    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
      | Widget   | X   | Y   | TaskName      | SuccesStatus | FailedStatus | FailureTaskRole     |DataSource      | DataList             |
      | API Task | 672 | 328 | Delete Record | In Progress    | In Progress    | Application Manager |PI API for Automation | Delete By Id PI API for Automation |
    When User Edit "API task" "Delete Record" field to Configure Service in "tasks" screen
    Then User will create transformation rule for "API Task" "Save Employee" and connect Input and Output nodes in "transformation" screen
      | Destination        | Source             | 
      | Pin          | Pin          | 
    
    And User see text "API" in "API Task" in "tasks" screen
    # Script to add Response Mapping Task
    Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
      | Widget           | X   | Y   | TaskName     | SuccesStatus | FailedStatus | FailureTaskRole     |Resources     |
      | Response Mapping | 918 | 124 | Response     | In Progress  | In Progress    | Application Manager |Update Record|
    When User Edit "API task" "Response" field to Configure Service in "tasks" screen
    Then User will create transformation rule for "Response Task" "Get Employee" and connect Input and Output nodes in "transformation" screen
      | Destination | Source |
      | BOPin       | Pin    |
   
  @appBo
  Scenario: Workflow designer for existing app poc

    Given user login to "Finlevit_admin" with "GroupAdmins" credentials

    Then User will open "GroupName" group in "HomePage" screen
    Then User will search for "Application_Name" in "Application" screen

    Then User click on "tab" "Design" in "frontOffice" screen
    Then User click on "span" "BackOffice" in "frontOffice" screen
    Then User click on "tab" "Workflow Design" in "backOffice" screen
    Then User will connect "tasks" in "BackOfficeCanvas"
      | Source          | Action  | Target          |
      | Start           |         | Review          |
      | Review          | Accept  | Review & Upload |
      | Review & Upload | Accept  | Update Record   |
      | Review & Upload | Reject  | Delete Record   |
      | Update Record   | Success | Response        |
      | Response        | Success | End             |
      | Delete Record   | Success | End             |
    Then User click on "button" "Save" in "workflowDesigner" screen
