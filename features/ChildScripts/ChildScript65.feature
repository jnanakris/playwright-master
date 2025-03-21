Feature: Use case to validate widget properties/features

        # @ChildScript
        @ChildScript65
        @widgetAssertions
        #Created by:Mohan.S


        Scenario: Usecase to cover widget Validation

                Given user login to "Finlevit_admin" with "GroupAdmins" credentials
                And User get the Test data from "Usecase_TestData/ChildScript65" json file in "WorkFlow UI" screen
                Then User will open "GroupName" group in "HomePage" screen
                Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
                Then User will search for "Application_Name" in "Application" screen


                # Table
                #sort#Showaddbutton#showEdit#ShowDelete#Readonly
                #Tablecolumn-placeholder,#InputTab#ValidationTab#ConfigutationTab are not covered
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget | X   | Y   | Fields             | Text |
                        | Table  | 400 | 200 | Name               |      |
                        | Table  | 400 | 200 | HideHeader         |      |
                        | Table  | 400 | 200 | OverflowPagination |      |
                        | Table  | 400 | 200 | OverflowScroll     |      |
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget | X   | Y   | Fields                 | Text |
                        | Table  | 400 | 200 | PaginationTopCanvas    |      |
                        | Table  | 400 | 200 | PaginationBottomCanvas |      |
                        | Table  | 400 | 200 | FilterIconCanvas       | Test |
                        | Table  | 400 | 200 | Label                  | Test |
                        | Table  | 400 | 200 | Hide                   |      |
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget | X   | Y   | Fields    | Text   | LabelAlignment           |
                        | Table  | 400 | 200 | Alignment | left   | RowActionAlignmentLeft   |
                        | Table  | 400 | 200 | Alignment | right  | RowActionAlignmentRight  |
                        | Table  | 400 | 200 | Alignment | center | RowActionAlignmentCenter |
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget | X   | Y   | Fields          | CloumnName | FieldLabel | Alignment             | canvasAlignmnet |
                        | Table  | 400 | 200 | CloumnAssertion |            | check1     | ColumnAlignmentLeft   | left            |
                        | Table  | 400 | 200 | CloumnAssertion | Column2    | Check2     | ColumnAlignmentRight  | right           |
                        | Table  | 400 | 200 | CloumnAssertion | Column3    | Check3     | ColumnAlignmentCenter | center          |


                #TabContainer
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget         | X   | Y   | Fields    | Text  | Tab1 | Tab2    |
                        | Container      | 400 | 200 | FieldName |       |      |         |
                        | Tabs Container | 400 | 200 | AddTab    | Check | Name | Address |

                #Text
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget | X   | Y   | Fields    | Text  |
                        | Text   | 400 | 200 | FieldName |       |
                        | Text   | 400 | 200 | Value     | Hello |
                        | Text   | 400 | 200 | Hide      | Hello |
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget | X   | Y   | Fields    | Text   | VerticalAlign |
                        | Text   | 400 | 200 | Alignment | Top    | flex-start    |
                        | Text   | 400 | 200 | Alignment | Bottom | flex-end      |
                        | Text   | 400 | 200 | Alignment | Middle | center        |
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget | X   | Y   | Fields    | Text   | HorizontalAlign |
                        | Text   | 400 | 200 | Alignment | Left   | left            |
                        | Text   | 400 | 200 | Alignment | Center | center          |
                        | Text   | 400 | 200 | Alignment | Right  | right           |


                #Date
                #VALIDATION FOR DATE FORMAT AND DEFALUT DATE NOT COVERED
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget      | X   | Y   | Fields      | Text       |
                        | Date Picker | 400 | 200 | FieldName   |            |
                        | Date Picker | 400 | 200 | FieldLabel  | Today Date |
                        | Date Picker | 400 | 200 | PlaceHolder | Verify     |
                        | Date Picker | 400 | 200 | ToolTip     | Verify     |
                        | Date Picker | 400 | 200 | Required    | Verify     |
                        | Date Picker | 400 | 200 | Hide        | Verify     |
                        | Date Picker | 400 | 200 | ReadOnly    | Verify     |


                #CheckBox
                #Tool tip not covered can be done in payload
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget   | X   | Y   | Fields       | Text |
                        | Checkbox | 400 | 200 | FieldName    |      |
                        | Checkbox | 400 | 200 | FieldLabel   | Test |
                        | Checkbox | 400 | 200 | DefaultValue | Test |
                        | Checkbox | 400 | 200 | Hide         | Test |
                        | Checkbox | 400 | 200 | ReadOnly     | Test |
                        | Checkbox | 400 | 200 | Required     | Test |