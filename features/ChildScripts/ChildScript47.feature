
Feature: Application to check Delete Styles

  # @ChildScript
  @ChildScript47
  #Createdby: Mary
  #CreatedDate:06/09/2023
  Scenario: Use case to to check Delete Styles and check deleted style properies are removed from application

    Given user login to "Finlevit_admin" with "Admin" credentials
    And User get the Test data from "Usecase_TestData/ChildScript47" json file in "WorkFlow UI" screen
    # Then User will open "#GroupName" group in "HomePage" screen
    Then User delete group "#GroupName" in "Groups" screen
    When User create group "#GroupName" with description "Group - Created by Automation" in "Groups" screen
    # Add New style in group settings
    Then User click on "button" "group_settings" in "Groups" screen
    Then User click on "button" "StylesMenu" in "GroupSetting" screen
    And User add new style in "GroupSetting" screen
      | StyleName             | WidgetType | LabelFontStyle | LabelColor | LabelFontSize | InputFontStyle | InputColor | InputFontSize | DefaultGroup |
      | Automation Text Input | Text Input | Arial          | #4abab0    | 15            | Futura         | #194775    | 15            | Yes          |
      | Automation Number     | Number     | Arial          | #4abab0    | 15            | Futura         | #194775    | 15            | Yes          |
      | Automation Text Area  | Text Area  | Arial          | #4abab0    | 15            | Futura         | #194775    | 15            | Yes          |
      | Automation Email      | Email      | Arial          | #4abab0    | 15            | Futura         | #194775    | 15            | Yes          |
      | Automation Password   | Password   | Arial          | #4abab0    | 15            | Futura         | #194775    | 15            | Yes          |

    And User add new style in "GroupSetting" screen
      | StyleName              | WidgetType  | LabelFontStyle | LabelColor | LabelFontSize | InputFontStyle | InputColor | InputFontSize | DefaultGroup |
      | Automation PhoneNumber | PhoneNumber | Arial          | #4abab0    | 15            | Futura         | #194775    | 15            | Yes          |
      | Automation SSN Input   | SSN Input   | Arial          | #4abab0    | 15            | Futura         | #194775    | 15            | Yes          |
      | Automation Dropdown    | Dropdown    | Arial          | #4abab0    | 15            | Futura         | #194775    | 15            | Yes          |
      | Automation Date        | Date        | Arial          | #4abab0    | 15            | Futura         | #194775    | 15            | Yes          |

    And User add new style in "GroupSetting" screen
      | StyleName         | WidgetType | LabelFontStyle | LabelColor | LabelFontSize | LabelBGColor | DefaultGroup |
      | Automation Button | Button     | Arial          | #4abab0    | 15            | #b53f59      | Yes          |

    And User add new style in "GroupSetting" screen
      | StyleName            | WidgetType | TitleFontStyle | TitleFontSize | TitleBGColor | DefaultGroup |
      | Automation Container | Container  | Arial          | 15            | #b53f59      | Yes          |

    And User add new style in "GroupSetting" screen
      | StyleName                | WidgetType    | TabFontStyle | TabFontSize | TabBGColor | DefaultGroup |
      | Automation Tab Container | Tab Container | Arial        | 15          | #b53f59    | Yes          |

    And User add new style in "GroupSetting" screen
      | StyleName           | WidgetType | LabelFontStyle | LabelColor | LabelFontSize | CheckboxSize | CheckedBGColor | DefaultGroup |
      | Automation Checkbox | Checkbox   | Arial          | #4abab0    | 15            | 18           | #105cad        | Yes          |

    And User add new style in "GroupSetting" screen
      | StyleName                 | WidgetType     | LabelFontStyle | LabelColor | LabelFontSize | CheckboxSize | CheckedBGColor | OptionFontStyle | OptionLabelColor | OptionFontSize | DefaultGroup |
      | Automation Checkbox Group | Checkbox Group | Arial          | #4abab0    | 15            | 18           | #105cad        | Helvetica       | #c62525          | 15             | Yes          |

    And User add new style in "GroupSetting" screen
      | StyleName              | WidgetType  | LabelFontStyle | LabelColor | LabelFontSize | RadioButtonSize | SelectedBGColor | OptionFontStyle | OptionLabelColor | OptionFontSize | DefaultGroup |
      | Automation Radio Group | Radio Group | Arial          | #4abab0    | 15            | 15              | #105cad         | Helvetica       | #c62525          | 15             | Yes          |

    Then User click on "button" "Back to Group" in "GroupSetting" screen
    # To Create an Application
    Then User will create "New" app "AppName" with "AppDescription" in "Application" screen
    Then User will search for "Application_Name" in "Application" screen
    And User wait for "5000"
    Then User see text "Front Office" in "FO" in "Page" screen

    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget         | X  | Y  | FieldName            | AddTabFieldName      | AddTabTabLabel       |
      | Tabs Container | 50 | 50 | EmployeeInformation | PersonalInformation | Personal Information |

    When User expand "Tabs Container" widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget               | X   | Y   |
      | Personal Information | 950 | 550 |
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget       | X   | Y   | FieldName    | FieldLabel   |
      | Text Input   | 60  | 150 | FirstName   | First Name   |
      | Text Area    | 250 | 150 | SurName      | SurName      |
      | Phone Number | 450 | 150 | PhoneNumber | Phone Number |

    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget | X   | Y   | FieldName | FieldLabel | PlaceHolder        |
      | Email  | 650 | 150 | Email     | Email      | example@domain.com |

    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget      | X  | Y   | FieldName | FieldLabel    |
      | Date Picker | 60 | 300 | DOB       | Date of Birth |

    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget      | X   | Y   | FieldName | FieldLabel | ValuesAlignment    | ValueCount | Value1 | Value2 |
      | Radio Group | 250 | 300 | Gender    | Gender     | ValueAlignVertical | 2          | Male   | Female |

    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget | X   | Y   | FieldName | FieldLabel |
      | SSN    | 450 | 300 | ssnNumber  | SSN/ITIN   |

    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget         | X   | Y   | FieldName       | FieldLabel      | ValuesAlignment    | ValueCount | Value1  | Value2 | Value3 |
      | Checkbox Group | 650 | 300 | LanguagesKnown | Languages Known | ValueAlignVertical | 3          | English | Tamil  | Telugu |

    When User expand "Checkbox Group" widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget          | X   | Y   |
      | Languages Known | 800 | 500 |

    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget   | X  | Y   | FieldName     | FieldLabel    |
      | Checkbox | 60 | 490 | IsUSCitizen | Is US Citizen |

    When User add a Tab to "Personal Information" Container in "UniqueWidgetFields" screen
      | AddTabFieldName        | AddTabTabLabel         |
      | EmploymentInformation | Employment Information |
    Then User click on "Button" widget "Employment Information" in "payload" screen
    And User wait for "1000"
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget     | X   | Y   | FieldName | FieldLabel |
      | Text Input | 60  | 150 | UserName | User Name  |
      | Password   | 250 | 150 | Password  | Password   |
      | Number     | 450 | 150 | Salary    | Salary     |

    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget   | X   | Y   | FieldName | FieldLabel | OptionType    | ValueCount | Value1    | Value2    |
      | Dropdown | 650 | 150 | EmpType  | Emp Type   | ManualOptions | 2          | Full Time | Part Time |
    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget  | X  | Y   | FieldName | FieldLabel |
      | Address | 60 | 350 | Address   | Address    |

    When User makes changes to "Salary" field format as in "UniqueWidgetFields" screen
      | TypeOfFormat | CurrencyCountry |
      | Currency     | United States   |

    And User Drag and Drop below widgets in "CanvasBody" in "UniqueWidgetFields" screen
      | Widget | X   | Y   | FieldName | FieldLabel | Action | Status |
      | Button | 800 | 620 | Submit    | Submit     | Submit | Save   |

    Then User click on "Menu" "Home" in "HomePage" screen
    Then User will "Logout" from "Page" the current session
    Given user login to "Finlevit_admin" with "Admin" credentials
     Then User will open "#GroupName" group in "HomePage" screen
    # Edit style in group settings
    Then User click on "button" "group_settings" in "Groups" screen
    Then User click on "button" "StylesMenu" in "GroupSetting" screen
    And User Delete style in "GroupSetting" screen
      | StyleName             | WidgetType |
      | Automation Text Input | TextInput  |
      | Automation Number     | Number     |
      | Automation Text Area  | TextArea   |
      | Automation Email      | Email      |
      | Automation Password   | Password   |

    And User Delete style in "GroupSetting" screen
      | StyleName              | WidgetType  |
      | Automation PhoneNumber | PhoneNumber |
      | Automation SSN Input   | SSNInput    |
      | Automation Dropdown    | Dropdown    |
      | Automation Date        | Date        |
      | Automation Button      | Button      |

    And User Delete style in "GroupSetting" screen
      | StyleName                 | WidgetType    |
      | Automation Tab Container  | TabContainer  |
      | Automation Checkbox       | Checkbox      |
      | Automation Checkbox Group | CheckboxGroup |
      | Automation Radio Group    | RadioGroup    |

    Then User click on "button" "Back to Group" in "GroupSetting" screen
    # To Create an Application
    Then User will search for "Application_Name" in "Application" screen
    And User wait for "5000"
    Then User see text "Front Office" in "FO" in "Page" screen

    Then User click on "Button" widget "Personal Information" in "payload" screen
    And User validate CSS Property for "Delete" style in "UniqueWidgetFields" screen
      | WidgetName             | WidgetType     | FontSize | FontStyle                                                                                                                                     | Color           | InputFontSize | InputFontStyle                                                                                                                                | InputColor      |
      | Personal Information   | Tabs Container | 16px     | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(73, 80, 87) |               |                                                                                                                                               |                 |
      | Employment Information | Tabs Container | 16px     | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(73, 80, 87) |               |                                                                                                                                               |                 |
      | First Name             | Text Input     | 16px     | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(55, 63, 81) | 16px          | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(73, 80, 87) |
      | SurName                | Text Area      | 16px     | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(55, 63, 81) | 16px          | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(73, 80, 87) |
      | Phone Number           | Phone Number   | 16px     | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(55, 63, 81) | 16px          | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(73, 80, 87) |
    And User validate CSS Property for "Delete" style in "UniqueWidgetFields" screen
      | WidgetName    | WidgetType  | FontSize | FontStyle                                                                                                                                     | Color           | InputFontSize | InputFontStyle                                                                                                                                | InputColor      |
      | Email         | Email       | 16px     | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(55, 63, 81) | 16px          | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(73, 80, 87) |
      | Date of Birth | Date Picker | 16px     | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(55, 63, 81) | 16px          | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(73, 80, 87) |
      | SSN/ITIN      | SSN         | 16px     | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(55, 63, 81) | 16px          | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(73, 80, 87) |

    And User validate CSS Property for "Delete" style in "UniqueWidgetFields" screen
      | WidgetName | WidgetType  | FontSize | FontStyle                                                                                                                                     | Color           | OptionFontSize | OptionFontStyle                                                                                                                               | OptionLabelColor |
      | Gender     | Radio Group | 16px     | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(55, 63, 81) | 16px           | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(51, 65, 85)  |

    And User validate CSS Property for "Delete" style in "UniqueWidgetFields" screen
      | WidgetName      | WidgetType     | FontSize | FontStyle                                                                                                                                     | Color           | OptionFontSize | OptionFontStyle                                                                                                                               | OptionLabelColor |
      | Languages Known | Checkbox Group | 16px     | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(55, 63, 81) | 16px           | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(73, 80, 87)  |

    And User validate CSS Property for "Delete" style in "UniqueWidgetFields" screen
      | WidgetName    | WidgetType | FontSize | FontStyle                                                                                                                                                    | Color           |
      | Is US Citizen | Checkbox   | 16px     | "SF Pro Text", -apple-system, BlinkMacSystemFont, Roboto, "Segoe UI", Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(73, 80, 87) |

    And User validate CSS Property for "Delete" style in "UniqueWidgetFields" screen
      | WidgetName | WidgetType | FontSize | FontStyle                                                                                                                                     | Color              | BgColor          |
      | Submit     | Button     | 14px     | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(255, 255, 255) | rgb(103, 47, 199) |

    Then User click on "Button" widget "Employment Information" in "payload" screen
    And User validate CSS Property for "Delete" style in "UniqueWidgetFields" screen
      | WidgetName | WidgetType | FontSize | FontStyle                                                                                                                                     | Color           | InputFontSize | InputFontStyle                                                                                                                                | InputColor      |
      | User Name  | Text Input | 16px     | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(55, 63, 81) | 16px          | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(73, 80, 87) |
      | Password   | Password   | 16px     | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(55, 63, 81) | 16px          | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(73, 80, 87) |
      | Salary     | Number     | 16px     | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(55, 63, 81) | 16px          | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(73, 80, 87) |
      | Emp Type   | Dropdown   | 16px     | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(55, 63, 81) | 16px          | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(73, 80, 87) |
    And User validate CSS Property for "Delete" style in "UniqueWidgetFields" screen
      | WidgetName     | WidgetType | FontSize | FontStyle                                                                                                                                     | Color           | InputFontSize | InputFontStyle                                                                                                                                | InputColor      |
      | Address        | Text Input | 16px     | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(55, 63, 81) | 16px          | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(73, 80, 87) |
      | Address Line 2 | Text Input | 16px     | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(55, 63, 81) | 16px          | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(73, 80, 87) |
      | City           | Text Input | 16px     | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(55, 63, 81) | 16px          | -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple color Emoji", "Segoe UI Emoji", "Segoe UI Symbol" | rgb(73, 80, 87) |
