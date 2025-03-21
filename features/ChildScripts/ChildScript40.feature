Feature: Delete,Modify fields to Fo in multiple version


    @ChildScript
    @ChildScript40
    @editField

    #Createdby: Mohan.S
    Scenario: Delete,Modify fields to Fo in multiple version

        #CreateGroup
        Given user login to "Finlevit_admin" with "Admin" credentials
        And User get the Test data from "Usecase_TestData/ChildScript40" json file in "WorkFlow UI" screen
        Then User will open "GroupName" group in "HomePage" screen
        Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
        Then User will search for "Application_Name" in "Application" screen
        Then User see text "Front Office" in "FO" in "Page" screen

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget    | X   | Y   | FieldName            | Title                |
            | Container | 100 | 200 | PersonalInformation | Personal Information |

        When User expand "Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget               | X    | Y   |
            | Personal Information | 1200 | 500 |


        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget       | X   | Y   | FieldName   | FieldLabel   | PlaceHolder        | OptionType | Action | Status |
            | Email        | 250 | 250 | Email       | Email        | example@domain.com |            |        |        |
            | Phone Number | 500 | 250 | PhoneNumber | Phone Number |                    |            |        |        |
            | SSN          | 750 | 250 | ssnNumber    | SSN / ITIN   |                    |            |        |        |
        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget     | X   | Y   | FieldName  | FieldLabel |
            | Text Input | 200 | 420 | FirstName | First Name |
            | Text Input | 500 | 420 | LastName  | Last Name  |

        And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
            | Widget | X   | Y   | FieldName | FieldLabel | Action | Status |
            | Button | 675 | 700 | Submit    | Submit     | Submit | Save   |

        Then User click on "tab" "Design" in "Page" screen
        Then User "Edit" the "Agent" role and add "FO_Agent" in "Roles" screen

        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User Drag and Drop particular FO widgets in BO "CanvasBody" in "UniqueWidgetFields" screen
            | Widget               | X   | Y   |
            | PersonalInformation | 100 | 200 |
        When User click "Last Name" field and delete "UniqueWidgetFields" screen

        Then User click on "AllWidget" "BoAllWidgets" in "UniqueWidgetFields" screen
        # # And User write "Front Office" widgets in "FrontOffice_Widgets" in "UniqueWidgetFields" screen
        # # And User write "Back Office" widgets in "BackOffice_Widgets" in "UniqueWidgetFields" screen


        Then User "Edit" the "Application Manager" role and add "AppManager" in "Roles" screen
        Then User click on "tab" "Workflow Design" in "backOffice" screen
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | Start  | 150 | 225 |
        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   | TaskName | Role                | noOfActions | Action1 | Action1Status |
            | Task   | 500 | 200 | Review   | Application Manager | 1           | Accept  | In Progress   |

        Then User will Drag and Drop below task on "BackOfficeCanvas" in "tasks" screen
            | Widget | X   | Y   |
            | End    | 900 | 200 |

        Then User will connect "tasks" in "BackOfficeCanvas"
            | Source | Action | Target |
            | Start  |        | Review |
            | Review | Accept | End    |

        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        Then User click on "button" "VersionControl" in "Version" screen
        When User checkout the version "latest version" for app modification
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User click on "FrontOffice" "Click_FrontOffice" in "Application" screen

        When User click "Last Name" field and delete "UniqueWidgetFields" screen
        Then User click on "button" "CanvasSave" in "UniqueWidgetFields" screen
        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen
        Then User click on "button" "VersionControl" in "Version" screen
        When User checkout the version "latest version" for app modification
        Then User click on "BackOffice" "Click_BackOffice" in "Application" screen
        Then User click on "FrontOffice" "Click_FrontOffice" in "Application" screen

        When User modify "First Name" FieldName as "FullName" and FieldLabel as "FullName" field in "UniqueWidgetFields" screen
        Then User click on "button" "CanvasSave" in "UniqueWidgetFields" screen


        Then User click on "button" "VersionControl" in "Version" screen
        Then User will publish the app with latest changes after adding "VersionDescription" in "Version" screen

