Feature: Use case to validate widget properties/features


  @ChildScript
  @ChildScript67
  @widgetAssertions
  #Created by:Mohan.S


  Scenario:Usecase to cover widget Validation

    Given user login to "Finlevit_admin" with "GroupAdmins" credentials
    And User get the Test data from "Usecase_TestData/ChildScript67" json file in "WorkFlow UI" screen
    Then User will open "GroupName" group in "HomePage" screen
    Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
    Then User will search for "Application_Name" in "Application" screen


    # #Divider
    # #Alignmnet#positon#Fontsize-not covered
    # When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
    #   | Widget  | X   | Y   | Fields     | Text  |
    #   | Divider | 400 | 200 | FieldName  |       |
    #   | Divider | 400 | 200 | Text       | Test  |
    #   | Divider | 400 | 200 | FontFamily | Arial |

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
      | Widget | X   | Y   | Fields             | Text |
      | Table  | 400 | 200 | Name               |      |
      | Table  | 400 | 200 | HideHeader         |      |
      | Table  | 400 | 200 | OverflowPagination |      |
      | Table  | 400 | 200 | OverflowScroll     |      |
    When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
      | Widget | X   | Y   | Fields                 | Text |
      | Table  | 400 | 200 | PaginationTopCanvas    |      |
      | Table  | 400 | 200 | PaginationBottomCanvas |      |
      | Table  | 400 | 200 | Label                  | Test |
      | Table  | 400 | 200 | Hide                   |      |
    When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
      | Widget | X   | Y   | Fields    | Text   | LabelAlignment           |
      | Table  | 400 | 200 | Alignment | left   | RowActionAlignmentLeft   |
      | Table  | 400 | 200 | Alignment | right  | RowActionAlignmentRight  |
      | Table  | 400 | 200 | Alignment | center | RowActionAlignmentCenter |
    # When User drag and drop below widget and validate below fields with text and validate it in canvas in "UniqueWidgetFields" screen
    #   | Widget | X   | Y   | Fields          | CloumnName | FieldLabel | Alignment             | canvasAlignmnet |
    #   | Table  | 400 | 200 | CloumnAssertion |            | check1     | ColumnAlignmentLeft   | left            |
    #   | Table  | 400 | 200 | CloumnAssertion | Column2    | Check2     | ColumnAlignmentRight  | right           |
    #   | Table  | 400 | 200 | CloumnAssertion | Column3    | Check3     | ColumnAlignmentCenter | center          |
