import { Given, When, Then, DataTable } from "@cucumber/cucumber";
import { page } from "./world";
import { ScreenMap } from "../Utility/Source/Core";
import { Actions } from "../Utility/Util/Actions";
import { OnloadTriggers } from "../Main/OnloadTriggers";
import { Assertions } from "../Utility/Util/Assertions";
import { CommonUtilObject } from "../Utility/Util/CommonUtil";
import { expect } from "@playwright/test";
import { UniqueWidgets } from "../Main/UniqueWidgets";

let action: Actions = new Actions();
let onloadTrigger: OnloadTriggers = new OnloadTriggers();
let assertion: Assertions = new Assertions();
let uwidgets: UniqueWidgets = new UniqueWidgets();
let additionalParameters,queryParameters,formURLParameters,ErrorCodes,ErrorData;

When(
  "User clone Service Provider {string} in {string} screen",
  async (ServiceProviderName, pageScreen) => {
    try {
      console.log(
        "User clone Service Provider " +
        ServiceProviderName +
        " in " +
        pageScreen +
        " screen"
      );
      await page.waitForTimeout(3000);
      // Clone data source when there is no data source
      let emptyElement = await ScreenMap.get(pageScreen).getSelector(
        "emptyServiceProvider"
      );
      await page.isVisible(emptyElement).then(async (exist) => {
        if (exist == true) {
          await action.selectDropdownbytagName(
            "span",
            "CloneServiceProvider",
            ServiceProviderName,
            pageScreen
          );
          await page.waitForTimeout(3000);
        } else {
          // // Check given api sourceprovider already cloned for a group
          let availableSource = await action.getElement(
            "availableServiceProvider",
            pageScreen
          );
          await page.waitForSelector(
            await ScreenMap.get(pageScreen).getSelector("availableServiceProvider")
          );
          const count = await availableSource.count();
          console.log("Total available source provider " + count);
          let sourcePresent: boolean;
          for (let i = 0; i < count; i++) {
            let sourceProvider = await availableSource.nth(i).textContent();
            if (sourceProvider.trim() == ServiceProviderName) {
              console.log(
                "Service Provider " +
                ServiceProviderName +
                " already cloned for this group"
              );
              sourcePresent = true;
              break;
            }
          }
          console.log("sourcePresent is " + sourcePresent);
          // Clone api for a group
          if (sourcePresent != true) {
            await action.selectDropdownbytagName(
              "span",
              "CloneServiceProvider",
              ServiceProviderName,
              pageScreen
            );
            await page.waitForTimeout(500);
          }
        }
      }
      );
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User click Data resources {string} add DataList with below name service operation as below in {string} screen",
  async (sourceName, pageScreen, table: DataTable) => {

    try {
      let dataSources = page.locator("//finlevit-card//div[contains(text(),'" + sourceName + "')]");
      await dataSources.click();
      await page.waitForTimeout(2000);
      const formValues = table.hashes();
      for (let i = 0; i < formValues.length; i++) {
        await action.ClickElement("AddDataList", pageScreen);
        await action.fillText(formValues[i].ListName, "ListName", pageScreen);
        await page.waitForTimeout(2000);
        await action.selectDropdownbytagName("span", "SelectService", formValues[i].Service, pageScreen);
        await page.waitForTimeout(2000);
        await action.selectDropdownbyspantext("SelectOperation", pageScreen, formValues[i].Operation);
        await action.ClickElement("CreateButton", pageScreen);
        await page.waitForTimeout(2000);
      }
    } catch (error) {
      throw error;
    }
  }
);

Then(
  "User verify connection to {string} is available in {string} screen",
  async (higherEnv, pageScreen) => {
    //edit current env
    let envEdit = page.locator(
      "//div[text()=' " +
      process.env.Env.toLocaleLowerCase() +
      " ']/../../../..//button//span[text()='Edit']"
    );
    await envEdit.click();
    await page.waitForTimeout(500);
    //get higherEnv
    let hEnv = await action.getText(higherEnv, pageScreen);
    console.log("Higher Environment is " + hEnv?.trim());
    //save higher environment in global value
    CommonUtilObject.writeUsecaseTestData(
      process.env.FileName,
      higherEnv,
      hEnv?.trim()
    );
    process.env.higherEnv = hEnv?.trim();
    //click test connection
    await action.ClickElement("TestConnection", pageScreen);
    //validate sucess banner
    let sToast = page.locator("//*[contains(@class,'success')]");
    await sToast.isVisible();
    console.log(
      "Connection to Higher Environment " + hEnv + " has been success"
    );
    //save hEnv admin url to usecase test data file
    let tempURL = CommonUtilObject.readUsecaseTestData(
      "resources/TestData",
      "Finlevit_admin"
    );
    let hEnvURLAdminwithEnv = tempURL.replace("ENV", hEnv?.trim());
    let hEnvURLAdmin = hEnvURLAdminwithEnv.replace(/DOMAIN/g, process.env.Domain);
    CommonUtilObject.writeUsecaseTestData(
      'resources/' + process.env.Env + 'TestData',
      "hEnvURL_admin",
      hEnvURLAdmin
    );
    //save hEnv payload url to usecase test data file
    tempURL = CommonUtilObject.readUsecaseTestData(
      "resources/TestData",
      "Finlevit_workflow"
    );
    let hEnvURLworkflowwithEnv = tempURL.replace("ENV", hEnv?.trim());
    let hEnvURLworkflow = hEnvURLworkflowwithEnv.replace(/DOMAIN/g, process.env.Domain);
    CommonUtilObject.writeUsecaseTestData(
      'resources/' + process.env.Env + 'TestData',
      "hEnvURL_workflow",
      hEnvURLworkflow
    );
    //cancel button
    let cancelbutton = page.locator("//button//span[text()='Cancel']");
    await cancelbutton.click();
  }
);

Then(
  "User promotes {string} to {string} from {string} screen",
  function (string, string2, string3) {
    // Write code here that turns the phrase above into concrete actions
    return "pending";
  }
);

Then(
  "User selectes {string} and clicks on {string} button in {string} screen",
  async (appName, buttonName, pageScreen) => {
    try {
      //select checkbox based on the app
      let AppName = CommonUtilObject.readUsecaseTestData(
        process.env.FileName,
        appName
      );
      await page.waitForTimeout(5000)
      let App = page.locator("(//div[contains(text(),'" + AppName + "')]/../..//div)[1]");
      console.log("......App..." + App);
      while (!(await App.isVisible())) {
        let nextPage = page.locator("//i[@class='pi pi-angle-right']/../..//button");
        await nextPage.click();
      }
      let promoteBtn = page.locator(
        "//div[contains(text(),'" +
        AppName +
        "')]/../../../..//*[@data-test-id='promote-btn']//button"
      );
      await promoteBtn.click();
      console.log(
        "Promote button for Application: " + AppName + "  has been Clicked"
      );
      //verify success message
      let sToast = page.locator(
        "//*[contains(text,'" +
        AppName +
        " version " +
        CommonUtilObject.readUsecaseTestData(
          process.env.FileName,
          "LatestVersionNO"
        ) +
        ", has been promoted to " +
        process.env.higherEnv +
        "')]"
      );
      if (sToast.isVisible()) {
        console.log(
          AppName +
          " version " +
          CommonUtilObject.readUsecaseTestData(
            process.env.FileName,
            "LatestVersionNO"
          ) +
          ", has been promoted to " +
          process.env.higherEnv
        );
      } else {
        console.log(
          AppName +
          " version " +
          CommonUtilObject.readUsecaseTestData(
            process.env.FileName,
            "LatestVersionNO"
          ) +
          ", has not been promoted to " +
          process.env.higherEnv
        );
      }
    } catch (err) {
      console.log(err);
      throw err;
    }
  });

When(
  "User add new style in {string} screen",
  async (pageScreen, table: DataTable) => {
    try {
      console.log(
        "User add new style in " +
        pageScreen +
        " screen"
      );
      const formValues = table.hashes();
      console.log(formValues.length);
      for (let i = 0; i < formValues.length; i++) {
        console.log(formValues[i]);
        await page.waitForTimeout(2000)
        await action.ClickElement('AddStyle', pageScreen)
        await page.waitForTimeout(500);
        await action.fillText(formValues[i].StyleName, 'StyleName', pageScreen);
        await page.waitForTimeout(500);
        await action.selectDropdownbyspantext('WidgetType', pageScreen, formValues[i].WidgetType)
        await page.waitForTimeout(500);
        if (formValues[i].WidgetType == 'Button') {
          // Fill Label Attributes
          await action.selectDropdownbytagName('span', 'LabelFontStyle', formValues[i].LabelFontStyle, pageScreen)
          await action.ClickElement('LabelColor', pageScreen)
          await action.ClickElement('LabelColorInput', pageScreen)
          await action.fillText(formValues[i].LabelColor, 'LabelColorInput', pageScreen);
          await page.keyboard.press("Enter");
          await action.ClickElement('LabelBackgroundColor', pageScreen)
          await action.ClickElement('LabelBackgroundColorInput', pageScreen)
          await action.fillText(formValues[i].LabelBGColor, 'LabelBackgroundColorInput', pageScreen);
          await page.keyboard.press("Enter");
          console.log("Label Attributes are entered for " + formValues[i].WidgetType)
        }
        else if (formValues[i].WidgetType == 'Container') {
          // Fill Title Attributes
          await action.selectDropdownbytagName('span', 'TitleFontStyle', formValues[i].TitleFontStyle, pageScreen)
          await action.ClickElement('TitleBGColor', pageScreen)
          await action.ClickElement('TitleBGColorInput', pageScreen)
          await action.fillText(formValues[i].TitleBGColor, 'TitleBGColorInput', pageScreen);
          await page.keyboard.press("Enter");
          await action.fillText(formValues[i].TitleFontSize, 'TitleFontSize', pageScreen);
          console.log("Title Attributes are entered for " + formValues[i].WidgetType)
        }
        else if (formValues[i].WidgetType == 'Tab Container') {
          // Fill Tab Attributes
          await action.selectDropdownbytagName('span', 'TabFontStyle', formValues[i].TabFontStyle, pageScreen)
          await action.ClickElement('TabColor', pageScreen)
          await action.ClickElement('TabColorInput', pageScreen)
          await action.fillText(formValues[i].TabBGColor, 'TabColorInput', pageScreen);
          await page.keyboard.press("Enter");
          await action.fillText(formValues[i].TabFontSize, 'TabFontSize', pageScreen);
          console.log("Tab Attributes are entered for " + formValues[i].WidgetType)
        }
        else if (formValues[i].WidgetType == 'Checkbox') {
          // Fill Label Attributes
          await action.selectDropdownbytagName('span', 'LabelFontStyle', formValues[i].LabelFontStyle, pageScreen)
          await action.ClickElement('LabelColor', pageScreen)
          await action.ClickElement('LabelColorInput', pageScreen)
          await action.fillText(formValues[i].LabelColor, 'LabelColorInput', pageScreen);
          await page.keyboard.press("Enter");
          await action.fillText(formValues[i].LabelFontSize, 'LabelFontSize', pageScreen);
          console.log("Label Attributes are entered for " + formValues[i].WidgetType)
          // Fill Checlbox Attributes
          await action.ClickElement('Styles Checkbox', pageScreen)
          await action.ClickElement('CheckboxChecked Background Color', pageScreen)
          await action.ClickElement('CheckboxChecked Background Color Input', pageScreen)
          await action.fillText(formValues[i].CheckedBGColor, 'CheckboxChecked Background Color Input', pageScreen);
          await page.keyboard.press("Enter");
          await action.fillText(formValues[i].CheckboxSize, 'CheckboxSize', pageScreen);
          console.log("Checkbox Attributes are entered for " + formValues[i].WidgetType)
        }
        else if (formValues[i].WidgetType == 'Checkbox Group') {
          // Fill Label Attributes
          await action.selectDropdownbytagName('span', 'LabelFontStyle', formValues[i].LabelFontStyle, pageScreen)
          await action.ClickElement('LabelColor', pageScreen)
          await action.ClickElement('LabelColorInput', pageScreen)
          await action.fillText(formValues[i].LabelColor, 'LabelColorInput', pageScreen);
          await page.keyboard.press("Enter");
          await action.fillText(formValues[i].LabelFontSize, 'LabelFontSize', pageScreen);
          console.log("Label Attributes are entered for " + formValues[i].WidgetType)
          // Fill Checlbox Attributes
          await action.ClickElement('Styles Checkbox', pageScreen)
          await action.ClickElement('CheckboxChecked Background Color', pageScreen)
          await action.ClickElement('CheckboxChecked Background Color Input', pageScreen)
          await action.fillText(formValues[i].CheckedBGColor, 'CheckboxChecked Background Color Input', pageScreen);
          await page.keyboard.press("Enter");
          await action.fillText(formValues[i].CheckboxSize, 'CheckboxSize', pageScreen);
          console.log("Checkbox Attributes are entered for " + formValues[i].WidgetType)
          // Fill Options Attributes
          await action.ClickElement('Styles Option Text', pageScreen)
          await action.ClickElement('OptionColor', pageScreen)
          await action.ClickElement('OptionColorInput', pageScreen)
          await action.fillText(formValues[i].OptionLabelColor, 'OptionColorInput', pageScreen);
          await page.keyboard.press("Enter");
          await action.fillText(formValues[i].OptionFontSize, 'OptionFontSize', pageScreen);
          await action.selectDropdownbytagName('span', 'OptionFontStyle', formValues[i].OptionFontStyle, pageScreen)
          console.log("Options Attributes are entered for " + formValues[i].WidgetType)
        }
        else if (formValues[i].WidgetType == 'Radio Group') {
          // Fill Label Attributes
          await action.selectDropdownbytagName('span', 'LabelFontStyle', formValues[i].LabelFontStyle, pageScreen)
          await action.ClickElement('LabelColor', pageScreen)
          await action.ClickElement('LabelColorInput', pageScreen)
          await action.fillText(formValues[i].LabelColor, 'LabelColorInput', pageScreen);
          await page.keyboard.press("Enter");
          await action.fillText(formValues[i].LabelFontSize, 'LabelFontSize', pageScreen);
          console.log("Label Attributes are entered for " + formValues[i].WidgetType)
          // Fill Radio Button Attributes
          await action.ClickElement('Styles RadioButton', pageScreen)
          await action.ClickElement('RadioButton Selected Background Color', pageScreen)
          await action.ClickElement('RadioButton Selected Background Color Input', pageScreen)
          await action.fillText(formValues[i].SelectedBGColor, 'RadioButton Selected Background Color Input', pageScreen);
          await page.keyboard.press("Enter");
          await action.fillText(formValues[i].RadioButtonSize, 'RadioButtonSize', pageScreen);
          console.log("Radio button Attributes are entered for " + formValues[i].WidgetType)
          // Fill Option Attributes
          await action.ClickElement('Styles Option Text', pageScreen)
          await action.ClickElement('OptionColor', pageScreen)
          await action.ClickElement('OptionColorInput', pageScreen)
          await action.fillText(formValues[i].OptionLabelColor, 'OptionColorInput', pageScreen);
          await page.keyboard.press("Enter");
          await action.fillText(formValues[i].OptionFontSize, 'OptionFontSize', pageScreen);
          await action.selectDropdownbytagName('span', 'OptionFontStyle', formValues[i].OptionFontStyle, pageScreen)
          console.log("Options Attributes are entered for " + formValues[i].WidgetType)
        }
        else if (formValues[i].WidgetType == 'Table') {
          // Fill Label Attributes
          let FontStylelocator = await ScreenMap.get(pageScreen).getSelector(
            "LabelFontStyle"
          );
          let HeaderFontStyle = page.locator(
            FontStylelocator.replace("Label", "Header")
          );
          await action.selectDropdownbytagName('span', HeaderFontStyle, formValues[i].HeaderFontStyle)
          let BGColorlocator = await ScreenMap.get(pageScreen).getSelector(
            "LabelBackgroundColor"
          );
          let HeaderColor = page.locator(
            BGColorlocator.replace("Label", "Header")
          );
          await action.ClickElement(HeaderColor)
          let BGColorlocatorInput = await ScreenMap.get(pageScreen).getSelector(
            "LabelBackgroundColorInput"
          );
          let HeaderBGColorInput = page.locator(
            BGColorlocatorInput.replace("Label", "Header")
          );
          await action.ClickElement(HeaderBGColorInput)
          await HeaderBGColorInput.fill(formValues[i].HeaderColor);
          await page.keyboard.press("Enter");
          let FontSizelocator = await ScreenMap.get(pageScreen).getSelector(
            "LabelFontSize"
          );
          let HeaderFontSize = page.locator(
            FontSizelocator.replace("Label", "Header")
          );
          await HeaderFontSize.fill(formValues[i].HeaderFontSize);
          // await action.fillText(formValues[i].LabelFontSize, 'LabelFontSize', pageScreen);
          console.log("Header Attributes are entered for " + formValues[i].WidgetType)
          // Fill Body Attributes
          let Bodylocator = await ScreenMap.get(pageScreen).getSelector(
            "Styles Option Text"
          );
          let Body = page.locator(
            Bodylocator.replace("Option Text", "Body")
          );
          await action.ClickElement(Body)
          let Colorlocator = await ScreenMap.get(pageScreen).getSelector(
            "LabelColor"
          );
          let BodyColor = page.locator(
            Colorlocator.replace("Label", "Body")
          );
          await action.ClickElement(BodyColor)
          let ColorlocatorInput = await ScreenMap.get(pageScreen).getSelector(
            "LabelColorInput"
          );
          let BodyColorInput = page.locator(
            ColorlocatorInput.replace("Label", "Body")
          );
          await action.ClickElement(BodyColorInput)
          await BodyColorInput.fill(formValues[i].BodyColor);
          // await action.fillText(formValues[i].OptionLabelColor, 'OptionColorInput', pageScreen);
          await page.keyboard.press("Enter");
          let BodyFontSize = page.locator(
            FontSizelocator.replace("Label", "Body")
          );
          await BodyFontSize.fill(formValues[i].BodyFontSize);
          // await action.fillText(formValues[i].OptionFontSize, 'OptionFontSize', pageScreen);
          let BodyFontStyle = page.locator(
            FontStylelocator.replace("Label", "Body")
          );
          await action.selectDropdownbytagName('span', BodyFontStyle, formValues[i].BodyFontStyle)
          console.log("Body Attributes are entered for " + formValues[i].WidgetType)
        }
        else {
          // Fill Label Attributes
          await action.selectDropdownbytagName('span', 'LabelFontStyle', formValues[i].LabelFontStyle, pageScreen)
          await action.ClickElement('LabelColor', pageScreen)
          await action.ClickElement('LabelColorInput', pageScreen)
          await action.fillText(formValues[i].LabelColor, 'LabelColorInput', pageScreen);
          await page.keyboard.press("Enter");
          await action.fillText(formValues[i].LabelFontSize, 'LabelFontSize', pageScreen);
          console.log("Label Attributes are entered for " + formValues[i].WidgetType)
          // Fill Input Attributes
          await action.ClickElement('INPUT', pageScreen)
          await action.selectDropdownbytagName('span', 'InputFontStyle', formValues[i].InputFontStyle, pageScreen)
          await action.ClickElement('InputColor', pageScreen)
          await action.ClickElement('InputColorInput', pageScreen)
          await action.fillText(formValues[i].InputColor, 'InputColorInput', pageScreen);
          await page.keyboard.press("Enter");
          await action.fillText(formValues[i].InputFontSize, 'InputFontSize', pageScreen);
          console.log("Input Attributes are entered for " + formValues[i].WidgetType)
        }
        await action.ClickElement('StyleCreateButton', pageScreen)
        await page.waitForTimeout(500);
        // await assertion.checktext('Success', 'apiGenerator', 'Success')
        if (formValues[i].DefaultGroup) {
          if (formValues[i].DefaultGroup == 'Yes') {
            await action.ClickElement('DefaultGroupSlider', pageScreen);
            await action.ClickElement('saveStyle', pageScreen);
          }

        }

      }
    } catch (err) {
      throw err;
    }
  });

When(
  "User Edit style in {string} screen",
  async (pageScreen, table: DataTable) => {
    try {
      console.log(
        "User Edit style in " +
        pageScreen +
        " screen"
      );
      const formValues = table.hashes();
      console.log(formValues.length);
      for (let i = 0; i < formValues.length; i++) {
        console.log(formValues[i]);
        await page.waitForTimeout(2000)
        // await action.ClickElement('Styles widget search', pageScreen)
        // await page.waitForTimeout(500);
        await action.fillText(formValues[i].WidgetType, 'Styles widget search', pageScreen);
        await page.waitForTimeout(500);
        let widgetType = formValues[i].WidgetType;
        if (formValues[i].WidgetType == 'Password') {
          widgetType = widgetType + "Input"
        }
        else if (formValues[i].WidgetType == 'PhoneNumber') {
          widgetType = "PhonenumberInput"
        }
        else if (formValues[i].WidgetType == 'Date') {
          widgetType = "DatePicker"
        }
        let editWidgetType = await page.locator("//span[contains(@class,'p-accordion-header-text') and text()=' " + widgetType + " ']")
        await action.ClickElement(editWidgetType)
        let editWidget = await page.locator("//div[@role='region']//div[text()='" + formValues[i].StyleName + "']")
        await action.ClickElement(editWidget)
        await page.waitForTimeout(500);
        if (formValues[i].WidgetType == 'Button') {
          // Fill Label Attributes
          await action.selectDropdownbytagName('span', 'LabelFontStyle', formValues[i].LabelFontStyle, pageScreen)
          console.log(formValues[i].LabelFontStyle + " is updated for label attribute in " + formValues[i].WidgetType)
        }
        else if (formValues[i].WidgetType == 'Container') {
          // Fill Title Attributes
          await action.selectDropdownbytagName('span', 'TitleFontStyle', formValues[i].TitleFontStyle, pageScreen)
          await action.ClickElement('TitleBGColor', pageScreen)
          await action.ClickElement('TitleBGColorInput', pageScreen)
          await action.fillText(formValues[i].TitleBGColor, 'TitleBGColorInput', pageScreen);
          await page.keyboard.press("Enter");
          await action.fillText(formValues[i].TitleFontSize, 'TitleFontSize', pageScreen);
          console.log("Title Attributes are entered for " + formValues[i].WidgetType)
        }
        else if (formValues[i].WidgetType == 'Tab Container' || formValues[i].WidgetType == 'TabContainer') {
          // Fill Tab Attributes
          await action.selectDropdownbytagName('span', 'TabFontStyle', formValues[i].TabFontStyle, pageScreen)
          console.log(formValues[i].TabFontStyle + " is updated for label attribute in " + formValues[i].WidgetType)
        }
        else if (formValues[i].WidgetType == 'Checkbox') {
          // Fill Label Attributes
          await action.selectDropdownbytagName('span', 'LabelFontStyle', formValues[i].LabelFontStyle, pageScreen)
          console.log(formValues[i].LabelFontStyle + " is updated for label attribute in " + formValues[i].WidgetType)
        }
        else if (formValues[i].WidgetType == 'Checkbox Group' || formValues[i].WidgetType == 'CheckboxGroup') {
          let expandlabel = await assertion.getAttributeGiven('Label', 'aria-expanded', pageScreen)
          if (expandlabel == true) {
          }
          else {
            await action.ClickElement('Label', pageScreen)
          }
          // Fill Label Attributes
          await action.selectDropdownbytagName('span', 'LabelFontStyle', formValues[i].LabelFontStyle, pageScreen)
          console.log(formValues[i].LabelFontStyle + " is updated for label attribute in " + formValues[i].WidgetType)
          // Fill Options Attributes
          await action.ClickElement('Styles Option Text', pageScreen)
          await action.selectDropdownbytagName('span', 'OptionFontStyle', formValues[i].OptionFontStyle, pageScreen)
          console.log(formValues[i].OptionFontStyle + " is updated for Options attribute in " + formValues[i].WidgetType)
        }
        else if (formValues[i].WidgetType == 'Radio Group' || formValues[i].WidgetType == 'RadioGroup') {
          let expandlabel = await assertion.getAttributeGiven('Label', 'aria-expanded', pageScreen)
          if (expandlabel == true) {
          }
          else {
            await action.ClickElement('Label', pageScreen)
          }
          // Fill Label Attributes
          await action.selectDropdownbytagName('span', 'LabelFontStyle', formValues[i].LabelFontStyle, pageScreen)
          console.log(formValues[i].LabelFontStyle + " is updated for Label attribute in " + formValues[i].WidgetType)
          // Fill Option Attributes
          await action.ClickElement('Styles Option Text', pageScreen)
          await action.selectDropdownbytagName('span', 'OptionFontStyle', formValues[i].OptionFontStyle, pageScreen)
          console.log(formValues[i].OptionFontStyle + " is updated for Options attribute in " + formValues[i].WidgetType)
        }
        else {
          let expandlabel = await assertion.getAttributeGiven('Label', 'aria-expanded', pageScreen)
          if (expandlabel == true) {
          }
          else {
            await action.ClickElement('Label', pageScreen)
          }
          // Fill Label Attributes
          await action.selectDropdownbytagName('span', 'LabelFontStyle', formValues[i].LabelFontStyle, pageScreen)
          console.log(formValues[i].LabelFontStyle + " is updated for label attribute in " + formValues[i].WidgetType)
          // Fill Input Attributes
          await action.ClickElement('INPUT', pageScreen)
          await action.selectDropdownbytagName('span', 'InputFontStyle', formValues[i].InputFontStyle, pageScreen)
          console.log(formValues[i].LabelFontStyle + " is updated for input attribute in " + formValues[i].WidgetType)
        }
        await action.ClickElement('saveStyle', pageScreen)
        await page.waitForTimeout(500);
        await assertion.checktext('Success', 'apiGenerator', 'Success')
        //app name
        let Appname = CommonUtilObject.readUsecaseTestData(
          process.env.FileName,
          'Application_Name'
        );
        await action.selectDropdownbytagName('div', 'Select Application Dropdown', Appname, pageScreen)
        await page.waitForTimeout(500);
        await action.ClickElement('Apply Button', pageScreen);
        if (formValues[i].DefaultGroup) {
          if (formValues[i].DefaultGroup == 'Yes') {
            await action.ClickElement('DefaultGroupSlider', pageScreen);
            await action.ClickElement('saveStyle', pageScreen);
          }
        }
      }
    } catch (err) {
      throw err;
    }
  });

When(
  "User Delete style in {string} screen",
  async (pageScreen, table: DataTable) => {
    try {
      console.log(
        "User Delete style in " +
        pageScreen +
        " screen"
      );
      const formValues = table.hashes();
      console.log(formValues.length);
      for (let i = 0; i < formValues.length; i++) {
        console.log(formValues[i]);
        await page.waitForTimeout(2000)
        await action.fillText(formValues[i].WidgetType, 'Styles widget search', pageScreen);
        await page.waitForTimeout(500);
        let widgetType = formValues[i].WidgetType;
        if (formValues[i].WidgetType == 'Password') {
          widgetType = widgetType + "Input"
        }
        else if (formValues[i].WidgetType == 'PhoneNumber') {
          widgetType = "PhonenumberInput"
        }
        else if (formValues[i].WidgetType == 'Date') {
          widgetType = "DatePicker"
        }
        let editWidgetType = await page.locator("//span[contains(@class,'p-accordion-header-text') and text()=' " + widgetType + " ']")
        await action.ClickElement(editWidgetType)
        let editWidget = await page.locator("//div[@role='region']//div[text()='" + formValues[i].StyleName + "']")
        await action.ClickElement(editWidget)
        await page.waitForTimeout(500);
        console.log(formValues[i].StyleName + " style is opened")
        // delete style
        await action.ClickElement('deleteStyle', pageScreen)
        await page.waitForTimeout(500);
        await action.ClickElement('ConfirmdeleteStyle', pageScreen)
        await assertion.checktext('Success', 'apiGenerator', 'Success')

      }
    }catch (error) {
      throw error;
    }
  });

When(
  "User create service provider in {string} screen",
  async (pageScreen, table: DataTable) => {
    try {
      console.log(
        "User create service provider in "
        + pageScreen +
        " screen"
      );
      const formValues = table.hashes();
      await page.waitForTimeout(3000);
      await action.waitforInvisibilityOfSpinner()
      for (let i = 0; i < formValues.length; i++) {
        let sourcePresent: boolean;
        // Check given api data source already created for a group
        let availableSP = await ScreenMap.get(pageScreen).getSelector(
          "availableServiceProvider"
        );
        await page.isVisible(availableSP).then(async (exist) => {
          console.log("Service Provider availability: " + exist);
          if (exist == true) {
            let availableSource = await action.getElement(
              "availableServiceProvider",
              pageScreen
            );
            const count = await availableSource.count();
            console.log("Total available sources are " + count);
            for (let j = 0; j < count; j++) {
              let dataSource = await availableSource.nth(j).textContent();
              if (dataSource.trim() == formValues[i].SPName) {
                console.log(
                  "Data source " +
                  formValues[i].SPName +
                  " already created for this group"
                );
                sourcePresent = true;
                break;
              }
              sourcePresent = false;
            }
            console.log("sourcePresent is " + sourcePresent);
          }
          if (exist != true || sourcePresent != true) {
            await action.ClickElement("addServiceProvider", pageScreen);
            console.log("addServiceProvider is clicked");
            await page.waitForTimeout(500);
            // add sp details
            await action.fillText(formValues[i].SPName, "serviceProviderName", pageScreen);
            console.log("serviceProviderName is entered as "+formValues[i].SPName);
            await action.fillText(formValues[i].Description, "serviceProviderDescription", pageScreen);
            await action.selectDropdownbytagName('span', 'authorizationType', formValues[i].AuthorizationType, pageScreen)
            await action.ClickElement("//*[@formcontrolname='serviceProviderType']//label[contains(text(),' "+formValues[i].SPType+")']");
            if(formValues[i].APIBuilder == 'True'){
             await page.click("//*[@formcontrolname='isAPIBuilder']//p-checkbox");
             console.log("API Builder checkbox is selected");
             //valiadate if //*[@formcontrolname='endPoint']//input is disabled  
             let endPoint = await page.$("//*[@formcontrolname='endPoint']//input");
             let endPointDisabled = await endPoint?.getAttribute('disabled');
             console.log("endPointDisabled is " + endPointDisabled);
             // print the //*[@formcontrolname='endPoint']//input thats populated in that field
             console.log("endPoint is " + await endPoint?.getAttribute('value'));

             
            }
            else{
            await action.fillText(formValues[i].EndPointURL, "endPointURL", pageScreen);
            }
              
            await action.ClickElement("create", pageScreen);
            await assertion.ContainText('Success', pageScreen, 'Success')
           }
          
        });
      }
    } catch (err) {
      throw err;
    }
  });

When(
  "User edit service provider and add service in {string} screen",
  async (pageScreen, table: DataTable) => {
    try {
      console.log(
        "User edit service provider and add service in "
        + pageScreen +
        " screen"
      );
      const formValues = table.hashes();
      await page.waitForTimeout(3000);
      for (let i = 0; i < formValues.length; i++) {
        let dataSources = page.locator("//div[@class='f-card-title ng-star-inserted' and normalize-space(text())='" + formValues[i].SPName + "']");
        await dataSources.click();
        await page.waitForTimeout(2000)
        await action.waitforInvisibilityOfSpinner()
        let sourcePresent: boolean;
        // Check given service already created for a group
        let availableSP = await ScreenMap.get(pageScreen).getSelector(
          "availableServiceProvider"
        );
        await page.isVisible(availableSP).then(async (exist) => {
          console.log("Service availability" + exist);
          if (exist == true) {
            let availableSource = await action.getElement(
              "availableServiceProvider",
              pageScreen
            );
            const count = await availableSource.count();
            console.log("Total available sources are " + count);
            for (let j = 0; j < count; j++) {
              let dataSource = await availableSource.nth(j).textContent();
              if (dataSource.trim() == formValues[i].ServiceName) {
                console.log(
                  "Service " +
                  formValues[i].ServiceName +
                  " already created for this group"
                );
                sourcePresent = true;
                break;
              }
            }
            console.log("sourcePresent is " + sourcePresent);
          }
          if (exist != true || sourcePresent != true) {
            await action.ClickElement("addService", pageScreen);
            await page.waitForTimeout(500);
            // add service details
            await action.fillText(formValues[i].ServiceName, "serviceProviderName", pageScreen);
            await action.fillText(formValues[i].Description, "serviceProviderDescription", pageScreen);
            await action.ClickElement("create", pageScreen);
          }

        });
      }
    } catch (err) {
      throw err;
    }
  });


  When(
    "User edit service {string} and add Operations with {string} service, {string} Request, {string} ContentType and {string} in {string} screen",
    async (serviceName, serviceType, requestType, contentType, typeOfParameter, pageScreen, table: DataTable) => {
      try {
        console.log(
          "User edit service " + serviceName + " and add Operations in "
          + pageScreen +
          " screen"
        );
        const formValues = table.hashes();
        await page.waitForTimeout(2000);

        for (let i = 0; i < formValues.length; i++) {
          let service = page.locator("//div[@class='f-card-title ng-star-inserted' and normalize-space(text())='" + serviceName + "']");
          await service.click();
          await action.waitforInvisibilityOfSpinner()
          await page.waitForTimeout(500);
          let operationName
          if((formValues[i].OperationName).startsWith("#"))
            operationName = await CommonUtilObject.readUsecaseTestData(process.env.FileName,formValues[i].OperationName.replace("#", ""))
          else
            operationName=formValues[i].OperationName
          // Check given Operation already created for a group
          let availableSP = "//div[normalize-space(text())='" + operationName + "']"
          await page.isVisible(availableSP).then(async (exist) => {
            console.log("Operation availability" + exist);
            if (exist == true) {
              console.log(
                "Operation " +
                formValues[i].OperationName +
                " already created for this group"
              );
              await action.ClickElement("arrowLeft", pageScreen);
            }
            if (exist != true) {
              await action.ClickElement("addOperation", pageScreen);
              await page.waitForTimeout(500);
              // add sp details
              
              await action.fillText(operationName, "operationName", pageScreen);
              if((formValues[i].Path).startsWith("#")){
              let path = await CommonUtilObject.readUsecaseTestData(process.env.FileName,"Path")
              await action.fillText(path, "operationPath", pageScreen);
              }else{
              await action.fillText(formValues[i].Path, "operationPath", pageScreen);
              }
              await action.fillText(formValues[i].Description, "operationDescription", pageScreen);
              await action.selectDropdownbytagName('span', 'serviceType', serviceType, pageScreen)
              await action.selectDropdownbytagName('span', 'requestType', requestType, pageScreen)
              await action.selectDropdownbytagName('span', 'contentType', contentType, pageScreen)
              if (typeOfParameter == "Additional Parameters") {
                await action.ClickElement("additionalParameters", pageScreen);
                console.log(additionalParameters.length)
                for (let j = 0; j < additionalParameters.length; j++) {
                  await action.ClickElement("additionalParametersAddicon", pageScreen);
                  await page.waitForTimeout(500);
                  let typeDropdown = await action.getElement('additionalParametersType', pageScreen)
                  let keyInput = await action.getElement('additionalParametersKey', pageScreen)
                  let valueInput = await action.getElement('additionalParametersValue', pageScreen)
                  await typeDropdown.nth(j).scrollIntoViewIfNeeded();
                  await action.selectDropdownbytagName('span', typeDropdown.nth(j), additionalParameters[j].Type)
                  await action.enterText(additionalParameters[j].Key, keyInput.nth(j));
                  await action.enterText(additionalParameters[j].Value, valueInput.nth(j));
                }
                console.log("Additional Parameters are added successfully");
              }
              else if (typeOfParameter == "Query Parameters") {
                await action.ClickElement("queryParameters", pageScreen);
                console.log(queryParameters.length)
                for (let j = 0; j < queryParameters.length; j++) {
                  await action.ClickElement("queryParametersAddicon", pageScreen);
                  let nameInput = await action.getElement('queryParametersName', pageScreen)
                  let dataTypeDropdown = await action.getElement('queryParameterDatatype', pageScreen)
                  await action.enterText(queryParameters[j].Name, nameInput.nth(j));
                  await action.selectDropdownbytagName('span', dataTypeDropdown.nth(j), queryParameters[j].DataType)
                }
                console.log("Query Parameters are added successfully");
              }
              if (typeOfParameter == "Form URL Parameters") {
                await action.ClickElement("formURLParameters", pageScreen);
                console.log(formURLParameters.length)
                for (let j = 0; j < formURLParameters.length; j++) {
                  await action.ClickElement("formURLParametersAddicon", pageScreen);
                  let nameInput = await action.getElement('formURLParametersName', pageScreen)
                  let dataTypeDropdown = await action.getElement('formURLParametersDatatype', pageScreen)
                  await nameInput.nth(j).scrollIntoViewIfNeeded()
                  await action.enterText(formURLParameters[j].Name, nameInput.nth(j));
                  await dataTypeDropdown.nth(j).click()
                  await page.waitForTimeout(500)
                  let exist = await page.isVisible("//li[@role='option']").then(async (eleexist) => {
                  return eleexist;
                })
                if(!exist){
                  await dataTypeDropdown.nth(j).click()
                await page.waitForTimeout(500)
                }
                await page.locator('//li//span[normalize-space(text())="' + formURLParameters[j].DataType + '"]').click();
                }
                console.log("Form URL Parameters are added successfully");
              }
              // Fill Request Json
              if (formValues[i].Request) {
                if (formValues[i].Request.length !== 0) {
                  let reqJson;
                  if (formValues[i].Request.startsWith("#")) {
                    // if(formValues[i].Request=='#EbayRequest') 
                    //   reqJson = (CommonUtilObject.readUsecaseTestData(process.env.FileName, formValues[i].Request.replace("#", ""))).replace(/\\/g, "");
                    // else
                      reqJson = (CommonUtilObject.readJSONData(process.env.FileName, formValues[i].Request.replace("#", ""))).replace(/\\/g, "");
                      reqJson = reqJson.replace(/^\"|\"$/g, '');
                  }
                  else {
                    reqJson = formValues[i].Request;
                  }
                  await action.fillText(reqJson, "requestJson", pageScreen);
                  console.log("Request Json added successfully " +reqJson)
                }
              }
              // Fill Response Json
              await action.fillText(formValues[i].Response, "responseJson", pageScreen);
              // Test Operation
              await action.ClickElement("testOperation", pageScreen);
              await page.waitForTimeout(500);
              if (requestType == 'POST') {
                if(formValues[i].RequestTestOperation){
                if (formValues[i].RequestTestOperation.length !== 0) {
                  let reqJson;
                  if (formValues[i].Request.startsWith("#")) {
                      reqJson = (CommonUtilObject.readJSONData(process.env.FileName, formValues[i].RequestTestOperation.replace("#", ""))).replace(/\\/g, "");
                      reqJson = reqJson.replace(/^\"|\"$/g, '');
                  }
                  else {
                    reqJson = formValues[i].RequestTestOperation;
                  }
                  await action.fillText(reqJson, "requestJson", pageScreen);
                  console.log("RequestTestOperation Json added successfully " +reqJson)
                }
              }
              }
              else if (requestType == 'GET' && serviceName == "Customer") {
                for (let j = 1; j <= 1; j++) {
                  let uniqueField = await page.locator("//td[text()='{" + formValues[i][`Parameter${j}`] + "}']/..//input");
                  await action.enterText(process.env['uniqueData'], uniqueField);
                }
              } 
              if (typeOfParameter == "Query Parameters") {
                console.log(queryParameters.length)
                for (let j = 0; j < queryParameters.length; j++) {
                  let valueInput = await action.getElement('queryParametersValue', pageScreen)
                  await action.enterText(queryParameters[j].Value, valueInput.nth(j));
                }
                console.log("Query Parameters value are added successfully");
              }
              else if (typeOfParameter == "Form URL Parameters") {
                console.log(formURLParameters.length)
                for (let j = 0; j < formURLParameters.length; j++) {
                  let valueInput = await action.getElement('queryParametersValue', pageScreen)
                  await action.enterText(formURLParameters[j].Value, valueInput.nth(j));
                }
                console.log("Query Parameters value are added successfully");
              }
  
              // Run and Use Response
              await action.ClickElement("run", pageScreen);
              await page.waitForTimeout(3000)
              await action.ClickElement("useResponse", pageScreen);
              console.log("USe Response button clicked successfully")
              await action.ClickElement("back", pageScreen);
              if (formValues[i].OperationName.startsWith('Create')) {
                let ResJson = await assertion.getAttributevalue("responseJson", pageScreen)
              let jsonObject = await JSON.parse(ResJson)
                process.env['uniqueData'] = await onloadTrigger.getChildJsonkey(jsonObject, formValues[i].UniqueField)
                console.log("uniqueField " + formValues[i].UniqueField + "value is " + process.env['uniqueData'])
              }
              // ADD ERROR CODE
              console.log("formValues[i].ErrorCodes "+formValues[i].ErrorCodes)
              if(formValues[i].ErrorCodes && formValues[i].ErrorCodes=="Yes"){
                await action.ClickElement("ErrorCodes", pageScreen);
                console.log(ErrorCodes.length)
                for (let j = 0; j < ErrorCodes.length; j++) {
                  await action.ClickElement("ErrorCodesAddicon", pageScreen);
                  let codeInput = await action.getElement('ErrorCodesHttpCode', pageScreen)
                  let typeDropdown = await action.getElement('ErrorCodesType', pageScreen)
                  await action.enterText(ErrorCodes[j].HttpCode, codeInput.nth(j));
                  await action.selectDropdownbytagName('span', typeDropdown.nth(j), ErrorCodes[j].Type)
                }
                console.log("Error codes are added successfully");
                // Test Operation
              await action.ClickElement("testOperation", pageScreen);
              await page.waitForTimeout(500);
              for (let j = 0; j < ErrorData.length; j++) {
                let valueInput = await action.getElement('queryParametersValue', pageScreen)
                await action.enterText(ErrorData[j].Value, valueInput.nth(j));
              }
              console.log("Error value are added successfully");
              await action.ClickElement("run", pageScreen);
              await page.waitForTimeout(3000)
              await action.ClickElement("useErrorResponse", pageScreen);
              console.log("Use Error Response button clicked successfully")
              await action.ClickElement("back", pageScreen);
              }
              await action.ClickElement("create", pageScreen);
              console.log("Operation " + formValues[i].OperationName + " created successfully");
              await action.ClickElement("arrowLeft", pageScreen);
            }
          });
        }
      } catch (err) {
        throw err;
      }
    });

When(
  "User write unique field {string} in parent {string} with {string} in {string} screen",
  async (key, parentObj, value, pageScreen) => {
    console.log(
      "User write unique field " + key + " in parent " + parentObj + " with " + value + " in "
      + pageScreen +
      " screen"
    );
    let expValue;
    if (value.startsWith("#")) {
      expValue = await action.generateRandomString(5);
    }
    else {
      expValue = process.env[value]
    }
    CommonUtilObject.writeTestDatatoNestedObject(
      process.env.FileName,
      key, expValue,
      parentObj)
  });


Then("User will create AuthProvider name as {string} with description and authType as {string} in {string} screen",
  async (AuthName, AuthType, pageScreen) => {

    console.log("User will create AuthProvider name as " + AuthName + " with description and authType as " + AuthType + " in " + pageScreen + " screen")
    try {
      await action.ClickElement("AuthProviders", "GroupSetting");
      await page.waitForTimeout(5000)
      let availableAuth = "//div[@class='f-card-title ng-star-inserted' and normalize-space(text())='" + AuthName + "']"
      await page.isVisible(availableAuth).then(async (exist) => {
        console.log("Auth Provider availability" + exist);
        if (exist == true) {
          console.log(
            "Auth Providers name " +
            AuthName +
            " already created for this group"
          );
        }
        else {
          await action.ClickElement("AddAuthProvider", "GroupSetting");
          await CommonUtilObject.writeUsecaseTestData(process.env.FileName, "AuthName", AuthName);
          await action.enterText(AuthName, "AuthName", pageScreen)
          await action.enterText(CommonUtilObject.readUsecaseTestData(process.env.FileName, "AuthDescription"), "AuthDescription", pageScreen);

          if (AuthType == "Basic Auth") {
            await uwidgets.basicAuth(AuthType, pageScreen);
            await page.waitForTimeout(2000);
          }
          else if (AuthType == "No Auth") {
            await action.selectDropdownbyspantext("AuthType", pageScreen, AuthType);
            await page.waitForTimeout(2000);
          }else if (AuthType == "OAuth 2.0") {
            await uwidgets.oAuth(AuthName,AuthType, pageScreen);
            await page.waitForTimeout(500);
            await page.waitForSelector(await ScreenMap.get(pageScreen).getSelector(
              "accessToken"
            ), { timeout: 90000 })
          }
          await action.ClickElement("Create", pageScreen);
          await page.waitForTimeout(2000);
          await assertion.checktext('Success', pageScreen, 'Success')
        }
      })
    } catch (error) {
      throw error;
    }

  })

When(
  "User Add below {string} when create an Operation in {string} screen",
  async (typeOfParameter, pageScreen, table: DataTable) => {
    try {
      console.log(
        "User Add below " + typeOfParameter + " when create an Operation in  "
        + pageScreen +
        " screen"
      );
      // Add additional Parameters
      if (typeOfParameter == "Additional Parameters")
        additionalParameters = table.hashes();
      else if (typeOfParameter == "Query Parameters")
        queryParameters = table.hashes();
      else if (typeOfParameter == "Form URL Parameters")
        formURLParameters = table.hashes();
      else if (typeOfParameter == "Error Codes")
        ErrorCodes = table.hashes(); 
        else if (typeOfParameter == "Error Data")
        ErrorData = table.hashes();

    } catch (error) {
      throw error;
    }

  })


When(
  "User add the {string},{string} Data resource name it as {string} add DataList and {string} ApplicationSourceSetup with below name service operation in {string} screen",
  async (serviceProvider, DataResourcesType, resourceName, AppSourceOption, pageScreen, table: DataTable) => {
    try {
      console.log(
        "User add the  " +
        serviceProvider + " " + DataResourcesType +
        "Data resource name it as" + resourceName + "add DataList and " + AppSourceOption + " ApplicationSourceSetup with below name service operation in"
        + pageScreen +
        " screen"
      );
      await action.ClickElement("dataSources", pageScreen);
      const formValues = table.hashes();
      await page.waitForTimeout(3000);
      await action.waitforInvisibilityOfSpinner()
      // await page.waitForLoadState("networkidle",{timeout:60000});
      // Clone data source when there is no data source
      let availableDS = "//div[normalize-space(text())='" + resourceName + "']"
          await page.isVisible(availableDS).then(async (exist) => {
            console.log("Data source availability" + exist);
            if (exist == true) {
          // Check given api data source already cloned for a group
          console.log(
            "Data source " +
            resourceName +
            " already created for this group"
          );
              // add resource name
            if (DataResourcesType == "Rest API") {
              await uwidgets.restApi(resourceName, AppSourceOption,serviceProvider, formValues, pageScreen,exist);
            } else if (DataResourcesType == "MongoDB") {
              await uwidgets.mongoDB(resourceName, AppSourceOption, formValues, pageScreen,exist);
            } else if (DataResourcesType == "MySQL") {
              await uwidgets.mySQL(resourceName, AppSourceOption, formValues, pageScreen,exist);
            }else if (DataResourcesType == "Amazon DynamoDB") {
              await uwidgets.DynamoDB(resourceName, AppSourceOption, formValues, pageScreen,exist);
            }
            }
          
          else {
            await action.ClickElement("AddDataSources", "GroupSetting");
            // Choose Add Data resources
            let resource = await ScreenMap.get(pageScreen).getSelector("DataResourcesType");
            let dataResource = page.locator(resource.replace("elementName", DataResourcesType))
            console.log("dataResource" + dataResource);
            await action.ClickElement(dataResource);
            // add resource name
            if (DataResourcesType == "Rest API") {
              await uwidgets.restApi(resourceName, AppSourceOption,serviceProvider, formValues, pageScreen);
            } else if (DataResourcesType == "MongoDB") {
              await uwidgets.mongoDB(resourceName, AppSourceOption, formValues, pageScreen);
            } else if (DataResourcesType == "MySQL") {
              await uwidgets.mySQL(resourceName, AppSourceOption, formValues, pageScreen);
            }else if (DataResourcesType == "Amazon DynamoDB") {
              await uwidgets.DynamoDB(resourceName, AppSourceOption, formValues, pageScreen);
            }
            await page.waitForTimeout(2000);
          } 
      });
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User {string} {string} {string} in {string} screen and validate text contains {string}",
  async (scenario, menu, name, pageScreen, expectedText) => {
    try {
      console.log(
        "User " + scenario + " " + name + " " +
        pageScreen +
        " screen"
      );
      await page.waitForTimeout(2000);
      await action.waitforInvisibilityOfSpinner()
      let nameOfSP, nameOfSPXpath, editTileXpath, deleteTileXpath;
      if (menu == "Data Lists" || menu == "Operations") {
        // Check given api data source already created for a group
        nameOfSPXpath = await ScreenMap.get(pageScreen).getSelector(
          "tableName"
        );
        deleteTileXpath = await ScreenMap.get(pageScreen).getSelector(
          "deleteTable"
        );
        editTileXpath = await ScreenMap.get(pageScreen).getSelector(
          "editTable"
        );
      }
      else {
        nameOfSPXpath = await ScreenMap.get(pageScreen).getSelector(
          "cardName"
        );
        deleteTileXpath = await ScreenMap.get(pageScreen).getSelector(
          "deleteTile"
        );
        editTileXpath = await ScreenMap.get(pageScreen).getSelector(
          "editTile"
        );
      }
      nameOfSP = nameOfSPXpath.replace("elementName", name
      );
      await page.isVisible(nameOfSP).then(async (exist) => {
        if (exist == true) {
          if (scenario == "Delete") {
            let deleteTile = page.locator(
              deleteTileXpath.replace("elementName", name)
            );
            await action.ClickElement(deleteTile)
            await action.ClickElement('ConfirmdeleteStyle', pageScreen)
            await action.waitforInvisibilityOfSpinner();
            await page.waitForTimeout(2000)
            console.log(menu, expectedText.indexOf("Success") == -1)
            if ((menu == "Data Sources" || menu == "Data Lists") && expectedText.indexOf("Success") == -1) {
              await assertion.ContainText('deleteDialog', pageScreen, expectedText)
              await action.ClickElement('okButton', pageScreen)
            }
            else {
              if (expectedText) {
                await assertion.ContainText('Pagelevel_alert_message', pageScreen, expectedText)
                await action.ClickElement('Pagelevel_alert_close', pageScreen)
              }
            }
            let cancelBtn = await ScreenMap.get(pageScreen).getSelector("cancel");
            exist = await page.isVisible(cancelBtn).then(async (eleexist) => {
              return eleexist;
            })
            if (exist == true) {
              await action.ClickElement('cancel', pageScreen)
            }
          }
          else if (scenario == "Edit") {
            let editTile = page.locator(
              editTileXpath.replace("elementName", name)
            );
            await action.ClickElement(editTile)
            await page.waitForTimeout(500);
            await action.ClickElement('updateButton', pageScreen)
            await page.waitForTimeout(2000)
            if ((menu == "Data Sources" || menu == "Data Lists") && expectedText.indexOf("Success") == -1) {
              await assertion.ContainText('deleteDialog', pageScreen, expectedText)
              await action.ClickElement('okButton', pageScreen)
            }
            else {
              if (expectedText) {
                await assertion.ContainText('Pagelevel_alert_message', pageScreen, expectedText)
                await action.ClickElement('Pagelevel_alert_close', pageScreen)
              }
              let cancelBtn = await ScreenMap.get(pageScreen).getSelector("cancel");
              exist = await page.isVisible(cancelBtn).then(async (eleexist) => {
                return eleexist;
              })
              if (exist == true) {
                await action.ClickElement('cancel', pageScreen)
              }
            }
          }
        }
        else {
          console.log("Api setup/Data source " + name + " is not available")
        }
      });
    } catch (err) {
      throw err;
    }
  });

When(
  "User click on {string} in {string} screen",
  async (elementName, pageScreen) => {
    try {
      console.log(
        "User click on " +
        elementName +
        " in " +
        pageScreen +
        " screen"
      );
      let elementToClick = await action.getandReplaceElement(elementName, 'cardName', pageScreen);
      await action.ClickElement(elementToClick)
      await page.waitForTimeout(500);
    } catch (err) {
      throw err;
    }
  }
);

