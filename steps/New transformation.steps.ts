import { Given, When, Then, DataTable } from "@cucumber/cucumber";
import { page } from "./world";
import { ScreenMap } from "../Utility/Source/Core";
import { Actions } from "../Utility/Util/Actions";
import { Assertions } from "../Utility/Util/Assertions";
import { NewTransformationUI } from "../Main/New TransformationUI";
import { CommonUtilObject } from "../Utility/Util/CommonUtil";

let action: Actions = new Actions();
let assertion: Assertions = new Assertions();
let transformation: NewTransformationUI = new NewTransformationUI();



When(
  "User will create transformation rule for {string} {string} and connect Input and Output nodes in {string} screen",
  async (scenario, ruleName, pageScreen, table: DataTable) => {
    try {
      console.log(
        "User will create transformation rule  for " + ruleName + " and connect Input and Output nodes in  " + pageScreen + " screen"
      );
      const configurevals = table.hashes();
      console.log(configurevals.length);
      await page.waitForTimeout(500);
      await action.ClickElement("addRuleButton", pageScreen)
      await action.enterText(ruleName, "Name", pageScreen)
      await page.waitForTimeout(500);
      if (scenario == "API Task") {
        for (let j = 0; j < configurevals.length; j++) {
          console.log(configurevals[j].Destination, configurevals[j].Source);
          await transformation.DragandDropFieldsforTransformationUI(configurevals[j].Source, j, pageScreen)
          let DestinationFieldInput = "(//div[@class='operation-area'])[" + (j + 1) + "]//input"
          let destDropdown = await page.locator(DestinationFieldInput).nth(0)
          let sourceDropdown = await page.locator(DestinationFieldInput).nth(1)
          // select option from destination dropdown
          let dropfield = await action.getElement('Rule body', pageScreen)
          await dropfield.scrollIntoViewIfNeeded();
          await destDropdown.click();
          let datalist = page.locator("//li//div[normalize-space(text())='" + process.env.DataList + "']")
          await action.mouseHoverElement(datalist)
          if (configurevals[0].DataType == "DynamoDB"||configurevals[0].DataType == "MySQL") {
            await console.log("Data Source type is" + configurevals[0].DataType)
            await console.log("process.env.DataList"+process.env.DataList);
            await transformation.SelectOptionsforDb(configurevals[j].Destination, configurevals[j].UniqueField, pageScreen)
          } else {
            await transformation.SelectOptionsforAPI(configurevals[j].Destination, configurevals[j].UniqueField, pageScreen)
          }
          // select option from source dropdown
          await sourceDropdown.click()
          await action.mouseHoverElement('Application', pageScreen)
          await action.mouseHoverElement('root', pageScreen);
          await transformation.SelectOptionsforUI(configurevals[j].Source, pageScreen)
        }
      } else if (scenario == "Response Mapping") {
        for (let j = 0; j < configurevals.length; j++) {
          console.log(configurevals[j].Destination, configurevals[j].Source);
          await transformation.DragandDropFieldsforTransformationUI(configurevals[j].Source, j, pageScreen)
          let DestinationFieldInput = "(//div[@class='operation-area'])[" + (j + 1) + "]//input"
          let destDropdown = await page.locator(DestinationFieldInput).nth(0)
          let sourceDropdown = await page.locator(DestinationFieldInput).nth(1)
          // select option from Destination dropdown
          await destDropdown.click()
          await action.mouseHoverElement('Application', pageScreen)
          await transformation.SelectOptionsforUI(configurevals[j].Destination, pageScreen)
          // select option from Source dropdown
          await sourceDropdown.click()
          let datalist = page.locator("//li//div[normalize-space(text())='" + process.env.RMDataList + "']")
          await action.mouseHoverElement(datalist);
          await action.mouseHoverElement('root', pageScreen);
          if (process.env.RMDataList.startsWith('Get All') || process.env.RMDataList.startsWith('Get By Filter')) {
            await action.mouseHoverElement('Array', pageScreen)
            await transformation.SelectOptionsfromDropdown(configurevals[j].Source, "Array", pageScreen)
          } else {
            await transformation.SelectOptionsfromDropdown(configurevals[j].Source, 'root', pageScreen)
          }
        }
      } else if (scenario == "Response Task") {
        for (let j = 0; j < configurevals.length; j++) {
          console.log(configurevals[j].Destination, configurevals[j].Source);
          await transformation.DragandDropFieldsforTransformationUI(configurevals[j].Source, j, pageScreen)
          let DestinationFieldInput = "(//div[@class='operation-area'])[" + (j + 1) + "]//input"
          let destDropdown = await page.locator(DestinationFieldInput).nth(0)
          let sourceDropdown = await page.locator(DestinationFieldInput).nth(1)
          // select option from destination dropdown
          await destDropdown.click()
          await action.mouseHoverElement('Application', pageScreen)
          await action.mouseHoverElement('Back_Office_Fields', pageScreen)
          await transformation.SelectOptionsfromDropdown(configurevals[j].Destination, 'Back_Office_Fields', pageScreen)
          // select option from source dropdown
          await sourceDropdown.click()
          let datalist = page.locator("//li//div[normalize-space(text())='" + process.env.RMResources + "']")
          await action.mouseHoverElement(datalist)   
          await action.mouseHoverElement('SuccessResponse', pageScreen);
          await action.mouseHoverElement('root', pageScreen);
          // await action.ClickElement('array element of root', pageScreen)
          await transformation.SelectOptionsfromDropdown(configurevals[j].Source,'root', pageScreen)
        }
      } else if (scenario == "Service Provider") {
        for (let j = 0; j < configurevals.length; j++) {
          console.log(configurevals[j].Destination, configurevals[j].Source);
          await transformation.DragandDropFieldsforTransformationUI(configurevals[j].Source, j, pageScreen)
          let DestinationFieldInput = "(//div[@class='operation-area'])[" + (j + 1) + "]//input"
          let destDropdown = await page.locator(DestinationFieldInput).nth(0)
          let sourceDropdown = await page.locator(DestinationFieldInput).nth(1)
          // select option from destination dropdown
          await destDropdown.click()
          await transformation.SelectOptionsforServiceProvider(configurevals[j].Destination, configurevals[j].UniqueField, pageScreen)
          // select option from source dropdown
          await sourceDropdown.click()
          await action.mouseHoverElement('Application', pageScreen)
          await transformation.SelectOptionsforUI(configurevals[j].Source, pageScreen)



        }
      }
      else if (scenario == "Response Populate") {
        for (let j = 0; j < configurevals.length; j++) {
          console.log(configurevals[j].Destination, configurevals[j].Source);
          await transformation.DragandDropFieldsforTransformationUI(configurevals[j].Source, j, pageScreen)
          let DestinationFieldInput = "(//div[@class='operation-area'])[" + (j + 1) + "]//input"
          let destDropdown = await page.locator(DestinationFieldInput).nth(0)
          let sourceDropdown = await page.locator(DestinationFieldInput).nth(1)
          // select option from destination dropdown
          await destDropdown.click()
          await action.mouseHoverElement('Application', pageScreen)
          await transformation.SelectOptionsforUI(configurevals[j].Destination, pageScreen);
          // select option from source dropdown
          await sourceDropdown.click()
          await action.mouseHoverElement('root', pageScreen);
          await transformation.SelectOptionsfromDropdown(configurevals[j].Source,'root', pageScreen)
        }
      } else if (scenario == "Populate") {
        for (let j = 0; j < configurevals.length; j++) {
          console.log(configurevals[j].Destination, configurevals[j].Source);
          await transformation.DragandDropFieldsforTransformationUI(configurevals[j].Source, j, pageScreen)
          let DestinationFieldInput = "(//div[@class='operation-area'])[" + (j + 1) + "]//input"
          let destDropdown = await page.locator(DestinationFieldInput).nth(0)
          let sourceDropdown = await page.locator(DestinationFieldInput).nth(1)
          // select option from destination dropdown
          await destDropdown.click();
          await action.mouseHoverElement('Application', pageScreen);
          await transformation.SelectOptionsforUI(configurevals[j].Destination, pageScreen);
          // select option from Source dropdown
          await sourceDropdown.click()
          let datalist = page.locator("//li//div[normalize-space(text())='" + process.env.RMDataList + "']")
          await action.mouseHoverElement(datalist)
          await action.mouseHoverElement('root', pageScreen);
          await page.waitForTimeout(500);
          if (process.env.RMDataList.startsWith('Get All') || process.env.RMDataList.startsWith('Get By Filter')) {
            await action.mouseHoverElement('Array', pageScreen)
            await transformation.SelectOptionsfromDropdown(configurevals[j].Source, "Array", pageScreen)
          } else {
            await transformation.SelectOptionsfromDropdown(configurevals[j].Source, 'root', pageScreen)
          }
        }
      } else if (scenario == "QueueTask") {
        for (let j = 0; j < configurevals.length; j++) {
          console.log(configurevals[j].Destination, configurevals[j].Source);
          await transformation.DragandDropFieldsforTransformationUI(configurevals[j].Source, j, pageScreen)
          let DestinationFieldInput = "(//div[@class='operation-area'])[" + (j + 1) + "]//input"
          let destDropdown = await page.locator(DestinationFieldInput).nth(0)
          let sourceDropdown = await page.locator(DestinationFieldInput).nth(1)
          // select option from destination dropdown
          await destDropdown.click();
          // await action.ClickElement('File', pageScreen);
          await transformation.SelectOptions(configurevals[j].Destination, pageScreen)
          console.log("Destination option selected successfully")
          // select option from Source dropdown
          await sourceDropdown.click()
          console.log("Source option clicked successfully")
          await action.mouseHoverElement('Application', pageScreen);
          await action.mouseHoverElement('root', pageScreen);
          await transformation.SelectOptionsforUI(configurevals[j].Source, pageScreen);
        }
      } else if (scenario == "MongoDB" || scenario == "DynamoDB") {
        for (let j = 0; j < configurevals.length; j++) {
          console.log(configurevals[j].Destination, configurevals[j].Source);
          await transformation.DragandDropFieldsforTransformationUI(configurevals[j].Source, j, pageScreen)
          let DestinationFieldInput = "(//div[@class='operation-area'])[" + (j + 1) + "]//input"
          let destDropdown = await page.locator(DestinationFieldInput).nth(0)
          let sourceDropdown = await page.locator(DestinationFieldInput).nth(1)
          // select option from destination dropdown
          let dropfield = await action.getElement('Rule body', pageScreen)
          await dropfield.scrollIntoViewIfNeeded();
          await destDropdown.click()
          await action.mouseHoverElement('API', pageScreen);
                    await transformation.SelectOptionsforDb(configurevals[j].Destination, configurevals[j].UniqueField, pageScreen)
          // select option from source dropdown
          await sourceDropdown.click()
          await action.mouseHoverElement('Application', pageScreen)
          await transformation.SelectOptionsforUI(configurevals[j].Source, pageScreen)
        }
      }
      await action.ClickElement('Save', pageScreen);
      await page.waitForSelector(await ScreenMap.get(pageScreen).getSelector("Success"), { state: 'hidden' ,timeout: 60000});
      await action.waitforInvisibilityOfToastMessage();
      await page.waitForTimeout(5000);
      await action.ClickElement('Close', pageScreen);
      await page.waitForTimeout(500);
      console.log('Mapping Saved and Transformations UI has been closed');
      if (scenario !== "API Task" && scenario !== "QueueTask" && scenario !== "Response Task") {
        await page.waitForSelector(await ScreenMap.get(pageScreen).getSelector("Success"), { state: 'hidden', timeout: 60000 });
        await page.waitForTimeout(500);
      }
    } catch (err) {
      throw err;
    }
  }
);

Then('User edit {string} with name {string} event and update mapping in {string} screen', async (scenario, eventName, pageScreen, table: DataTable) => {
  console.log("User will update mapping for " + eventName + " in " + pageScreen);

  if (scenario == "Service Provider" || scenario == "Populate" || scenario == "Response Mapping") {
    //verify mapping is visible
    let txtElement = await ScreenMap.get('EventConfigurations').getSelector("EventLabel");
    let typeElement = page.locator(
      txtElement.replace("EventName", eventName)
    );
    //expand event
    await action.ClickElement(typeElement);
    // edit event
    txtElement = await ScreenMap.get('EventConfigurations').getSelector("TxUIEventEdit");
    typeElement = page.locator(
      txtElement.replace("EventName", eventName)
    );
    //edit event
    await action.ClickElement(typeElement);
  } else if (scenario == "API Task" || scenario == "Response Task") {
    //code to edit mappings for API and Response task
  } else {
    //When Tasks doesn't match the above covered tasks
    console.log('Mappings cannot be updated for ' + scenario);
  }
  console.log(eventName + " mappings will be updated");
  //do the mapping
  let srcElement = "//div[@class='count']";
  const count = await page.evaluate((srcElement) => {
    const elements = document.evaluate(
      srcElement,
      document,
      null,
      XPathResult.ORDERED_NODE_SNAPSHOT_TYPE,
      null
    );
    return elements.snapshotLength;
  }, srcElement);
  //count of existing mapping

  //get count for //div[@class='count']

  const configurevals = table.hashes();
  console.log(configurevals.length);
  await page.waitForTimeout(500);
  let newLen = count + configurevals.length;
  if (scenario == "API Task") {
    for (let j = count + 1; j < newLen; j++) {
      let x = j - count - 1;
      console.log(configurevals[x].Destination, configurevals[x].Source);
      await transformation.DragandDropFieldsforTransformationUI(configurevals[j].Source, j, pageScreen)
      let DestinationFieldInput = "(//div[@class='operation-area'])[" + (j + 1) + "]//input"
      let destDropdown = await page.locator(DestinationFieldInput).nth(0)
      let sourceDropdown = await page.locator(DestinationFieldInput).nth(1)
      // select option from destination dropdown
      await destDropdown.click()
      await transformation.SelectOptionsforAPI(configurevals[j].Destination, configurevals[x].UniqueField, pageScreen)
      // select option from source dropdown
      await sourceDropdown.click()
      await action.mouseHoverElement('Application', pageScreen)
      await transformation.SelectOptionsforUI(configurevals[x].Source, pageScreen)
    }
  } else if (scenario == "Response Mapping") {
    for (let j = count; j < newLen; j++) {
      let x = j - count;
      console.log(configurevals[x].Destination, configurevals[x].Source);
      await transformation.DragandDropFieldsforTransformationUI(configurevals[x].Source, j, pageScreen)
      let DestinationFieldInput = "(//div[@class='operation-area'])[" + (j + 1) + "]//input"
      let destDropdown = await page.locator(DestinationFieldInput).nth(0)
      let sourceDropdown = await page.locator(DestinationFieldInput).nth(1)

      // select option from Destination dropdown
      await destDropdown.click()
      await action.mouseHoverElement('Application', pageScreen)
      await transformation.SelectOptionsforUI(configurevals[x].Destination, pageScreen)

      // select option from Source dropdown
      await sourceDropdown.click()
      let datalist = page.locator("//li//div[normalize-space(text())='" + process.env.RMDataList + "']")
      await action.mouseHoverElement(datalist);
      await action.mouseHoverElement('root', pageScreen);
      if (process.env.RMDataList.startsWith('Get All') || process.env.RMDataList.startsWith('Get By Filter')) {
        await action.mouseHoverElement('Array', pageScreen)
        await transformation.SelectOptionsfromDropdown(configurevals[x].Source, "Array", pageScreen)
      } else {
        await transformation.SelectOptionsfromDropdown(configurevals[x].Source, 'root', pageScreen)
      }
    }
  } else if (scenario == "Response Task") {
    for (let j = count + 1; j < newLen; j++) {
      console.log(configurevals[j].Destination, configurevals[j].Source);
      await transformation.DragandDropFieldsforTransformationUI(configurevals[j].Source, j, pageScreen)
      let DestinationFieldInput = "(//div[@class='operation-area'])[" + (j + 1) + "]//input"
      let destDropdown = await page.locator(DestinationFieldInput).nth(0)
      let sourceDropdown = await page.locator(DestinationFieldInput).nth(1)
      // select option from destination dropdown
      await destDropdown.click()
      await action.mouseHoverElement('Application', pageScreen)
      await action.mouseHoverElement('Back_Office_Fields', pageScreen)
      await transformation.SelectOptionsfromDropdown(configurevals[j].Destination, 'Back_Office_Fields', pageScreen)
      // select option from source dropdown
      await sourceDropdown.click()
      let datalist = page.locator("//li//div[normalize-space(text())='" + process.env.RMResources + "']")
      await action.mouseHoverElement(datalist)
      await action.mouseHoverElement('array element of root', pageScreen)
      await transformation.SelectOptionsfromDropdown(configurevals[j].Source, 'array element of root', pageScreen)
    }
  } else if (scenario == "Service Provider") {
    for (let j = count; j < newLen; j++) {
      let x = j - count;
      console.log(configurevals[x].Destination, configurevals[x].Source);
      await transformation.DragandDropFieldsforTransformationUI(configurevals[x].Source, j, pageScreen)
      let DestinationFieldInput = "(//div[@class='operation-area'])[" + (j + 1) + "]//input"
      let destDropdown = await page.locator(DestinationFieldInput).nth(0)
      let sourceDropdown = await page.locator(DestinationFieldInput).nth(1)
      // select option from destination dropdown
      await destDropdown.click();
      await action.mouseHoverElement('API', pageScreen);
      await action.mouseHoverElement('Request', pageScreen);
      await action.mouseHoverElement('root', pageScreen);
      await transformation.SelectOptionsfromDropdown(configurevals[x].Destination, 'root', pageScreen);
      // select option from source dropdown
      await sourceDropdown.click();
      await action.mouseHoverElement('Application', pageScreen);
      await transformation.SelectOptionsforUI(configurevals[x].Source, pageScreen)
    }
  } else if (scenario == "Populate") {
    for (let j = count; j < newLen; j++) {
      let x = j - count;
      console.log(configurevals[x].Destination, configurevals[x].Source);
      await transformation.DragandDropFieldsforTransformationUI(configurevals[x].Source, j, pageScreen)
      let DestinationFieldInput = "(//div[@class='operation-area'])[" + (j + 1) + "]//input"
      let destDropdown = await page.locator(DestinationFieldInput).nth(0)
      let sourceDropdown = await page.locator(DestinationFieldInput).nth(1)
      // select option from destination dropdown
      await destDropdown.click();
      await action.mouseHoverElement('Application', pageScreen);
      await transformation.SelectOptionsforUI(configurevals[x].Destination, pageScreen)
      // select option from Source dropdown
      await sourceDropdown.click()
      let datalist = page.locator("//li//div[normalize-space(text())='" + process.env.RMDataList + "']")
      await action.mouseHoverElement(datalist);
      await action.mouseHoverElement('root', pageScreen);
      if (process.env.RMDataList.startsWith('Get All') || process.env.RMDataList.startsWith('Get By Filter')) {
        await action.mouseHoverElement('Array', pageScreen)
        await transformation.SelectOptionsfromDropdown(configurevals[x].Source, "Array", pageScreen)
      } else {
        await transformation.SelectOptionsfromDropdown(configurevals[x].Source, 'root', pageScreen)
      }
    }
  }
  await action.ClickElement('Save', pageScreen);
  await assertion.Visible("Success", pageScreen);
  await action.ClickElement('Close', pageScreen);
  await page.waitForTimeout(500);
});

When(
  "User will create transformation rule for {string} {string} in {string} screen",
  async (scenario, ruleName, pageScreen, table: DataTable) => {
    try {
      console.log(
        "User will create transformation rule  for " + ruleName + " in  " + pageScreen + " screen"
      );
      const configurevals = table.hashes();
      console.log(configurevals.length);
      await page.waitForTimeout(500);
      await action.ClickElement("addRuleButton", pageScreen)
      await action.enterText(ruleName, "Name", pageScreen)
      await page.waitForTimeout(500);
      if (scenario == "API Task") {
        for (let j = 0; j < configurevals.length; j++) {
          console.log(configurevals[j].Destination, configurevals[j].Source);
          await transformation.DragandDropFieldsforTransformationUI(configurevals[j].Source, j, pageScreen)
          let DestinationFieldInput = "(//div[@class='operation-area'])[" + (j + 1) + "]//input"
          let destDropdown = await page.locator(DestinationFieldInput).nth(0)
          let sourceDropdown = await page.locator(DestinationFieldInput).nth(1)
          // select option from destination dropdown
          let dropfield = await action.getElement('Rule body', pageScreen)
          await dropfield.scrollIntoViewIfNeeded();
          await destDropdown.click()
          // Check the destination fields contains -> symbol
          if (configurevals[j].Destination.indexOf("->") == -1) {
            let datalist = page.locator("//li//div[normalize-space(text())='" + process.env.DataList + "']")
            await action.mouseHoverElement(datalist)
            await transformation.SelectOptionsforAPI(configurevals[j].Destination, configurevals[j].UniqueField, pageScreen)
          }
          else {
            let datalist = page.locator("//li//div[normalize-space(text())='" + process.env.DataList + "']")
            await action.mouseHoverElement(datalist)
            const destElements = (configurevals[j].Destination).split("->")
            for (let i = 0; i < await destElements.length; i++) {
              const destElement = destElements[i];
              let fieldxpath = await ScreenMap.get(pageScreen).getSelector("options");
              if (destElements[i].startsWith("#"))
                destElements[i] = CommonUtilObject.readUsecaseTestData(process.env.FileName, destElements[i].replace("#", ""))

              let field = page.locator(
                fieldxpath.replace("elementName", destElements[i])
              );
              await action.mouseHoverElement(field);
              if (i == (destElements.length - 1)) {
                await action.ClickElement(field);
              }
            }
          }
          // select option from source dropdown
          await sourceDropdown.click()
          if (configurevals[j].Source.indexOf("->") == -1) {
            await action.mouseHoverElement('Application', pageScreen)
            await action.mouseHoverElement('root', pageScreen);
            await transformation.SelectOptionsforUI(configurevals[j].Source, pageScreen)
          }
          else {
            await action.mouseHoverElement('Application', pageScreen)
            await action.mouseHoverElement('root', pageScreen);
            console.log(configurevals[j].Source)
            const destElements = (configurevals[j].Source).split("->")
            for (let i = 0; i < await destElements.length; i++) {
              const destElement = destElements[i];
              console.log("element" + i + "is " + destElement)
              let fieldxpath = await ScreenMap.get(pageScreen).getSelector("options");
              if (destElements[i].startsWith("#"))
                destElements[i] = CommonUtilObject.readUsecaseTestData(process.env.FileName, destElements[i].replace("#", ""))

              let field = page.locator(
                fieldxpath.replace("elementName", destElements[i])
              );
              console.log(field)
              //div[@role='menuitem']//div[normalize-space(text())='elementName']
              await action.mouseHoverElement(field);
              if (i == (destElements.length - 1)) {
                await action.ClickElement(field);
              }
            }
          }
        }
      }
      else if (scenario == "QueueTask") {
        for (let j = 0; j < configurevals.length; j++) {
          console.log(configurevals[j].Destination, configurevals[j].Source);
          await transformation.DragandDropFieldsforTransformationUI(configurevals[j].Source, j, pageScreen)
          let DestinationFieldInput = "(//div[@class='operation-area'])[" + (j + 1) + "]//input"
          let destDropdown = await page.locator(DestinationFieldInput).nth(0)
          let sourceDropdown = await page.locator(DestinationFieldInput).nth(1)
          // select option from destination dropdown
          await destDropdown.click();
          // await action.ClickElement('File', pageScreen);
          await transformation.SelectOptions(configurevals[j].Destination, pageScreen)
          // select option from Source dropdown
          await sourceDropdown.click()
          await action.mouseHoverElement('Application', pageScreen);
          await action.mouseHoverElement('root', pageScreen);
          console.log(configurevals[j].Source)
          const destElements = (configurevals[j].Source).split("->")
          for (let i = 0; i < await destElements.length; i++) {
            const destElement = destElements[i];
            console.log("element" + i + "is " + destElement)
            let fieldxpath = await ScreenMap.get(pageScreen).getSelector("options");
            if (destElements[i].startsWith("#"))
              destElements[i] = CommonUtilObject.readUsecaseTestData(process.env.FileName, destElements[i].replace("#", ""))
            let field = page.locator(
              fieldxpath.replace("elementName", destElements[i])
            );
            await action.mouseHoverElement(field);
            if (i == (destElements.length - 1)) {
              await action.ClickElement(field);
            }

          }
        }
      }
      else if (scenario == "Response Task") {
        for (let j = 0; j < configurevals.length; j++) {
          console.log(configurevals[j].Destination, configurevals[j].Source);
          await transformation.DragandDropFieldsforTransformationUI(configurevals[j].Source, j, pageScreen)
          let DestinationFieldInput = "(//div[@class='operation-area'])[" + (j + 1) + "]//input"
          let destDropdown = await page.locator(DestinationFieldInput).nth(0)
          let sourceDropdown = await page.locator(DestinationFieldInput).nth(1)
          // select option from Destination dropdown
          await destDropdown.click()
          await action.mouseHoverElement('Application', pageScreen)
          await transformation.SelectOptionsforUI(configurevals[j].Destination, pageScreen)
          // select option from source dropdown
          await sourceDropdown.click()
          if (configurevals[j].Source.indexOf("->") == -1) {
            let datalist = page.locator("//li//div[normalize-space(text())='" + process.env.RMResources + "']")
            await action.mouseHoverElement(datalist);
            await action.mouseHoverElement('root', pageScreen);
            await transformation.SelectOptionsforUI(configurevals[j].Source, pageScreen)

          }
          else {
            let datalist = page.locator("//li//div[normalize-space(text())='" + process.env.RMResources + "']")
            await action.mouseHoverElement(datalist);
            // await action.mouseHoverElement('root', pageScreen);
            console.log(configurevals[j].Source)
            const destElements = (configurevals[j].Source).split("->")
            for (let i = 0; i < await destElements.length; i++) {
              const destElement = destElements[i];
              let fieldxpath = await ScreenMap.get(pageScreen).getSelector("options");
              if (destElements[i].startsWith("#"))
                destElements[i] = CommonUtilObject.readUsecaseTestData(process.env.FileName, destElements[i].replace("#", ""))

              let field = page.locator(
                fieldxpath.replace("elementName", destElements[i])
              );
              await action.mouseHoverElement(field);
              if (i == (destElements.length - 1)) {
                await action.ClickElement(field);
              }
            }
          }
        }
      }
      await action.ClickElement('Save', pageScreen);
      await page.waitForSelector(await ScreenMap.get(pageScreen).getSelector("Success"), { state: 'hidden', timeout: 60000 });
      await action.waitforInvisibilityOfToastMessage();
      await page.waitForTimeout(5000);
      await action.ClickElement('Close', pageScreen);
      await page.waitForTimeout(500);
      console.log('Mapping Saved and Transformations UI has been closed');
      if (scenario !== "API Task" && scenario !== "QueueTask" && scenario !== "Response Task") {
        await page.waitForSelector(await ScreenMap.get(pageScreen).getSelector("Success"), { state: 'hidden', timeout: 60000 });
        await page.waitForTimeout(500);
      }
    } catch (err) {
      throw err;
    }
  });


