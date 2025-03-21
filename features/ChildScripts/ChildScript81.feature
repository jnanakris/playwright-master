Feature: Create New Application with Workday SOAP API

    @WorkdayAPIsetup @ChildScript81
    # @ChildScript
    #Created By: Mary
    #Created on : 01/02/2024
    Scenario Outline: Create New Application with Workday SOAP API

        Given user login to "Finlevit_admin" with "Admin" credentials
        And User get the Test data from "Usecase_TestData/ChildScript81" json file in "WorkFlow UI" screen
        Then User will open "GroupName" group in "HomePage" screen
        Then User click on "button" "group_settings" in "Groups" screen
        Then User will create AuthProvider name as "No Auth" with description and authType as "No Auth" in "GroupSetting" screen
        Then User click on "button" "apiSetup" in "GroupSetting" screen
        # Create Service Provider
        And User create service provider in "apiSetup" screen
            | SPName  | Description                           | EndPointURL                            | AuthorizationType | SPType   |
            | WorkDay | WorkDay SP created through automation | https://wd2-impl-services1.workday.com | No Auth           | External |
        # Create Service
        And User edit service provider and add service in "apiSetup" screen
            | SPName  | ServiceName | Description                      |
            | WorkDay | HR          | Service added through automation |

        # Create Operation
        And User edit service "HR" and add Operations with "SOAP" service, "POST" Request, "text/xml" ContentType and "No Parameters" in "apiSetup" screen
            | OperationName     | Path                                      | Description                        | Request                    | RequestTestOperation       | Response |
            | Get_Job_Positions | /ccx/service/tires1/Recruiting/v41.0      | Operation added through automation | #WorkdayRequest            | #WorkdayRequest            | {}       |
            | Get_Job_Profiles  | /ccx/service/tires1/Human_Resources/v36.0 | Operation added through automation | #WorkdayJobProfilesRequest | #WorkdayJobProfilesRequest | {}       |

        Then User click on "button" "dataSources" in "GroupSetting" screen
        Then User add the "WorkDay","Rest API" Data resource name it as "WorkDay_DS" add DataList and "UnSelect" ApplicationSourceSetup with below name service operation in "GroupSetting" screen
            | ListName             | Service | Operation         |
            | Get all Job Position | HR      | Get_Job_Positions |
            | Get all Job Profiles | HR      | Get_Job_Profiles  |

        Then User will open "GroupName" group in "HomePage" screen
        And User wait for "5000"
        # # App
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "3000"
        Then User see text "Front Office" in "FO" in "Page" screen

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X  | Y  | FieldName | Title   |
            | Container | 25 | 25 | Workday   | Workday |
        When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget  | X   | Y   |
            | Workday | 900 | 700 |
        Then User click on "span" "Save" in "Page" screen
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName   | FieldLabel  |
            | Text Input | 50  | 125 | positionsId | Position ID |
            | Text Input | 250 | 125 | wid         | WID         |
            | Number     | 450 | 125 | count       | Count       |
            | Number     | 50  | 250 | page        | Page        |

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget   | X   | Y   | FieldName | FieldLabel | OptionType       |
            | Dropdown | 750 | 125 | Jobid     | Jobid      | ConfigureOptions |

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName                                | FieldLabel                               |
            | Text Input | 250 | 250 | userName                                 | User Name                                |
            | Text Input | 450 | 250 | password                                 | Password                                 |
            | Checkbox   | 50  | 375 | Include_Position_Definition_Data         | Include_Position_Definition_Data         |
            | Checkbox   | 450 | 375 | Include_Position_Restrictions_Data       | Include_Position_Restrictions_Data       |
            | Checkbox   | 50  | 475 | Include_Default_Position_Organization_As | Include_Default_Position_Organization_As |
            | Checkbox   | 450 | 475 | Include_Worker_For_Filled_Positions_Data | Include_Worker_For_Filled_Positions_Data |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X  | Y   | FieldName | FieldLabel | Action | Status |
            | Button | 50 | 575 | Submit    | Submit     | Submit | Save   |
        And User set Default value "Position-3-5834" to the "Text Input" field "Position ID" in "UniqueWidgetFields" screen
        And User set Default value "622c21af1b080134f901044734226a53" to the "Text Input" field "WID" in "UniqueWidgetFields" screen
        And User set Default value "ISU_Read_NonSensitiveData@tires1" to the "Text Input" field "User Name" in "UniqueWidgetFields" screen
        And User set Default value "pSk@E#-$?M]gd9dF" to the "Text Input" field "Password" in "UniqueWidgetFields" screen
        And User set Default value "Include_Position_Definition_Data" to the "Checkbox" field "Include_Position_Definition_Data" in "UniqueWidgetFields" screen
        And User set Default value "Include_Position_Restrictions_Data" to the "Checkbox" field "Include_Position_Restrictions_Data" in "UniqueWidgetFields" screen
        And User set Default value "Include_Default_Position_Organization_As" to the "Checkbox" field "Include_Default_Position_Organization_As" in "UniqueWidgetFields" screen
        And User set Default value "Include_Worker_For_Filled_Positions_Data" to the "Checkbox" field "Include_Worker_For_Filled_Positions_Data" in "UniqueWidgetFields" screen
        Then User click on "span" "Save" in "Page" screen
        And User should contain text "Saved successfully" in "SavedSuccessfully" in "UniqueWidgetFields" screen
        # #To set Onload Triggers for get Position dropdown
        # And User create Onload Triggers with "1" Rule Options Mapping "addOnloadTrigger" in "onLoadTrigger" screen
        #     | Name        | Description | DataSource | DataList             | Rule1 | Ref1    | RootKey1                                                                                                                                                                 | Field1 | Label1                                                                                                                                                                                | Value1                                                                                                                                                                                | SourceOption                                                                                                       |
        #     | Job id | Job id | WorkDay_DS | Get all Job Profiles | Rule1 | element | Get all Job Profiles->root->env_Envelope->env_Body->wd_Get_Job_Profiles_Response->wd_Response_Data->wd_Job_Profile->array element of wd_Job_Profile->wd_Job_Profile_Data | Jobid  | Get all Job Profiles->root->env_Envelope->env_Body->wd_Get_Job_Profiles_Response->wd_Response_Data->wd_Job_Profile->array element of wd_Job_Profile->wd_Job_Profile_Data->wd_Job_Code | Get all Job Profiles->root->env_Envelope->env_Body->wd_Get_Job_Profiles_Response->wd_Response_Data->wd_Job_Profile->array element of wd_Job_Profile->wd_Job_Profile_Data->wd_Job_Code | Get all Job Profiles->root->env_Envelope->env_Body->wd_Get_Job_Profiles_Response->wd_Response_Data->wd_Job_Profile |
        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User see text "Back Office" in "BO" in "Page" screen
        And User wait for "3000"
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget  | X  | Y  |
            | Workday | 50 | 50 |
        Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen

        And User Drag and Drop in BO below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName        | FieldLabel         |
            | Text Input | 750 | 250 | JobPositionTitle | Job Position Title |
        Then User click on "span" "Save" in "Page" screen
        # And User should contain text "Saved successfully" in "SavedSuccessfully" in "UniqueWidgetFields" screen
        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen

        # To Add the required tasks onto the workflow Designer
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 200 | 100 |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget   | X   | Y   | TaskName | SuccesStatus | FailedStatus | FailureTaskRole     | DataSource | DataList             |
            | API Task | 376 | 152 | PostAPI  | In Progress  | In Progress  | Application Manager | WorkDay_DS | Get all Job Position |

        When User Edit "API task" "PostAPI" field to Configure Service in "tasks" screen
        Then User will create transformation rule for "API Task" "SaveOrders" in "transformation" screen
            | Destination                                                                                                                                                     | Source                                   |
            | Request->root->soap_Envelope->soap_Body->ns0_Get_Positions_Request->ns0_Response_Filter->ns0_Count                                                              | count                                    |
            | Request->root->soap_Envelope->soap_Body->ns0_Get_Positions_Request->ns0_Response_Filter->ns0_Page                                                               | page                                     |
            | Request->root->soap_Envelope->soap_Body->ns0_Get_Positions_Request->ns0_Response_Group->ns0_Include_Position_Restrictions_Data                                  | Include_Position_Restrictions_Data       |
            | Request->root->soap_Envelope->soap_Body->ns0_Get_Positions_Request->ns0_Response_Group->ns0_Include_Default_Position_Organization_Assignment_Data               | Include_Default_Position_Organization_As |
            | Request->root->soap_Envelope->soap_Body->ns0_Get_Positions_Request->ns0_Response_Group->ns0_Include_Worker_For_Filled_Positions_Data                            | Include_Worker_For_Filled_Positions_Data |
            | Request->root->soap_Envelope->soap_Body->ns0_Get_Positions_Request->ns0_Response_Group->ns0_Include_Position_Definition_Data                                    | Include_Position_Definition_Data         |
            | Request->root->soap_Envelope->soap_Body->ns0_Get_Positions_Request->ns0_Request_References->ns0_Positions_Reference->ns0_ID                                     | positionsId                              |
            | Request->root->soap_Envelope->soap_Body->ns0_Get_Positions_Request->ns0_Request_Criteria->ns0_Field_And_Parameter_Criteria_Data->ns0_Provider_Reference->ns0_ID | wid                                      |
            | Request->root->soap_Envelope->soap_Header->wsse_Security->wsse_UsernameToken->wsse_Username                                                                     | userName                                 |
            | Request->root->soap_Envelope->soap_Header->wsse_Security->wsse_UsernameToken->wsse_Password                                                                     | password                                 |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget           | X   | Y   | TaskName     | SuccesStatus | FailedStatus | FailureTaskRole     | Resources |
            | Response Mapping | 684 | 255 | Get Response | In Progress  | In Progress  | Application Manager | PostAPI   |
        When User Edit "Response task" "Get Response" field to Configure Service in "tasks" screen
        Then User will create transformation rule for "Response Task" "Get Response" in "transformation" screen
            | Destination      | Source                                                                                                                                                      |
            | JobPositionTitle | root->env_Envelope->env_Body->wd_Get_Positions_Response->wd_Response_Data->wd_Position->wd_Position_Data->wd_Position_Definition_Data->wd_Job_Posting_Title |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status | SLAHours | SLADays |
            | Task   | 917 | 255 | Review   | Application Manager | 1           | Accept  | In Progress   | 1        | 0       |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | End    | 686 | 380 |

        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source       | Action  | Target       |
            | Start        |         | PostAPI      |
            | PostAPI      | Success | Get Response |
            | Get Response | Success | Review       |
            | Review       | Accept  | End          |

        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        #  To validate Preview
        And User validate Payload app opening in a new tab
        Then User will "Logout" from "Page" the current session
        #   # Payload
        Given user login to payload application with "Finlevit_payload" with "1" agent
        And User Fill "1" in "Number" widget "Count" in "payload" screen
        And User Fill "1" in "Number" widget "Page" in "payload" screen
        And User wait for "1000"
        #     Then User click on "Dropdown" widget "Jobid" in "payload" screen
        # And User wait for "1000"
        # Then User should have count more than "2" in "DropdownValues" in "payload" screen
        # Then User click on "Dropdown" widget "Jobid" in "payload" screen
        # And User select drop down option "India" in "Jobid" widget in "payload" screen
        Then User click on "Button" widget "Submit" in "payload" screen
        And User get Transaction Id and save it in json file
        # Workflow
        Given user login to workflow UI "Finlevit_workflow" with "1" "AppManager" credentials
        And User wait until the "Filter Transaction id" appears in "WorkFlow UI" screen
        Then User click on "Button" "Home" in "HomePage" screen
        Then User will open "GroupName" group in "HomePage" screen
        Then User will search for "Application_Name" in "Application" screen
        And User wait for "5000"
        Then User click on "Menu" "Team Task" in "WorkFlow UI" screen
        And User wait until the spinner disappears
        And As "Agent" user verify Task "1" Details under "Team Task" in "WorkFlow UI" screen
        Then Based on the Task assigned to person logout or continue with the same user in "WorkFlow UI" screen for "Application_Name"
        And As "Application Manager" user verify Task "1" Details under "My Task" in "WorkFlow UI" screen
        Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
        And User validate "Text Input" widget "Job Position Title" is not empty in "WorkFlow UI" screen
        Then User validate Task "1" Actions and select "Accept" action in "WorkFlow UI" screen
        And User wait for "5000"
        And User validate Transaction details are removed from "Team Task" in "WorkFlow UI" screen
        Then User will "Logout" from "Page" the current session