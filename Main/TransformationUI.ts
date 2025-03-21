import { ScreenMap } from "../Utility/Source/Core";
import { page } from "../steps/world";
import { Actions } from "../Utility/Util/Actions";
import { OnloadTriggers } from "../Main/OnloadTriggers";

let action: Actions = new Actions();
let OnloadTrigger: OnloadTriggers = new OnloadTriggers();

export class TransformationUI {
  async editAPITask(reqElement) {
    await page.waitForTimeout(500);
    await reqElement.click();
    await action.ClickElement("EditWidget", "UniqueWidgetFields");
    await page.waitForTimeout(500);
    let configureAPI = await action.getElement("ConfigureService", "tasks");
    await action.ClickElement(configureAPI);
    await page.waitForTimeout(3000);
  }

  async verifyTransformationUIforAPITask(reqElement) {
    let frame;
    console.log(process.env.Env)
    if (process.env.Env != 'Demo') {
      frame = page;
    }
    else {
      console.log("In Else");
      frame = page.frame({ url: /transformations*/ });
    }
    await page.waitForTimeout(2000);
    // Check Transformation UI loaded with all the data.
    // If not, Again click on response mapping from onload trigger ui
    let inputElement = await ScreenMap.get("transformationUI").getSelector(
      "inputMenu"
    );
    await frame.isVisible(inputElement).then(async (exist) => {
      console.log(exist);
      if (exist == false) {
        await frame.waitForTimeout(2000);
        let closeButton = await OnloadTrigger.getFrameElement(
          frame,
          "closeButton",
          "transformationUI"
        );
        await action.ClickElement(closeButton);
        await reqElement.click();
        await action.ClickElement("EditWidget", "UniqueWidgetFields");
        await page.waitForTimeout(500);
        await action.waitforInvisibilityOfSpinner();
        let configureAPI = await action.getElement("ConfigureService", "tasks");
        await action.ClickElement(configureAPI);
        await page.waitForTimeout(2000);
      }
    });
  }

  async expandInputConfiguration() {
    let frame;
    console.log(process.env.Env)
    if (process.env.Env != 'Demo') {
      frame = page;
    }
    else {
      console.log("In Else");
      frame = page.frame({ url: /transformations*/ });
    }
    try {
      let inputMenu = await OnloadTrigger.getFrameElement(
        frame,
        "inputMenu",
        "transformationUI"
      );
      await action.ClickElement(inputMenu);
      let expand = await OnloadTrigger.getFrameElement(
        frame,
        "expandAllButton",
        "transformationUI"
      );
      await action.ClickElement(expand);
    } catch (err) {
      throw err;
    }
  }

  async apiSetup(formValues) {
    let frame;
    console.log(process.env.Env)
    if (process.env.Env != 'Demo') {
      frame = page;
    }
    else {
      console.log("In Else");
      frame = page.frame({ url: /transformations*/ });
    }
    await frame.waitForTimeout(5000);
    await frame.waitForSelector(
      await ScreenMap.get("transformationUI").getSelector(
        "applicationInputConfiguration"
      )
    );
    // Click on outputUploadButton
    await frame.waitForSelector(
      await ScreenMap.get("transformationUI").getSelector("outputUploadButton")
    );
    let outputUploadButton = await OnloadTrigger.getFrameElement(
      frame,
      "outputUploadButton",
      "transformationUI"
    );
    await action.ClickElement(outputUploadButton);
    // Fill i all the require fields for API Setup
    await OnloadTrigger.selectFrameDropdownbytagName(
      frame,
      "span",
      "apiSetupCategoryDropdown",
      formValues[0].Category,
      "transformationUI"
    );
    console.log("Category Selected");
    await frame.waitForTimeout(2000);
    let providerButton = await OnloadTrigger.getFrameElement(
      frame,
      "apiSetupProviderDropdown",
      "transformationUI"
    );
    await action.ClickElement(providerButton);
    await frame.waitForTimeout(2000);
    // loop the provider until get required service
    let provider = await OnloadTrigger.getFrameElement(
      frame,
      "apiSetupDropdownOptions",
      "transformationUI"
    );
    let count = await provider.count();
    console.log("count is " + count);
    for (let i = 0; i < count; i++) {
      await action.ClickElement(await provider.nth(i));
      await page.waitForTimeout(500);
      let serviceButton = await OnloadTrigger.getFrameElement(
        frame,
        "apiSetupServiceDropdown",
        "transformationUI"
      );
      await action.ClickElement(serviceButton);
      let service = await OnloadTrigger.getFrameElement(
        frame,
        "apiSetupDropdownOptions",
        "transformationUI"
      );
      let sercount = await service.count();
      console.log("sercount is " + sercount);
      let expected;
      for (let j = 0; j < sercount; j++) {
        console.log("Service name from app " + (await service.nth(j).textContent()));
        console.log("Expected service name  " + formValues[0].Service);
        if ((await service.nth(j).textContent()) == formValues[0].Service) {
          await action.ClickElement(await service.nth(j));
          console.log("Expected element clicked");
          expected = "true"
          break;
        }
      }
      if (expected != "true") {
        await action.ClickElement(providerButton);
        await frame.waitForTimeout(1000);
      }
      else if (expected == "true") {
        break;
      }
    }
    await frame.waitForTimeout(1000);
    await OnloadTrigger.selectFrameDropdownbytagName(
      frame,
      "span",
      "apiSetupOperationDropdown",
      formValues[0].Operation,
      "transformationUI"
    );
    console.log("Operation Selected");
    await frame.waitForTimeout(1000);
    let doneButton = await OnloadTrigger.getFrameElement(
      frame,
      "apiSetupDoneButton",
      "transformationUI"
    );
    await action.ClickElement(doneButton);
  }

  // script to edit Button forServiceProvider
  async editButtonforServiceProvider(reqElement, pageScreen, formValues) {
    await reqElement.click({ button: "right" });
    await action.ClickElement("EditWidget", pageScreen);
    await page.waitForTimeout(500);
    await action.ClickElement("Events", pageScreen);
    await action.ClickElement("EventClickAction", pageScreen);
    await page.waitForTimeout(500);
    await action.selectDropdownbyspantext(
      "EventClickActionInputbox",
      pageScreen,
      formValues[0].Action
    );
  }

  // script to do  response setup for response mapping
  async responseSetup(formValues) {
    let frame;
    if (process.env.Env != 'Demo') {
      frame = page;
    }
    else {
      frame = page.frame({ url: /transformations*/ });
    }
    await frame.waitForSelector(
      await ScreenMap.get("transformationUI").getSelector("inputUploadButton")
    );
    let inputUploadButton = await OnloadTrigger.getFrameElement(
      frame,
      "inputUploadButton",
      "transformationUI"
    );
    await action.ClickElement(inputUploadButton);
    await page.waitForTimeout(500);
    let del = "//input/../..//i[contains(@class,'pi-times')]";
    await page.isVisible(del).then(async (exist) => {
      if (exist == true) {
        let Option = await page.locator(del);
        let noOfOption = await Option.count();
        for (let j = 0; j < noOfOption; j++) {
          await action.ClickElement(Option.nth(0));
        }
      }
    });
    await page.waitForTimeout(500);
    await OnloadTrigger.selectFrameDropdownbytagName(
      frame,
      "div",
      "responseSetupInput",
      formValues.ResponseInput,
      "transformationUI"
    );
    console.log("Input Selected");
    await frame.waitForTimeout(2000);
    let responseSetupInput = await OnloadTrigger.getFrameElement(
      frame,
      "responseSetupInput",
      "transformationUI"
    );
    await action.ClickElement(responseSetupInput);
    let doneButton = await OnloadTrigger.getFrameElement(
      frame,
      "apiSetupDoneButton",
      "transformationUI"
    );
    await action.ClickElement(doneButton);
  }
}
