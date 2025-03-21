Feature: Use case to validate widget properties/features

        # @ChildScript
        @ChildScript64
        @widgetAssertions
         #Created By: Mohan.S


        Scenario: Usecase to cover widget Validation

                Given user login to "Finlevit_admin" with "GroupAdmins" credentials
                And User get the Test data from "Usecase_TestData/ChildScript64" json file in "WorkFlow UI" screen
                Then User will open "GroupName" group in "HomePage" screen
                Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
                And User wait until the spinner disappears
                Then User will search for "Application_Name" in "Application" screen


                # #WidgetsNotCovered-StepperContainer,CollapseContainer,Upload,Image,Transaction,Address

                # TextInput
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget     | X   | Y   | Fields       | Text   |
                        | Text Input | 400 | 200 | FieldName    |        |
                        | Text Input | 400 | 200 | FieldLabel   | Verify |
                        | Text Input | 400 | 200 | PlaceHolder  | Verify |
                        | Text Input | 400 | 200 | PrefixText   | Verify |
                        | Text Input | 400 | 200 | SuffixText   | Verify |
                        | Text Input | 400 | 200 | ToolTip      | Verify |
                        | Text Input | 400 | 200 | DefaultValue | Verify |
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget     | X   | Y   | Fields          | Text   |
                        | Text Input | 400 | 200 | Required        | Verify |
                        | Text Input | 400 | 200 | PrefixIcon      | Verify |
                        | Text Input | 400 | 200 | SuffixIcon      | Verify |
                        | Text Input | 400 | 200 | Hide            | Verify |
                        | Text Input | 400 | 200 | ReadOnly        | Verify |
                        | Text Input | 400 | 200 | ShowClearButton | Verify |

                # #Number
                # show clear button need to be verified in payload
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget | X   | Y   | Fields            | Text          | ExpectedText |
                        | Number | 400 | 200 | FieldName         |               |              |
                        | Number | 400 | 200 | FieldLabel        | Verify        |              |
                        | Number | 400 | 200 | PlaceHolder       | Verify        |              |
                        | Number | 400 | 200 | PrefixText        | Verify        |              |
                        | Number | 400 | 200 | SuffixText        | Verify        |              |
                        | Number | 400 | 200 | ToolTip           | Verify        |              |
                        | Number | 400 | 200 | CurrencyType      | United States | $            |
                        # | Number | 400 | 200 | ThousandSeparator | 1000000       | 1,000,000    |

                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget | X   | Y   | Fields             | Text   |
                        | Number | 400 | 200 | Required           | Verify |
                        | Number | 400 | 200 | PrefixIcon         | Verify |
                        | Number | 400 | 200 | SuffixIcon         | Verify |
                        | Number | 400 | 200 | ShowStepperButtons | Verify |
                        | Number | 400 | 200 | Hide               | Verify |
                        | Number | 400 | 200 | ReadOnly           | Verify |

                #Button
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget | X   | Y   | Fields     | Text   |
                        | Button | 400 | 200 | FieldName  |        |
                        | Button | 400 | 200 | FieldLabel | Verify |
                        | Button | 400 | 200 | PrefixIcon |        |
                        | Button | 400 | 200 | SuffixIcon |        |
                        | Button | 400 | 200 | Hide       |        |
                        | Button | 400 | 200 | ReadOnly   |        |

                # DropDown
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget   | X   | Y   | Fields      | Text   |
                        | Dropdown | 400 | 200 | FieldName   |        |
                        | Dropdown | 400 | 200 | FieldLabel  | Verify |
                        | Dropdown | 400 | 200 | PlaceHolder | Verify |
                        | Dropdown | 400 | 200 | ToolTip     | Verify |
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget   | X   | Y   | Fields       | Text   |
                        | Dropdown | 400 | 200 | DefaultValue | Verify |
                        | Dropdown | 400 | 200 | Required     | Verify |
                        | Dropdown | 400 | 200 | Hide         |        |
                        | Dropdown | 400 | 200 | ReadOnly     |        |


                # RadioGroup
                #Coulmns count not covered
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget      | X   | Y   | Fields       | Text   | Value1 |
                        | Radio Group | 400 | 200 | FieldName    |        |        |
                        | Radio Group | 400 | 200 | FieldLabel   | Verify |        |
                        | Radio Group | 400 | 200 | ToolTip      | Verify |        |
                        | Radio Group | 400 | 200 | DefaultValue | Verify |        |
                        | Radio Group | 400 | 200 | Required     | Verify |        |
                        | Radio Group | 400 | 200 | Hide         |        |        |
                        | Radio Group | 400 | 200 | ReadOnly     | Verify |        |
                        | Radio Group | 400 | 200 | Values       | Test   | MAle   |
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget      | X   | Y   | Fields    | Text   | Value1 | Value2 | HorzontalAligment |
                        | Radio Group | 400 | 200 | Alignment | Gender | Male   | Female | True              |
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget      | X   | Y   | Fields    | Text   | Value1 | Value2 | HorzontalAligment |
                        | Radio Group | 400 | 200 | Alignment | Gender | Male   | Female | False             |

                #CheckboxGroup
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget         | X   | Y   | Fields      | Text     | Value1  |
                        | Checkbox Group | 400 | 200 | FieldName   |          |         |
                        | Checkbox Group | 400 | 200 | FieldLabel  | Verify   |         |
                        | Checkbox Group | 400 | 200 | WidgetValue | Verify   |         |
                        | Checkbox Group | 400 | 200 | Required    | Verify   |         |
                        | Checkbox Group | 400 | 200 | Hide        |          |         |
                        | Checkbox Group | 400 | 200 | ReadOnly    |          |         |
                        | Checkbox Group | 400 | 200 | Values      | Language | English |
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget         | X   | Y   | Fields    | Text     | LabelAlignment         | Value1  | Value2 | Value3 | HorzontalAligment |
                        | Checkbox Group | 650 | 300 | Alignment | Language | RowActionAlignmentLeft | English | Tamil  | Telugu | True              |
                        | Checkbox Group | 650 | 300 | Alignment | Language | RowActionAlignmentLeft | English | Tamil  | Telugu | False             |


                #Container
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget    | X   | Y   | Fields    | Text  |
                        | Container | 400 | 200 | FieldName |       |
                        | Container | 400 | 200 | Hide      |       |
                        | Container | 400 | 200 | Title     | Check |