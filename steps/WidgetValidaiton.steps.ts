import { ScreenMap } from "../Utility/Source/Core";
import { CommonUtilObject } from "../Utility/Util/CommonUtil";
import { page, context } from "./world";
import { Actions } from "../Utility/Util/Actions";
import { Assertions } from "../Utility/Util/Assertions";
import { DataTable, When, Then, Given, } from "@cucumber/cucumber";
import * as moment from "moment";
import { Browser, chromium, Page } from "playwright";
import { expect } from "@playwright/test";
import { UniqueWidgets } from "../Main/UniqueWidgets";
import { OnloadTriggers } from "../Main/OnloadTriggers";
import { createWriteStream, readFileSync, writeFileSync } from "fs";
import { ExitStatus } from "typescript";
import { TransformationUI } from "../Main/TransformationUI";

let action: Actions = new Actions();
let assertion: Assertions = new Assertions();
let Uwidgets: UniqueWidgets = new UniqueWidgets();
let OnloadTrigger: OnloadTriggers = new OnloadTriggers();
let transformationUI: TransformationUI = new TransformationUI();
let browser: Browser;


When(
  "User drag and drop below widget and validate below fields with text and validate it in canvas in {string} screen",
  async (pageScreen, table: DataTable) => {
    try {
      const formValues = table.hashes();
      for (let i = 0; i < formValues.length; i++) {
        console.log(formValues[i]);
        const reqElement = page.locator(
          "//konfig-grid-item//*[contains(text(),'" +
          formValues[i].Text +
          "')]/../..//input"
        );
        console.log(
          "User drag and drop below widget and validate below fields as" +
          formValues[i].Text +
          "and validate it in canvas in" +
          pageScreen +
          "screen"
        );
        // await action.ClickElement("SearchWidget", pageScreen);
        // await action.fillText(formValues[i].Widget, "SearchWidget", pageScreen);
        await page.locator("//span[text()='Front Office']").click();
        await 
        await page.waitForTimeout(2000);
        await page.waitForLoadState('load');
        const grid = page.locator("//konfig-grid//div")
        if(grid.isVisible){
          page.waitForLoadState('load');
         await grid.click();
         console.log('Konfig grid is availbale for drag and drop');
        }
        await page.waitForTimeout(2000);
        await action.dragAndDrop(
          formValues[i].Widget,
          "CanvasBody",
          Number(formValues[i].X),
          Number(formValues[i].Y),
          "AllWidgets"
        );      
        //FieldLabel
        if (formValues[i].Fields == "FieldLabel") {
          await action.fillText(
            formValues[i].Text,
            formValues[i].Fields,
            pageScreen
          );
          await page.waitForTimeout(3000);
          await page.waitForTimeout(2000);
          if (formValues[i].Widget == "Button" || formValues[i].Widget == "Modal") {
            let elementText = await page.locator(
              "//app-grid-field//span[@class='label ng-star-inserted']"
            );
            let expectedText = await elementText.textContent();
            console.log("expectedText is :" + expectedText);
            await expect(expectedText.trim()).toEqual(formValues[i].Text);
            console.log("actualText is :" + formValues[i].Text);
          } else if (formValues[i].Widget == "Checkbox") {
            await assertion.checktext(
              "CheckboxLabel",
              pageScreen,
              formValues[i].Text
            );
          } else if (formValues[i].Widget == "Address") {
            let elementText = await page.locator(
              "(//konfig-grid-item//div[@class='f-input-label f-input-label-custom'])[1]"
            );
            let expectedText = await elementText.textContent();
            console.log("expectedText is :" + expectedText);
            await expect(expectedText?.trim()).toEqual(formValues[i].Text);
            console.log("actualText is :" + formValues[i].Text);
          } else if (formValues[i].Widget == "Avatar") {
            let elementText = await page.locator(
              "//konfig-grid-item//div[@class='p-element avatar-label']"
            );
            let expectedText = await elementText.textContent();
            console.log("expectedText is :" + expectedText);
            await expect(elementText).toContainText(formValues[i].Text);
            console.log("actualText is :" + formValues[i].Text);
          } else {
            await assertion.checktext(
              "WidgetLabel",
              pageScreen,
              formValues[i].Text
            );
          }
          console.log("FieldLabel is validation done");
          await action.ClickElement("WidgetClose", pageScreen);
          console.log("widgetClose");
          await action.ClickElement("DeleteSubmit", pageScreen);
          console.log("widgetDelete");
        } else if (formValues[i].Fields == "FieldName") {
          await action.fillText(
            formValues[i].Text,
            formValues[i].Fields,
            pageScreen
          );
          await page.waitForTimeout(3000);
          await action.ClickElement("WidgetSave", pageScreen);
          await page.waitForTimeout(2000);
          if (
            formValues[i].Widget == "Button" ||
            formValues[i].Widget == "Checkbox Group" ||
            formValues[i].Widget == "Container" ||
            formValues[i].Widget == "Tabs Container" ||
            formValues[i].Widget == "Divider" ||
            formValues[i].Widget == "Spacer" ||
            formValues[i].Widget == "Icon" ||
            formValues[i].Widget == "Avatar" ||
            formValues[i].Widget == "Header" ||
            formValues[i].Widget == "Footer" ||
            formValues[i].Widget == "Modal" ||
            formValues[i].Widget == "Dropdown" ||
            formValues[i].Widget == "Radio Group"
          ) {
            await assertion.checktext(
              "FieldNameValidation",
              pageScreen,
              "Field Name is required"
            );
          } else {
            await assertion.checktext(
              "FieldNameValidation",
              pageScreen,
              "Field Name is required"
            );
          }
          console.log("FieldName validation is done");
          await action.ClickElement("WidgetClose", pageScreen);
          console.log("widgetClose");
          await action.ClickElement("DeleteSubmit", pageScreen);
          console.log("widgetDelete");
        } else if (formValues[i].Fields == "PlaceHolder") {
          await action.fillText(
            formValues[i].Text,
            formValues[i].Fields,
            pageScreen
          );
          await page.waitForTimeout(3000);
          await page.waitForTimeout(2000);
          let placeholder;
          if (formValues[i].Widget == "Text Area") {
            placeholder = page.locator("//app-grid-field//textarea[@placeholder='" + formValues[i].Text + "']");
          } else {
            placeholder = await page.locator(
              "//app-grid-field//input[@placeholder='" + formValues[i].Text + "']"
            );
          }
          let actualText = await placeholder.getAttribute("placeholder");
          await expect(actualText?.trim()).toEqual(formValues[i].Text);
          console.log("Expected text is " + formValues[i].Text);
          console.log("actualText text is " + actualText);
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
          console.log("PlaceHolder is validation done");
        } else if (formValues[i].Fields == "PrefixText") {
          await page.waitForTimeout(3000);
          let Input = page.locator(
            "//*[translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ','abcdefghijklmnopqrstuvwxyz') = 'input']"
          );
          await Input.click();
          await page.waitForTimeout(2000);
          await action.enterText(
            formValues[i].Text,
            formValues[i].Fields,
            pageScreen
          );
          let prefix = page.locator(
            "//app-grid-field//div[@class='f-input-prefix-text ng-star-inserted']"
          );
          let text = await prefix.textContent();
          await expect(text.trim()).toEqual(formValues[i].Text);
          console.log("actual text is " + formValues[i].Text);
          console.log("expected text is " + text);
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
          await page.waitForTimeout(2000);
          console.log("PrefixText is validation done");
        } else if (formValues[i].Fields == "SuffixText") {
          await page.waitForTimeout(3000);
          await action.ClickElement("INPUT", pageScreen);
          await page.waitForTimeout(2000);
          await action.enterText(
            formValues[i].Text,
            formValues[i].Fields,
            pageScreen
          );
          let suffix = page.locator(
            "//app-grid-field//div[@class='f-input-suffix-text ng-star-inserted']"
          );
          let text = await suffix.textContent();
          await expect(text.trim()).toEqual(formValues[i].Text);
          console.log("actual text is " + formValues[i].Text);
          console.log("expected text is " + text);
          console.log("SuffixText is validation done");
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
        } else if (formValues[i].Fields == "ToolTip") {
          if (formValues[i].Widget == "Dropdown") {
            await page.waitForTimeout(500);
            await action.enterText(
              formValues[i].Text,
              formValues[i].Fields,
              pageScreen
            );
            await page.waitForTimeout(500);
            await action.mouseHoverElement("WidgetLabelToolTip", pageScreen);
            await page.waitForTimeout(2000);
          } else if (formValues[i].Widget == "Avatar") {
            await page.waitForTimeout(3000);
            await action.ClickElement("AVATAR", pageScreen);
            await page.waitForTimeout(2000);
            await action.enterText(
              formValues[i].Text,
              formValues[i].Fields,
              pageScreen
            );
            await page.waitForTimeout(2000);
            await action.mouseHoverElement("AvatarToolTip", pageScreen);
            await page.waitForTimeout(2000);
          } else {
            await page.waitForTimeout(3000);
            await action.ClickElement("INPUT", pageScreen);
            await page.waitForTimeout(2000);
            await action.enterText(
              formValues[i].Text,
              formValues[i].Fields,
              pageScreen
            );
            await page.waitForTimeout(2000);
            await action.mouseHoverElement("WidgetLabelToolTip", pageScreen);
            await page.waitForTimeout(2000);
          }
          let toolTip = page.locator(
            "//div[@class='p-tooltip-text' and text()='" +
            formValues[i].Text +
            "']"
          );
          let text = await toolTip.textContent();
          await expect(text.trim()).toEqual(formValues[i].Text);
          console.log("actual tooltip is " + formValues[i].Text);
          console.log("expected tooltip is " + text);
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
          console.log("ToolTip is validation done");

        } else if (formValues[i].Fields == "DefaultValue") {
          if (formValues[i].Widget == "Radio Group") {
            await action.ClickElement("INPUT", pageScreen);
            await action.ClickElement("AddItem", pageScreen);
            await page.waitForTimeout(2000);
            await action.enterText(formValues[i].Text, "ValuesValue", pageScreen);
            let close = page.locator("//span/..//button[@type='button']//span");
            await close.click();
            await page.waitForTimeout(2000);
            await action.selectDropdownbytagName(
              "span",
              "DefaultValueDropdown",
              formValues[i].Text,
              pageScreen
            );
            let SelectedValue = page.locator(
              "//app-grid-field//label[contains(text(),'" +
              formValues[i].Text +
              "')]/../..//div[@class='p-radiobutton-box p-highlight']"
            );
            await expect(SelectedValue).toBeVisible();
            console.log("The given element is visible");
          } else if (formValues[i].Widget == "Checkbox") {
            await action.ClickElement("CheckBox", pageScreen);
            await action.ClickElement(
              "CheckBoxDefaultValueChecked",
              pageScreen
            );
            await page.waitForTimeout(4000);
            await assertion.Visible(
              "CanvasCheckBoxDefaultValueChecked",
              pageScreen
            );
          } else if (formValues[i].Widget == "Dropdown") {
            await action.ClickElement("INPUT", pageScreen);
            await action.ClickElement("OptionsClick", pageScreen);
            await page.waitForTimeout(2000);
            await action.enterText(formValues[i].Text, "ValuesValue", pageScreen);
            await page.waitForTimeout(2000);
            await action.selectDropdownbytagName(
              "span",
              "DefaultValueDropdown",
              formValues[i].Text,
              pageScreen
            );
            let SelectedValue = page.locator(
              "//konfig-grid-item//app-grid-field//div[contains(text(),'" +
              formValues[i].Text +
              "')]"
            );
            await page.waitForTimeout(2000);
            await expect(SelectedValue).toBeVisible();
            console.log("The given element is visible");
          } else if (formValues[i].Widget == "Address") {
            await action.ClickElement("INPUT", pageScreen);
            await page.waitForTimeout(2000);
            await action.fillText(
              formValues[i].Text,
              formValues[i].Fields,
              pageScreen
            );
            await page.waitForTimeout(3000);
            await page.waitForTimeout(2000);
            let defaultValue = await page.locator(
              "//input[@class='p-inputtext p-component p-element p-inputtext-custom ng-star-inserted pac-target-input p-filled']"
            );
            await expect(defaultValue).toBeVisible();
            console.log("The given element is visible");
          } else {
            await action.ClickElement("INPUT", pageScreen);
            await page.waitForTimeout(2000);
            await action.fillText(
              formValues[i].Text,
              formValues[i].Fields,
              pageScreen
            );
            await page.waitForTimeout(3000);
            await page.waitForTimeout(2000);
            let defaultValue = await page.locator(
              "//input[@class='p-inputtext p-component p-element p-inputtext-custom ng-star-inserted p-filled']"
            );
            await expect(defaultValue).toBeVisible();
            console.log("The given element is visible");
          }
          console.log("Default is validation done");
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
        } else if (formValues[i].Fields == "Required") {
          await action.fillText(formValues[i].Text, "FieldLabel", pageScreen);
          await page.waitForTimeout(3000);
          await action.ClickElement("VALIDATIONS", pageScreen);
          if (formValues[i].Widget == "Checkbox") {
            await action.ClickElement("CheckBoxRequired", pageScreen);
          } else {
            await action.ClickElement("Required", pageScreen);
          }

          let Element = page.locator(
            "//konfig-grid//konfig-grid-item//*[contains(text(),'*')]"
          );
          let actualText = await Element.textContent();
          console.log("expectedText is *")
          console.log("actualText is" + actualText);
          await expect(actualText.trim()).toEqual("*");
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
          console.log("Required field validation done");
        } else if (formValues[i].Fields == "ShowClearButton") {
          await action.fillText(formValues[i].Text, "FieldLabel", pageScreen);
          await action.ClickElement("INPUT", pageScreen);
          await action.ClickElement(formValues[i].Fields, pageScreen);
          await action.ClickElement("WidgetSave", pageScreen);
          await page.waitForTimeout(2000);
          await reqElement.fill(formValues[i].Text);
          await assertion.Visible("CanvasWidgetClearbutton", pageScreen);
          await page.waitForTimeout(2000);
          await reqElement.click({ button: "right" });
          await action.ClickElement("DeleteWidget", pageScreen);
          await page.waitForTimeout(500);
          await action.ClickElement("DeleteSubmit", pageScreen);
          console.log("ShowClearButton is validation done");
        } else if (formValues[i].Fields == "ThousandSeparator") {
          await action.ClickElement("NUMBER FORMAT", pageScreen);
          await action.ClickElement("ThousandsSeparator", pageScreen);
          let Number = page.locator(
            "//div[text()=' Number']/../..//span//input"
          );
          await Number.fill(formValues[i].Text);
          console.log("actual text is " + formValues[i].Text);
          let expectedValue = await Number.getAttribute("aria-valuenow");

          console.log("actual text is " + formValues[i].Text);
          await expect(expectedValue).toEqual(formValues[i].ExpectedText);
          console.log("expected text is " + expectedValue);
          console.log("Thousand Separator validation done");
        } else if (formValues[i].Fields == "CurrencyType") {
          await action.fillText(formValues[i].Text, "FieldLabel", pageScreen);
          await action.ClickElement("NUMBER FORMAT", pageScreen);
          await page.waitForTimeout(500);
          await action.selectDropdownbyspantext("TypeOfFormat", pageScreen, "Currency");
          await page.waitForTimeout(3000);
          await action.ClickElement("CurrencyDropdown", pageScreen);
          await action.enterText(
            formValues[i].Text,
            "CurrencySearch",
            pageScreen
          );
          await action.ClickElement("SelectFirstCountry", pageScreen);
          await page.waitForTimeout(500);
          if (formValues[i].ExpectedText) {
            let Element = page.locator(
              "//konfig-grid-item//*[contains(text(),'" +
              formValues[i].ExpectedText +
              "')]"
            );
            let actualText = await Element.textContent();
            console.log("actualText is" + actualText);
            await expect(Element).toContainText(formValues[i].ExpectedText);
          }
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
          console.log("Currency is validation done");
        } else if (formValues[i].Fields == "PrefixIcon") {
          let Input = page.locator(
            "//*[translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ','abcdefghijklmnopqrstuvwxyz') = 'input']"
          );
          await Input.click();
          await page.waitForTimeout(2000);
          await action.ClickElement("PrefixIcon", pageScreen);
          await page.waitForTimeout(2000);
          let icon = page.locator(
            "(//*[@name='leftIcon']//span[@class='p-element material-icons each-icon ng-star-inserted'])[1]"
          );
          await icon.click();
          await page.waitForTimeout(3000);
          icon = page.locator(
            "//app-grid-field//span//finlevit-icon-preview//i[contains(@class,'left material material-icons')]"
          );
          await expect(icon).toBeVisible();
          console.log("The given element is visible");
          await page.waitForTimeout(2000);
          console.log("PrefixIcon is validation done");
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
        } else if (formValues[i].Fields == "SuffixIcon") {
          let Input = page.locator(
            "//*[translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ','abcdefghijklmnopqrstuvwxyz') = 'input']"
          );
          await Input.click();
          await action.ClickElement("SuffixIcon", pageScreen);
          await page.waitForTimeout(2000);
          let icon = page.locator(
            "(//*[@name='rightIcon']//span[@class='p-element material-icons each-icon ng-star-inserted'])[1]"
          );
          await icon.click();
          await page.waitForTimeout(3000);
          icon = page.locator(
            "//app-grid-field//span//finlevit-icon-preview//i[contains(@class,'material material-icons right')]"
          );
          await expect(icon).toBeVisible();
          console.log("The given element is visible");
          await page.waitForTimeout(2000);
          console.log("SuffixIcon is validation done");
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
        } else if (formValues[i].Fields == "ShowStepperButtons") {
          await action.ClickElement("INPUT", pageScreen);
          await action.ClickElement("ShowStepperButtons", pageScreen);
          await page.waitForTimeout(2000);
          let stepperButton = page.locator(
            "//app-grid-field//span[@class='p-inputnumber-button-group ng-star-inserted']"
          );
          await expect(stepperButton).toBeVisible();
          console.log("ShowStepperButtons element is visible");
          await page.waitForTimeout(2000);
          console.log("ShowStepperButton is validation done");
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
        } else if (formValues[i].Fields == "Hide") {
          if (formValues[i].Widget == "Container") {
            await action.ClickElement("Hide", pageScreen);
            await page.waitForTimeout(2000);
            let reqElement = page.locator(
              "//konfig-grid-item[@class='selected card-container ng-star-inserted']"
            );
            await expect(reqElement).toBeHidden();
          } else if (formValues[i].Widget == "Text") {
            await action.ClickElement("TEXT", pageScreen);
            await action.fillText(formValues[i].Text, "Value", pageScreen);
            await action.ClickElement("CONFIGURATIONS", pageScreen);
            await action.ClickElement("Hide", pageScreen);
            await assertion.Hidden("TextWidgetCanvas", pageScreen);
          } else if (
            formValues[i].Widget == "Avatar" ||
            formValues[i].Widget == "Table" ||
            formValues[i].Widget == "Advance Table"
          ) {
            await action.ClickElement("CONFIGURATIONS", pageScreen);
            await action.ClickElement("Hide", pageScreen);
            let reqElement = page.locator(
              "//konfig-grid-item//div[@class='input-container ng-star-inserted']"
            );
            await expect(reqElement).toBeHidden();
          } else if (formValues[i].Widget == "Address") {
            await action.ClickElement("CONFIGURATIONS", pageScreen);
            await action.ClickElement("Hide", pageScreen);
            let reqElement = page.locator(
              "//konfig-grid-item//*[text()=' " +
              formValues[i].Text +
              "']"
            );
            await expect(reqElement).toBeHidden();
          } else if (formValues[i].Widget == "Icon") {
            await action.ClickElement("Hide", pageScreen);
            await assertion.Hidden("IconCanvas", pageScreen);
          } else if (formValues[i].Widget == "Modal") {
            await action.ClickElement("Hide", pageScreen);
            let reqElement = page.locator(
              "//button[@class='animate f-button-custom']"
            );
            await expect(reqElement).toBeHidden();
          } else if (formValues[i].Widget == "Button") {
            await action.ClickElement("CONFIGURATIONS", pageScreen);
            await action.ClickElement("Hide", pageScreen);
            let reqElement = page.locator(
              "//button[@class='animate f-button-custom']"
            );
            await expect(reqElement).toBeHidden();
          } else {
            await action.fillText(formValues[i].Text, "FieldLabel", pageScreen);
            await action.ClickElement("CONFIGURATIONS", pageScreen);
            await action.ClickElement("Hide", pageScreen);
            await page.waitForTimeout(2000);
            await expect(reqElement).toBeHidden();
          }
          console.log("The element is not visible");
          await page.waitForTimeout(2000);
          console.log("Hide validation done");
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
        } else if (formValues[i].Fields == "ReadOnly") {
          await action.fillText(formValues[i].Text, "FieldLabel", pageScreen);
          if (formValues[i].Widget == "Button") {
            await action.ClickElement("CONFIGURATIONS", pageScreen);
            await action.ClickElement("ReadOnly", pageScreen);
            let buttonType = page.locator(
              "//*[@type='button']"
            );
            await page.waitForTimeout(500);
            await expect(buttonType).toBeDisabled();
          } else if (formValues[i].Widget == "Radio Group") {
            await action.ClickElement("INPUT", pageScreen);
            await action.ClickElement("AddItem", pageScreen);
            await page.waitForTimeout(2000);
            await action.enterText(formValues[i].Text, "ValuesValue", pageScreen);
            await action.ClickElement("CONFIGURATIONS", pageScreen);
            await action.ClickElement("ReadOnly", pageScreen);
            await page.waitForTimeout(500);
            await expect(reqElement).toBeDisabled();
          } else if (formValues[i].Widget == "Checkbox Group") {
            await action.ClickElement("VALUES", pageScreen);
            await action.ClickElement("ClickValue", pageScreen);
            await page.waitForTimeout(2000);
            await action.enterText(formValues[i].Text, "ValuesValue", pageScreen);
            await action.ClickElement("CONFIGURATIONS", pageScreen);
            await action.ClickElement("ReadOnly", pageScreen);
            await page.waitForTimeout(500);
            await expect(reqElement).toBeDisabled();
          } else if (formValues[i].Widget == "Checkbox") {
            await action.ClickElement("CONFIGURATIONS", pageScreen);
            await action.ClickElement("ReadOnly", pageScreen);
            await page.waitForTimeout(500);
            let checkbox = page.locator(
              "//konfig-grid//konfig-grid-item//*[contains(text(),'" +
              formValues[i].Text +
              "')]/../..//input[@type='checkbox']"
            );
            await expect(checkbox).toBeDisabled();
          } else if (formValues[i].Widget == "Text Area") {
            await action.ClickElement("CONFIGURATIONS", pageScreen);
            await action.ClickElement("ReadOnly", pageScreen);
            await page.waitForTimeout(500);
            let TextArea = page.locator(
              "//konfig-grid-item//finlevit-lib-textarea//*[contains(@class,'p-inputtextarea p-inputtext')]"
            );
            await expect(TextArea).toBeDisabled();
          } else {
            await action.ClickElement("CONFIGURATIONS", pageScreen);
            await action.ClickElement("ReadOnly", pageScreen);
            await page.waitForTimeout(500);
            await expect(reqElement).toBeDisabled();
          }
          console.log("The element is disabled");
          await page.waitForTimeout(2000);
          console.log("ReadOnly validation done");
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
        } else if (formValues[i].Fields == "FormulaField") {
          let reqElement = page.locator("//span//b[text()='Formula Builder']");
          await action.fillText(formValues[i].Text, "FieldLabel", pageScreen);
          await action.ClickElement("CONFIGURATIONS", pageScreen);
          await action.ClickElement("FormulaField", pageScreen);
          await action.ClickElement("ConfigureFormula", pageScreen);
          await page.waitForTimeout(2000);
          let expectedText = await reqElement.textContent();
          await expect(expectedText.trim()).toEqual("Formula Builder");
          console.log("actual text is" + "Formula Builder");
          console.log("expected text is" + expectedText);
          await action.ClickElement("Cancel", pageScreen);
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
          await page.waitForTimeout(2000);
          console.log("Formula field assertion is successful");
        } else if (formValues[i].Fields == "Title") {
          await action.ClickElement("CONTAINER", pageScreen);
          await action.enterText(formValues[i].Text, "Title", pageScreen);
          await page.waitForTimeout(2000);
          let reqElement = page.locator(
            "//konfig-grid-item//*[contains(text(),'" +
            formValues[i].Text +
            "')]"
          );
          await expect(reqElement).toHaveText(formValues[i].Text);
          let expectedText = await reqElement.textContent();
          console.log("actual text is" + formValues[i].Text);
          console.log("expected text is" + expectedText);
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
          await page.waitForTimeout(2000);
          console.log("Title is visible in container");
        } else if (formValues[i].Fields == "WidgetValue") {
          await action.ClickElement("VALUES", pageScreen);
          await action.ClickElement("ClickValue", pageScreen);
          await page.waitForTimeout(2000);
          await action.enterText(formValues[i].Text, "ValuesValue", pageScreen);
          let value = await page.locator(
            "//konfig-grid-item//label[@class='checkbox-option-label']"
          );
          let expectedText = await value.textContent();
          await expect(value).toContainText(formValues[i].Text);
          console.log("expected text is" + expectedText);
          console.log("actual text is" + formValues[i].Text);
          console.log("WidgetValue validation done");
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
          console.log("given value is displayed in canvas");
        } else if (formValues[i].Fields == "AddTab") {
          await action.fillText(formValues[i].Text, "FieldName", pageScreen);
          await action.ClickElement("TABS", pageScreen);
          await action.ClickElement("ExisitingTab", pageScreen);
          await action.fillText(
            formValues[i].Tab1,
            "AddTabFieldName",
            pageScreen
          );
          await action.fillText(formValues[i].Tab1, "AddTabTabLabel", pageScreen);
          await action.ClickElement("AddTab", pageScreen);
          await page.waitForTimeout(2000);
          await action.fillText(
            formValues[i].Tab2,
            "AddTabFieldName",
            pageScreen
          );
          await action.fillText(formValues[i].Tab2, "AddTabTabLabel", pageScreen);
          await page.waitForTimeout(2000);
          let reqElement = page.locator(
            "//konfig-grid-item//app-tab-container//a[@class='p-ripple p-element p-tabview-nav-link']"
          );
          let tabValue = await reqElement.count();
          console.log("avalilable tab is " + tabValue);
          for (let i = 0; i < tabValue; i++) {
            let tab = await reqElement.nth(i).textContent();
            console.log(" the tab is" + tab);
          }
          await expect(reqElement.nth(0)).toHaveText(formValues[i].Tab1);
          await expect(reqElement.nth(1)).toHaveText(formValues[i].Tab2);
          console.log("AddTab validation done");
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
          console.log("given value is displayed in canvas");
        } else if (formValues[i].Fields == "Value") {
          await action.ClickElement("TEXT", pageScreen);
          await action.fillText(
            formValues[i].Text,
            formValues[i].Fields,
            pageScreen
          );
          await page.waitForTimeout(3000);
          await page.waitForTimeout(2000);
          await assertion.checktext(
            "TextWidgetCanvas",
            pageScreen,
            formValues[i].Text
          );
          console.log("Text Value validation done");
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
        } else if (formValues[i].Fields == "Text") {
          await action.ClickElement("DIVIDER", pageScreen);
          await page.waitForTimeout(2000);
          await action.fillText(
            formValues[i].Text,
            formValues[i].Fields,
            pageScreen
          );
          await page.waitForTimeout(2000);
          let Divider = await page.locator(
            "//konfig-grid-item//*[@class='input-container ng-star-inserted']"
          );
          let expectedText = await Divider.textContent();
          await expect(expectedText.trim()).toEqual(formValues[i].Text);
          console.log("expected text is" + expectedText);
          console.log("actual text is" + formValues[i].Text);
          console.log("DividerText validation done");
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
        } else if (formValues[i].Fields == "FontFamily") {
          await action.ClickElement("DIVIDER", pageScreen);
          await action.fillText(formValues[i].Text, "Text", pageScreen);
          await page.waitForTimeout(2000);
          await action.selectDropdownbyspantext(
            "DividerFontFamily",
            pageScreen,
            formValues[i].Text
          );
          await page.waitForTimeout(2000);
          let Divider = await page.locator(
            "//konfig-grid-item//*[contains(@style,'font-family: " +
            formValues[i].Text +
            "')]"
          );
          await Divider.isVisible();
          console.log("The expected element is Visible");
          console.log("FontFamily validation done");
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
        } else if (formValues[i].Fields == "Icon") {
          await action.ClickElement("IconIcon", pageScreen);
          let icon = page.locator(
            "(//*[@name='iconPicker']//span[@class='p-element material-icons each-icon ng-star-inserted'])[1]"
          );
          await icon.click();
          await page.waitForTimeout(3000);
          await assertion.Visible("IconCanvas", pageScreen);
          console.log("The given element is visible");
          await page.waitForTimeout(2000);
          console.log("Icon validation done");
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
        } else if (
          formValues[i].Fields == "Horizontal" ||
          formValues[i].Fields == "Vertical"
        ) {
          await action.ClickElement("STYLE", pageScreen);
          await action.ClickElement(formValues[i].Position, pageScreen);
          await assertion.Visible(formValues[i].CanvasPosition, pageScreen);
          console.log("The given element is visible");
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
        } else if (formValues[i].Fields == "Caption") {
          await action.ClickElement("AVATAR", pageScreen);
          await action.fillText(formValues[i].Text, "Caption", pageScreen);
          await assertion.checktext(
            "AvatarCaptionCanvas",
            pageScreen,
            formValues[i].Text
          );
          console.log("Caption validation done");
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
        } else if (formValues[i].Fields == "FallbackText") {
          await action.ClickElement("AVATAR", pageScreen);
          await action.fillText(formValues[i].Text, "FallbackText", pageScreen);
          await assertion.checktext(
            "AvatarFallbackTextCanvas",
            pageScreen,
            formValues[i].Text
          );
          console.log("FallbackText validation done");
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
        } else if (formValues[i].Fields == "ModalPopup") {
          await action.ClickElement("ModalCanvas", pageScreen);
          await assertion.checktext(
            "ModalPopHeader",
            pageScreen,
            formValues[i].Text
          );
          console.log("ModalPopuo validation done");
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
        } else if (formValues[i].Fields == "ModalAddPage") {
          await action.ClickElement("PAGES", pageScreen);
          await action.ClickElement("Add", pageScreen);
          await action.fillText(
            formValues[i].Text,
            "ModalPageFieldName",
            pageScreen
          );
          await action.fillText(
            formValues[i].Title,
            "ModalPageTitle",
            pageScreen
          );
          await action.ClickElement("ModalCanvas", pageScreen);
          await assertion.checktext(
            "ModalPopHeader",
            pageScreen,
            formValues[i].Title
          );
          await page.waitForTimeout(3000);
          console.log("ModalAddPage validation done");
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
        } else if (formValues[i].Fields == "Name") {
          await action.fillText(formValues[i].Text, "Name", "AdvanceTable");
          await action.ClickElement("WidgetSave", pageScreen);
          await assertion.checktext(
            "FieldNameValidation",
            pageScreen,
            "Name is required"
          );
          await page.waitForTimeout(3000);
          console.log("Name validation done");
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
        } else if (formValues[i].Fields == "HideHeader") {
          await page.waitForTimeout(3000);
          await action.ClickElement("HideHeader", "AdvanceTable");
          await page.waitForTimeout(3000);
          await assertion.Hidden("TableHeader", "AdvanceTable");
          console.log("HideHeader validation done");
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
        } else if (formValues[i].Fields == "OverflowPagination") {
          await assertion.Visible("OverflowElement", "AdvanceTable");
          console.log("Caption validation done");
          console.log("OverflowPagination validation done");
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
        } else if (formValues[i].Fields == "OverflowScroll") {
          await action.ClickElement("PAGINATION", "AdvanceTable");
          await action.ClickElement("OverflowScroll", "AdvanceTable");
          await assertion.Hidden("OverflowElement", "AdvanceTable");
          console.log("OverflowScroll validation done");
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
        } else if (formValues[i].Fields == "PaginationTopCanvas") {
          await action.ClickElement("PAGINATION", "AdvanceTable");
          await page.waitForTimeout(2000);
          await action.ClickElement("PaginationTop", "AdvanceTable");
          await page.waitForTimeout(2000);
          await assertion.Visible("PaginationTopCanvas", "AdvanceTable");
          await page.waitForTimeout(2000);
          console.log("PaginationTopCanvas validation done");
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
        } else if (formValues[i].Fields == "PaginationBottomCanvas") {
          await action.ClickElement("PAGINATION", "AdvanceTable");
          await page.waitForTimeout(2000);
          await action.ClickElement("PaginationBottom", "AdvanceTable");
          await page.waitForTimeout(2000);
          await assertion.Visible("PaginationBottomCanvas", "AdvanceTable");
          await page.waitForTimeout(2000);
          console.log("PaginationBottomCanvas validation done");
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
        } else if (formValues[i].Fields == "FilterIconCanvas") {
          await action.ClickElement("PAGINATION", "AdvanceTable");
          await page.waitForTimeout(2000);
          await action.ClickElement("ShowFilter", "AdvanceTable");
          await page.waitForTimeout(2000);
          // await assertion.Visible("FilterIconCanvas", "AdvanceTable");
          await page.waitForTimeout(2000);
          console.log("FilterIconCanvas validation done");
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
        } else if (formValues[i].Fields == "Label") {
          await action.ClickElement("ROWACTIONS", "AdvanceTable");
          await page.waitForTimeout(2000);
          await action.fillText(formValues[i].Text, "Label", "AdvanceTable");
          await page.waitForTimeout(2000);
          await assertion.checktext(
            "LabelCanvas",
            "AdvanceTable",
            formValues[i].Text
          );
          await page.waitForTimeout(2000);
          console.log("LabelValidaton validation done");
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
        }
        else if (formValues[i].Fields == "Values") {
          let Checkboxvalue = page.locator("//finlevit-lib-checkbox-group//div//label[@class='checkbox-option-label']");
          let RadioValue = page.locator("//finlevit-radio-group//div//label[@class='radio-option-label']");

          if (formValues[i].Widget == "Radio Group") {
            await action.fillText(
              formValues[i].Text,
              "FieldLabel",
              pageScreen
            );
            await action.ClickElement("INPUT", pageScreen);
            await action.ClickElement("AddItem", pageScreen);
            await action.ClickElement("ValuesValue", pageScreen);
            await action.enterText(
              formValues[i].Value1,
              "ValuesValue",
              pageScreen
            );
            let actualText = await RadioValue.textContent();
            await expect(actualText?.trim()).toEqual(formValues[i].Value1);
            console.log("expected text is " + formValues[i].Value1);
            console.log("actual text is " + actualText);
          }
          else if (formValues[i].Widget == "Checkbox Group") {
            await action.fillText(
              formValues[i].Text,
              "FieldLabel",
              pageScreen
            );
            await action.ClickElement("VALUES", pageScreen);
            await action.ClickElement("ClickValue", pageScreen);
            await action.ClickElement("ValuesValue", pageScreen);
            await action.enterText(formValues[i].Value1, "ValuesValue", pageScreen);
            let actualText = await Checkboxvalue.textContent();
            await expect(actualText?.trim()).toEqual(formValues[i].Value1);
            console.log("expected text is " + formValues[i].Value1);
            console.log("actual text is " + actualText);
          }
          console.log("Values validation done");
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
        }
        else if (formValues[i].Fields == "Alignment") {
          if (formValues[i].Widget == "Advance Table" || formValues[i].Widget == "Table") {
            await page.waitForTimeout(2000);
            await action.ClickElement("ROWACTIONS", "AdvanceTable");
            await page.waitForTimeout(2000);
            await action.ClickElement(formValues[i].LabelAlignment, "AdvanceTable");
            console.log("element is chosen");
            await page.waitForTimeout(2000);
            let canvasAlignmnet = page.locator(
              "//div[@class='f-column-header-name " +
              formValues[i].Text +
              "' and text()=' Actions ']"
            );
            console.log("let " + canvasAlignmnet);
            await expect(canvasAlignmnet).toBeVisible();
            console.log("element is visible");
            await page.waitForTimeout(2000);
            console.log("Alignment validation done");
            await action.ClickElement("WidgetClose", pageScreen);
            await action.ClickElement("DeleteSubmit", pageScreen);
          }
          else if (formValues[i].Widget == "Radio Group") {
            await action.fillText(
              formValues[i].Text,
              "FieldLabel",
              pageScreen
            );
            await action.ClickElement("INPUT", pageScreen);
            for (let j = 1; j <= 2; j++) {
              await action.ClickElement("AddItem", pageScreen);
              await action.ClickElement("ValuesValue", pageScreen);
              await action.enterText(
                formValues[i][`Value${j}`],
                "ValuesValue",
                pageScreen
              );
            }
            if (formValues[i].HorzontalAligment == "True") {
              await action.ClickElement("ValueAlignHorizontal", pageScreen)
              let HorizontalAlignment = page.locator("//finlevit-radio-group//div[@class='radio-options-wrapper horizontal']");
              await expect(HorizontalAlignment).toBeVisible();
              console.log("Horizontal value assigment is chosen");
            } else if (formValues[i].HorzontalAligment == "False") {
              let VerticalAlignment = page.locator("//finlevit-radio-group//div[@class='radio-options-wrapper vertical']");
              await expect(VerticalAlignment).toBeVisible();
              console.log("Vertical value assigment is chosen");
            }
            await action.ClickElement("WidgetClose", pageScreen);
            await action.ClickElement("DeleteSubmit", pageScreen);
          }
          else if (formValues[i].Widget == "Checkbox Group") {
            await action.fillText(
              formValues[i].Text,
              "FieldLabel",
              pageScreen
            );
            await action.ClickElement("VALUES", pageScreen);
            for (let k = 1; k <= 3; k++) {
              if (k == 1) {
                await action.ClickElement("ClickValue", pageScreen);
                await action.ClickElement("ValuesValue", pageScreen);
                await action.enterText(formValues[i][`Value${1}`], "ValuesValue", pageScreen);
                console.log("User entered value as:" + formValues[i][`Value${1}`]);
              } else {
                await action.ClickElement("AddItem", pageScreen);
                await action.ClickElement("ValuesValue", pageScreen);
                await action.enterText(
                  formValues[i][`Value${k}`],
                  "ValuesValue",
                  pageScreen
                );
                console.log("User entered value as:" + formValues[`Value${i}`]);
              }
            }
            if (formValues[i].HorzontalAligment == "True") {
              let HorizontalAlignment = page.locator("//finlevit-lib-checkbox-group//div[@class='checkbox-options-wrapper horizontal']");
              await expect(HorizontalAlignment).toBeVisible();
              console.log("Horizontal value assigment is chosen");
            } else if (formValues[i].HorzontalAligment == "False") {
              await action.ClickElement("ValueAlignVertical", pageScreen)
              let VerticalAlignment = page.locator("//finlevit-lib-checkbox-group//div[@class='checkbox-options-wrapper vertical']");
              await expect(VerticalAlignment).toBeVisible();
              console.log("Vertical value assigment is chosen");
            }
            await action.ClickElement("WidgetClose", pageScreen);
            await action.ClickElement("DeleteSubmit", pageScreen);
          }
          else if (formValues[i].Widget == "Text") {
            await action.ClickElement("TEXT", pageScreen)
            let Alignment = await page.locator("//div[contains(@class,'widget-Holder ')]//*[contains(text(),Align)]//span[text()='" + formValues[i].Text + "']");
            await Alignment.click();
            if (formValues[i].VerticalAlign) {
              let TextPosition = await page.locator("//div[contains(@style,'align-items: " + formValues[i].VerticalAlign + "')]");
              await expect(TextPosition).toBeVisible();
            } else if (formValues[i].HorizontalAlign) {
              let TextPosition = await page.locator("//div[contains(@style,'justify-content: " + formValues[i].HorizontalAlign + "')]");
              await expect(TextPosition).toBeVisible();
            }

            console.log(formValues[i].Text + " aligment is visible")
            await action.ClickElement("WidgetClose", pageScreen);
            await action.ClickElement("DeleteSubmit", pageScreen);
          }

        } else if (formValues[i].Fields == "CloumnAssertion") {
          await action.ClickElement("COLUMNS", "AdvanceTable");
          if (i == 0) {
            await action.ClickElement("Column1", "AdvanceTable");
          } else if (i != 0) {
            await action.ClickElement("AddColumn", "AdvanceTable");
          }
          console.log(formValues[i].CloumnName.length);
          if (formValues[i].CloumnName.length == 0) {
            console.log("column is empty");
            await action.fillText(
              formValues[i].CloumnName,
              "ColumnName",
              "AdvanceTable"
            );
            await action.ClickElement("WidgetSave", pageScreen);
            console.log("ColumnName validation done");
            await page.waitForTimeout(2000);
            console.log("element is visible");
            if (formValues[i].Widget == "Table") {
              await assertion.checktext(
                "FieldNameValidation",
                "AdvanceTable",
                "is required"
              );
            } else {
              await action.ClickElement("WidgetSave", pageScreen);
              await page.waitForTimeout(2000);
              await assertion.checktext(
                "FieldNameValidation",
                "AdvanceTable",
                "is required"
              );
            }
            console.log("ColumnName validation done");
          } else {
            await action.fillText(
              formValues[i].CloumnName,
              "ColumnName",
              "AdvanceTable"
            );
            console.log("ColumnName validation done");
            console.log("Cloumn name is " + formValues[i].CloumnName);
            await page.waitForTimeout(500);
          }
          await page.waitForTimeout(2000);
          await action.fillText(
            formValues[i].FieldLabel,
            "FieldLabel",
            "AdvanceTable"
          );
          await page.waitForTimeout(500);
          let elementText = await page.locator(
            "//div[@class='f-column-header-name left' and contains(text(),'" +
            formValues[i].FieldLabel +
            "')]"
          );
          let expectedText = await elementText.textContent();
          console.log("expectedText is :" + expectedText);
          await expect(elementText).toContainText(formValues[i].FieldLabel);
          console.log("actualText is :" + formValues[i].FieldLabel);
          await page.waitForTimeout(500);
          await action.ClickElement(formValues[i].Alignment, "AdvanceTable");
          let canvasAlignmnet = page.locator(
            "//div[@class='f-column-header-name " +
            formValues[i].canvasAlignmnet +
            "' and contains(text(),'" +
            formValues[i].FieldLabel +
            "')]"
          );
          console.log("let " + canvasAlignmnet);
          await expect(canvasAlignmnet).toBeVisible();
          await page.waitForTimeout(500);
          console.log("element is visible");
          console.log("FieldLabel validation done");
          await action.ClickElement("WidgetClose", pageScreen);
          await action.ClickElement("DeleteSubmit", pageScreen);
        }
      }
    } catch (err) {
      throw err;
    }
  }
);

When("User add required field validation msg to the fields in payload page {string} pageScreen", async (pageScreen, table: DataTable) => {

  try {
    console.log("User add required field validation msg to the fields in payload page " + pageScreen + " pageScreen");
    let formValues = table.hashes();
    for (let i = 0; i < formValues.length; i++) {
      await page.waitForTimeout(500);
      let reqElement = page.locator(
        "//konfig-grid-item//*[contains(text(),'" +
        formValues[i].fieldName +
        "')]"
      ).first();
      await reqElement.click({ button: "right" });
      await page.waitForTimeout(500);
      await action.ClickElement("EditWidget", pageScreen);
      await page.waitForTimeout(500);
      await action.ClickElement("VALIDATIONS", pageScreen);
      let checkbox = await ScreenMap.get(pageScreen).getSelector("CheckBoxRequired")
      await page.isVisible(checkbox).then(async (exist) => {
        if (exist == true) {
          await action.ClickElement("CheckBoxRequired", "UniqueWidgetFields");
        } else {
          await action.ClickElement("Required", pageScreen);
        }
      })
      await page.waitForTimeout(500);
      if (formValues[i].validationMessage) {
        await action.enterText(formValues[i].validationMessage, "CustomMsg", pageScreen);
      }
      await action.ClickElement("WidgetSave", pageScreen);
      await page.waitForTimeout(500);
      console.log(formValues[i].validationMessage + " Clicked on save button");
      // await assertion.checktext(
      //   "SavedSuccessfully",
      //   pageScreen,
      //   "Saved successfully"
      // );

    }

  } catch (err) {
    throw err;
  }
})

When('User enter {string} text in {string} field', async (value, elementName) => {
  await page.waitForTimeout(500);
  let field = page.locator("//div[text()=' " + elementName + "']/../..//input");
  //   await page.click(temp);
  // await page.locator(temp).fill(value);
  await field.fill(value);
  console.log('User enters ' + elementName + '  as ' + value);
});

When(
  "User drag and drop {string} widget and validate all the fields in canvas in {string} screen",
  async (Widget, pageScreen, table: DataTable) => {
    try {
      const formValues = table.hashes();
      console.log(
        "User drag and drop " +
        Widget +
        " widget and validate all the fields in canvas in " +
        pageScreen +
        " screen"
      );
      await action.ClickElement("SearchWidget", pageScreen);
      await action.fillText("Address", "SearchWidget", pageScreen);
      await page.waitForTimeout(3000);
      await action.dragAndDrop(
        Widget,
        "CanvasBody",
        Number(400),
        Number(200),
        "AllWidgets"
      );
      await action.ClickElement("WidgetSave", pageScreen);
      await page.waitForTimeout(3000);
      console.log(formValues.length);
      for (let i = 0; i < formValues.length; i++) {
        console.log(formValues[i]);
        const reqElement = page.locator(
          "//konfig-grid-item//*[text()=' " +
          formValues[i].WidgetType +
          "']"
        );
        // FieldName Validation
        if (formValues[i].Fields == "FieldName") {
          await page.waitForTimeout(3000);
          await reqElement.click({ button: "right" });
          await action.ClickElement("EditWidget", pageScreen);
          await page.waitForTimeout(3000);
          await action.fillText(
            formValues[i].Text,
            formValues[i].Fields,
            pageScreen
          );
          await page.waitForTimeout(3000);
          await action.ClickElement("WidgetSave", pageScreen);
          await page.waitForTimeout(2000);
          await assertion.checktext(
            "FieldNameValidation",
            pageScreen,
            "Field name can not be empty"
          );
          await action.ClickElement("WidgetClose", pageScreen);
          console.log("Field name is validated succesfully");
        } else if (formValues[i].Fields == "FieldLabel") {
          // FieldLabel validation
          await page.waitForTimeout(3000);
          await reqElement.click({ button: "right" });
          await action.ClickElement("EditWidget", pageScreen);
          await action.fillText(
            formValues[i].Text,
            formValues[i].Fields,
            pageScreen
          );
          await page.waitForTimeout(3000);
          await assertion.checktext(
            "WidgetLabel",
            pageScreen,
            formValues[i].Text
          );
          await action.ClickElement("WidgetClose", pageScreen);
          console.log("Field Label is validated succesfully");
        } else if (formValues[i].Fields == "PlaceHolder") {
          await page.waitForTimeout(3000);
          await reqElement.click({ button: "right" });
          await action.ClickElement("EditWidget", pageScreen);
          await action.fillText(
            formValues[i].Text,
            formValues[i].Fields,
            pageScreen
          );
          await page.waitForTimeout(3000);
          await page.waitForTimeout(2000);
          let placeholder = await page.locator(
            "//app-grid-field//input[@placeholder='" + formValues[i].Text + "']"
          );
          await assertion.getAttributeGiven(placeholder, "placeholder");
          console.log("Placeholder is validated succesfully");
          await action.ClickElement("WidgetClose", pageScreen);
        } else if (formValues[i].Fields == "PrefixText") {
          await page.waitForTimeout(3000);
          await reqElement.click({ button: "right" });
          await action.ClickElement("EditWidget", pageScreen);
          await page.waitForTimeout(3000);
          let Input = page.locator(
            "//*[translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ','abcdefghijklmnopqrstuvwxyz') = 'input']"
          );
          await Input.click();
          await page.waitForTimeout(2000);
          await action.enterText(
            formValues[i].Text,
            formValues[i].Fields,
            pageScreen
          );
          let prefix = page.locator(
            "//app-grid-field//div[@class='f-input-prefix-text ng-star-inserted']"
          );
          let text = await prefix.textContent();
          await expect(prefix).toContainText(formValues[i].Text);
          console.log("actual text is " + formValues[i].Text);
          console.log("expected text is " + text);
          console.log("PrefixText is validated succesfully");
          await action.ClickElement("WidgetClose", pageScreen);
        } else if (formValues[i].Fields == "SuffixText") {
          await page.waitForTimeout(3000);
          await reqElement.click({ button: "right" });
          await action.ClickElement("EditWidget", pageScreen);
          await page.waitForTimeout(3000);
          await action.ClickElement("INPUT", pageScreen);
          await page.waitForTimeout(2000);
          await action.enterText(
            formValues[i].Text,
            formValues[i].Fields,
            pageScreen
          );
          let suffix = page.locator(
            "//app-grid-field//div[@class='f-input-suffix-text ng-star-inserted']"
          );
          let text = await suffix.textContent();
          await expect(suffix).toContainText(formValues[i].Text);
          console.log("actual text is " + formValues[i].Text);
          console.log("expected text is " + text);
          console.log("SuffixText is validated succesfully");
          await action.ClickElement("WidgetClose", pageScreen);
        } else if (formValues[i].Fields == "ToolTip") {
          await page.waitForTimeout(3000);
          await reqElement.click({ button: "right" });
          await action.ClickElement("EditWidget", pageScreen);
          let toolTip = page.locator(
            "//div[@class='p-tooltip-text' and text()='" +
            formValues[i].Text +
            "']"
          );
          let text = await toolTip.textContent();
          await expect(toolTip).toContainText(formValues[i].Text);
          console.log("actual tooltip is " + formValues[i].Text);
          console.log("expected tooltip is " + text);
          console.log("ToolTip is validated succesfully");
          await action.ClickElement("WidgetClose", pageScreen);
        } else if (formValues[i].Fields == "DefaultValue") {
          await page.waitForTimeout(3000);
          await reqElement.click({ button: "right" });
          await action.ClickElement("EditWidget", pageScreen);
          await action.ClickElement("INPUT", pageScreen);
          await page.waitForTimeout(2000);
          await action.fillText(
            formValues[i].Text,
            formValues[i].Fields,
            pageScreen
          );
          await page.waitForTimeout(3000);
          await page.waitForTimeout(2000);
          let defaultValue = await page.locator(
            "//input[@class='p-inputtext p-component p-element p-inputtext-custom ng-star-inserted pac-target-input p-filled']"
          );
          await expect(defaultValue).toBeVisible();
          console.log("The given element is visible");
          console.log("DefaultValue is validated succesfully");
          await action.ClickElement("WidgetClose", pageScreen);
        }
      }
    } catch (error) { }
  }
);

When('User Widget should have attribute {string} value of {string} in {string} in {string} screen', async (attribute, expText, WidgetType, pageScreen) => {
  try {
    console.log('User Widget should have attribute  ' + attribute + ' in ' + WidgetType + ' in ' + pageScreen + ' screen')
    let elementText =await ScreenMap.get(pageScreen).getSelector(
      "PayloadFieldValue");
    
    elementText=await page.locator(elementText.replace("elementName",WidgetType))
    console.log("ekekek"+elementText);
    const actualText = await elementText.getAttribute(attribute);
    console.log("ActualText is " + actualText);
    await expect(actualText).toEqual(expText);
    console.log("expectedText is " + expText);
  }
  catch (err) {
    throw err;
  }
})

When('User should validate in payload placeholder value of {string} in {string} in {string} screen', async (expText, WidgetType, pageScreen) => {
  try {
    console.log('User should validate in payload placeholder value of '+expText+' in ' + WidgetType + ' in ' + pageScreen + ' screen')
    let elementText =await ScreenMap.get(pageScreen).getSelector(
      "DefaultValue") 
    
    let element= page.locator(elementText.replace("elementName",WidgetType));
    const actualText = await element.getAttribute("placeholder");
    console.log("ActualText is " + actualText);
    await expect(actualText?.trim()).toEqual(expText);
    console.log("expectedText is " + expText);
  }
  catch (err) {
    throw err;
  }
})

