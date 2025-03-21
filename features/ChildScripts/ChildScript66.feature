Feature: Use case to validate widget properties/features

        @ChildScript
        @ChildScript66
        @widgetAssertions
        #Created by:Mohan.S


        Scenario: Usecase to cover widget Validation

                Given user login to "Finlevit_admin" with "GroupAdmins" credentials
                And User get the Test data from "Usecase_TestData/ChildScript66" json file in "WorkFlow UI" screen
               Then User will open "GroupName" group in "HomePage" screen
                Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
                Then User will search for "Application_Name" in "Application" screen


                #TextArea
                #Default value not covered can be done in payload
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget    | X   | Y   | Fields      | Text        |
                        | Text Area | 400 | 200 | FieldName   |             |
                        | Text Area | 400 | 200 | FieldLabel  | Test        |
                        | Text Area | 400 | 200 | ToolTip     | Test        |
                        | Text Area | 400 | 200 | Hide        | Test        |
                        | Text Area | 400 | 200 | ReadOnly    | Test        |
                        | Text Area | 400 | 200 | Required    | Test        |
                        | Text Area | 400 | 200 | PlaceHolder | Test Design |

                #Email
                #Default value not covered can be done in payload
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget     | X   | Y   | Fields       | Text               |
                        | Email      | 400 | 200 | FieldName    |                    |
                        | Email      | 400 | 200 | FieldLabel   | Email              |
                        | Email      | 400 | 200 | PlaceHolder  | example@domain.com |
                        | Email      | 400 | 200 | PrefixText   | Verify             |
                        | Email      | 400 | 200 | SuffixText   | Verify             |
                        | Email      | 400 | 200 | ToolTip      | Verify             |
                        | Text Input | 400 | 200 | DefaultValue | Verify             |
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget | X   | Y   | Fields          | Text   |
                        | Email  | 400 | 200 | Required        | Verify |
                        | Email  | 400 | 200 | PrefixIcon      | Verify |
                        | Email  | 400 | 200 | SuffixIcon      | Verify |
                        | Email  | 400 | 200 | Hide            | Verify |
                        | Email  | 400 | 200 | ReadOnly        | Verify |
                        | Email  | 400 | 200 | ShowClearButton | Verify |


                #Phone Number
                #Default value not covered can be done in payload
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget       | X   | Y   | Fields      | Text         |
                        | Phone Number | 400 | 200 | FieldName   |              |
                        | Phone Number | 400 | 200 | FieldLabel  | Phone        |
                        | Phone Number | 400 | 200 | PlaceHolder | 212-333-3333 |
                        | Phone Number | 400 | 200 | PrefixText  | Phone        |
                        | Phone Number | 400 | 200 | SuffixText  | Phone        |
                        | Phone Number | 400 | 200 | ToolTip     | Phone        |
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget       | X   | Y   | Fields          | Text     |
                        | Phone Number | 400 | 200 | Required        | Phone    |
                        | Phone Number | 400 | 200 | PrefixIcon      | Phone    |
                        | Phone Number | 400 | 200 | SuffixIcon      | Phone    |
                        | Phone Number | 400 | 200 | Hide            | Phone    |
                        | Phone Number | 400 | 200 | ReadOnly        | Phone    |
                        | Phone Number | 400 | 200 | ShowClearButton | 65446456 |


                #Modal
                # When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                #         | Widget | X   | Y   | Fields       | Text       | Title |
                #         | Modal  | 400 | 200 | FieldName    |            |       |
                #         | Modal  | 400 | 200 | FieldLabel   | CheckModal |       |
                #         | Modal  | 400 | 200 | Hide         |            |       |
                #         | Modal  | 400 | 200 | ModalPopup   | Header     |       |
                #         | Modal  | 400 | 200 | ModalAddPage | Header     | Test  |


                #Password
                #Defaultvalue#Showicon#Hideicon-not covered
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget   | X   | Y   | Fields      | Text   |
                        | Password | 400 | 200 | FieldName   |        |
                        | Password | 400 | 200 | FieldLabel  | Verify |
                        | Password | 400 | 200 | PlaceHolder | Verify |
                        | Password | 400 | 200 | PrefixText  | Verify |
                        | Password | 400 | 200 | SuffixText  | Verify |
                        | Password | 400 | 200 | ToolTip     | Verify |
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget   | X   | Y   | Fields          | Text   |
                        | Password | 400 | 200 | Required        | Verify |
                        | Password | 400 | 200 | PrefixIcon      | Verify |
                        | Password | 400 | 200 | Hide            | Verify |
                        | Password | 400 | 200 | ReadOnly        | Verify |
                        | Password | 400 | 200 | ShowClearButton | Verify |



                #SSN / ITIN
                #Default value can be done in payload#showiconhideicon#Selectpattern-not covered
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget | X   | Y   | Fields      | Text        |
                        | SSN    | 400 | 200 | FieldName   |             |
                        | SSN    | 400 | 200 | FieldLabel  | SSN / ITIN  |
                        | SSN    | 400 | 200 | PlaceHolder | ***-**-**** |
                        | SSN    | 400 | 200 | PrefixText  | SSN         |
                        | SSN    | 400 | 200 | SuffixText  | SSN         |
                        | SSN    | 400 | 200 | ToolTip     | SSN         |
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget | X   | Y   | Fields          | Text       |
                        | SSN    | 400 | 200 | Required        | SSN / ITIN |
                        | SSN    | 400 | 200 | PrefixIcon      |            |
                        | SSN    | 400 | 200 | Hide            |            |
                        | SSN    | 400 | 200 | ReadOnly        |            |
                        | SSN    | 400 | 200 | ShowClearButton | 65446456   |
