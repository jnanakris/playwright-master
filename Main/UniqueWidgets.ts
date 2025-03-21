import { ScreenMap } from "../Utility/Source/Core";
import { CommonUtilObject } from "../Utility/Util/CommonUtil";
import { context, page } from "../steps/world";
import { Actions } from "../Utility/Util/Actions";
import { Assertions } from "../Utility/Util/Assertions";
import { expect } from "@playwright/test";
import moment = require("moment");

let action: Actions = new Actions();
let assertion: Assertions = new Assertions();
export class UniqueWidgets {
  async inputTypeWidget(destElement, pageScreen, formValues) {
    await action.ClickElement("SearchWidget", pageScreen);
    await action.enterText(formValues.Widget, "SearchWidget", pageScreen);
    await page.waitForTimeout(3000);
    await action.dragAndDropWidgets(
      formValues.Widget,
      destElement,
      Number(formValues.X),
      Number(formValues.Y),
      "AllWidgets"
    );
    await action.fillText(formValues.FieldName, "FieldName", pageScreen);
    await action.fillText(formValues.FieldLabel, "FieldLabel", pageScreen);
    await page.waitForTimeout(3000);
    await action.ClickElement("WidgetSave", pageScreen);
    await assertion.checktext(
      "SavedSuccessfully",
      pageScreen,
      "Saved successfully"
    );
    await action.ClickElement("CancelSearchWidget", pageScreen);
    console.log("------- Cleared the Widget Search ---------------");
  }

  async TextWidget(destElement, pageScreen, formValues) {
    await action.ClickElement("SearchWidget", pageScreen);
    await action.enterText(formValues.Widget, "SearchWidget", pageScreen);
    await page.waitForTimeout(3000);
    await action.dragAndDropWidgets(
      formValues.Widget,
      destElement,
      Number(formValues.X),
      Number(formValues.Y),
      "AllWidgets"
    );
    await action.fillText(formValues.FieldName, "FieldName", pageScreen);
    await action.ClickElement("TEXT", pageScreen);
    await action.selectDropdownbyspantext("Style", pageScreen, formValues.Style);
    await action.ClickElement(formValues.HorizontalAlign, pageScreen);
    await action.ClickElement(formValues.VerticalAlign, pageScreen);
    await action.fillText(formValues.Value, "Value", pageScreen);
    await action.ClickElement("WidgetSave", pageScreen);
    // await assertion.checktext(
    //   "SavedSuccessfully",
    //   pageScreen,
    //   "Saved successfully"
    // );
    await action.ClickElement("CancelSearchWidget", pageScreen);
    console.log("------- Cleared the Widget Search ---------------");
    await page.waitForTimeout(2000);
  }

  async NumberWidget(destElement, pageScreen, formValues) {
    await action.ClickElement("SearchWidget", pageScreen);
    await action.enterText(formValues.Widget, "SearchWidget", pageScreen);
    await page.waitForTimeout(3000);
    await action.dragAndDropWidgets(
      formValues.Widget,
      destElement,
      Number(formValues.X),
      Number(formValues.Y),
      "AllWidgets"
    );
    await action.fillText(formValues.FieldName, "FieldName", pageScreen);
    await action.fillText(formValues.FieldLabel, "FieldLabel", pageScreen);
    await page.waitForTimeout(2000);
    await action.ClickElement("WidgetSave", pageScreen);
    await assertion.checktext(
      "SavedSuccessfully",
      pageScreen,
      "Saved successfully"
    );
    await action.ClickElement("CancelSearchWidget", pageScreen);
    await page.waitForTimeout(2000);
  }

  async DatePickerWidget(destElement, pageScreen, formValues) {
    await action.ClickElement("SearchWidget", pageScreen);
    await action.enterText(formValues.Widget, "SearchWidget", pageScreen);
    await page.waitForTimeout(3000);
    await action.dragAndDropWidgets(
      formValues.Widget,
      destElement,
      Number(formValues.X),
      Number(formValues.Y),
      "AllWidgets"
    );
    await action.fillText(formValues.FieldName, "FieldName", pageScreen);
    await action.fillText(formValues.FieldLabel, "FieldLabel", pageScreen);
    await action.ClickElement("WidgetSave", pageScreen);
    await assertion.checktext(
      "SavedSuccessfully",
      pageScreen,
      "Saved successfully"
    );
    await action.ClickElement("CancelSearchWidget", pageScreen);
    console.log("------- Cleared the Widget Search ---------------");
    await page.waitForTimeout(2000);
  }

  async HeaderWidget(destElement, pageScreen, formValues) {
    await action.ClickElement("SearchWidget", pageScreen);
    await action.enterText(formValues.Widget, "SearchWidget", pageScreen);
    await page.waitForTimeout(3000);
    await action.dragAndDropWidgets(
      formValues.Widget,
      destElement,
      Number(formValues.X),
      Number(formValues.Y),
      "AllWidgets"
    );
    await action.fillText(formValues.FieldName, "FieldName", pageScreen);
    await action.ClickElement("WidgetSave", pageScreen);
    await assertion.checktext(
      "SavedSuccessfully",
      pageScreen,
      "Saved successfully"
    );
    await action.ClickElement("CancelSearchWidget", pageScreen);
    console.log("------- Cleared the Widget Search ---------------");
    await page.waitForTimeout(3000);
  }

  async AddressWidget(destElement, pageScreen, formValues) {
    await action.ClickElement("SearchWidget", pageScreen);
    await action.enterText(formValues.Widget, "SearchWidget", pageScreen);
    await page.waitForTimeout(3000);
    await action.dragAndDropWidgets(
      formValues.Widget,
      destElement,
      Number(formValues.X),
      Number(formValues.Y),
      "AllWidgets"
    );
    await action.fillText(formValues.FieldName, "FieldName", pageScreen);
    await action.fillText(formValues.FieldLabel, "FieldLabel", pageScreen);
    await page.waitForTimeout(3000);
    await action.ClickElement("WidgetSave", pageScreen);
    await assertion.checktext(
      "SavedSuccessfully",
      pageScreen,
      "Saved successfully"
    );
    await action.ClickElement("CancelSearchWidget", pageScreen);
    console.log("------- Cleared the Widget Search ---------------");
    await page.waitForTimeout(3000);
  }

  async ExpandWidget(elementName, destElement, pageScreen, XCord, YCord) {
    let srcElement: any =
      "//grid-field-container//div[contains(text(),'" +
      elementName +
      "')]/../../../..//div[@class='corner bottom-right']//div[@class='resize-handle']";
    let desElement: any = await ScreenMap.get(pageScreen).getSelector(
      destElement
    );
    await action.dragAndDropWidgets(srcElement, desElement,
      XCord,YCord, pageScreen );
    console.log("save");
  }

  async AdvancetableWidget(destElement, pageScreen, formValues) {
    await action.ClickElement("SearchWidget", pageScreen);
    await action.enterText(formValues.Widget, "SearchWidget", pageScreen);
    await page.waitForTimeout(500);
    await action.dragAndDropWidgets(
      formValues.Widget,
      destElement,
      Number(formValues.X),
      Number(formValues.Y),
      "AllWidgets"
    );
    await action.fillText(formValues.Name, "Name", pageScreen);
    await action.ClickElement("WidgetSave", pageScreen);
    // await assertion.checktext(
    //   "SavedSuccessfully",
    //   pageScreen,
    //   "Saved successfully"
    // );
    await action.ClickElement("CancelSearchWidget", pageScreen);
  }

  async containerWidget(destElement, pageScreen, formValues) {
    await action.ClickElement("SearchWidget", pageScreen);
    await action.enterText(formValues.Widget, "SearchWidget", pageScreen);
    await page.waitForTimeout(500);
    await action.dragAndDropWidgets(
      formValues.Widget,
      destElement,
      Number(formValues.X),
      Number(formValues.Y),
      "AllWidgets"
    );
    await action.fillText(formValues.FieldName, "FieldName", pageScreen);
    await action.ClickElement("CONTAINER", pageScreen);
    await action.fillText(formValues.Title, "Title", pageScreen);
    formValues.Title = process.env.Title;
    await page.waitForTimeout(2000);
    await action.ClickElement("WidgetSave", pageScreen);
    await page.waitForTimeout(500);
    await page.waitForSelector(await ScreenMap.get(pageScreen).getSelector("SavedSuccessfully"), { state: 'hidden', timeout: 60000 });
    // await assertion.checktext(
    //   "SavedSuccessfully",
    //   pageScreen,
    //   "Saved successfully"
    // );
    await action.ClickElement("CancelSearchWidget", pageScreen);
  }

  async TabcontainerWidget(destElement, pageScreen, formValues) {
    await action.ClickElement("SearchWidget", pageScreen);
    await action.enterText(formValues.Widget, "SearchWidget", pageScreen);
    await page.waitForTimeout(500);
    await action.dragAndDropWidgets(
      formValues.Widget,
      destElement,
      Number(formValues.X),
      Number(formValues.Y),
      "AllWidgets"
    );
    await action.fillText(formValues.FieldName, "FieldName", pageScreen);
    await action.ClickElement("TABS", pageScreen);
    await action.ClickElement("ExisitingTab", pageScreen);
    await action.fillText(
      formValues.AddTabFieldName,
      "AddTabFieldName",
      pageScreen
    );
    await action.fillText(
      formValues.AddTabTabLabel,
      "AddTabTabLabel",
      pageScreen
    );
    await action.ClickElement("WidgetSave", pageScreen);
    await assertion.checktext(
      "SavedSuccessfully",
      pageScreen,
      "Saved successfully"
    );
    await action.ClickElement("CancelSearchWidget", pageScreen);
  }

  async dragandDropParticularWidget(widgetName: string
  ) {
    await action.dragAndDropFOWidgetsinBO(
      widgetName,
      "//konfig-grid//div"
    );
  }

  async ButtonWidget(destElement, pageScreen, formValues) {
    await action.ClickElement("SearchWidget", pageScreen);
    await action.enterText(formValues.Widget, "SearchWidget", pageScreen);
    await action.dragAndDropWidgets(
      formValues.Widget,
      destElement,
      Number(formValues.X),
      Number(formValues.Y),
      "AllWidgets"
    );
    await page.waitForTimeout(500);
    await action.fillText(formValues.FieldName, "FieldName", pageScreen);
    await action.fillText(formValues.FieldLabel, "FieldLabel", pageScreen);
    if (formValues.Action !== 'Service Providers' && formValues.Action !== "Populate" && formValues.Status !== "None") {
      await action.ClickElement("Events", pageScreen);
      await action.ClickElement("EventClickAction", pageScreen);
      await page.waitForTimeout(500);
      await action.fillText(formValues.Status, "EventTitleInputbox", pageScreen);
      let EventStatusInputbox = await ScreenMap.get(pageScreen).getSelector(
        "EventStatusInputbox"
      );
      await page.isVisible(EventStatusInputbox).then(async (exist) => {
        if (exist == true) {
          await page.waitForTimeout(500);
          await action.selectDropdownbyspantext(
            "EventStatusInputbox",
            pageScreen,
            formValues.Status
          );
        }
      });
      await page.waitForTimeout(500);
      await action.selectDropdownbyspantext(
        "EventClickActionInputbox",
        pageScreen,
        formValues.Action
      );
    }
    else {
      console.log("Status / Actions doesnt need Event configuration");
    }
    await action.ClickElement("WidgetSave", pageScreen);
    // await assertion.checktext(
    //   "SavedSuccessfully",
    //   pageScreen,
    //   "Saved successfully"
    // );
    await action.ClickElement("CancelSearchWidget", pageScreen);
  }

  async CheckboxGroupWidget(destElement, pageScreen, formValues) {
    await action.ClickElement("SearchWidget", pageScreen);
    await action.enterText(formValues.Widget, "SearchWidget", pageScreen);
    await page.waitForTimeout(3000);
    await action.dragAndDropWidgets(
      formValues.Widget,
      destElement,
      Number(formValues.X),
      Number(formValues.Y),
      "AllWidgets"
    );
    await action.fillText(formValues.FieldName, "FieldName", pageScreen);
    await action.fillText(formValues.FieldLabel, "FieldLabel", pageScreen);
    await action.ClickElement("VALUES", pageScreen);
    await action.ClickElement(formValues.ValuesAlignment, pageScreen);
    let count = formValues.ValueCount;
    console.log("Total Number of values: " + count);
    if (formValues["InputType"] == "Labels&Values") {
      await action.ClickElement("LabelsAndValues", pageScreen);
      for (let i = 1; i <= count; i++) {
        if (i == 1) {
          await action.enterText(formValues.Label1, "ValuesLabel", pageScreen);
          await action.enterText(formValues.Value1, "ValuesValue", pageScreen);
          console.log("User entered value as:" + formValues.Value1);
        } else {
          await action.ClickElement("AddItem", pageScreen);
          await action.ClickElement("ValuesValue", pageScreen);
          await action.enterText(
            formValues[`Label${i}`],
            "ValuesLabel",
            pageScreen
          );
          await action.enterText(
            formValues[`Value${i}`],
            "ValuesValue",
            pageScreen
          );
          console.log("User entered value as:" + formValues[`Value${i}`]);
        }
      }
    } else {
      for (let i = 1; i <= count; i++) {
        if (i == 1) {
          await action.ClickElement("ClickValue", pageScreen);
          await action.ClickElement("ValuesValue", pageScreen);
          await action.enterText(formValues.Value1, "ValuesValue", pageScreen);
          console.log("User entered value as:" + formValues.Value1);
        } else {
          await action.ClickElement("AddItem", pageScreen);
          await action.ClickElement("ValuesValue", pageScreen);
          await action.enterText(
            formValues[`Value${i}`],
            "ValuesValue",
            pageScreen
          );
          console.log("User entered value as:" + formValues[`Value${i}`]);
        }
      }
    }
    await page.waitForTimeout(2000);
    await action.ClickElement("WidgetSave", pageScreen);
    await page.waitForTimeout(2000);
    await assertion.checktext(
      "SavedSuccessfully",
      pageScreen,
      "Saved successfully"
    );
    await action.ClickElement("CancelSearchWidget", pageScreen);
  }

  async RadioGroupWidget(destElement, pageScreen, formValues) {
    await action.ClickElement("SearchWidget", pageScreen);
    await action.enterText(formValues.Widget, "SearchWidget", pageScreen);
    await page.waitForTimeout(3000);
    await action.dragAndDropWidgets(
      formValues.Widget,
      destElement,
      Number(formValues.X),
      Number(formValues.Y),
      "AllWidgets"
    );
    await action.fillText(formValues.FieldName, "FieldName", pageScreen);
    await action.fillText(formValues.FieldLabel, "FieldLabel", pageScreen);
    await action.ClickElement("INPUT", pageScreen);
    if(formValues.ValuesAlignment == 'ValueAlignHorizontal'){
    await action.ClickElement(formValues.ValuesAlignment, pageScreen);
    }
    let count = formValues.ValueCount;
    console.log("Total Number of values: " + count);
    console.log(formValues["InputType"]);
    if (formValues["InputType"] == "Labels&Values") {
      await page.waitForTimeout(2000);
      await action.ClickElement("LabelsAndValues", pageScreen);
      for (let i = 1; i <= count; i++) {
        await action.ClickElement("AddItem", pageScreen);
        await page.waitForTimeout(2000);
        await action.enterText(
          formValues[`Label${i}`],
          "ValuesLabel",
          pageScreen
        );
        await action.ClickElement("ValuesValue", pageScreen);
        await action.enterText(
          formValues[`Value${i}`],
          "ValuesValue",
          pageScreen
        );
        console.log(formValues[`Value${i}`]);
      }
    } else {
      for (let i = 1; i <= count; i++) {
          let option = page.locator("//*[text()='Values']/..//button[contains(@popoverclass,'popover')]//div[text()='Option "+i+"']");
          let valueText = page.locator("(//div[@class='popover-body']//div[text()=' Value']/../..//input[@type='text'])["+i+"]");
          if (i == 1 || i == 2) {
            await option.click();
            await valueText.clear();
            await action.enterText(formValues[`Value${i}`], valueText);
            console.log("User entered value as: " + formValues[`Value${i}`]);
            await page.waitForTimeout(2000);
          }
          else {
            let valuesValue = page.locator("//finlevit-text[@data-test-id='option-Value-"+i+"']//input")
            await action.ClickElement("AddItem", pageScreen);
            await page.waitForTimeout(500);
            await action.enterText(
              formValues[`Value${i}`],
              valuesValue
            );
            console.log("User entered value as:" + formValues[`Value${i}`]);
            await page.waitForTimeout(2000);
          }
      }
    }
    await action.ClickElement("WidgetSave", pageScreen);
    await page.waitForTimeout(2000);
    await assertion.checktext(
      "SavedSuccessfully",
      pageScreen,
      "Saved successfully"
    );
    await action.ClickElement("CancelSearchWidget", pageScreen);
  }

  async EmailWidget(destElement, pageScreen, formValues) {
    await action.ClickElement("SearchWidget", pageScreen);
    await action.enterText(formValues.Widget, "SearchWidget", pageScreen);
    await page.waitForTimeout(3000);
    await action.dragAndDropWidgets(
      formValues.Widget,
      destElement,
      Number(formValues.X),
      Number(formValues.Y),
      "AllWidgets"
    );
    await action.fillText(formValues.FieldName, "FieldName", pageScreen);
    await action.fillText(formValues.FieldLabel, "FieldLabel", pageScreen);
    await action.fillText(formValues.PlaceHolder, "PlaceHolder", pageScreen);
    await page.waitForTimeout(3000);
    await action.ClickElement("WidgetSave", pageScreen);
    await page.waitForTimeout(2000);
    await assertion.checktext(
      "SavedSuccessfully",
      pageScreen,
      "Saved successfully"
    );
    await action.ClickElement("CancelSearchWidget", pageScreen);
    console.log("------- Cleared the Widget Search ---------------");
    await page.waitForTimeout(3000);
  }

  async SSNWidget(destElement, pageScreen, formValues) {
    await action.ClickElement("SearchWidget", pageScreen);
    await action.enterText(formValues.Widget, "SearchWidget", pageScreen);
    await page.waitForTimeout(3000);
    await action.dragAndDropWidgets(
      formValues.Widget,
      destElement,
      Number(formValues.X),
      Number(formValues.Y),
      "AllWidgets"
    );
    await action.fillText(formValues.FieldName, "FieldName", pageScreen);
    await action.fillText(formValues.FieldLabel, "FieldLabel", pageScreen);
    await page.waitForTimeout(2000);
    await action.ClickElement("WidgetSave", pageScreen);
    await assertion.checktext(
      "SavedSuccessfully",
      pageScreen,
      "Saved successfully"
    );
    await action.ClickElement("CancelSearchWidget", pageScreen);
    console.log("------- Cleared the Widget Search ---------------");
    await page.waitForTimeout(2000);
  }

  async PhoneNumberWidget(destElement, pageScreen, formValues) {
    await action.ClickElement("SearchWidget", pageScreen);
    await action.enterText(formValues.Widget, "SearchWidget", pageScreen);
    await page.waitForTimeout(3000);
    await action.dragAndDropWidgets(
      formValues.Widget,
      destElement,
      Number(formValues.X),
      Number(formValues.Y),
      "AllWidgets"
    );
    await action.fillText(formValues.FieldName, "FieldName", pageScreen);
    await action.fillText(formValues.FieldLabel, "FieldLabel", pageScreen);
    await page.waitForTimeout(3000);
    await action.ClickElement("WidgetSave", pageScreen);
    await assertion.checktext(
      "SavedSuccessfully",
      pageScreen,
      "Saved successfully"
    );
    await action.ClickElement("CancelSearchWidget", pageScreen);
    console.log("------- Cleared the Widget Search ---------------");
    await page.waitForTimeout(2000);
  }

  async CheckboxWidget(destElement, pageScreen, formValues) {
    await action.ClickElement("SearchWidget", pageScreen);
    await action.enterText(formValues.Widget, "SearchWidget", pageScreen);
    await page.waitForTimeout(3000);
    await action.dragAndDropWidgets(
      formValues.Widget,
      destElement,
      Number(formValues.X),
      Number(formValues.Y),
      "AllWidgets"
    );
    await action.fillText(formValues.FieldName, "FieldName", pageScreen);
    await action.fillText(formValues.FieldLabel, "FieldLabel", pageScreen);
    await page.waitForTimeout(2000);
    await action.ClickElement("WidgetSave", pageScreen);
    await assertion.checktext(
      "SavedSuccessfully",
      pageScreen,
      "Saved successfully"
    );
    await action.ClickElement("CancelSearchWidget", pageScreen);
    console.log("------- Cleared the Widget Search ---------------");
    await page.waitForTimeout(2000);
  }

  async DatepickerWidget(destElement, pageScreen, formValues) {
    await action.ClickElement("SearchWidget", pageScreen);
    await action.enterText(formValues.Widget, "SearchWidget", pageScreen);
    await page.waitForTimeout(3000);
    await action.dragAndDropWidgets(
      formValues.Widget,
      destElement,
      Number(formValues.X),
      Number(formValues.Y),
      "AllWidgets"
    );
    await action.fillText(formValues.FieldName, "FieldName", pageScreen);
    await action.fillText(formValues.FieldLabel, "FieldLabel", pageScreen);
    await page.waitForTimeout(2000);
    await action.ClickElement("WidgetSave", pageScreen);
    // await assertion.checktext('savedSuccessfully',pageScreen,'Saved successfully')
    await action.ClickElement("CancelSearchWidget", pageScreen);
    console.log("------- Cleared the Widget Search ---------------");
    await page.waitForTimeout(3000);
  }

  async Divider(destElement, pageScreen, formValues) {
    await action.ClickElement("SearchWidget", pageScreen);
    await action.enterText(formValues.Widget, "SearchWidget", pageScreen);
    await page.waitForTimeout(3000);
    await action.dragAndDropWidgets(
      formValues.Widget,
      destElement,
      Number(formValues.X),
      Number(formValues.Y),
      "AllWidgets"
    );
    await action.ClickElement("WidgetSave", pageScreen);
    // await assertion.checktext('savedSuccessfully',pageScreen,'Saved successfully')
    await action.ClickElement("CancelSearchWidget", pageScreen);
    console.log("------- Cleared the Widget Search ---------------");
    await page.waitForTimeout(3000);
  }

  async DropdownWidget(destElement, pageScreen, formValues) {
    await action.ClickElement("SearchWidget", pageScreen);
    await action.enterText(formValues.Widget, "SearchWidget", pageScreen);
    await page.waitForTimeout(3000);
    await action.dragAndDropWidgets(
      formValues.Widget,
      destElement,
      Number(formValues.X),
      Number(formValues.Y),
      "AllWidgets"
    );
    await action.fillText(formValues.FieldName, "FieldName", pageScreen);
    await action.fillText(formValues.FieldLabel, "FieldLabel", pageScreen);
    await action.ClickElement("INPUT", pageScreen);
    await page.waitForTimeout(2000);
    let count = formValues.ValueCount;
    console.log("Total Number of values: " + count);
    if (formValues.OptionType == "ManualOptions") {
      if (formValues["InputType"] == "Labels&Values") {
        await page.waitForTimeout(2000);

        await action.ClickElement("LabelsAndValues", pageScreen);
        for (let i = 1; i <= count; i++) {
          if (i == 1) {
            await action.ClickElement("ValuesValue", pageScreen);
            await action.enterText(formValues.Label1, "ValuesLabel", pageScreen);
            await action.enterText(formValues.Value1, "ValuesValue", pageScreen);
            console.log("User entered value as:" + formValues.Value1);
          } else {
            await action.ClickElement("AddItem", pageScreen);
            await action.ClickElement("ValuesValue", pageScreen);
            await action.enterText(
              formValues[`Label${i}`],
              "ValuesLabel",
              pageScreen
            );
            await action.enterText(
              formValues[`Value${i}`],
              "ValuesValue",
              pageScreen
            );
            console.log("User entered value as:" + formValues[`Value${i}`]);
          }
        }
      } else {
        for (let i = 1; i <= count; i++) {
          console.log('i  ---->', i);
          let option = page.locator("//*[text()='Options']/..//button[contains(@popoverclass,'popover')]//div[text()='Option "+i+"']");
          let valueText = page.locator("(//div[@class='popover-body']//div[text()=' Value']/../..//input[@type='text'])["+i+"]");
          if (i == 1 || i==2) {
            await option.click();
            await page.locator("//span[text()='Option "+i+"']/../../..//input[@type='text']").clear();
            await action.enterText(formValues[`Value${i}`], valueText);
            console.log("User entered value as: " + formValues[`Value${i}`]);
            await page.waitForTimeout(2000);
          }
          else {
            let valuesValue = page.locator("//finlevit-text[@data-test-id='option-Value-"+i+"']//input")
            await action.ClickElement("AddItem", pageScreen);
            await page.waitForTimeout(500);
            await action.enterText(
              formValues[`Value${i}`],
              valuesValue
            );
            console.log("User entered value as:" + formValues[`Value${i}`]);
            await page.waitForTimeout(2000);
          }
        }
      }
    }
    else if(formValues.OptionType == "ConfigureOptions"){
      await page.waitForTimeout(2000);
      await action.ClickElement("ConfigureOptions", pageScreen);
      console.log('User selected Configure Options for Dropdown ');
    }
    await page.waitForTimeout(2000);
    await action.ClickElement("WidgetSave", pageScreen);
    await assertion.checktext(
      "SavedSuccessfully",
      pageScreen,
      "Saved successfully"
    );
    await action.ClickElement("CancelSearchWidget", pageScreen);
    console.log("------- Cleared the Widget Search ---------------");
    await page.waitForTimeout(2000);
  }

  async WorkflowDesignerWidget(destElement, pageScreen, formValues) {
    console.log(
      formValues.Widget,
      destElement,
      Number(formValues.X),
      Number(formValues.Y),
      pageScreen
    );
    await action.dragAndDrop(
      formValues.Widget,
      destElement,
      Number(formValues.X),
      Number(formValues.Y),
      pageScreen
    );
    
    await page.waitForTimeout(500);
    console.log(formValues.Widget + " has been dropped on Workflow Designer");
  }

  async VersionDescription(vDescription, destElement, pageScreen) {
    console.log("VersionDescription is " + vDescription);
    await action.fillText(vDescription, destElement, pageScreen);
    CommonUtilObject.writeUsecaseTestData(
      process.env.FileName,
      "VersionDescription",
      vDescription
    );
  }

  async GroupName(GroupName, destElement, pageScreen) {
    let Group = CommonUtilObject.getTestData(GroupName);
    console.log("GroupName is " + Group);
    await action.enterText(Group, destElement, pageScreen);
  }

  async GroupDescription(GroupDescription, destElement, pageScreen) {
    let Description = CommonUtilObject.getTestData(GroupDescription);
    console.log("GroupDescription is " + Description);
    await action.enterText(Description, destElement, pageScreen);
  }

  async ExpandGivenWidget(
    widgetType,
    elementName,
    destElement,
    pageScreen,
    XCord,
    YCord
  ) {
    let srcElement: any;
    console.log("Widget type is " + widgetType);
    if (widgetType == "Tabs Container") {
      srcElement =
        "//*[contains(text(),'" +
        elementName +
        "')]/ancestor::app-tab-container[1]/../..//div[@class='corner bottom-right']//div[@class='resize-handle']";
    } else if (widgetType == "Container") {
      srcElement =
        "//*[contains(normalize-space(text()),'" +
        elementName +
        "')]/ancestor::grid-field-container[1]/../..//div[@class='corner bottom-right']//div[@class='resize-handle']";
    } else if (widgetType == "Table") {
      srcElement =
        "//*[contains(text(),'" +
        elementName +
        "')]/ancestor::finlevit-custom-adv-table[1]/../../..//div[@class='corner bottom-right']//div[@class='resize-handle']";
    } else if (widgetType == "Divider") {
      srcElement =
        "(//mat-divider[@role='separator']/../../../../../..//div[contains(@class,'resize-handle')])[1]";
    } else if (widgetType == "Button") {
      srcElement =
        "//*[contains(text(),'" +
        elementName +
        "')]/ancestor::finlevit-button[1]/../../..//div[@class='corner bottom-right']//div[@class='resize-handle']";
    } else if (widgetType == "Modal") {
      srcElement =
        "//div[@role='dialog']//div[contains(@class,'p-resizable-handle')]";
    } else if (widgetType == "Radio Group") {
      srcElement =
        "//*[contains(normalize-space(text()),'" +
        elementName +
        "')]/ancestor::finlevit-radio-group/../../..//div[@class='corner bottom-right']//div[@class='resize-handle']";
    } else if (widgetType == "Checkbox Group") {
      srcElement =
        "//*[contains(normalize-space(text()),'" +
        elementName +
        "')]/ancestor::finlevit-lib-checkbox-group/../../../..//div[@class='corner bottom-right']//div[@class='resize-handle']";
    }
    const elementHandle = await page.evaluateHandle(({ srcElement, XCord, YCord }) => {
      const element = document.evaluate(
          srcElement,
          document,
          null,
          XPathResult.FIRST_ORDERED_NODE_TYPE,
          null
      ).singleNodeValue as HTMLElement;
  
      if (element) {
          element.style.left = '0px';
          element.style.top = '0px';
          element.style.width = `${XCord}px`;
          element.style.height = `${YCord}px`;
          
          return 'success'; // Return a success message
      }
      return 'element not found'; // Return failure message if element is missing
  }, { srcElement, XCord, YCord });
  
  const result = await elementHandle.jsonValue(); // Get the returned value
  console.log(`Resize Operation: ${result}`); // Print success or failure message
  
  
  // await action.expandWidgets(srcElement,"canvasBody",XCord,YCord,pageScreen);
  }

  // Add input items for Radio group
  async InputItems(formValues, pageScreen) {
    await action.ClickElement("INPUT", pageScreen);
    for (let i = 1; i <= formValues.NoofInput; i++) {
      await action.ClickElement("AddItem", pageScreen);
      await page.waitForTimeout(500);
      await action.enterText(formValues["Value" + i], "ValuesValue", pageScreen);
    }
  }

  async NumberFormat(formValues, pageScreen) {
    await action.ClickElement("NUMBER FORMAT", pageScreen);
    await action.ClickElement("ThousandsSeparator", pageScreen);
    await page.waitForTimeout(500);
    console.log("Thousand Separator checkbox selected");
    await action.selectDropdownbyspantext(
      "TypeOfFormat",
      pageScreen,
      formValues.TypeOfFormat
    );
    await page.waitForTimeout(3000);
    await action.ClickElement("CurrencyDropdown", pageScreen);
    await action.enterText(
      formValues.CurrencyCountry,
      "CurrencySearch",
      pageScreen
    );
    await action.ClickElement("SelectFirstCountry", pageScreen);
    await page.waitForTimeout(500);
  }

  async PagesinModal(formValues, pageScreen) {
    await action.ClickElement("PAGES", pageScreen);
    let Page1 = await ScreenMap.get(pageScreen).getSelector("Page1");
    for (let i = 1; i <= formValues.NoofPages; i++) {
      await page.isVisible(Page1).then(async (exist) => {
        if (exist == true) {
          await action.ClickElement("Page1", pageScreen);
        } else {
          await action.ClickElement("AddModalPage", pageScreen);
        }
      });
      await action.fillText(
        formValues["Page" + i + "Name"],
        "ModalPageFieldName",
        pageScreen
      );
      await action.fillText(
        formValues["Page" + i + "Title"],
        "ModalPageTitle",
        pageScreen
      );
    }
    await page.waitForTimeout(2000);
  }

  async ScrolltoElement(srcElement, pageScreen?) {
    let source = page.locator(srcElement);
    await source.scrollIntoViewIfNeeded();
    console.log("Scrolled to the element " + (await source.textContent()));
    await page.waitForTimeout(500);
  }

  async AppIdentifiers(formValues) {
    let count = formValues.ValueCount;
    console.log(formValues.ValueCount + ": " + "check");
    for (let i = 1; i <= count; i++) {
      await page.waitForTimeout(500);
      const today = moment();
      let Time = today.format("hhmmss");
      let k1 = formValues[`Key${i}`].split(" ")[0];
      const newKey = k1.charAt(0) + Time;
      // Write the Application Identifiers to the JSON file
      console.log("identifiers are" + formValues[`Identifiers${i}`]);
      await CommonUtilObject.writeUsecaseTestData(
        process.env.FileName,
        formValues[`Identifiers${i}`],
        newKey
      );
      let identifiers =
        "//div[contains(text(),'" +
        formValues[`Identifiers${i}`] +
        "')]/..//input";
      await page.fill(identifiers, newKey);
      await page.waitForTimeout(500);
      console.log(formValues[`Key${i}`] + ": " + newKey);
    }
  }

  async CreateGroup(expectedText, Description) {
    await action.waitforInvisibilityOfSpinner();
    await action.enterText(expectedText, 'create_group_name', 'Groups');
    // await this.GroupName(expectedText, "create_group_name", "Groups");
    await page.waitForTimeout(2000);
    await this.GroupDescription(
      Description,
      "create_group_description",
      "Groups"
    );
    let admins: any = [];
    admins = CommonUtilObject.getTestData("GroupAdmins");
    let grpAdmins: any = [];
    admins = admins.replace("[", "");
    admins = admins.replace("]", "");
    admins = admins.replace("", "");
    grpAdmins = admins.split(",");
    console.log(grpAdmins);
    console.log("Number of Group Admins: " + grpAdmins.length);
    await action.selectDropdownbyMultipleText(
      "create_group_Admins_Dropdown",
      grpAdmins,
      "Groups"
    );
    await action.ClickElement("create_group_Admins_OK_button", "Groups");
    await page.waitForTimeout(2000);
    await action.ClickElement("create_group_save_button", "Groups");
    await page.waitForTimeout(2000);
  }

  async AddGroup(groupName, Description, pageScreen) {
    if (groupName.startsWith("#")) {
      await action.enterText(
        CommonUtilObject.readUsecaseTestData(
          process.env.FileName,
          groupName.replace("#", "")
        ),
        "create_group_name",
        pageScreen
      );
    } else {
      await action.enterText(groupName, "create_group_name", pageScreen);
    }
    await action.enterText(Description, "create_group_description", pageScreen);
    let admins: any = [];
    admins = CommonUtilObject.getTestData("GroupAdmins");
    let grpAdmins: any = [];
    admins = admins.replace("[", "");
    admins = admins.replace("]", "");
    admins = admins.replace("", "");
    grpAdmins = admins.split(",");
    console.log(grpAdmins);
    console.log("Number of Group Admins: " + grpAdmins.length);
    await action.selectDropdownbyMultipleText(
      "create_group_Admins_Dropdown",
      grpAdmins,
      pageScreen
    );
    await action.ClickElement("create_group_Admins_OK_button", pageScreen);
    await page.waitForTimeout(2000);
    await action.ClickElement("create_group_save_button", pageScreen);
    await page.waitForTimeout(2000);
  }

  async CreateApp(typeofApp, appName, Description, pageScreen) {
    //Enter App Name
    await action.enterText(appName, "create_application_name", pageScreen);
    if (typeofApp == "New") {
      //Select App type
      await action.ClickElement("create_application_radio_newapp", pageScreen);
      console.log("New Application");
    } else if (typeofApp == "Existing") {
      await action.ClickElement("create_application_radio_extapp", pageScreen);
      console.log("Existing Application");
      //Enter Appid for existing app
      await page.waitForTimeout(500);
      let Appid = String(Math.floor(Math.random() * 8999999999 + 1000000000));
      await action.enterText(Appid, "create_application_id", pageScreen);
      await page.waitForTimeout(500);
    }
    await action.enterText(
      Description,
      "create_application_description",
      pageScreen
    );
    //Add App Admins
    let admins: any = [];
    admins = CommonUtilObject.getTestData("AppAdmins");
    let appAdmins: any = [];
    admins = admins.replace("[", "");
    admins = admins.replace("]", "");
    admins = admins.replace("", "");
    appAdmins = admins.split(",");
    console.log("Number of Group Admins: " + appAdmins.length);
    console.log(appAdmins);
    await action.selectDropdownbyMultipleText(
      "create_group_Admins_Dropdown",
      appAdmins,
      "Groups"
    );
    await action.ClickElement("create_app_Admins_OK_button", pageScreen);
    console.log("Save button clicked");
    //Save Application
    await page.waitForTimeout(500);
    await action.ClickElement("create_app_save_button", pageScreen);
    await page.waitForTimeout(500);
  }

  async TextAreaWidget(destElement, pageScreen, formValues) {
    await action.ClickElement("SearchWidget", pageScreen);
    await action.enterText(formValues.Widget, "SearchWidget", pageScreen);
    await page.waitForTimeout(3000);
    await action.dragAndDropWidgets(
      formValues.Widget,
      destElement,
      Number(formValues.X),
      Number(formValues.Y),
      "AllWidgets"
    );
    await action.fillText(formValues.FieldName, "FieldName", pageScreen);
    await action.fillText(formValues.FieldLabel, "FieldLabel", pageScreen);
    await page.waitForTimeout(3000);
    await action.ClickElement("WidgetSave", pageScreen);
    await assertion.checktext(
      "SavedSuccessfully",
      pageScreen,
      "Saved successfully"
    );
    await action.ClickElement("CancelSearchWidget", pageScreen);
    console.log("------- Cleared the Widget Search ---------------");
  }

  async UploadWidget(destElement, pageScreen, formValues) {
    await action.ClickElement("SearchWidget", pageScreen);
    await action.enterText(formValues.Widget, "SearchWidget", pageScreen);
    await page.waitForTimeout(3000);
    await action.dragAndDropWidgets(
      formValues.Widget,
      destElement,
      Number(formValues.X),
      Number(formValues.Y),
      "AllWidgets"
    );
    await action.fillText(formValues.FieldName, "FieldName", pageScreen);
    await action.ClickElement("INPUT", pageScreen);
    await action.fillText(
      formValues.FieldLabel,
      "Upload_Input_Label",
      pageScreen
    );
    await page.waitForTimeout(3000);
    await action.ClickElement("WidgetSave", pageScreen);
    await assertion.checktext(
      "SavedSuccessfully",
      pageScreen,
      "Saved successfully"
    );
    await action.ClickElement("CancelSearchWidget", pageScreen);
    console.log("------- Cleared the Widget Search ---------------");
  }

  async addDropdownValues(formValues, pageScreen) {

    await page.waitForTimeout(500);
    await action.ClickElement("INPUT", pageScreen);
    await action.ClickElement(formValues.OptionType, pageScreen);
    let count = formValues.ValueCount;
    console.log("Total Number of values: " + count);
    if (formValues.OptionType == "ManualOptions") {
      if (formValues["InputType"] == "Labels&Values") {
        await page.waitForTimeout(2000);
        await action.ClickElement("LabelsAndValues", pageScreen);
        for (let i = 1; i <= count; i++) {
          if (i == 1) {
            await action.ClickElement("ValuesValue", pageScreen);
            await action.enterText(formValues.Label1, "ValuesLabel", pageScreen);
            await action.enterText(formValues.Value1, "ValuesValue", pageScreen);
            console.log("User entered value as:" + formValues.Value1);
          } else {
            await action.ClickElement("AddItem", pageScreen);
            await action.ClickElement("ValuesValue", pageScreen);
            await action.enterText(
              formValues[`Label${i}`],
              "ValuesLabel",
              pageScreen
            );
            await action.enterText(
              formValues[`Value${i}`],
              "ValuesValue",
              pageScreen
            );
            console.log("User entered value as:" + formValues[`Value${i}`]);
          }
        }
      } else {
        console.log('*****');
        for (let i = 1; i <= count; i++) {
          if (i == 1) {
            await action.ClickElement("FirstOption", pageScreen);
            await action.ClickElement("ValuesValue", pageScreen);
            await action.enterText(formValues.Value1, "ValuesValue", pageScreen);
            console.log("User entered value as:" + formValues.Value1);
          } else {
            await action.ClickElement("AddItem", pageScreen);
            await action.ClickElement("ValuesValue", pageScreen);
            await action.enterText(
              formValues[`Value${i}`],
              "ValuesValue",
              pageScreen
            );
            console.log("User entered value as:" + formValues[`Value${i}`]);
          }
        }
      }
    }
  }

  async addRadioGroupValues(pageScreen, formValues) {
    await action.ClickElement("INPUT", pageScreen);
    await page.waitForTimeout(500);
    await action.ClickElement(formValues.ValuesAlignment, pageScreen);
    let count = formValues.ValueCount;
    console.log("Total Number of values: " + count);
    console.log('Options Type: ' + formValues["InputType"]);
    if (formValues["InputType"] == "Labels&Values") {
      await page.waitForTimeout(2000);
      await action.ClickElement("LabelsAndValues", pageScreen);
      for (let i = 1; i <= count; i++) {
        await action.ClickElement("AddItem", pageScreen);
        await page.waitForTimeout(2000);
        await action.enterText(
          formValues[`Label${i}`],
          "ValuesLabel",
          pageScreen
        );
        await action.ClickElement("ValuesValue", pageScreen);
        await action.enterText(
          formValues[`Value${i}`],
          "ValuesValue",
          pageScreen
        );
        console.log(formValues[`Value${i}`]);
      }
    } else {
      for (let i = 1; i <= count; i++) {
        await action.ClickElement("AddItem", pageScreen);
        await action.ClickElement("ValuesValue", pageScreen);
        await action.enterText(
          formValues[`Value${i}`],
          "ValuesValue",
          pageScreen
        );
        console.log('Added option:' + formValues[`Value${i}`]);
        await page.waitForTimeout(2000);
      }
    }
  }
  async fillAppidentifier(elementName) {
    const today = moment();
    let Time = today.format("hhmmss");
    const newKey = elementName.charAt(0) + elementName.charAt(1) + Time;
    // Write the Application Identifiers to the JSON file
    CommonUtilObject.writeUsecaseTestData(
      process.env.FileName,
      elementName,
      newKey
    );
    let identifiers = "//div[contains(text(),'" + elementName + "')]/..//input";
    await page.waitForTimeout(500);
    console.log(CommonUtilObject.readUsecaseTestData(process.env.FileName, elementName))
    await page.fill(
      identifiers,
      CommonUtilObject.readUsecaseTestData(process.env.FileName, elementName)
    );
  }

  async basicAuth(AuthType, pageScreen) {
    await action.selectDropdownbyspantext("AuthType", pageScreen, AuthType);
    await page.waitForTimeout(2000);
    let userName = await CommonUtilObject.readUsecaseTestData(process.env.FileName, "UserName");
    let password = await CommonUtilObject.readUsecaseTestData(process.env.FileName, "Password");
    await action.enterText(userName, "UserName", pageScreen);
    await action.enterText(password, "Password", pageScreen);
  }

  async oAuth(AuthName, AuthType, pageScreen) {
    await action.selectDropdownbyspantext("AuthType", pageScreen, AuthType);
    await page.waitForTimeout(2000);

    let grantType = await CommonUtilObject.readUsecaseTestData(process.env.FileName, "GrantType")
    await action.selectDropdownbyspantext("GrantType", pageScreen, grantType);
    await page.waitForTimeout(3000);
    if (grantType == 'Authorization Code') {
      let EnvUrl;
      let callbackUrl = await CommonUtilObject.readUsecaseTestData(process.env.FileName, "CallbackUrl")
      EnvUrl = callbackUrl.replace("env", (process.env.Env).toLowerCase());
      EnvUrl = EnvUrl.replace(/DOMAIN/g, process.env.Domain);;
      console.log("env url is" + EnvUrl)
      await action.fillText(EnvUrl, "CallbackUrl", pageScreen);
      await page.waitForTimeout(500);
      let AuthUrl = await CommonUtilObject.readUsecaseTestData(process.env.FileName, "AuthUrl")
      await action.fillText(AuthUrl, "AuthUrl", pageScreen);
      await page.waitForTimeout(500);
    }
    let AccessTokenUrl = await CommonUtilObject.readUsecaseTestData(process.env.FileName, "AccessTokenUrl")
    await action.fillText(AccessTokenUrl, "AccessTokenUrl", pageScreen);
    await page.waitForTimeout(500);
    let clientID = await CommonUtilObject.readUsecaseTestData(process.env.FileName, "ClientID")
    await action.fillText(clientID, "ClientID", pageScreen);
    await page.waitForTimeout(500);
    let ClientSecret = await CommonUtilObject.readUsecaseTestData(process.env.FileName, "ClientSecret")
    await action.fillText(ClientSecret, "ClientSecret", pageScreen);
    await page.waitForTimeout(500);
    let Scope = await CommonUtilObject.readUsecaseTestData(process.env.FileName, "Scope")
    await action.fillText(Scope, "Scope", pageScreen);
    await page.waitForTimeout(500);
    let state = await CommonUtilObject.readUsecaseTestData(process.env.FileName, "State")
    await action.fillText(state, "State", pageScreen);
    await page.waitForTimeout(500);
    let ClientAuthentication = await CommonUtilObject.readUsecaseTestData(process.env.FileName, "ClientAuthentication")
    await action.selectDropdownbyspantext("ClientAuthentication", pageScreen, ClientAuthentication);
    await page.waitForTimeout(500);
    let RefreshTokenUrl = await CommonUtilObject.readUsecaseTestData(process.env.FileName, "RefreshTokenUrl")
    await action.fillText(RefreshTokenUrl, "RefreshTokenUrl", pageScreen);
    await page.waitForTimeout(500);
    await action.ClickElement("AccessToken", pageScreen);
    if (grantType == 'Authorization Code') {
      await page.waitForTimeout(10000);
      await page.waitForLoadState('domcontentloaded');
      await page.waitForTimeout(10000);
      let pages = await context.pages();
      await pages[1].bringToFront();
      let Username = await CommonUtilObject.readUsecaseTestData(process.env.FileName, "UserName")
      let Password = await CommonUtilObject.readUsecaseTestData(process.env.FileName, "Password");
      if (AuthName.startsWith("Intuit")) {
        await pages[1].locator("//input[@name='Email']").fill(Username);
        await pages[1].locator("//button[@type='submit']").click()
        await pages[1].locator("//input[@name='Password']").fill(Password);
        await pages[1].locator("//button[@type='submit']").click()
        await pages[1].waitForSelector("//div[text()='Authentication Successful']", { timeout: 90000 })
        await assertion.ContainText("AppHeader", pageScreen, await CommonUtilObject.readUsecaseTestData(process.env.FileName, "AuthName"))
        await page.waitForTimeout(500);
      } else if (AuthName.startsWith("Salesforce")) {
        await pages[1].locator("//input[@type='email']").fill(Username);
        await pages[1].locator("//input[@type='password']").fill(Password);
        await pages[1].locator("//input[@type='submit']").click()
        await pages[1].waitForSelector("//div[text()='Authentication Successful']", { timeout: 90000 })
        await assertion.ContainText("AppHeader", pageScreen, await CommonUtilObject.readUsecaseTestData(process.env.FileName, "AuthName"))
        await page.waitForTimeout(500);
      }

    }
  }

  async mongoDB(resourceName, AppSourceOption, formValues, pageScreen,resourceExistance?) {
    try {
      if (resourceExistance!=true){
      await action.fillText(resourceName, "AddResourceName", pageScreen);
      await page.waitForTimeout(500);
      let connectionType = await CommonUtilObject.readUsecaseTestData(process.env.FileName, "ConnectionType")
      if (connectionType == "Manual") {
        console.log("connection is " + connectionType);
        await action.ClickElement(connectionType, pageScreen);
        await page.waitForTimeout(500);
        await action.enterText((await CommonUtilObject.readUsecaseTestData(process.env.FileName, "HostName")), "HostName", pageScreen);
        await action.enterText(await CommonUtilObject.readUsecaseTestData(process.env.FileName, "Port"), "Port", pageScreen);
      } else if (connectionType == "URI") {
        await action.ClickElement(connectionType, pageScreen);
        await page.waitForTimeout(500);
        if (resourceName == 'Konfig-DB' && process.env.Infra == 'cloud') {
          await action.enterText(await CommonUtilObject.getTestData('MongoDB-URI-cloud'), "UriInput", pageScreen);
        }
        else if (resourceName == 'Konfig-DB' && process.env.Infra == 'onPrem') {
          await action.enterText(await CommonUtilObject.getTestData('MongoDB-URI-onPrem'), "UriInput", pageScreen);
        }
        else {
          await action.enterText(await CommonUtilObject.readUsecaseTestData(process.env.FileName, "URI"), "UriInput", pageScreen);
        }
        await page.waitForTimeout(500);
      }
      if (AppSourceOption == "Select") {
        await action.ClickElement("ApplicationSourceSetup", pageScreen)
      } else {
        console.log("For Application Source Setup is not selected")
      }
      await action.ClickElement("TestConnection", pageScreen);
      await page.waitForSelector(await ScreenMap.get(pageScreen).getSelector(
        "ConnectionSuccess"
      ),{timeout:60000})
      await assertion.ContainText("ConnectionSuccess", pageScreen, "Connection Successful")
      await page.waitForTimeout(500);
      await action.ClickElement("CreateButton", pageScreen);
      }
      await page.waitForTimeout(500);
      let dataSources = page.locator("//finlevit-card//div[contains(text(),'" + resourceName + "')]");
      await dataSources.click();
      await page.waitForTimeout(500);
      //add data list
      for (let i = 0; i < formValues.length; i++) {
        let availableDL = "//div[normalize-space(text())='" + formValues[i].ListName + "']"
          await page.isVisible(availableDL).then(async (exist) => {
            console.log("Datalist availability" + exist);
            if (exist == true) {
              console.log(
                "Datalist " +
                formValues[i].OperationName +
                " already created for this group"
              );
            }
            else{
        await action.ClickElement("AddDataList", pageScreen);
        await action.fillText(formValues[i].ListName, "ListName", pageScreen);
        await page.waitForTimeout(2000);
        await action.selectDropdownbyspantext("Database", pageScreen, formValues[i].DataBase);
        await page.waitForTimeout(2000);
        //CollectionName
        await action.selectDropdownbytagName("span","CollectionName",formValues[i].CollectionName, pageScreen);
        await page.waitForTimeout(500);
        await action.selectDropdownbyspantext("OperationType", pageScreen, formValues[i].OperationType);
        if (formValues[i].ReturnSingleRecord) {
          await action.selectDropdownbyspantext("ReturnSingleRecord", pageScreen, formValues[i].ReturnSingleRecord);

        }
        let query;
        if (formValues[i].Query.startsWith("#")) {
          query = CommonUtilObject.readJSONData(process.env.FileName, formValues[i].Query.replace("#", ""));
        }
        else {
          query = formValues[i].Query;
        }
        await action.fillText(query, "Query", pageScreen);
        await page.waitForTimeout(500);
        if (formValues[i].UpdateQuery) {
          let UpdateQuery = await CommonUtilObject.readJSONData(process.env.FileName, formValues[i].UpdateQuery);
          await action.fillText(UpdateQuery, "UpdateQuery", pageScreen);
          await page.waitForTimeout(500);
        }
        // let json = await CommonUtilObject.readJSONData(process.env.FileName, formValues[i].ResponseJson);
        await action.fillText(formValues[i].ResponseJson, "ResponseJson", pageScreen);
        await page.waitForTimeout(500);
        console.log("formValues[i].Parameters " + formValues[i].Parameters);
        let name = await ScreenMap.get(pageScreen).getElement("ListName");
        await name.scrollIntoViewIfNeeded();     
        // Enter Request json
        if (formValues[i].RequestJson) {
          let request = await CommonUtilObject.readJSONData(process.env.FileName, formValues[i].RequestJson);
          await action.fillText(request, "bulkUpsertRequestJson", pageScreen);

        }
        //SelectDataType
        if (formValues[i].Parameters) {
          if (formValues[i].DataType1.startsWith("#")) {
            let parentObject = formValues[i].DataType1.replace("#", "")
            console.log("Paramters is  " + parentObject);
            for (let j = 1; j <= formValues[i].Parameters; j++) {
              await page.waitForTimeout(500);
              let Data = await CommonUtilObject.readTestDataFromNestedObject(process.env.FileName, "DataType" + j, parentObject);
              await console.log("DataType is " + Data)
              let dropDown = await page.locator("(//div[contains(text(),'Data Type')]/..//div[@aria-label='dropdown trigger'])[" + j + "]")
              let scrollView = await page.locator("(//div[contains(text(),'Data Type')]/..//div[@aria-label='dropdown trigger'])[" + (j + 2) + "]")
              await scrollView.isVisible().then(async (exist) => {
                if (exist == true) {
                  await scrollView.scrollIntoViewIfNeeded();
                } else {
                  console.log("No elemnt is seen");
                }
              })
              await action.selectDropdownbytagName("span", dropDown, Data);

            }
          } else {
            for (let j = 1; j <= formValues[i].Parameters; j++) {
              let dropDown = await page.locator("(//div[contains(text(),'Data Type')]/..//div[@aria-label='dropdown trigger'])[" + j + "]")
              console.log("DataType is " + formValues[i]["DataType" + j])
              await action.selectDropdownbytagName("span", dropDown, formValues[i]["DataType" + j]);

            }
          }
        }
        if (resourceName!="Tririga-DB"){
        await action.ClickElement("TestQuery", pageScreen);
        await page.waitForTimeout(500);
        //EnterValue
        if (formValues[i].Parameters) {
          if (formValues[i].Value1.startsWith("#")) {
            let parentObject = formValues[i].Value1.replace("#", "")
            console.log("Parent object for the ResponseValue is " + parentObject)
            for (let j = 1; j <= formValues[i].Parameters; j++) {
              let Data = await CommonUtilObject.readTestDataFromNestedObject(process.env.FileName, "Value" + j, parentObject);
              let value = await page.locator("(//input[@placeholder='value*'])[" + j + "]")
              console.log("Value is " + Data)
              await value.scrollIntoViewIfNeeded();
              await action.enterText(Data, value);
              await page.waitForTimeout(500);
            }
          } else {
            for (let j = 1; j <= formValues[i].Parameters; j++) {
              let value = await page.locator("(//input[@placeholder='value*'])[" + j + "]")
              console.log("Value is" + formValues[i]["Value" + j])
              await action.enterText(formValues[i]["Value" + j], value);
              await page.waitForTimeout(500);
            }
          }

        }
        await action.ClickElement("Run", pageScreen);
        await assertion.HaveText("UseResponse", pageScreen, "Use Response");
        await action.ClickElement("UseResponse", pageScreen)
        await page.waitForTimeout(500);
        await action.ClickElement("Back", pageScreen);
      }
        await page.waitForTimeout(500);
        await action.ClickElement("CreateButton", pageScreen);
        await page.waitForTimeout(2000);
      }
    });
  }

    } catch (error) {
      throw error;
    }
  }

  async restApi(resourceName, AppSourceOption, serviceProvider, formValues, pageScreen,resourceExistance?) {
    if (resourceExistance!=true){
    // add resource name
    await action.fillText(resourceName, "AddResourceName", pageScreen);
    await action.selectDropdownbyspantext("serviceDropDown", pageScreen, serviceProvider);
    if (AppSourceOption == "Select") {
      await action.ClickElement("ApplicationSourceSetup", pageScreen)
    } else {
      console.log("For Application Source Setup is not selected")
    }
    await action.ClickElement("CreateButton", pageScreen);
    await assertion.ContainText("SuccessMsg", pageScreen, "Successfully")
  }
    let dataSources = page.locator("//finlevit-card//div[normalize-space(text())='" + resourceName + "']");
    await dataSources.click();
    await page.waitForTimeout(500);
    await action.waitforInvisibilityOfSpinner()
    //add data list
    for (let i = 0; i < formValues.length; i++) {
      let listName;
      if((formValues[i].ListName).startsWith("#"))
        listName = await CommonUtilObject.readUsecaseTestData(process.env.FileName,formValues[i].ListName.replace("#", ""))
      else
        listName=formValues[i].ListName

      let availableDL = "//div[normalize-space(text())='" + listName + "']"
          await page.isVisible(availableDL).then(async (exist) => {
            console.log("Datalist availability" + exist);
            if (exist == true) {
              console.log(
                "Datalist " +
                listName +
                " already created for this group"
              );
            }
            else{
              await action.ClickElement("AddDataList", pageScreen);
              await action.fillText(listName, "ListName", pageScreen);
              await page.waitForTimeout(3000);
              await action.selectDropdownbytagName("span", "SelectService", formValues[i].Service, pageScreen);
              await page.waitForTimeout(2000);
              if((formValues[i].Operation).startsWith("#")){
                let operationName = await CommonUtilObject.readUsecaseTestData(process.env.FileName,formValues[i].Operation.replace("#", ""))
                await action.selectDropdownbyspantext("SelectOperation", pageScreen, operationName);
                }else{
                  await action.selectDropdownbyspantext("SelectOperation", pageScreen, formValues[i].Operation);
                }
             
              await action.ClickElement("CreateButton", pageScreen);
              await page.waitForTimeout(2000);
            }
          });
  }
}

  async mySQL(resourceName, AppSourceOption, formValues, pageScreen,resourceExistance?) {
    try {
      if (resourceExistance!=true){
      await action.fillText(resourceName, "AddResourceName", pageScreen);
      await page.waitForTimeout(500);
      let connectionType = await CommonUtilObject.readUsecaseTestData(process.env.FileName, "ConnectionType")
      if (connectionType == "Manual") {
        console.log("connection is " + connectionType);
        await action.ClickElement(connectionType, pageScreen);
        await action.ClickElement("URI", pageScreen);
        await action.ClickElement(connectionType, pageScreen);
        await action.enterText((await CommonUtilObject.readUsecaseTestData(process.env.FileName, "HostName")), "HostName", pageScreen);
        await action.enterText(await CommonUtilObject.readUsecaseTestData(process.env.FileName, "Port"), "Port", pageScreen);
        await action.enterText(await CommonUtilObject.readUsecaseTestData(process.env.FileName, "Username"), "DataSourceUsername", pageScreen);
        await action.enterText(await CommonUtilObject.readUsecaseTestData(process.env.FileName, "Password"), "DataSourcePassword", pageScreen);
      } else if (connectionType == "URI") {
        await action.ClickElement(connectionType, pageScreen);
        await page.waitForTimeout(500);
        await action.enterText(await CommonUtilObject.readUsecaseTestData(process.env.FileName, "URI"), "UriInput", pageScreen);
        await page.waitForTimeout(500);
      }
      if (AppSourceOption == "Select") {
        await action.ClickElement("ApplicationSourceSetup", pageScreen)
      } else {
        console.log("For Application Source Setup is not selected")
      }
      await action.ClickElement("TestConnection", pageScreen);
      await assertion.ContainText("ConnectionSuccess", pageScreen, "Connection Successful")
      await action.ClickElement("CreateButton", pageScreen);
    }
      await page.waitForTimeout(500);
      let dataSources = page.locator("//finlevit-card//div[contains(text(),'" + resourceName + "')]");
      await dataSources.click();
      await page.waitForTimeout(500);
      //add data list
      for (let i = 0; i < formValues.length; i++) {
        let availableDL = "//div[normalize-space(text())='" + formValues[i].ListName + "']"
          await page.isVisible(availableDL).then(async (exist) => {
            console.log("Datalist availability" + exist);
            if (exist == true) {
              console.log(
                "Datalist " +
                formValues[i].OperationName +
                " already created for this group"
              );
            }
            else{
        await action.ClickElement("AddDataList", pageScreen);
        await action.fillText(formValues[i].ListName, "ListName", pageScreen);
        await page.waitForTimeout(2000);
        await action.selectDropdownbyspantext("Schema", pageScreen, formValues[i].Schema);
        await page.waitForTimeout(2000);
        //Schema,Table,Operation
        // await action.selectDropdownbyspantext("Table", pageScreen, formValues[i].Table);
        // await page.waitForTimeout(500);
        await action.selectDropdownbyspantext("OperationType", pageScreen, formValues[i].OperationType);
        if (formValues[i].ReturnSingleRecord) {
          await action.selectDropdownbyspantext("ReturnSingleRecord", pageScreen, formValues[i].ReturnSingleRecord);

        }
        await page.waitForTimeout(2000);
        // let responseFields = await CommonUtilObject.readUsecaseTestData(process.env.FileName, "FieldList");
        // let fields = responseFields.replace("[", "");
        // fields = fields.replace("]", "");
        // fields = fields.split(",");
        // console.log("Fields is " + fields);
        // await console.log("FieldCount is " + fields.length)
        // for (let i = 0; i < fields.length; i++) {
        //   let fieldList = "//span[text()='" + fields[i] + "']/../..//div"
        //   let respsone = "//label[text()='Response Fields']/..//div[@class='field-container']"
        //   console.log("Field dropped is" + fields[i]);
        //   await page.locator(fieldList).dragTo(page.locator(respsone));
        // }
        let query = await CommonUtilObject.readUsecaseTestData(process.env.FileName, formValues[i].Query);
        await action.fillText(query, "Query", pageScreen);
        await page.waitForTimeout(500);
        await action.fillText(formValues[i].ResponseJson, "ResponseJson", pageScreen);
        await page.waitForTimeout(500);
        //SelectDataType
        if (formValues[i].Parameters) {
          if (formValues[i].DataType1.startsWith("#")) {
            let DataType = formValues[i].DataType1.replace("#", "");
            let SqlDataType = formValues[i].SqlDataType1.replace("#", "")

            for (let j = 1; j <= formValues[i].Parameters; j++) {
              await page.waitForTimeout(500);
              let Data = await CommonUtilObject.readTestDataFromNestedObject(process.env.FileName, "DataType" + j, DataType);
              let SqlData = await CommonUtilObject.readTestDataFromNestedObject(process.env.FileName, "SqlDataType" + j, SqlDataType);
              await console.log("DataType is " + Data)
              await console.log("SqlData is " + SqlData)
              let SqlDropDown = await page.locator("(//finlevit-lib-select[@prefixtext='SQL Data Type']//div[@aria-label='dropdown trigger'])[" + j + "]")
              let DataDropDown = await page.locator("(//finlevit-lib-select[@prefixtext='Data Type']//div[@aria-label='dropdown trigger'])[" + j + "]")
              let scrollView = await page.locator("(//finlevit-lib-select[@prefixtext='SQL Data Type']//div[@aria-label='dropdown trigger'])[" + (j + 2) + "]")
              await scrollView.isVisible().then(async (exist) => {
                if (exist == true) {
                  await scrollView.scrollIntoViewIfNeeded();
                } else {
                  console.log("No elemnt is seen");
                }
              })

              // SELECTDATATYPE
              await DataDropDown.click();
              let optionelement = page.locator('//li[@aria-label="' + Data + '"]');
              await optionelement.click();
              // SELECT SQLDATATYPE
              await page.waitForTimeout(500);
              await SqlDropDown.click();
              let Sqlelement = page.locator('//li[@aria-label="' + SqlData + '"]');
              await Sqlelement.click();


            }
          } else {
            for (let j = 1; j <= formValues[i].Parameters; j++) {
              let dropDown = await page.locator("(//div[contains(text(),'Data Type')]/..//div[@aria-label='dropdown trigger'])[" + j + "]")
              console.log("DataType is " + formValues[i]["DataType" + j])
              await action.selectDropdownbytagName("span", dropDown, formValues[i]["DataType" + j]);
            }
          }

        }
        await action.ClickElement("TestQuery", pageScreen);
        await page.waitForTimeout(500);
        if (formValues[i].Parameters) {
          if (formValues[i].Value1.startsWith("#")) {
            for (let j = 1; j <= formValues[i].Parameters; j++) {
              let text= await action.generateRandomString(4)
              let value = await page.locator("(//input[@placeholder='value*'])[" + j + "]")
              console.log("Value is " + text)
              await value.scrollIntoViewIfNeeded();
              await action.enterText(text, value);
              await page.waitForTimeout(500);
            }
          } else {
            for (let j = 1; j <= formValues[i].Parameters; j++) {
              let value = await page.locator("(//input[@placeholder='value*'])[" + j + "]")
              console.log("Value is" + formValues[i]["Value" + j])
              await action.enterText(formValues[i]["Value" + j], value);
              await page.waitForTimeout(500);
            }
          }

        }

        action.ClickElement("Run", pageScreen);
        await assertion.HaveText("UseResponse", pageScreen, "Use Response");
        await action.ClickElement("UseResponse", pageScreen)
        await page.waitForTimeout(500);
        await action.ClickElement("Back", pageScreen);
        await page.waitForTimeout(500);
        await action.ClickElement("CreateButton", pageScreen);
        await page.waitForTimeout(2000);
      }
    });

  }

    } catch (error) {
      throw error;
    }
  }

  async DynamoDB(resourceName, AppSourceOption, formValues, pageScreen,resourceExistance?) {
    try {
      if (resourceExistance!=true){
      await action.fillText(resourceName, "AddResourceName", pageScreen);
      await page.waitForTimeout(500);
      await action.enterText(await CommonUtilObject.readUsecaseTestData(process.env.FileName, "DataSource_ClientId"), "ClientId", pageScreen);
      await action.enterText(await CommonUtilObject.readUsecaseTestData(process.env.FileName, "DataSource_AccessKey"), "AccessKey", pageScreen);
      await action.selectDropdownbyText("Region", pageScreen, await CommonUtilObject.readUsecaseTestData(process.env.FileName, "Region"))
      await page.waitForTimeout(500);
      if (AppSourceOption == "Select") {
        await action.ClickElement("ApplicationSourceSetup", pageScreen)
      } else {
        console.log("For Application Source Setup is not selected")
      }
      await action.ClickElement("TestConnection", pageScreen);
      await assertion.ContainText("ConnectionSuccess", pageScreen, "Connection Successful")
      await action.ClickElement("CreateButton", pageScreen);
    }
      await page.waitForTimeout(500);
      let dataSources = page.locator("//finlevit-card//div[contains(text(),'" + resourceName + "')]");
      await dataSources.click();
      await page.waitForTimeout(500);
      //add data list
      for (let i = 0; i < formValues.length; i++) {
        let availableDL = "//div[normalize-space(text())='" + formValues[i].ListName + "']"
          await page.isVisible(availableDL).then(async (exist) => {
            console.log("Datalist availability" + exist);
            if (exist == true) {
              console.log(
                "Datalist " +
                formValues[i].OperationName +
                " already created for this group"
              );
            }
            else{
        await action.ClickElement("AddDataList", pageScreen);
        await action.fillText(formValues[i].ListName, "ListName", pageScreen);
        await page.waitForTimeout(2000);
        await action.selectDropdownbyspantext("TableName", pageScreen, formValues[i].TableName);
        await action.selectDropdownbyspantext("OperationType", pageScreen, formValues[i].OperationType);
        let query = await CommonUtilObject.readUsecaseTestData(process.env.FileName, formValues[i].Query);
        await action.fillText(query, "Query", pageScreen);
        await page.waitForTimeout(500);
        await action.fillText(formValues[i].ResponseJson, "ResponseJson", pageScreen);
        await page.waitForTimeout(500);
        //SelectDataType
        if (formValues[i].Parameters) {
          if (formValues[i].DataType1.startsWith("#")) {
            let parentObject = formValues[i].DataType1.replace("#", "");
            let parentObject2 = formValues[i].ParameterName1.replace("#", "")
            console.log("Paramters is  " + parentObject);
            for (let j = 1; j <= formValues[i].Parameters; j++) {
              await page.waitForTimeout(500);
              let Data = await CommonUtilObject.readTestDataFromNestedObject(process.env.FileName, "DataType" + j, parentObject);
              let Name = await CommonUtilObject.readTestDataFromNestedObject(process.env.FileName, "ParameterName" + j, parentObject2);
              await console.log("DataType is " + Data)
              let parameterField = await page.locator("(//finlevit-text[@prefixtext='Name']//input[@type='text'])[" + j + "]")
              let dropDown = await page.locator("(//div[contains(text(),'Data Type')]/..//div[@aria-label='dropdown trigger'])[" + j + "]")
              let scrollView = await page.locator("(//div[contains(text(),'Data Type')]/..//div[@aria-label='dropdown trigger'])[" + (j + 2) + "]")
              await scrollView.isVisible().then(async (exist) => {
                if (exist == true) {
                  await scrollView.scrollIntoViewIfNeeded();
                } else {
                  console.log("No elemnt is seen");
                }
              })
              await action.ClickElement("ParameterName", pageScreen);
              await page.waitForTimeout(500);
              await parameterField.fill(Name);
              await page.waitForTimeout(500);
              await action.selectDropdownbytagName("span", dropDown, Data);

            }
          } else {
            for (let j = 1; j <= formValues[i].Parameters; j++) {
              let dropDown = await page.locator("(//div[contains(text(),'Data Type')]/..//div[@aria-label='dropdown trigger'])[" + j + "]")
              console.log("DataType is " + formValues[i]["DataType" + j])
              await action.selectDropdownbytagName("span", dropDown, formValues[i]["DataType" + j]);
            }
          }

        }
        await action.ClickElement("TestQuery", pageScreen);
        await page.waitForTimeout(500); //EnterValue
        if (formValues[i].Parameters) {
          if (formValues[i].Value1.startsWith("#")) {
            let parentObject = formValues[i].Value1.replace("#", "")
            console.log("Parent object for the ResponseValue is " + parentObject)
            let rName= await action.generateRandomString(5);
            for (let j = 1; j <= formValues[i].Parameters; j++) {
              let Data = await CommonUtilObject.readTestDataFromNestedObject(process.env.FileName, "Value" + j, parentObject).replace(/random/g,rName);
              let value = await page.locator("(//input[@placeholder='value*'])[" + j + "]")
              console.log("Value is " + Data)
              await value.scrollIntoViewIfNeeded();
              await action.enterText(Data, value);
              await page.waitForTimeout(500);
            }
          } else {
            for (let j = 1; j <= formValues[i].Parameters; j++) {
              let value = await page.locator("(//input[@placeholder='value*'])[" + j + "]")
              console.log("Value is" + formValues[i]["Value" + j])
              await action.enterText(formValues[i]["Value" + j], value);
              await page.waitForTimeout(500);
            }
          }

        }
        action.ClickElement("Run", pageScreen);
        await assertion.HaveText("UseResponse", pageScreen, "Use Response");
        await action.ClickElement("UseResponse", pageScreen)
        await page.waitForTimeout(500);
        await action.ClickElement("Back", pageScreen);
        await page.waitForTimeout(500);
        await action.ClickElement("CreateButton", pageScreen);
        await page.waitForTimeout(2000);
      }
    });
  }


    } catch (error) {
      throw error;
    }
  }

}

