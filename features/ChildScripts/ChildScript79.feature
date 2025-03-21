Feature: Existing application with Flat file and Bulk upsert to Mongo DB

    Background: Create File setup for Existing Application
        Given user login to "Finlevit_admin" with "Admin" credentials
        And User get the Test data from "Usecase_TestData/ChildScript79" json file in "WorkFlow UI" screen
        Then User will open "GroupName" group in "HomePage" screen
        Then User click on "button" "group_settings" in "Groups" screen
        Then User click on "button" "dataSources" in "GroupSetting" screen
        Then User add the "Generated APIs","MongoDB" Data resource name it as "Tririga-DB" add DataList and "UnSelect" ApplicationSourceSetup with below name service operation in "GroupSetting" screen
            | ListName     | DataBase | CollectionName | OperationType | ReturnSingleRecord | Query                                             | ResponseJson | RequestJson         |
            | Save Tririga | KON_API  | New_Tririga    | BULK UPSERT   |                    | {"uniqueKey": "{{uniqueKey}}", "data": {{data}} } | []           | Tririga_RequestJson |

        And User test connection for the document in "document" screen
            | Type | Root | AccessKey            | SecretKey                                | BucketName         | AWSRegion      |
            | S3   | SIT/ | AKIAVVCS3TID6M6RK3IJ | jsFIpgk+l+duBLWzKUZ9n54haljxtnoDvRoqtIgL | qaautomationkonfig | US East (Ohio) |
        Then User click on "Menu" "fileSetupMenu" in "HomePage" screen

        Then User will create app source setup with "File" in "appSourceSetup" screen
            | FileType  | FileSeparator | FolderType | SourceFolder        | ProcessedFolder     | FileUpload                       | AppMode |SourceName|
            | Flat File | \|            | S3         | #DocumentSourceName | #DocumentSourceName | CS79_tririga_site_Automation.csv | Batch   |New|

    @ChildScript79
    @ChildScript
    Scenario: Existing application with Flat file
        #CreateGroup
        # Given user login to "Finlevit_admin" with "Admin" credentials
        And User get the Test data from "Usecase_TestData/ChildScript79" json file in "WorkFlow UI" screen
        Then User will open "GroupName" group in "HomePage" screen
        And User wait for "5000"
        # App
        Then User will create "Existing" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "3000"
        When User click on "FrontOffice" "Click_FrontOffice" in "Application" screen
        Then User click on "span" "Save" in "Page" screen
        # And User write "Front Office" widgets in "FrontOffice_Widgets" in "UniqueWidgetFields" screen
        # add FO agent role
        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User see text "Back Office" in "BO" in "Page" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X  | Y  |
            | #FileName | 50 | 50 |
        Then User click on "span" "Save" in "Page" screen
        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        # To Add the required tasks onto the workflow Designer
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 230 | 250 |
            | End    | 845 | 250 |
        
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget   | X   | Y   | TaskName      | SuccesStatus | FailedStatus | FailureTaskRole     | DataSource | DataList     |BatchTransactions|ChunkSize|
            | API Task | 456 | 255 | Create Record | In Progress  | In Progress  | Application Manager | Tririga-DB | Save Tririga |Yes|10000|
        When User Edit "API task" "Create Record" field to Configure Service in "tasks" screen
        And User wait for "5000"
        Then User click on "button" "addRuleButton" in "transformation" screen
        Then User enter text "inserttoFile" in "Name" in "transformation" screen
        Then User add the below conditions in "expressionBuilder" screen
            | ConditionTypeCount | OperatorTypeCount1 | ConditionType1 | ConditionType1OperatorType1 |
            | 1                  | 1                  | Konfig         | Save To Database            |
        Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | Source                                                             |
            | Application->root->Single_Screen_Payload->#FileName->System_Record_ID  |
            | Application->root->Single_Screen_Payload->#FileName->Building_Type  |
            | Application->root->Single_Screen_Payload->#FileName->Store_Number           |
            | Application->root->Single_Screen_Payload->#FileName->Store_Status |
            | Application->root->Single_Screen_Payload->#FileName->Name |
            | Application->root->Single_Screen_Payload->#FileName->Address            |
            | Application->root->Single_Screen_Payload->#FileName->Address2          |
            | Application->root->Single_Screen_Payload->#FileName->City             |
            | Application->root->Single_Screen_Payload->#FileName->State_Province          |
            | Application->root->Single_Screen_Payload->#FileName->Zip_Postal_Code         |
            | Application->root->Single_Screen_Payload->#FileName->County          |
            | Application->root->Single_Screen_Payload->#FileName->Country             |
            | Application->root->Single_Screen_Payload->#FileName->Discount_Tire_or_Americas_Tire          |
            | Application->root->Single_Screen_Payload->#FileName->Campus_ID         |

            | Application->root->Single_Screen_Payload->#FileName->Region  |
            | Application->root->Single_Screen_Payload->#FileName->Region_Code  |
            | Application->root->Single_Screen_Payload->#FileName->SAP_Number           |
            | Application->root->Single_Screen_Payload->#FileName->Store_Type |
            | Application->root->Single_Screen_Payload->#FileName->TOD |
            | Application->root->Single_Screen_Payload->#FileName->GIS_Latitude            |
            | Application->root->Single_Screen_Payload->#FileName->GIS_Longitude          |
            | Application->root->Single_Screen_Payload->#FileName->Status             |
            | Application->root->Single_Screen_Payload->#FileName->Owned_Leased          |
            | Application->root->Single_Screen_Payload->#FileName->Year_Built         |
            | Application->root->Single_Screen_Payload->#FileName->Bays_Avg_Used          |
            | Application->root->Single_Screen_Payload->#FileName->Bays_Total             |
            | Application->root->Single_Screen_Payload->#FileName->Building_Size          |
            | Application->root->Single_Screen_Payload->#FileName->Common_Area         |

            | Application->root->Single_Screen_Payload->#FileName->Construction_Type             |
            | Application->root->Single_Screen_Payload->#FileName->Contract_Close_Date          |
            | Application->root->Single_Screen_Payload->#FileName->Flood_Zone         |
            | Application->root->Single_Screen_Payload->#FileName->Land_Size          |
            | Application->root->Single_Screen_Payload->#FileName->Roof_Type             |
            | Application->root->Single_Screen_Payload->#FileName->Sprinklers_Yes_or_No          |
            | Application->root->Single_Screen_Payload->#FileName->Unit_Capacity_Max         |
             | Application->root->Single_Screen_Payload->#FileName->Entrances          |
            | Application->root->Single_Screen_Payload->#FileName->Number_Of_Floors          |
            | Application->root->Single_Screen_Payload->#FileName->Parking_Space_Open         |

         Then User initiates the value for the below mentioned fields in "expressionBuilder" pageScreen
            | StringConstant |
            | System_Record_ID          |

        Then User click on "Button" "Save" in "transformation" screen
        And User wait for "2000"
        Then User click on "Button" "Close" in "transformation" screen
        And User wait for "2000"

       # To connect the tasks present on the workflow designer canvas
        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source        | Action  | Target        |
            | Start         |         | Create Record |
            | Create Record | Success | End           |
        Then User click on "button" "Save" in "workflowDesigner" screen
        #  To validate Version Management
        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        Then User will "Logout" from "Page" the current session
