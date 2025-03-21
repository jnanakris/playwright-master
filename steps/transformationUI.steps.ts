import { Given, When, Then, DataTable } from "@cucumber/cucumber";
import { page } from "./world";
import { ScreenMap } from "../Utility/Source/Core";
import { UniqueWidgets } from "../Main/UniqueWidgets";
import { OnloadTriggers } from "../Main/OnloadTriggers";
import { Actions } from "../Utility/Util/Actions";
import { Assertions } from "../Utility/Util/Assertions";
import { TransformationUI } from "../Main/TransformationUI";

let action: Actions = new Actions();
let assertion: Assertions = new Assertions();
let Uwidgets: UniqueWidgets = new UniqueWidgets();
let OnloadTrigger: OnloadTriggers = new OnloadTriggers();
let transformationUI: TransformationUI = new TransformationUI();

When(
  "User makes changes to the API task {string} field to Configure Service in {string} screen",
  async (elementName, pageScreen, table: DataTable) => {
    try {
      console.log(
        "User makes changes to" +
        elementName +
        " field to Configure API in " +
        pageScreen +
        " screen"
      );
      let reqElement = await page.locator(
        "//div[normalize-space(text())='" +
        elementName +
        "']/../..//span[@class='option-icon']//i"
      );
      // Edit API Task
      await transformationUI.editAPITask(reqElement);
      const formValues = table.hashes();
      await page.waitForTimeout(3000);
      // Check Transformation UI loaded with all the data. If not, Again click on response mapping from onload trigger ui
      await transformationUI.verifyTransformationUIforAPITask(reqElement);
      console.log("Transformation UI loaded properly");
      // Script to do API setup in transformation UI
      await transformationUI.apiSetup(formValues);
      // switch to frame
      let frame;
      console.log(process.env.Env)
      if (process.env.Env != 'Demo') {
        frame = page;
      }
      else {
        console.log("In Else");
        frame = page.frame({ url: /transformations*/ });
      }
      await frame.waitForTimeout(1000);
      // Do Expand all for input configuration in transformation UI
      await transformationUI.expandInputConfiguration();
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User will connect Input and Output nodes in {string} screen",
  async (pageScreen, table: DataTable) => {
    try {
      console.log(
        "User will connect Input and Output nodes in " + pageScreen + " screen"
      );
      const configurevals = table.hashes();
      console.log(configurevals.length);
      await page.waitForTimeout(3000);
      // switch to frame
      console.log(process.env.Env)
      let frame;
      if (process.env.Env != 'Demo') {
        frame = page;
      }
      else {
        frame = page.frame({ url: /transformations*/ });
      }
      for (let j = 0; j < configurevals.length; j++) {
        console.log(configurevals[j].Input, configurevals[j].Output);
        // Connect input and output nodes
        let sourceLocator = await ScreenMap.get(pageScreen).getSelector(
          "inputConfiguration"
        );
        let sourceElement = await sourceLocator.replace(
          "expectedText",
          configurevals[j].Input
        );
        let destLocator = await ScreenMap.get(pageScreen).getSelector(
          "outputConfiguration"
        );
        let destElement = await destLocator.replace(
          "expectedText",
          configurevals[j].Output
        );
        await frame.dragAndDrop(sourceElement, destElement);
        await frame.waitForTimeout(1000);
      }
      await page.waitForTimeout(500);
      let execute = frame.locator(
        await ScreenMap.get("transformationUI").getSelector("executeButton")
      );
      await execute.hover();
      await frame.waitForTimeout(1000);
      await action.ClickElement(execute);
      console.log("Execute button clicked successfully");
      await frame.waitForTimeout(2000);
      // verify the mapping success message
      await assertion.checktext(
        "SavedSuccessfully",
        pageScreen,
        "Mappings save successfully"
      );
      // click on close button
      await page.waitForTimeout(5000);
      await action.ClickElement('closeButton', pageScreen);
      console.log('Mapping Saved and Transformations UI has been closed');
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User makes changes to {string} field to Configure API in {string} screen",
  async (elementName, pageScreen, table: DataTable) => {
    try {
      console.log(
        "User makes changes to" +
        elementName +
        " field to Configure API in " +
        pageScreen +
        " screen"
      );
      let reqElement = page.locator(
        "//konfig-grid-item//*[contains(text(),'" +
        elementName +
        "')]"
      );
      const formValues = table.hashes();
      // Edit Service Provider button
      await transformationUI.editButtonforServiceProvider(
        reqElement,
        pageScreen,
        formValues
      );
      let configureAPI = await action.getElement(
        "EventConfigureAPIButton",
        "UniqueWidgetFields"
      );
      await action.ClickElement(configureAPI);
      await page.waitForTimeout(3000);
      // Check Transformation UI loaded with all the data. If not, Again click on response mapping from onload trigger ui
      await OnloadTrigger.verifyTransformationUILoads(configureAPI);
      console.log("Transformation UI loaded properly");
      // Script to do API setup in transformation UI
      await transformationUI.apiSetup(formValues);
      let frame;
      if (process.env.Env != 'Demo') {
        frame = page;
      }
      else {
        console.log("In Else");
        frame = page.frame({ url: /transformations*/ });
      }
      await frame.waitForTimeout(1000);
      // Do Expand all for input configuration in transformation UI
      await transformationUI.expandInputConfiguration();
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User makes changes to the Response task {string} field to Configure Service in {string} screen",
  async (elementName, pageScreen, table: DataTable) => {
    try {
      console.log(
        "User makes changes to Response task" +
        elementName +
        " field to Configure API in " +
        pageScreen +
        " screen"
      );
      let reqElement = await page.locator(
        "//div[normalize-space(text())='" +
        elementName +
        "']/../..//span[@class='option-icon']//i"
      );
      await transformationUI.editAPITask(reqElement);
      const formValues = table.hashes();
      await page.waitForTimeout(3000);
      // Check Transformation UI loaded with all the data.
      // If not, Again click on response mapping from onload trigger ui
      await transformationUI.verifyTransformationUIforAPITask(reqElement);
      console.log("Transformation UI loaded properly");
      // Script to do response setup in transformation UI
      console.log(formValues.length);
      for (let j = 0; j < formValues.length; j++) {
        console.log(formValues[j]);
        await transformationUI.responseSetup(formValues[j]);
      }
      let frame;
      if (process.env.Env != 'Demo') {
        frame = page;
      }
      else {
        console.log("In Else");
        frame = page.frame({ url: /transformations*/ });
      }
      await frame.waitForTimeout(1000);
      // Do Expand all for input configuration in transformation UI
      await transformationUI.expandInputConfiguration();
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User will connect Unique Field nodes in {string} screen",
  async (pageScreen, table: DataTable) => {
    try {
      console.log(
        "User will connect Unique Field nodes in " + pageScreen + " screen"
      );
      const configurevals = table.hashes();
      console.log(configurevals.length);
      await page.waitForTimeout(3000);
      // switch to frame
      let frame;
      if (process.env.Env != 'Demo') {
        frame = page;
      }
      else {
        console.log("In Else");
        frame = page.frame({ url: /transformations*/ });
      }
      for (let j = 0; j < configurevals.length; j++) {
        console.log(configurevals[j].Input, configurevals[j].Output);
        // Connect input and output nodes
        let sourceLocator = await ScreenMap.get(pageScreen).getSelector(
          "inputConfiguration"
        );
        let sourceElement = await sourceLocator.replace(
          "expectedText",
          configurevals[j].Input
        );
        let destLocator = await ScreenMap.get(pageScreen).getSelector(
          "pathOutputConfiguration"
        );
        let destElement = await destLocator.replace(
          "expectedText",
          configurevals[j].Output
        );
        await frame.dragAndDrop(sourceElement, destElement);
        await frame.waitForTimeout(2000);
      }
    } catch (err) {
      throw err;
    }
  }
);
