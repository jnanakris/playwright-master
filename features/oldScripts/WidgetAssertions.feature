Feature: Use case to validate widget properties/features

        @widgetAssertions


        Scenario: Usecase to checkout the version

                Given user login to "Finlevit_admin" with "GroupAdmins" credentials
                And User get the Test data from "Usecase_TestData/WidgetAssertion" json file in "WorkFlow UI" screen
                When User enter create group with "GroupName" and "GroupDescription" in "Groups" screen
                Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
                Then User will search for "Application_Name" in "Application" screen


                #WidgetsNotCovered-StepperContainer,CollapseContainer,Upload,Image,Transaction,Address

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
                        | Text Input | 400 | 200 | FormulaField    | Verify |
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
                        | Number | 400 | 200 | ThousandSeparator | 1000000       | 1,000,000    |

                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget | X   | Y   | Fields             | Text   |
                        | Number | 400 | 200 | Required           | Verify |
                        | Number | 400 | 200 | PrefixIcon         | Verify |
                        | Number | 400 | 200 | SuffixIcon         | Verify |
                        | Number | 400 | 200 | ShowStepperButtons | Verify |
                        | Number | 400 | 200 | Hide               | Verify |
                        | Number | 400 | 200 | ReadOnly           | Verify |
                        | Number | 400 | 200 | FormulaField       | Verify |

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
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget | X   | Y   | Fields       | Text       | Title |
                        | Modal  | 400 | 200 | FieldName    |            |       |
                        | Modal  | 400 | 200 | FieldLabel   | CheckModal |       |
                        | Modal  | 400 | 200 | Hide         |            |       |
                        | Modal  | 400 | 200 | ModalPopup   | Header     |       |
                        | Modal  | 400 | 200 | ModalAddPage | Header     | Test  |


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

                #Divider
                #Alignmnet#positon#Fontsize-not covered
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget  | X   | Y   | Fields     | Text  |
                        | Divider | 400 | 200 | FieldName  |       |
                        | Divider | 400 | 200 | Text       | Test  |
                        | Divider | 400 | 200 | FontFamily | Arial |

                #Spacer
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget | X   | Y   | Fields    | Text |
                        | Spacer | 400 | 200 | FieldName |      |

                #Icon
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget | X   | Y   | Fields    | Text |
                        | Icon   | 400 | 200 | FieldName |      |
                        | Icon   | 400 | 200 | Hide      |      |
                        | Icon   | 400 | 200 | Icon      |      |
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget | X   | Y   | Fields     | Position   | CanvasPosition   |
                        | Icon   | 400 | 200 | Horizontal | IconRight  | IconCanvasRight  |
                        | Icon   | 400 | 200 | Horizontal | IconLeft   | IconCanvasLeft   |
                        | Icon   | 400 | 200 | Horizontal | IconCenter | IconCanvasCenter |
                        | Icon   | 400 | 200 | Vertical   | IconTop    | IconCanvasTop    |
                        | Icon   | 400 | 200 | Vertical   | IconMiddle | IconCanvasMiddle |
                        | Icon   | 400 | 200 | Vertical   | IconBottom | IconCanvasBottom |


                #Avatar
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget | X   | Y   | Fields       | Text       |
                        | Avatar | 400 | 200 | FieldName    |            |
                        | Avatar | 400 | 200 | FieldLabel   | AvatarTool |
                        | Avatar | 400 | 200 | Caption      | AvatarTool |
                        | Avatar | 400 | 200 | FallbackText | K          |
                        | Avatar | 400 | 200 | ToolTip      | Check      |
                        | Avatar | 400 | 200 | Hide         |            |

                #Header#Footer
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget | X   | Y   | Fields    | Text |
                        | Header | 400 | 200 | FieldName |      |
                        | Footer | 400 | 200 | FieldName |      |


                # AdvanceTable
                #sort#Showaddbutton#showEdit#ShowDelete#Readonly#showfilter
                #Tablecolumn-placeholder,#InputTab#ValidationTab#ConfigutationTab are not covered
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget        | X   | Y   | Fields             | Text |
                        | Advance Table | 400 | 200 | Name               |      |
                        | Advance Table | 400 | 200 | HideHeader         |      |
                        | Advance Table | 400 | 200 | OverflowPagination |      |
                        | Advance Table | 400 | 200 | OverflowScroll     |      |
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget        | X   | Y   | Fields                 | Text |
                        | Advance Table | 400 | 200 | PaginationTopCanvas    |      |
                        | Advance Table | 400 | 200 | PaginationBottomCanvas |      |
                        | Advance Table | 400 | 200 | Label                  | Test |
                        | Advance Table | 400 | 200 | Hide                   |      |
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget        | X   | Y   | Fields    | Text   | LabelAlignment           |
                        | Advance Table | 400 | 200 | Alignment | left   | RowActionAlignmentLeft   |
                        | Advance Table | 400 | 200 | Alignment | right  | RowActionAlignmentRight  |
                        | Advance Table | 400 | 200 | Alignment | center | RowActionAlignmentCenter |
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget        | X   | Y   | Fields          | CloumnName | FieldLabel | Alignment             | canvasAlignmnet |
                        | Advance Table | 400 | 200 | CloumnAssertion |            | check1     | ColumnAlignmentLeft   | left            |
                        | Advance Table | 400 | 200 | CloumnAssertion | Column2    | Check2     | ColumnAlignmentRight  | right           |
                        | Advance Table | 400 | 200 | CloumnAssertion | Column3    | Check3     | ColumnAlignmentCenter | center          |



                #Address
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget  | X   | Y   | Fields      | Text   |
                        | Address | 400 | 200 | FieldName   |        |
                        # | Address | 400 | 200 | FieldLabel  | Verify |
                        | Address | 400 | 200 | PlaceHolder | Verify |
                        | Address | 400 | 200 | PrefixText  | Verify |

                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget  | X   | Y   | Fields     | Text   |
                        | Address | 400 | 200 | SuffixText | Verify |
                #     | Address | 400 | 200 | ToolTip      | Verify |
                #     | Address | 400 | 200 | DefaultValue | Verify |
                # When User clear all the widgets in "UniqueWidgetFields" screen
                # When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                #     | Widget  | X   | Y   | Fields     | Text   |
                #     | Address | 400 | 200 | Required   | Verify |
                #     | Address | 400 | 200 | PrefixIcon | Verify |
                #     | Address | 400 | 200 | SuffixIcon | Verify |
                # When User clear all the widgets in "UniqueWidgetFields" screen
                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget  | X   | Y   | Fields       | Text   |
                        # | Address | 400 | 200 | Hide         | Address |
                        # | Address | 400 | 200 | ReadOnly     | Verify  |
                        | Address | 400 | 200 | FormulaField | Verify |

                When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
                        | Widget  | X   | Y   | Fields          | Text   |
                        # | Address | 400 | 200 | SuffixText   | Verify |
                        | Address | 400 | 200 | ShowClearButton | Verify |



                When User drag and drop "Address" widget and validate all the fields in canvas in "UniqueWidgetFields" screen
                        | WidgetType | Fields       | Text   |
                        | Address    | FieldName    |        |
                        | Address    | FieldLabel   | Verify |
                        | Address    | PlaceHolder  | Verify |
                        | Address    | PrefixText   | Verify |
                        | Address    | SuffixText   | Verify |
                        | Address    | ToolTip      | Verify |
                        | Address    | DefaultValue | Verify |










































































