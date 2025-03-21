import { Given, When, Then, DataTable } from "@cucumber/cucumber";
import { page } from "./world";
import { ScreenMap } from "../Utility/Source/Core";
import { expect } from "@playwright/test";
import { Actions } from "../Utility/Util/Actions";
import { OnloadTriggers } from "../Main/OnloadTriggers";
import { Assertions } from "../Utility/Util/Assertions";
import { CommonUtilObject } from "../Utility/Util/CommonUtil";
import { expressionBuilder } from "../Main/ExpresssionBuilder";
import { NewTransformationUI } from "../Main/New TransformationUI";

let action: Actions = new Actions();
let onloadTrigger: OnloadTriggers = new OnloadTriggers();
let assertion: Assertions = new Assertions();
let esbuilder: expressionBuilder = new expressionBuilder();
let transformation: NewTransformationUI = new NewTransformationUI();

When(
  "User clone Data Source {string} in {string} screen",
  async (dataSourceName, pageScreen) => {
    try {
      console.log(
        "User clone Data Source " +
        dataSourceName +
        " in " +
        pageScreen +
        " screen"
      );
      await page.waitForTimeout(3000);
      // Clone data source when there is no data source
      let emptyElement = await ScreenMap.get(pageScreen).getSelector(
        "emptyDataSource"
      );
      await page.isVisible(emptyElement).then(async (exist) => {
        if (exist == true) {
          await action.selectDropdownbytagName(
            "span",
            "Clone Data Source",
            dataSourceName,
            pageScreen
          );
          await action.ClickElement("cloneButtoninModal", pageScreen);
        } else {
          // Check given api data source already cloned for a group
          let availableSource = await action.getElement(
            "availableDataSources",
            pageScreen
          );
          await page.waitForSelector(
            await ScreenMap.get(pageScreen).getSelector("availableDataSources")
          );
          const count = await availableSource.count();
          console.log("Total available sources are " + count);
          let sourcePresent: boolean;
          for (let i = 0; i < count; i++) {
            let dataSource = await availableSource.nth(i).textContent();
            if (dataSource.trim() == dataSourceName) {
              console.log(
                "Data source " +
                dataSourceName +
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
              "Clone Data Source",
              dataSourceName,
              pageScreen
            );
            await action.ClickElement("cloneButtoninModal", pageScreen);
            await page.waitForTimeout(500);;
          }
        }
      });
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User create Onload Triggers with {string} Options Mapping {string} in {string} screen",
  async (noOfOptionMapping, elementName, pageScreen, table: DataTable) => {
    try {
      console.log(
        "User create Onload Triggers with " + noOfOptionMapping + "  Options Mapping " +
        elementName +
        " in " +
        pageScreen +
        " screen"
      );
      const triggervals = table.hashes();
      console.log(triggervals.length);
      await action.ClickElement('Settings', 'Page')
      await assertion.checktext('onLoadTriggerTitle', 'onLoadTrigger', 'Onload Triggers')
      for (let j = 0; j < triggervals.length; j++) {
        await page.waitForTimeout(3000);
        await action.ClickElement(elementName, pageScreen)
        console.log("Add button for Trigger " + (j + 1) + " is clicked");
        // get the count of Existing triggers
        let expandButton = await action.getElement(
          "triggerExpandArrow",
          pageScreen
        );
        const count = await expandButton.count();
        console.log("count is " + count);
        let i = count - 1;
        console.table(triggervals[j]);
        await onloadTrigger.fillOptionsMappingTrigger(
          elementName,
          pageScreen,
          triggervals[j],
          i, noOfOptionMapping
        );
        await page.waitForTimeout(500);;
      }
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User create Onload Triggers with Response Mapping {string} in {string} screen",
  async (elementName, pageScreen, table: DataTable) => {
    try {
      console.log(
        "User create Onload Triggers with Response Maping" +
        elementName +
        " in " +
        pageScreen +
        " screen"
      );
      await page.waitForTimeout(3000);
      const triggervals = table.hashes();
      await action.ClickElement('Settings', 'Page')
      // await assertion.checktext('onLoadTriggerTitle', 'onLoadTrigger', 'Onload Triggers')
      const pageHeader = page.locator("//app-design-header[@headertitle='Onload Triggers']");
      
     await  expect(pageHeader).toBeVisible();
     console.log("Onload Triggers is visible");
      await page.waitForTimeout(3000);
      console.log(triggervals.length);
      for (let j = 0; j < triggervals.length; j++) {
        // Click on Add Trigger Button
        await action.ClickElement(elementName, pageScreen)
        console.log("Add button for Trigger " + (j + 1) + " is clicked");
        let expandButton = await action.getElement(
          "triggerExpandArrow",
          pageScreen
        );
        const count = await expandButton.count();
        console.log("count of Existing trigger is " + count);
        console.log("Add button for Trigger " + (j + 1) + " is clicked");
        console.table(triggervals[j]);
        await onloadTrigger.fillResponseMappingTrigger(
          elementName,
          pageScreen,
          triggervals[j],
          count - 1
        );
      }

    }
    catch (err) {
      throw err;
    }
  }
);


When(
  "User get number of records in {string} API and store it in {string}",
  async (apiName, apiDataCount) => {
    try {
      console.log(
        "User get number of records in " +
        apiName +
        " API and store it in " +
        apiDataCount
      );
      await page.waitForTimeout(2000);
      await action.ClickElement("API Generator", "HomePage");
      await action.ClickElement("searchAPIGenerator", "apiGenerator");
      await action.enterText(apiName, "searchAPIGenerator", "apiGenerator");
      await page.waitForTimeout(2000);
      await action.ClickElement("select_first_api", "apiGenerator");
      await page.waitForTimeout(2000);
      let apiDataFulltext = await page
        .locator(
          await ScreenMap.get("apiGenerator").getSelector("apiDataCount")
        )
        .textContent();
      console.log("apiDataFulltext " + apiDataFulltext);
      apiDataCount = apiDataFulltext
        .split(" ")[0]
        .replace(/[()]/g, "");
      await CommonUtilObject.writeUsecaseTestData(process.env.FileName, 'apiCount', apiDataCount)
      console.log(apiDataCount);
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User should see {string} in {string} in {string} screen",
  async (apiDataCount, elementName, pageScreen) => {
    try {
      console.log(
        "User should see " +
        apiDataCount +
        " in " +
        elementName +
        " in " +
        pageScreen +
        " screen"
      );
      console.log(process.env["apiDataCount"]);
      await assertion.ContainText(
        elementName,
        pageScreen,
        CommonUtilObject.getExpectedValue('apiCount')
      );
    } catch (err) {
      throw err;
    }
  });

When(
  "User Configuring a Trigger on a {string} {string} in {string} screen",
  async (elementType, elementName, pageScreen, table: DataTable) => {
    try {
      console.log(
        "User Configuring a Trigger on a Dropdown " +
        elementName +
        " in " +
        pageScreen +
        " screen"
      );
      let reqElementXpath = "//konfig-grid-item//*[normalize-space(text())='" + elementName + "']";
      let reqElement = page.locator(reqElementXpath);
      console.log(reqElement);
      await page.waitForTimeout(2000);
      await reqElement.dblclick({ force: true });
      let elementExist = await page.isVisible(await ScreenMap.get(pageScreen).getSelector("WidgetName")).then(async (exist) => {
        return exist;
      });
      if (elementExist == true) {
        console.log("Edit widget opened")
      }
      else {
        await reqElement.click({ button: "right" });
        await action.ClickElement("EditWidget", pageScreen);
      }
      await page.waitForTimeout(500);;
      await action.ClickElement("Events", pageScreen);
      await page.waitForTimeout(500);;
      const triggervals = table.hashes();
      console.log(triggervals.length);
      for (let j = 0; j < triggervals.length; j++) {
        if (elementType == "Dropdown") {
          await onloadTrigger.FillOnChangeAction(triggervals[j], pageScreen)
        }
        else if (elementType == "Button") {
          await onloadTrigger.FillOnButtonEvent(triggervals[j], pageScreen)
        }
        else if (elementType == "Container") {
          await onloadTrigger.FillOnContainerEvent(triggervals[j], pageScreen)
        }
      }
      await action.ClickElement("WidgetSave", pageScreen);
      await page.waitForTimeout(2000);
      // await assertion.checktext(
      //   "SavedSuccessfully",
      //   pageScreen,
      //   "Saved successfully"
      // );
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User Configuring Options mapping for a dropdown {string} in {string} screen from {string} trigger in {string}",
  async (elementName, pageScreen, triggerName, triggerField, table: DataTable) => {
    try {
      console.log(
        "User Configuring a Trigger on a Dropdown " +
        elementName +
        " in " +
        pageScreen +
        " screen"
      );
      let reqElement = page.locator(
        "//konfig-grid-item//*[contains(text(),'" +
        elementName +
        "')]"
      );
      await reqElement.click({ button: "right" });
      await action.ClickElement("EditWidget", pageScreen);
      await page.waitForTimeout(500);;
      await action.ClickElement("INPUT", pageScreen);
      await action.ClickElement('ConfigureOptions', pageScreen);
      const triggervals = table.hashes();
      console.log(triggervals.length);
      for (let j = 0; j < triggervals.length; j++) {
        await onloadTrigger.FillInputOptionConfig(triggervals[j], pageScreen, triggerField, triggerName)
      }
      await action.ClickElement("WidgetSave", pageScreen);
      await page.waitForTimeout(500);;
      // await assertion.checktext(
      //   "SavedSuccessfully",
      //   pageScreen,
      //   "Saved successfully"
      // );
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User get unique field in Data Source {string} in {string} screen and save it in {string}",
  async (dataSourceName, pageScreen, variable) => {
    try {
      console.log(
        "User get unique field in Data Source " +
        dataSourceName +
        " in " +
        pageScreen +
        " screen"
      );
      process.env[variable] = await onloadTrigger.getUniqueFildDataList(dataSourceName, pageScreen)
      console.log(variable + " is " + process.env[variable])
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User makes changes to below field's to Configure Data Population for {string} in {string} screen",
  async (typeofElement, pageScreen, table: DataTable) => {
    try {
      const triggervals = table.hashes();
      console.log(triggervals.length);
      for (let j = 0; j < triggervals.length; j++) {
        console.log(
          "User makes changes to" +
          triggervals[j].Field +
          "field format as in " +
          pageScreen +
          " screen"
        );
        let reqElement = await page.locator(
          "//konfig-grid-item//*[normalize-space(text())='" +
          triggervals[j].Field +
          "']/../../../..//div[contains(@class,'f-input f-input-custom')]"
        );
        console.log(reqElement)
        await page.waitForTimeout(2000);
        await reqElement.click({ button: "right" });
        await action.ClickElement("EditWidget", pageScreen);
        console.log("Edit widget opened")
        await page.waitForTimeout(500);;
        await page.waitForTimeout(500);;
        await action.ClickElement("CONFIGURATIONS", pageScreen);
        await action.ClickElement("ConfigureDataPopulation", pageScreen);
        await action.ClickElement("EventAddConfig", pageScreen);
        await action.ClickElement("SelectConfig", pageScreen);
        await action.fillText(triggervals[j].Title, "EventTitleInputbox", pageScreen);
        await page.waitForTimeout(500);;
        await action.selectDropdownbytagName('span', 'TriggerDropdown', triggervals[j].Trigger, pageScreen)
        await page.waitForTimeout(500);;
        if (typeofElement == "DropDown") {
          await action.ClickElement("ResponseFieldDropdown", pageScreen);
          await page.waitForTimeout(500);;
          await onloadTrigger.SelectOptionsMappingforFOandBO(triggervals[j].ResponseField, 'onLoadTrigger')
          await action.ClickElement("WidgetSave", pageScreen);
          await page.waitForTimeout(500);;
          // await assertion.checktext(
          //   "SavedSuccessfully",
          //   pageScreen,
          //   "Saved successfully"
          // );
        }
      }

    } catch (err) {
      throw err;
    }

  }
);

When(
  "User add Column and Response path for {string} in {string} screen",
  async (typeofElement, pageScreen, table: DataTable) => {
    try {
      const triggervals = table.hashes();
      console.log(triggervals.length);
      if (typeofElement == "Button" || typeofElement == "Advance Table") {
        await onloadTrigger.AddColumnforDataPopulation(triggervals, pageScreen)
      }
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User {string} Data Configuration for {string} in {string} screen",
  async (typeofElement, elementName, pageScreen, table: DataTable) => {
    try {
      const triggervals = table.hashes();
      console.log(triggervals.length);
      for (let j = 0; j < triggervals.length; j++) {
        console.log(
          "User Edit Data Configuration for" +
          triggervals[j].Operations +
          " in " +
          pageScreen +
          " screen"
        );
        if (typeofElement == "Edit") {
          if (triggervals[j].Operations == 'Get All Records')
            await action.ClickElement('GetAllRecords', 'AdvanceTable')
          else if (triggervals[j].Operations == 'Update Record By Unique Id')
            await action.ClickElement('UpdateRecordByUniqueId', 'AdvanceTable')
          else if (triggervals[j].Operations == 'Get Record By Unique Id')
            await action.ClickElement('GetRecordByUniqueId', 'AdvanceTable')
        }
        else if (typeofElement == "Delete") {
          if (triggervals[j].Operations == 'Get All Records') {
            let getAllElement = await action.getElement('GetAllRecords', 'AdvanceTable')
            let count = await getAllElement.count();
            console.log("count of Get All Record is " + count)
            await action.ClickElement(getAllElement.nth((count - 1)));
          }
          else if (triggervals[j].Operations == 'Delete Record By Unique Id')
            await action.ClickElement('DeleteRecordsByUniqueId', 'AdvanceTable')
        }
        await onloadTrigger.FillDataSourceConfig(triggervals[j], 'UniqueWidgetFields')
      }
    } catch (err) {
      throw err;
    }
  }
);


When(
  "User click on save button for {string} Response Mapping in {string} screen",
  async (elementName, pageScreen) => {
    try {
      console.log(
        "User click on " + elementName + " button for Response Mapping in" + pageScreen + " screen"
      );
      await page.waitForTimeout(500);;
      let txtElement = await ScreenMap.get(pageScreen).getSelector("onloadTriggerIndSave");
      let indSave = page.locator(txtElement.replace("elementName", elementName));
      await action.ClickElement(indSave)
      console.log("Save button clicked");
      await action.waitforInvisibilityOfSpinner();
    }
    catch (err) {
      throw err;
    }
  }
);

When(
  "User Edit Response Mapping {string} in {string} screen",
  async (elementName, pageScreen) => {
    try {
      console.log(
        "User Edit Response Mapping " +
        elementName +
        " in " +
        pageScreen +
        " screen"
      );
      await page.waitForTimeout(3000);
      await action.ClickElement('Settings', 'Page')
      await assertion.checktext('onLoadTriggerTitle', 'onLoadTrigger', 'Onload Triggers')
      await action.ClickElement('Settings', 'Page')
      await assertion.checktext('onLoadTriggerTitle', 'onLoadTrigger', 'Onload Triggers')
      await page.waitForTimeout(3000);
      let expandButton = await action.getElement(
        "triggerExpandArrow",
        pageScreen
      );
      const count = await expandButton.count();
      console.log("count of Existing trigger is " + count);
      // Expand Trigger
      let txtElement = await ScreenMap.get(pageScreen).getSelector("triggerTileName");
      let triggerTile = page.locator(txtElement.replace("elementName", elementName));
      let actualTriggerTitle = await triggerTile.textContent();
      console.log("Actual Trigger title is " + actualTriggerTitle);
      console.log("Expected Trigger title is " + elementName);
      await triggerTile.click();
      await page.waitForTimeout(500);;
      // Click on Response mapping settings icon
      let Iconxpath = await ScreenMap.get(pageScreen).getSelector(
        "responseMappingSettingsIcon"
      );
      let cogIcon = page.locator(
        Iconxpath.replace("elementName", elementName)
      );
      await action.ClickElement(await cogIcon);
      await page.waitForTimeout(3000);
      // await page.waitForLoadState("networkidle", { timeout: 60000 });
      // await onloadTrigger.verifyTransformationUILoads(cogIcon);
      // //  Click on expand all button
      // await page.waitForTimeout(5000);
      // let frame;
      // if (process.env.Env != "Demo") {
      //   frame = page;
      // } else {
      //   frame = page.frame({ url: /transformations*/ });
      // }
      // let inputMenu = await onloadTrigger.getFrameElement(
      //   frame,
      //   "inputMenu",
      //   "transformationUI"
      // );
      // await action.ClickElement(inputMenu);
      // let expand = await onloadTrigger.getFrameElement(
      //   frame,
      //   "expandAllButton",
      //   "transformationUI"
      // );
      // await action.ClickElement(expand);
    }
    catch (err) {
      throw err;
    }
  }
);

When(
  "User Delete Onload Trigger {string} in {string} screen",
  async (elementName, pageScreen) => {
    try {
      console.log(
        "User Delete Onload Trigger " +
        elementName +
        " in " +
        pageScreen +
        " screen"
      );
      await page.waitForTimeout(3000);
      await action.ClickElement('Settings', 'Page')
      await assertion.checktext('onLoadTriggerTitle', 'onLoadTrigger', 'Onload Triggers')
      await action.ClickElement('Settings', 'Page')
      await assertion.checktext('onLoadTriggerTitle', 'onLoadTrigger', 'Onload Triggers')
      await page.waitForTimeout(3000);
      let txtElement = await ScreenMap.get(pageScreen).getSelector("triggerTileOptions");
      let deltriggerTile = page.locator(txtElement.replace("elementName", elementName));
      await deltriggerTile.click();
      await action.ClickElement('triggerDelete', pageScreen)
      await page.waitForTimeout(500);;
      await action.ClickElement('deleteConfirmationModal', pageScreen)
      await page.waitForTimeout(2000);
      await action.waitforInvisibilityOfSpinner();
      let triggerTileXpath = await ScreenMap.get(pageScreen).getSelector("triggerTileName");
      let triggerTile = triggerTileXpath.replace("elementName", elementName);
      // Check deleted OLT is not visible in UI
      // await assertion.checkElementnotVisible(triggerTile); 
    }
    catch (err) {
      throw err;
    }
  }
);

When(
  "User create Onload Triggers with {string} Rule Options Mapping {string} in {string} screen",
  async (noOfoptionsmapping, elementName, pageScreen, table: DataTable) => {
    try {
      console.log(
        "User create Onload Triggers with Options Mapping " +
        elementName +
        " in " +
        pageScreen +
        " screen"
      );
      await page.waitForTimeout(3000);
      const triggervals = table.hashes();
      await action.ClickElement('Settings', 'Page')
      await action.ClickElement('EventConfig', 'EventConfigurations');
      const pageHeader = page.locator("//app-design-header[@headertitle='Events']");
      await  expect(pageHeader).toBeVisible();
      console.log("Events Configurations is visible");
      await action.waitforInvisibilityOfSpinner();
      await page.waitForTimeout(500);;
      console.log(triggervals.length);
      for (let j = 0; j < triggervals.length; j++) {
        // Click on Add Trigger Button
       let addButtonStateelement = await action.getElement(elementName, pageScreen)
        let isDisabled = await addButtonStateelement.evaluate(e => (e as HTMLInputElement).disabled);
        if (isDisabled == true) {
          console.log("Add button is disabled");
          await action.ClickElement('Settings', 'Page')
          await action.ClickElement('onloadTriggerMenu', pageScreen)
          // await assertion.checktext('onLoadTriggerTitle', 'onLoadTrigger', 'Onload Triggers')
            await action.waitforInvisibilityOfSpinner();
            await action.ClickElement(elementName, pageScreen)
        }
        else {
            await action.ClickElement(elementName, pageScreen)
        }

        console.log("Add button for Trigger " + (j + 1) + " is clicked");
        let expandButton = await action.getElement(
          "triggerExpandArrow",
          pageScreen
        );
        const count = await expandButton.count();
        console.log("count of Existing trigger is " + count);
        console.table(triggervals[j]);
        await onloadTrigger.fillResponseMappingTrigger(
          elementName,
          pageScreen,
          triggervals[j],
          count - 1
        );
        await onloadTrigger.optionMapping(noOfoptionsmapping, triggervals[j], "expressionBuilder");
        await action.waitforInvisibilityOfToastMessage();
        await page.waitForTimeout(500);
      }
      await page.waitForTimeout(2000);
    } catch (err) {
      throw err;
    }
  }
);