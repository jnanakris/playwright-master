Feature: FO - Validation of Email, Phone, SSN, and ITIN,Validate same on WF UI

    @ChildScript
    @ChildScript13
    @fieldValidation
    #Created By: Mohan.S
    Scenario: Use Case to demonstrate FO - Validation of Email, Phone, SSN, and ITIN,Validate same on WF UI

        #CreateGroup
        Given user login to "Finlevit_admin" with "GroupAdmins" credentials
        And User get the Test data from "Usecase_TestData/ChildScript13" json file in "WorkFlow UI" screen
        Then User will open "GroupName" group in "HomePage" screen
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        Then User see text "Front Office" in "FO" in "Page" screen
        And User wait until the spinner disappears
         And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
             | Widget    | X   | Y   | FieldName            | Title                |
             | Container | 100 | 200 | PersonalInformation | Personal Information |

         When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
             | Widget               | X    | Y   |
             | Personal Information | 1200 | 500 |


         And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
             | Widget       | X   | Y   | FieldName   | FieldLabel   | PlaceHolder        | OptionType | Action | Status |
             | Email        | 250 | 300 | Email       | Email        | example@domain.com |            |        |        |
             | Phone Number | 500 | 300 | PhoneNumber | Phone Number |                    |            |        |        |
             | SSN          | 750 | 300 | ssnNumber    | SSN / ITIN   |                    |            |        |        |

         And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
             | Widget | X   | Y   | FieldName | FieldLabel | Action | Status |
             | Button | 675 | 700 | Submit    | Submit     | Submit | Save   |

         Then User click on "tab" "Design" in "Page" screen
         Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen

         Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
         And User should contain text "Back Office" in "BO" in "Page" screen
         Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
             | Widget               | X   | Y   |
             | PersonalInformation | 100 | 200 |


         Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
         # # And User write "Front Office" widgets in "FrontOffice_Widgets" in "UniqueWidgetFields" screen
         # # And User write "Back Office" widgets in "BackOffice_Widgets" in "UniqueWidgetFields" screen


         Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
         Then User click on "tab" "Workflow Design" in "backOffice" screen
         Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
             | Widget | X   | Y   |
             | Start  | 150 | 225 |
         Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
             | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status |SLAHours | SLADays |
             | Task   | 500 | 200 | Review   | Application Manager | 1           | Accept  | In Progress   |1        | 0       |

         Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
             | Widget | X   | Y   |
             | End    | 900 | 200 |

         Then User will connect "tasks" in "BackOfficeCanvas"
             | Source | Action | Target |
             | Start  |        | Review |
             | Review | Accept | End    |

         Then User click on "button" "VersionControl" in "Version" screen
         Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
         #  To validate Preview
         And User validate Payload app opening in a new tab
         # Payload Validation
         Given user login to payload application with "Finlevit_payload" with "1" agent
         And User wait for "5000"
         #Phonenumber
         And User enter text "1223" in "PhoneNumber" in "payload" screen
         And User see text "Phone Number is not valid" in "NotaValidValue" in "payload" screen
         And User wait for "2000"
         When User Fill "" in "PhoneNumber" in "payload" screen
         And User enter "phoneNumber" in "Phone Number" with "10" characters
         And User wait for "5000"
         #Email
         And User enter text "@gmail.com" in "Email" in "payload" screen
         And User see text "Email is not valid" in "NotaValidValue" in "payload" screen
         And User wait for "2000"
         When User Fill "" in "Email" in "payload" screen
         And User enter text "AAAA" in "Email" in "payload" screen
         And User see text "Email is not valid" in "NotaValidValue" in "payload" screen
         And User wait for "2000"
         When User Fill "" in "Email" in "payload" screen
         And User enter "email" in "Email" with "4" characters
         #SSN
         And User enter "number" in "SSN / ITIN" with "1" characters
         And User see text "SSN / ITIN is not valid" in "NotaValidValue" in "payload" screen
         And User wait for "2000"
         When User Fill "" in "SSN" in "payload" screen
         And User enter "SSN" in "SSN / ITIN" with "9" characters
         Then User click on "button" "Submit_btn" in "payload" screen
         And User get Transaction Id and save it in json file

         #Workflow
         Given user login to workflow UI "Finlevit_workflow" with "1" "AppManager" credentials
         And User wait until the "Filter Transaction id" appears in "WorkFlow UI" screen
         Then User click on "Button" "Home" in "HomePage" screen
         Then User will open "GroupName" group in "HomePage" screen
         Then User will search for "Application_Name" in "Application" screen
         And User wait for "5000"
         And User validate Transaction table header under "Team Task" in "WorkFlow UI" screen
             | SLA | Transaction Id | Task Name | Priority | Created At | Submitted By | Last Updated By | Last Updated At | Assigned To |
         And As "Agent" user verify Task "1" Details under "Team Task" in "WorkFlow UI" screen
     Then Based on the Task assigned to person logout or continue with the same user in "WorkFlow UI" screen for "Application_Name"
         And As "Application Manager" user verify Task "1" Details under "My Task" in "WorkFlow UI" screen
         Then User click on "Transaction" "Transaction id Column Data" in "WorkFlow UI" screen
         And User validate left side menu options for the Task in "WorkFlow UI" screen
         And User wait for "2000"
         When User Fill "" in "PhoneNumber" in "payload" screen
         And User enter text "1223" in "PhoneNumber" in "payload" screen
         And User see text "Phone Number is not valid" in "NotaValidValue" in "payload" screen
         And User wait for "2000"
         When User Fill "" in "PhoneNumber" in "payload" screen
         And User enter "phoneNumber" in "Phone Number" with "10" characters
         And User wait for "5000"
         #Email
         When User Fill "" in "Email" in "payload" screen
         And User enter text "@gmail.com" in "Email" in "payload" screen
         And User see text "Email is not valid" in "NotaValidValue" in "payload" screen
         And User wait for "2000"
         When User Fill "" in "Email" in "payload" screen
         And User enter text "AAAA" in "Email" in "payload" screen
         And User see text "Email is not valid" in "NotaValidValue" in "payload" screen
         And User wait for "2000"
         When User Fill "" in "Email" in "payload" screen
         And User enter "email" in "Email" with "4" characters
         #SSN
         When User Fill "" in "SSN" in "payload" screen
         And User enter "number" in "SSN / ITIN" with "1" characters
         Then User click "Tab"
         And User see text "SSN / ITIN is not valid" in "NotaValidValue" in "payload" screen
         And User wait for "2000"
         When User Fill "" in "SSN" in "payload" screen
         And User enter "SSN" in "SSN / ITIN" with "9" characters
         Then User validate Task "1" Actions and select "Accept" action in "WorkFlow UI" screen
         Then User will "Logout" from "Page" the current session
         And User wait for "5000"








