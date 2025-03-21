import { ScreenMap } from "../Utility/Source/Core";
import { page } from "../steps/world";
import { Actions } from "../Utility/Util/Actions";
import { NewTransformationUI } from "./New TransformationUI";
import { Assertions } from "../Utility/Util/Assertions";

let action: Actions = new Actions();
let assertions: Assertions = new Assertions();
let transformation: NewTransformationUI = new NewTransformationUI();
export class OnloadTriggers {
  // Select options mapping drop down with dynamic values
  async selectOption(option, elementName?) {
    let txtElement;
    if (elementName !== undefined) {
      txtElement = await ScreenMap.get("onLoadTrigger").getSelector(
        elementName
      );
    } else {
      txtElement = await ScreenMap.get("onLoadTrigger").getSelector(
        "optionsMappingoption"
      );
    }
    txtElement = txtElement.replace("elementName", "" + option + "");
    await page.isVisible(txtElement).then(async (exist) => {
      if (exist == true) {
        let element = page.locator(txtElement);
        await action.mouseHoverElement(element)
      }
    });
    await page.waitForTimeout(2000);
  }

  // Fill all the requiredd fields for options mapping
  async fillOptionsMappingTrigger(
    elementName,
    pageScreen,
    triggerValues,
    triggerNo,
    noOfOptionMapping
  ) {
    await page.waitForTimeout(500);
    let i = triggerNo;
    //Enter name of the Trigger
    await page.waitForTimeout(500);
    let nameElement = await action.getElement("triggerName", pageScreen);
    await action.enterText(triggerValues.Name, await nameElement.nth(i));
    console.log("Trigger name entered");
    //Enter Description for the Trigger
    let descElement = await action.getElement("triggerDescription", pageScreen);
    await action.enterText(triggerValues.Description, await descElement.nth(i));
    console.log("Trigger Description entered");
    await page.waitForTimeout(500);
    // Select Data Source
    let dataSourceElement = await action.getElement(
      "triggerDataSource",
      pageScreen
    );
    await action.selectDropdownbytagName(
      "span",
      await dataSourceElement.nth(i),
      triggerValues.DataSource
    );
    console.log("Data Source selected as " + triggerValues.DataSource);
    // Select Data List
    let dataListElement = await action.getElement(
      "triggerDataList",
      pageScreen
    );
    await action.selectDropdownbytagName(
      "span",
      await dataListElement.nth(i),
      triggerValues.DataList
    );
    console.log("Data List Selected as " + triggerValues.DataList);
    console.log(" noOfOptionMapping is " + noOfOptionMapping);
    for (let k = 0; k < noOfOptionMapping; k++) {
      // Click on Options mapping plus icon
      let plusIconXpath = await ScreenMap.get(pageScreen).getSelector(
        "optionsMappingPlusIcon"
      );
      let plusIconElement = await page.locator(
        await plusIconXpath.replace("elementName", triggerValues.Name)
      );
      await action.ClickElement(plusIconElement);

      await page.waitForTimeout(500);
      console.log("Options Mapping plus Icon selected");
      // Select Field
      let fieldElementXpath = await ScreenMap.get(pageScreen).getSelector(
        "field"
      );
      let fieldElement = await page.locator(
        await fieldElementXpath.replace("elementName", triggerValues.Name)
      );
      await action.ClickElement(fieldElement.nth(k));
      await this.SelectOptionsMappingforFOandBO(
        triggerValues[`Field${k + 1}`],
        pageScreen
      );
      console.log("field " + triggerValues[`Field${k + 1}`] + "selected");

      // Select Label
      let labelElementXpath = await ScreenMap.get(pageScreen).getSelector(
        "label"
      );
      let labelElement = await page.locator(
        await labelElementXpath.replace("elementName", triggerValues.Name)
      );
      await action.ClickElement(labelElement.nth(k));
      if (
        triggerValues.DataList.startsWith("Save") ||
        triggerValues.DataList.startsWith("Get All")
      ) {
        await this.selectOption("root");
        await this.selectOption("array element of root");
      }
      await this.SelectOptionsMappingforFOandBO(
        triggerValues[`Label${k + 1}`],
        pageScreen
      );
      console.log("Label " + triggerValues[`Label${k + 1}`] + " selected");

      // Select value
      let valueElementXpath = await ScreenMap.get(pageScreen).getSelector(
        "value"
      );
      let valueElement = await page.locator(
        await valueElementXpath.replace("elementName", triggerValues.Name)
      );
      await action.ClickElement(valueElement.nth(k));
      if (
        triggerValues.DataList.startsWith("Save") ||
        triggerValues.DataList.startsWith("Get All")
      ) {
        await this.selectOption("root");
        await this.selectOption("array element of root");
      }
      // await this.SelectOptionsMappingforFOandBO(
      //   triggerValues[`Value${k + 1}`],
      //   pageScreen
      // );
      await transformation.SelectOptionsfromDropdown(triggerValues[`Value${k + 1}`], 'array element of root', pageScreen)
      console.log("value " + triggerValues[`Value${k + 1}`] + " selected");
      if (triggerValues[`DefaultKey${k + 1}`]) {
        // Select DefaultKey
        let delfaultElementXpath = await ScreenMap.get(pageScreen).getSelector(
          "defaultKey"
        );
        let defaultElement = await page.locator(
          await delfaultElementXpath.replace("elementName", triggerValues.Name)
        );
        await action.ClickElement(defaultElement.nth(k));
        if (
          triggerValues.DataList.startsWith("Save") ||
          triggerValues.DataList.startsWith("Get All")
        ) {
          await this.selectOption("root");
          await this.selectOption("array element of root");
        }
        await this.SelectOptionsMappingforFOandBO(
          triggerValues[`Value${k + 1}`],
          pageScreen
        );
        console.log("field " + triggerValues[`DefaultKey${k + 1}`] + "selected");
      }
      // Select DefaultValue
      if (triggerValues[`Defaultvalue${k + 1}`]) {
        let valueElementXpath = await ScreenMap.get(pageScreen).getSelector(
          "defaultValue"
        );
        let valueElement = await page.locator(
          await valueElementXpath.replace("elementName", triggerValues.Name)
        );
        await valueElement.fill(triggerValues[`Defaultvalue${k + 1}`])
      }
    }
    if (triggerValues.DataList.startsWith("Save")) {
      console.log("No need to fill Param Config Details");
    } else if (triggerValues.DataList.startsWith("Get All")) {
      console.log("No need to fill Param Config Details");
    } else if (
      triggerValues.DataList.startsWith("Get By Id") ||
      triggerValues.DataList.startsWith("Delete By Id") ||
      triggerValues.DataList.startsWith("Update By Id")
    ) {
      // Select Type
      let txtElement = await ScreenMap.get(pageScreen).getSelector("paramType");
      let typeElement = page.locator(
        txtElement.replace("elementName", triggerValues.Name)
      );
      await action.selectDropdownbytagName(
        "span",
        typeElement,
        triggerValues.Type
      );
      await page.waitForTimeout(500);
      console.log("Type selected");

      //Select uniqueField details
      if (triggerValues.Type == "value") {
        let inputLocator = await ScreenMap.get(pageScreen).getSelector(
          "paramUniqueFieldInputBox"
        );
        let IdInput = await page.locator(
          await inputLocator.replace("elementName", triggerValues.Name).replace(
            "uniqueField",
            process.env[triggerValues.uniqueField]
          )
        );
        await action.enterText(triggerValues.uniqueFieldValue, IdInput);
      } else if (triggerValues.Type == "session") {
        let inputLocator = await ScreenMap.get(pageScreen).getSelector(
          "paramUniqueFieldDropdown"
        );
        let IdInputDropdown = await page.locator(
          await inputLocator.replace("elementName", triggerValues.Name).replace(
            "uniqueField",
            process.env[triggerValues.uniqueField]
          )
        );

        await action.selectDropdownbytagName(
          "span",
          await IdInputDropdown,
          triggerValues.uniqueFieldValue
        );
      } else if (triggerValues.Type == "ref") {
        let inputLocator = await ScreenMap.get(pageScreen).getSelector(
          "paramUniqueFieldInputBox"
        );
        let IdInputDropdown = await page.locator(
          await inputLocator.replace("elementName", triggerValues.Name).replace(
            "uniqueField",
            process.env[triggerValues.uniqueField]
          )
        );
        await action.ClickElement(IdInputDropdown);
        await this.SelectOptionsMappingforFOandBO(
          triggerValues.uniqueFieldValue,
          pageScreen
        );
      }
    } else if (triggerValues.DataList.startsWith("Get By Filter")) {
      // Select Type
      let txtElement = await ScreenMap.get(pageScreen).getSelector("paramType");
      let typeElement = page.locator(
        txtElement.replace("elementName", triggerValues.Name)
      );
      await action.selectDropdownbytagName(
        "span",
        typeElement,
        triggerValues.Type
      );
      await page.waitForTimeout(500);
      console.log("Type selected");

      if (triggerValues.Type == "value") {
        let filterElementXpath = await ScreenMap.get(pageScreen).getSelector(
          "filterInputBox"
        );
        let filterElement = page.locator(
          filterElementXpath.replace("elementName", triggerValues.Name)
        );
        await action.enterText(triggerValues.uniqueFieldValue, filterElement);
      } else if (triggerValues.Type == "session") {
        let filterElementXpath = await ScreenMap.get(pageScreen).getSelector(
          "filterDropdown"
        );
        let filterElement = page.locator(
          filterElementXpath.replace("elementName", triggerValues.Name)
        );
        await action.selectDropdownbytagName(
          "span",
          filterElement,
          triggerValues.uniqueFieldValue
        );
      } else if (triggerValues.Type == "ref") {
        let filterElementXpath = await ScreenMap.get(pageScreen).getSelector(
          "filterInputBox"
        );
        let filterElement = page.locator(
          filterElementXpath.replace("elementName", triggerValues.Name)
        );
        await action.ClickElement(filterElement);
        await this.SelectOptionsMappingforFOandBO(
          triggerValues.uniqueFieldValue,
          pageScreen
        );
      }
    }
    // Save Trigger
    let saveOnloadTrigger = await action.getElement(
      "saveOnloadTrigger",
      pageScreen
    );
    await action.ClickElement(await saveOnloadTrigger);
    console.log("Save button clicked");
    await action.waitforInvisibilityOfSpinner();
  }

  // Fill all the required fields for response mapping
  async fillResponseMappingTrigger(
    elementName,
    pageScreen,
    triggerValues,
    triggerNo
  ) {
    await page.waitForTimeout(2000);
    let i = triggerNo;
    //Enter name of the Trigger
    await page.waitForTimeout(500);
    let nameElement = await action.getElement("triggerName", pageScreen);
    await action.enterText(triggerValues.Name, await nameElement.nth(i));
    console.log("Trigger name entered");
    //Enter Description for the Trigger
    let descElement = await action.getElement("triggerDescription", pageScreen);
    await action.enterText(triggerValues.Description, await descElement.nth(i));
    console.log("Trigger Description entered");
    await page.waitForTimeout(500);
    // Select Data Source
    let dataSourceElement = await action.getElement(
      "triggerDataSource",
      pageScreen
    );
    await page.waitForTimeout(500);
    console.log(await dataSourceElement.nth(i));
    await action.selectDropdownbytagName(
      "span",
      await dataSourceElement.nth(i),
      triggerValues.DataSource
    );
    console.log("Data Source selected as " + triggerValues.DataSource);
    // Select Data List
    let dataListElement = await action.getElement(
      "triggerDataList",
      pageScreen
    );
    console.log(await dataListElement.nth(i));
    await action.selectDropdownbytagName(
      "span",
      await dataListElement.nth(i),
      triggerValues.DataList
    );
    process.env.RMDataList = triggerValues.DataList;
    console.log("Data List Selected as " + triggerValues.DataList);
    if (triggerValues.DataList.startsWith("Save")) {
      console.log("No need to fill Param Config Details");
    } else if (triggerValues.DataList.startsWith("Get All")) {
      console.log("No need to fill Param Config Details");
    } else if (
      triggerValues.DataList.startsWith("Get By Id") ||
      triggerValues.DataList.startsWith("Delete By Id") ||
      triggerValues.DataList.startsWith("Update By Id")
    ) {
      // Select Type
      let txtElement = await ScreenMap.get(pageScreen).getSelector("paramType");
      let typeElement = page.locator(
        txtElement.replace("elementName", triggerValues.Name)
      );
      await action.selectDropdownbytagName(
        "span",
        typeElement,
        triggerValues.Type
      );
      await page.waitForTimeout(500);
      console.log("Type selected as:" + triggerValues.Type);

      //Select uniqueField details
      if (triggerValues.Type == "value") {
        let inputLocator = await ScreenMap.get(pageScreen).getSelector(
          "paramUniqueFieldInputBox"
        );
        let IdInput = await page.locator(
          await inputLocator.replace("elementName", triggerValues.Name).replace(
            "uniqueField",
            process.env[triggerValues.uniqueField]
          )
        );
        await action.enterText(triggerValues.uniqueFieldValue, IdInput);
      } else if (triggerValues.Type == "session") {
        let inputLocator = await ScreenMap.get(pageScreen).getSelector(
          "paramUniqueFieldDropdown"
        );
        let IdInputDropdown = await page.locator(
          await inputLocator.replace("elementName", triggerValues.Name).replace(
            "uniqueField",
            process.env[triggerValues.uniqueField]
          )
        );
        console.log(IdInputDropdown);
        console.log(triggerValues.uniqueFieldValue);
        await action.selectDropdownbytagName(
          "span",
          await IdInputDropdown,
          triggerValues.uniqueFieldValue
        );
        console.log("Pin selected as " + triggerValues.uniqueFieldValue);
      } else if (triggerValues.Type == "ref") {
        let inputLocator = await ScreenMap.get(pageScreen).getSelector(
          "paramUniqueFieldInputBox"
        );
        let IdInputDropdown = await page.locator(
          await inputLocator.replace("elementName", triggerValues.Name).replace(
            "uniqueField",
            process.env[triggerValues.uniqueField]
          )
        );
        // console.log(IdInputDropdown);
        await action.ClickElement(IdInputDropdown);
        await this.SelectOptionsMappingforFOandBO(
          triggerValues.uniqueFieldValue,
          pageScreen
        );
      }
    } else if (triggerValues.DataList.startsWith("Get By Filter")) {
      // Select Type
      let txtElement = await ScreenMap.get(pageScreen).getSelector("paramType");
      let typeElement = page.locator(
        txtElement.replace("elementName", triggerValues.Name)
      );
      await action.selectDropdownbytagName(
        "span",
        typeElement,
        triggerValues.Type
      );
      await page.waitForTimeout(500);
      console.log("Type selected");

      if (triggerValues.Type == "value") {
        let filterElementXpath = await ScreenMap.get(pageScreen).getSelector(
          "filterInputBox"
        );
        let filterElement = page.locator(
          filterElementXpath.replace("elementName", triggerValues.Name)
        );
        await action.enterText(triggerValues.uniqueFieldValue, filterElement);
      } else if (triggerValues.Type == "session") {
        let filterElementXpath = await ScreenMap.get(pageScreen).getSelector(
          "filterDropdown"
        );
        let filterElement = page.locator(
          filterElementXpath.replace("elementName", triggerValues.Name)
        );
        await action.selectDropdownbytagName(
          "span",
          filterElement,
          triggerValues.uniqueFieldValue
        );
      } else if (triggerValues.Type == "ref") {
        let filterElementXpath = await ScreenMap.get(pageScreen).getSelector(
          "filterInputBox"
        );
        let filterElement = page.locator(
          filterElementXpath.replace("elementName", triggerValues.Name)
        );
        await action.ClickElement(filterElement);
        await this.SelectOptionsMappingforFOandBO(
          triggerValues.uniqueFieldValue,
          pageScreen
        );
      }
    }
    await page.waitForTimeout(2000);
    await action.ClickElement('saveOnloadTrigger',pageScreen)
    await assertions.ContainText('Success', 'EventConfigurations', 'Success')
    await action.waitforInvisibilityOfToastMessage()
    await page.waitForTimeout(2000);
    // Click on Response mapping settings icon
    let iconXpath = await ScreenMap.get(pageScreen).getSelector(
      "responseMappingSettingsIcon"
    );
    let cogIcon = page.locator(
      iconXpath.replace("elementName", triggerValues.Name)
    );
    console.log(await cogIcon);
    await action.ClickElement(await cogIcon);
    await page.waitForTimeout(3000);
    await page.waitForLoadState("networkidle", { timeout: 60000 });
    // await this.verifyTransformationUILoads(cogIcon);
    // //  Click on expand all button
    // await page.waitForTimeout(5000);
    // let frame;
    // if (process.env.Env != "Demo") {
    //   frame = page;
    // } else {
    //   frame = page.frame({ url: /transformations*/ });
    // }
    // // console.log(frame);
    // let inputMenu = await this.getFrameElement(
    //   frame,
    //   "inputMenu",
    //   "transformationUI"
    // );
    // await action.ClickElement(inputMenu);
    // let expand = await this.getFrameElement(
    //   frame,
    //   "expandAllButton",
    //   "transformationUI"
    // );
    // await action.ClickElement(expand);
  }

  async getFrameElement(frame, elementName, pageScreen) {
    let locator;
    try {
      locator = await frame.locator(
        await ScreenMap.get(pageScreen).getSelector(elementName)
      );
    } catch (err) {
      throw err;
    }
    return locator;
  }

  // async dragAndDropwithiFrame(frame, sourceLocator, destLocator, pageScreen) {
  //   try {
  //     const src = await frame.locator(
  //       (
  //         await ScreenMap.get(pageScreen).getSelector("inputConfiguration")
  //       ).replace("expectedText", sourceLocator)
  //     );
  //     const dst = await frame.locator(
  //       (
  //         await ScreenMap.get(pageScreen).getSelector("outputConfiguration")
  //       ).replace("expectedText", destLocator)
  //     );
  //     console.log(src, dst);
  //     if (src && dst) {
  //       const srcBound = await src.boundingBox();
  //       const dstBound = await dst.boundingBox();
  //       if (srcBound && dstBound) {
  //         console.log(
  //           srcBound.x + srcBound.width / 2,
  //           srcBound.y + srcBound.height / 2
  //         );
  //         await page.mouse.move(
  //           srcBound.x + srcBound.width / 2,
  //           srcBound.y + srcBound.height / 2
  //         );
  //         await page.mouse.down();
  //         await page.mouse.move(
  //           dstBound.x + dstBound.width / 2,
  //           dstBound.y + dstBound.height / 2
  //         );
  //         await page.mouse.up();
  //       } else {
  //         throw new Error("No Element");
  //       }
  //     }
  //   } catch (err) {
  //     throw err;
  //   }
  // }

  async verifyTransformationUILoads(element) {
    let frame;
    if (process.env.Env != "Demo") {
      frame = page;
    } else {
      frame = page.frame({ url: /transformations*/ });
    }
    await frame.waitForTimeout(3000);
    // Check Transformation UI loaded with all the data. If not, Again click on response mapping from onload trigger ui
    let inputElement = await ScreenMap.get("transformationUI").getSelector(
      "inputMenu"
    );
    await frame.isVisible(inputElement).then(async (exist) => {
      console.log(exist);
      if (exist == false) {
        let closeButton = await this.getFrameElement(
          frame,
          "closeButton",
          "transformationUI"
        );
        await action.ClickElement(closeButton);
        await action.ClickElement(await element);
        await frame.waitForTimeout(5000);
      }
    });
  }

  async selectFrameDropdownbytagName(
    frame,
    tagName,
    elementName,
    option,
    pageScreen?
  ) {
    let txtElement: any;
    try {
      if (pageScreen !== undefined) {
        txtElement = await this.getFrameElement(frame, elementName, pageScreen);
      } else {
        txtElement = elementName;
      }
      await txtElement.click();
      if (option) {
        let optionElement = frame.locator(
          "//" + tagName + '[normalize-space(text())="' + option + '"]'
        );
        await optionElement.click();
      }
    } catch (err) {
      throw err;
    }
  }

  async getUniqueFildDataList(expectedSource, pageScreen) {
    let uniqueField;
    try {
      //Search app
      await action.ClickElement("search_datasources_textbox", pageScreen);
      await action.enterText(
        expectedSource,
        "search_datasources_textbox",
        pageScreen
      );
      //click on app
      let currentSource =
        '//div[contains(@class,"card-title") and contains(text(),"' +
        expectedSource +
        '")]';
      await page.click(currentSource);
      console.log(expectedSource + " is open now");
      uniqueField = await action.getText(
        "GetByIdParameter_DataLists",
        pageScreen
      );
      await action.ClickElement("leftArrow_DataLists", pageScreen);
    } catch (err) {
      throw err;
    }
    return uniqueField;
  }
  //
  async SelectOptionsMapping(triggerValues, pageScreen, elementName?) {
    await page.waitForTimeout(500);
    let txtElement;
    if (elementName !== undefined) {
      txtElement = await ScreenMap.get("onLoadTrigger").getSelector(
        elementName
      );
    } else {
      txtElement = await ScreenMap.get("onLoadTrigger").getSelector(
        "optionsMappingoption"
      );
    }

    let allOptions = await action.getElement(
      "optionsMappingAlloption",
      pageScreen
    );
    let optionsCount = await allOptions.count();
    console.log("optionsCount is " + optionsCount);
    for (let k = 0; k < optionsCount; k++) {
      await action.ClickElement(allOptions.nth(k));
      await page.waitForTimeout(500);
      let txtElementXpath = await txtElement.replace(
        "elementName",
        "" + triggerValues + ""
      );
      console.log("txtElementXpath is " + txtElementXpath);
      let exist = await page.isVisible(txtElementXpath).then(async (exist) => {
        return exist;
      });
      if (exist == true) {
        await action.ClickElement(page.locator(txtElementXpath));
        await page.waitForTimeout(500);
        break;
      }
    }
  }
  // Fill all the required fields for OnChangeAction
  async FillOnChangeAction(triggerValues, pageScreen) {
    await action.ClickElement("AddAction", pageScreen);
    await action.fillText(triggerValues.Title, "EventTitleInputbox", pageScreen);
    console.log("Title Entered");
    await page.waitForTimeout(500);
    await action.selectDropdownbytagName(
      "span",
      "OnChangeActionDropdown",
      triggerValues.OnChangeAction,
      pageScreen
    );
    console.log("OnChangeActionDropdown selected");
    await this.FillDataSourceConfig(triggerValues, pageScreen);
  }
  // Fill all the required fields for Input Configuration for a Drop down
  async FillInputOptionConfig(
    triggerValues,
    pageScreen,
    triggerField,
    triggerName
  ) {
    await action.ClickElement("AddoptionConfig", pageScreen);
    //Enter Trigger Title
    await action.fillText(triggerValues.Title, "EventTitleInputbox", pageScreen);
    console.log("Trigger Title Entered");
    await page.waitForTimeout(500);
    // Select Trigger
    let trigger = triggerField + " : " + triggerName;
    console.log(trigger);
    await action.selectDropdownbytagName(
      "span",
      "TriggerDropdown",
      trigger,
      pageScreen
    );
    console.log("Trigger Selected");
    // Select Option Label
    await action.ClickElement("OptionLabelDropdown", pageScreen);
    await this.selectOption("Array");
    await this.SelectOptionsMapping(triggerValues.OptionLabel, "onLoadTrigger");
    console.log("OptionLabelDropdown Selected");
    // Select Option Value
    await action.ClickElement("OptionValueDropdown", pageScreen);
    await this.selectOption("Array");
    await this.SelectOptionsMapping(triggerValues.OptionValue, "onLoadTrigger");
    console.log("OptionValueDropdown Selected");
    if (triggerValues.Defaultkey.length !== 0) {
      await action.ClickElement("DefaultKeyDropdown", pageScreen);
      await this.selectOption("Array");
      await this.SelectOptionsMapping(triggerValues.Defaultkey, "onLoadTrigger");
    }
  }

  // Fill all the required fields for button Event
  async FillOnButtonEvent(triggerValues, pageScreen) {
    await action.ClickElement("EventClickAction", pageScreen);
    await action.fillText(triggerValues.Title, "EventTitleInputbox", pageScreen);
    console.log("Title Entered");
    await page.waitForTimeout(500);
    await action.selectDropdownbytagName(
      "span",
      "EventClickActionInputbox",
      triggerValues.ClickAction,
      pageScreen
    );
    console.log("OnChangeActionDropdown selected");
    await this.FillDataSourceConfig(triggerValues, pageScreen);
  }
  //container onload
  async FillOnContainerEvent(triggerValues, pageScreen) {
    await action.ClickElement("EventAddConfig", pageScreen);
    await action.fillText(triggerValues.Title, "EventTitleInputbox", pageScreen);
    console.log("Title Entered as: " + triggerValues.Title);
    await page.waitForTimeout(500);
    await action.selectDropdownbytagName(
      "span",
      "EventClickActionInputbox",
      triggerValues.ClickAction,
      pageScreen
    );
    console.log("Click Action is " + triggerValues.ClickAction);
    await this.FillDataSourceConfig(triggerValues, pageScreen);
  }
  // Add column and response field/response path for an Advanced table
  async AddColumnforDataPopulation(triggerValues, pageScreen) {
    await page.waitForTimeout(500);
    console.log(triggerValues.length);
    for (let j = 0; j < triggerValues.length; j++) {
      console.log(
        "User add Column and Response path for " +
        triggerValues[j].Column +
        " field format as in " +
        pageScreen +
        " screen"
      );
      await action.ClickElement("Add Column", pageScreen);
      let columnelement = (
        await action.getElement("ColumnDropdown", pageScreen)
      ).nth(j);
      await columnelement.click();
      console.log("Column " + (j + 1) + " Clicked");

      let txtElement = await ScreenMap.get("onLoadTrigger").getSelector(
        "AddColumnoption"
      );
      let txtElementXpath = await txtElement.replace(
        "elementName",
        " " + triggerValues[j].Column + " "
      );
      let exist = await page.isVisible(txtElementXpath).then(async (exist) => {
        return exist;
      });
      console.log(
        "Looking for element " + triggerValues[j].Column + " is " + exist
      );
      if (exist == true) {
        await action.ClickElement(page.locator(txtElementXpath));
        await page.waitForTimeout(500);
      } else {
        let allOptions = page.locator("//div[@role='menuitem']//i");
        let optionsCount = await allOptions.count();
        for (let k = 0; k < optionsCount; k++) {
          await action.ClickElement(allOptions.nth(k));
          let exist = await page
            .isVisible(txtElementXpath)
            .then(async (exist) => {
              return exist;
            });
          console.log("Looking for element on second try " + exist);
          if (exist == true) {
            await action.ClickElement(page.locator(txtElementXpath));
            await page.waitForTimeout(500);
            break;
          } else if (exist == false) {
            let secondOptions = page.locator(
              "(//div[@role='menuitem']//i)[" +
              k +
              1 +
              "]/ancestor::div[contains(@id,'cdk-overlay')]/../following-sibling::div//i"
            );
            await action.ClickElement(secondOptions);
            await action.ClickElement(page.locator(txtElementXpath));
            break;
          }
        }
      }
      let responsePath = (
        await action.getElement("ResponsePathDropdown", pageScreen)
      ).nth(j);
      await responsePath.click();
      console.log("responsePath " + (j + 1) + " Clicked");
      await this.selectOption("Array", "ResponsePathoption");
      await this.SelectOptionsMapping(
        triggerValues[j].ResponsePath,
        "onLoadTrigger",
        "ResponsePathoption"
      );
    }
  }

  // Reusable code to fill Data Source
  async FillDataSourceConfig(triggerValues, pageScreen) {
    await action.selectDropdownbytagName(
      "span",
      "DataResourcesDropdown",
      triggerValues.DataResources,
      pageScreen
    );
    console.log(
      "DataResources Dropdown selected as " + triggerValues.DataResources
    );
    await page.waitForTimeout(2000);
    await action.ClickElement("DatalistDropdown", pageScreen);
    await page.waitForTimeout(2000);
    const dropdownValue = page.locator("//ul[@role='listbox']//li//span");
    let count = await dropdownValue.count();
    for (let i = 0; i < count; i++) {
      let actual = await dropdownValue.nth(i).textContent();
      if ((await actual.trim()) === triggerValues.DataList) {
        await page.keyboard.down("ArrowDown");
        await dropdownValue.nth(i).click();
        break;
      }
    }
    console.log("DatalistDropdown selected");
    //Fill Params Config details
    if (triggerValues.DataList.startsWith("Save")) {
      console.log("No need to fill Param Config Details");
    } else if (triggerValues.DataList.startsWith("Get All")) {
      console.log("No need to fill Param Config Details");
    } else if (
      triggerValues.DataList.startsWith("Get By Id") ||
      triggerValues.DataList.startsWith("Delete By Id") ||
      triggerValues.DataList.startsWith("Update By Id")
    ) {
      await page.waitForTimeout(2000);
      await action.selectDropdownbytagName(
        "span",
        "TypeDropdown",
        triggerValues.Type,
        pageScreen
      );
      console.log("Type selected");
      if (triggerValues.Type == "value") {
        let idInputLocator = await ScreenMap.get(pageScreen).getSelector(
          "IdInput"
        );
        let IdInput = idInputLocator.replace(
          "Id",
          process.env[triggerValues.uniqueField]
        );
        await action.fillText(
          triggerValues.uniqueFieldValue,
          IdInput,
          pageScreen
        );
      } else if (triggerValues.Type == "ref" || triggerValues.Type == "session") {
        let idInputLocator = await ScreenMap.get(pageScreen).getSelector(
          "IdDropdown"
        );
        let idInputXpath = idInputLocator.replace(
          "id",
          process.env[triggerValues.uniqueField]
        );
        let IdInput = await page.locator(idInputXpath);
        await action.selectDropdownbytagName(
          "span",
          IdInput,
          triggerValues.Value
        );
      }
    } else if (triggerValues.DataList.startsWith("Get By Filter")) {
      await action.selectDropdownbytagName(
        "span",
        "TypeDropdown",
        triggerValues.Type,
        pageScreen
      );
      if (triggerValues.Type == "value") {
        await action.fillText(triggerValues.Value, "FilterInput", pageScreen);
      } else if (triggerValues.Type == "ref" || triggerValues.Type == "session") {
        await action.selectDropdownbytagName(
          "span",
          "FilterDropdown",
          triggerValues.Value,
          pageScreen
        );
      }
    }
  }

  async SelectOptionsMappingforFOandBO(triggerValues, pageScreen, elementName?) {
    await page.waitForTimeout(500);
    let txtElement;
    if (elementName !== undefined) {
      txtElement = await ScreenMap.get("onLoadTrigger").getSelector(
        elementName
      );
    } else {
      txtElement = await ScreenMap.get("onLoadTrigger").getSelector(
        "optionsMappingoption"
      );
    }
    let txtElementXpath = await txtElement.replace(
      "elementName",
      triggerValues
    );
    let exist = await page.isVisible(txtElementXpath).then(async (exist) => {
      return exist;
    });
    console.log("Looking for element " + triggerValues + " is " + exist);
    if (exist == true) {
      await action.ClickElement(page.locator(txtElementXpath));
      await page.waitForTimeout(500);
    } else {
      let allOptions = page.locator("//div[@role='menuitem']//i");
      let optionsCount = await allOptions.count();
      console.log("optionsCount is " + optionsCount);
      for (let k = 0; k < optionsCount; k++) {
        await action.mouseHoverElement(allOptions.nth(k));
        let exist = await page
          .isVisible(txtElementXpath)
          .then(async (exist) => {
            return exist;
          });
        console.log("Looking for element on second try " + exist);
        if (exist == true) {
          await action.ClickElement(page.locator(txtElementXpath));
          await page.waitForTimeout(500);
          break;
        }
      }
    }
  }

  async FillEventConfiguration(triggerValues, triggerNo, pageScreen) {
    let i = triggerNo;
    //Enter name of the Trigger
    await page.waitForTimeout(500);
    let nameElement = await action.getElement("EventName", pageScreen);
    await action.enterText(triggerValues.EventName, await nameElement);
    console.log("Trigger name entered as: " + triggerValues.EventName);

    // Select Type
    let txtElement = await ScreenMap.get(pageScreen).getSelector("EventType");
    let typeElement = page.locator(
      txtElement.replace("EventName", triggerValues.EventName)
    );
    await action.selectDropdownbytagName(
      "span",
      typeElement,
      triggerValues.EventType
    );
    await page.waitForTimeout(500);
    console.log("Event selected as: " + triggerValues.EventType);

    //Select Widget
    let widgetPath = await ScreenMap.get(pageScreen).getSelector("EventWidget");
    widgetPath = page.locator(
      widgetPath.replace("EventName", triggerValues.EventName)
    );
    await action.ClickElement(widgetPath);
    // await transformation.SelectOptionsforUI(triggerValues.Widget, "EventConfigurations")
    let widgetOption  = page.locator("//li//div[contains(text(),'"+triggerValues.Widget+"')]");
    await widgetOption.hover();
    await widgetOption.click();
    await page.waitForTimeout(500);
    console.log("Selected Widget: " + triggerValues.Widget);
    // Select Data Source
    let dataSourceElement = await ScreenMap.get(pageScreen).getSelector(
      "EventDataSource"
    );
    dataSourceElement = page.locator(
      dataSourceElement.replace("EventName", triggerValues.EventName)
    );
    await action.selectDropdownbytagName(
      "span",
      await dataSourceElement,
      triggerValues.DataSource
    );
    console.log("DataSource selected as: " + triggerValues.DataSource);
    // Select Data List
    let dataListElement = await ScreenMap.get(pageScreen).getSelector(
      "EventDataList"
    );
    dataListElement = page.locator(
      dataListElement.replace("EventName", triggerValues.EventName)
    );

    console.log(await dataListElement.nth(i));
    await action.selectDropdownbytagName(
      "span",
      await dataListElement,
      triggerValues.DataList
    );
    process.env.RMDataList = triggerValues.DataList;
    console.log("Data List selected as: " + triggerValues.DataList);
    if (triggerValues.DataList.startsWith("Save") ||
      triggerValues.DataList.startsWith("Update") ||
      triggerValues.DataList.startsWith("Delete")) {
      let cogIcon = await ScreenMap.get(pageScreen).getSelector(
        "ServiceProviderCog"
      );
      await page
        .locator(cogIcon.replace("EventName", triggerValues.EventName))
        .click();
    } else if (triggerValues.DataList.startsWith("Get All")) {
      console.log("No need to fill Param Config Details");
    } else if (
      triggerValues.DataList.startsWith("Get By Id")
    ) {
      await page.waitForTimeout(500);
      // Select Type
      let txtElement = await ScreenMap.get(pageScreen).getSelector(
        "EventParamType"
      );
      let typeElement = page.locator(
        txtElement.replace("EventName", triggerValues.EventName)
      );
      await action.selectDropdownbytagName(
        "span",
        typeElement,
        triggerValues.Type
      );
      await page.waitForTimeout(500);
      console.log("Type selected as: " + triggerValues.Type);

      //Select uniqueField details
      if (triggerValues.Type == "value") {
        let inputLocator = await ScreenMap.get(pageScreen).getSelector(
          "paramUniqueFieldInputBox"
        );
        let IdInput = await page.locator(
          await inputLocator.replace(
            "EventName",
            triggerValues.EventName
          ).replace("uniqueField", process.env[triggerValues.uniqueField])
        );
        await action.enterText(triggerValues.uniqueFieldValue, IdInput);
      } else if (triggerValues.Type == "session") {
        let inputLocator = await ScreenMap.get(pageScreen).getSelector(
          "paramUniqueFieldDropdown"
        );
        let IdInputDropdown = await page.locator(
          await inputLocator.replace(
            "EventName",
            triggerValues.EventName
          ).replace("uniqueField", process.env[triggerValues.uniqueField])
        );
        console.log(IdInputDropdown);
        console.log(triggerValues.uniqueFieldValue);
        await action.selectDropdownbytagName(
          "span",
          await IdInputDropdown,
          triggerValues.uniqueFieldValue
        );
        console.log("Pin selected as " + triggerValues.uniqueFieldValue);
      } else if (triggerValues.Type == "ref") {
        let inputLocator = await ScreenMap.get(pageScreen).getSelector(
          "paramUniqueFieldInputBox"
        );
        let IdInputDropdown = await page.locator(
          await inputLocator.replace("elementName", triggerValues.EventName).replace(
            "uniqueField",
            process.env[triggerValues.UniqueField]
          )
        );
        await action.ClickElement(IdInputDropdown);
        // await transformation.SelectOptionsforUI(triggerValues.Value, "EventConfigurations")
        let widgetOption  = page.locator("//li//div[contains(text(),'"+triggerValues.Value+"')]");
       await widgetOption.hover();
       await widgetOption.click();
       await page.waitForTimeout(500);
       console.log("Selected: " + triggerValues.Value);
      }
      let cogIcon = await ScreenMap.get(pageScreen).getSelector(
        "ResponseMappingCog"
      );
      await page
        .locator(cogIcon.replace("EventName", triggerValues.EventName))
        .click();
      console.log("Cog icon clicked for event " +triggerValues.EventName)
    }
    await page.waitForTimeout(2000);
  }

  async FillEventConfigOptionMapping(triggerValues, triggerNo, noOfOptionMapping, pageScreen) {
    let i = triggerNo;
    //Enter name of the Trigger
    await page.waitForTimeout(500);
    let nameElement = await action.getElement("EventName", pageScreen);
    await action.enterText(triggerValues.EventName, await nameElement);
    console.log("Trigger name entered as: " + triggerValues.EventName);

    // Select Type
    let txtElement = await ScreenMap.get(pageScreen).getSelector("EventType");
    let typeElement = page.locator(
      txtElement.replace("EventName", triggerValues.EventName)
    );
    await action.selectDropdownbytagName(
      "span",
      typeElement,
      triggerValues.EventType
    );
    await page.waitForTimeout(500);
    console.log("Event selected as: " + triggerValues.EventType);

    //Select Widget
    let widgetPath = await ScreenMap.get(pageScreen).getSelector("EventWidget");
    widgetPath = page.locator(
      widgetPath.replace("EventName", triggerValues.EventName)
    );
    await action.ClickElement(widgetPath);
    await transformation.SelectOptionsforUI(triggerValues.Widget, "EventConfigurations")
    // Select Data Source
    let dataSourceElement = await ScreenMap.get(pageScreen).getSelector(
      "EventDataSource"
    );
    dataSourceElement = page.locator(
      dataSourceElement.replace("EventName", triggerValues.EventName)
    );
    await action.selectDropdownbytagName(
      "span",
      await dataSourceElement,
      triggerValues.DataSource
    );
    console.log("DataSource selected as: " + triggerValues.DataSource);
    // Select Data List
    let dataListElement = await ScreenMap.get(pageScreen).getSelector(
      "EventDataList"
    );
    dataListElement = page.locator(
      dataListElement.replace("EventName", triggerValues.EventName)
    );

    console.log(await dataListElement.nth(i));
    await action.selectDropdownbytagName(
      "span",
      await dataListElement,
      triggerValues.DataList
    );
    process.env.RMDataList = triggerValues.DataList;
    console.log("Data List selected as: " + triggerValues.DataList);
    if (triggerValues.DataList.startsWith("Save")) {
      let cogIcon = await ScreenMap.get(pageScreen).getSelector(
        "ServiceProviderCog"
      );
      await page
        .locator(cogIcon.replace("EventName", triggerValues.EventName))
        .click();
    } else if (triggerValues.DataList.startsWith("Get All")) {
      console.log("No need to fill Param Config Details");
    } else if (
      triggerValues.DataList.startsWith("Get By Id") ||
      triggerValues.DataList.startsWith("Delete By Id") ||
      triggerValues.DataList.startsWith("Update By Id") ||
      triggerValues.DataList.startsWith("Get By Filter Field")
    ) {
      // Select Type
      let txtElement = await ScreenMap.get(pageScreen).getSelector(
        "EventParamType"
      );
      let typeElement = page.locator(
        txtElement.replace("EventName", triggerValues.EventName)
      );
      await action.selectDropdownbytagName(
        "span",
        typeElement,
        triggerValues.Type
      );
      await page.waitForTimeout(500);
      console.log("Type selected as:" + triggerValues.Type);

      //Select uniqueField details
      if (triggerValues.Type == "value") {
        let inputLocator = await ScreenMap.get(pageScreen).getSelector(
          "paramUniqueFieldInputBox"
        );
        let IdInput = await page.locator(
          await inputLocator.replace(
            "EventName",
            triggerValues.EventName
          ).replace("uniqueField", process.env[triggerValues.uniqueField])
        );
        await action.enterText(triggerValues.uniqueFieldValue, IdInput);
      } else if (triggerValues.Type == "session") {
        let inputLocator = await ScreenMap.get(pageScreen).getSelector(
          "paramUniqueFieldDropdown"
        );
        let IdInputDropdown = await page.locator(
          await inputLocator.replace(
            "EventName",
            triggerValues.EventName
          ).replace("uniqueField", process.env[triggerValues.uniqueField])
        );
        console.log(IdInputDropdown);
        console.log(triggerValues.uniqueFieldValue);
        await action.selectDropdownbytagName(
          "span",
          await IdInputDropdown,
          triggerValues.uniqueFieldValue
        );
        console.log("Pin selected as " + triggerValues.uniqueFieldValue);
        //Select Pin
      } else if (triggerValues.Type == "ref") {
        let ParamPinPath
        if (
          triggerValues.DataList.startsWith("Get By Filter Field")) {
          ParamPinPath = await ScreenMap.get(pageScreen).getSelector(
            "EventParamFilter")
        } else {
          ParamPinPath = await ScreenMap.get(pageScreen).getSelector(
            "EventParamPinInput"
          );
        }
        ParamPinPath = page.locator(
          ParamPinPath.replace("EventName", triggerValues.EventName)
        );
        await action.ClickElement(ParamPinPath);
        await transformation.SelectOptionsforUI(triggerValues.paramValue, "EventConfigurations")
      }
    }
    for (let k = 0; k < noOfOptionMapping; k++) {
      // Click on Options mapping plus icon
      let plusIconXpath = await ScreenMap.get("onLoadTrigger").getSelector(
        "optionsMappingPlusIcon"
      );
      let plusIconElement = await page.locator(
        await plusIconXpath.replace("elementName", triggerValues.EventName)
      );
      await action.ClickElement(plusIconElement);

      await page.waitForTimeout(500);
      console.log("Options Mapping plus Icon selected");
      // Select Field
      let fieldElementXpath = await ScreenMap.get("onLoadTrigger").getSelector(
        "field"
      );
      let fieldElement = await page.locator(
        await fieldElementXpath.replace("elementName", triggerValues.EventName)
      );
      await action.ClickElement(fieldElement.nth(k));
      await this.SelectOptionsMappingforFOandBO(
        triggerValues[`Field${k + 1}`],
        "onLoadTrigger"
      );
      console.log("field " + triggerValues[`Field${k + 1}`] + "selected");

      // Select Label
      let labelElementXpath = await ScreenMap.get("onLoadTrigger").getSelector(
        "label"
      );
      let labelElement = await page.locator(
        await labelElementXpath.replace("elementName", triggerValues.EventName)
      );
      await action.ClickElement(labelElement.nth(k));
      if (
        triggerValues.DataList.startsWith("Save") ||
        triggerValues.DataList.startsWith("Get All") || triggerValues.DataList.startsWith("Get By Filter")
      ) {
        await this.selectOption("root");
        await this.selectOption("array element of root");
      }
      await this.SelectOptionsMappingforFOandBO(
        triggerValues[`Label${k + 1}`],
        "onLoadTrigger"
      );
      console.log("Label " + triggerValues[`Label${k + 1}`] + " selected");

      // Select value
      let valueElementXpath = await ScreenMap.get("onLoadTrigger").getSelector(
        "value"
      );
      let valueElement = await page.locator(
        await valueElementXpath.replace("elementName", triggerValues.EventName)
      );
      await action.ClickElement(valueElement.nth(k));
      if (
        triggerValues.DataList.startsWith("Save") ||
        triggerValues.DataList.startsWith("Get All") || triggerValues.DataList.startsWith("Get By Filter")
      ) {
        await this.selectOption("root");
        await this.selectOption("array element of root");
      }
      await this.SelectOptionsMappingforFOandBO(
        triggerValues[`Value${k + 1}`],
        "onLoadTrigger"
      );
      console.log("value " + triggerValues[`Value${k + 1}`] + " selected");
      if (triggerValues[`DefaultKey${k + 1}`]) {
        // Select DefaultKey
        let delfaultElementXpath = await ScreenMap.get("onLoadTrigger").getSelector(
          "defaultKey"
        );
        let defaultElement = await page.locator(
          await delfaultElementXpath.replace("elementName", triggerValues.EventName)
        );
        await action.ClickElement(defaultElement.nth(k));
        if (
          triggerValues.DataList.startsWith("Save") ||
          triggerValues.DataList.startsWith("Get All") || triggerValues.DataList.startsWith("Get By Filter")
        ) {
          await this.selectOption("root");
          await this.selectOption("array element of root");
        }
        await this.SelectOptionsMappingforFOandBO(
          triggerValues[`Value${k + 1}`],
          pageScreen
        );
        console.log("field " + triggerValues[`DefaultKey${k + 1}`] + "selected");
      }
      // Select DefaultValue
      if (triggerValues[`Defaultvalue${k + 1}`]) {
        let valueElementXpath = await ScreenMap.get(pageScreen).getSelector(
          "defaultValue"
        );
        let valueElement = await page.locator(
          await valueElementXpath.replace("elementName", triggerValues.EventName)
        );
        await valueElement.fill(triggerValues[`Defaultvalue${k + 1}`])
      }
    }
    await page.waitForTimeout(2000);
    let save = await ScreenMap.get(pageScreen).getSelector("Save")
    let triggerSave = await page.locator(save.replace("EventName", triggerValues.EventName));
    await triggerSave.click();
    await assertions.ContainText('Success', pageScreen, 'Success')
    await page.waitForTimeout(500);
  }

  async OnchangeOptionMapping(triggerValues, triggerNo, noOfOptionMapping, pageScreen) {
    let i = triggerNo;
    //Enter name of the Trigger
    await page.waitForTimeout(500);
    let nameElement = await action.getElement("EventName", pageScreen);
    await action.enterText(triggerValues.EventName, await nameElement);
    console.log("Trigger name entered as: " + triggerValues.EventName);

    // Select Type
    let txtElement = await ScreenMap.get(pageScreen).getSelector("EventType");
    let typeElement = page.locator(
      txtElement.replace("EventName", triggerValues.EventName)
    );
    await action.selectDropdownbytagName(
      "span",
      typeElement,
      triggerValues.EventType
    );
    await page.waitForTimeout(500);
    console.log("Event selected as: " + triggerValues.EventType);

    //Select Widget
    let widgetPath = await ScreenMap.get(pageScreen).getSelector("EventWidget");
    widgetPath = page.locator(
      widgetPath.replace("EventName", triggerValues.EventName)
    );
    await action.ClickElement(widgetPath);
    // await transformation.SelectOptionsforUI(triggerValues.Widget, "EventConfigurations")
    let widgetOption  = page.locator("//li//div[contains(text(),'"+triggerValues.Widget+"')]");
    await widgetOption.hover();
    await widgetOption.click();
    await page.waitForTimeout(500);
    console.log("Selected Widget: " + triggerValues.Widget);
    // Select Data Source
    let dataSourceElement = await ScreenMap.get(pageScreen).getSelector(
      "EventDataSource"
    );
    dataSourceElement = page.locator(
      dataSourceElement.replace("EventName", triggerValues.EventName)
    );
    await action.selectDropdownbytagName(
      "span",
      await dataSourceElement,
      triggerValues.DataSource
    );
    console.log("DataSource selected as: " + triggerValues.DataSource);
    // Select Data List
    let dataListElement = await ScreenMap.get(pageScreen).getSelector(
      "EventDataList"
    );
    dataListElement = page.locator(
      dataListElement.replace("EventName", triggerValues.EventName)
    );

    console.log(await dataListElement.nth(i));
    await action.selectDropdownbytagName(
      "span",
      await dataListElement,
      triggerValues.DataList
    );
    process.env.RMDataList = triggerValues.DataList;
    console.log("Data List selected as: " + triggerValues.DataList);
    if (triggerValues.DataList.startsWith("Save")) {
      let cogIcon = await ScreenMap.get(pageScreen).getSelector(
        "ServiceProviderCog"
      );
      await page
        .locator(cogIcon.replace("EventName", triggerValues.EventName))
        .click();
    } else if (triggerValues.DataList.startsWith("Get All")) {
      console.log("No need to fill Param Config Details");
    } else if (
      triggerValues.DataList.startsWith("Get By Id") ||
      triggerValues.DataList.startsWith("Delete By Id") ||
      triggerValues.DataList.startsWith("Update By Id") ||
      triggerValues.DataList.startsWith("Get By Filter Field")
    ) {
      // Select Type
      let txtElement = await ScreenMap.get(pageScreen).getSelector(
        "EventParamType"
      );
      let typeElement = page.locator(
        txtElement.replace("EventName", triggerValues.EventName)
      );
      await action.selectDropdownbytagName(
        "span",
        typeElement,
        triggerValues.Type
      );
      await page.waitForTimeout(500);
      console.log("Type selected as:" + triggerValues.Type);

      //Select uniqueField details
      if (triggerValues.Type == "value") {
        let inputLocator = await ScreenMap.get(pageScreen).getSelector(
          "paramUniqueFieldInputBox"
        );
        let IdInput = await page.locator(
          await inputLocator.replace(
            "EventName",
            triggerValues.EventName
          ).replace("uniqueField", process.env[triggerValues.uniqueField])
        );
        await action.enterText(triggerValues.uniqueFieldValue, IdInput);
      } else if (triggerValues.Type == "session") {
        let inputLocator = await ScreenMap.get(pageScreen).getSelector(
          "paramUniqueFieldDropdown"
        );
        let IdInputDropdown = await page.locator(
          await inputLocator.replace(
            "EventName",
            triggerValues.EventName
          ).replace("uniqueField", process.env[triggerValues.uniqueField])
        );
        console.log(IdInputDropdown);
        console.log(triggerValues.uniqueFieldValue);
        await action.selectDropdownbytagName(
          "span",
          await IdInputDropdown,
          triggerValues.uniqueFieldValue
        );
        console.log("Pin selected as " + triggerValues.uniqueFieldValue);
        //Select Pin
      } else if (triggerValues.Type == "ref") {
        let ParamPinPath
        if (
          triggerValues.DataList.startsWith("Get By Filter Field")) {
          ParamPinPath = await ScreenMap.get(pageScreen).getSelector(
            "EventParamFilter")
        } else {
          ParamPinPath = await ScreenMap.get(pageScreen).getSelector(
            "EventParamPinInput"
          );
        }
        ParamPinPath = page.locator(
          ParamPinPath.replace("EventName", triggerValues.EventName)
        );
        await action.ClickElement(ParamPinPath);
        // await transformation.SelectOptionsforUI(triggerValues.paramValue, "EventConfigurations")
        let widgetOption  = page.locator("//li//div[contains(text(),'"+triggerValues.paramValue+"')]");
        await widgetOption.hover();
        await widgetOption.click();
        await page.waitForTimeout(500);
        console.log("Selected: " + triggerValues.paramValue);
      }
    }
    // Click on Response mapping settings icon
    let iconXpath = await ScreenMap.get(pageScreen).getSelector(
      "responseMappingSettingsIcon"
    );
    let cogIcon = page.locator(
      iconXpath.replace("elementName", triggerValues.EventName)
    );
    console.log(await cogIcon);
    await action.ClickElement(await cogIcon);
    await page.waitForTimeout(3000);
    await page.waitForLoadState("networkidle", { timeout: 60000 });
    for (let k = 0; k < noOfOptionMapping; k++) {
      await this.optionMapping(noOfOptionMapping, triggerValues, "expressionBuilder");
    }
  }

  async RootKey(triggerValues, pageScreen, i) {

    let getKey = await ScreenMap.get(pageScreen).getSelector("GetKey");
    let labelValueDrop = await ScreenMap.get(pageScreen).getSelector("LabelValueDropField");
    await action.ClickElement("LabelRefFieldDelete", pageScreen);
    await page.dragAndDrop(getKey, labelValueDrop);
    await action.ClickElement("ValueRefFieldDelete", pageScreen);
    await page.dragAndDrop(getKey, labelValueDrop);
    //SelectRootLabel
    if (triggerValues["RootKey" + i].indexOf("->") == -1) {
      await action.selectDropdownbyspantext("refDropDown", pageScreen, triggerValues["Ref" + i])
      await this.selectOLTOptions(triggerValues, triggerValues["RootKey" + i], pageScreen)
    }
    else {
      await action.selectDropdownbyspantext("refDropDown", pageScreen, triggerValues["Ref" + i])
      await action.ClickElement("SourceDropdown", pageScreen);
      await this.selectNestedElement(triggerValues["RootKey" + i], pageScreen)
    }
    console.log("RootLabel " + triggerValues["RootKey" + i] + " selected");
    //SelectLabel
    await page.waitForTimeout(500)
    if (triggerValues["Label" + i].indexOf("->") == -1) {
      await this.selectOLTOptions(triggerValues, triggerValues["Label" + i], pageScreen)
    }
    else {
      await action.ClickElement("SourceDropdown", pageScreen);
      await this.selectNestedElement(triggerValues["Label" + i], pageScreen)
    }
    console.log("Label " + triggerValues["Label" + i] + " selected");
    let dropfield = await action.getElement('condition expression', pageScreen)
    await dropfield.scrollIntoViewIfNeeded();
    //SelectRootValue
    if (triggerValues["RootKey" + i].indexOf("->") == -1) {
      await action.selectDropdownbyspantext("refDropDown", pageScreen, triggerValues["Ref" + i])
      await this.selectOLTOptions(triggerValues, triggerValues["RootKey" + i], pageScreen)
    }
    else {
      await action.selectDropdownbyspantext("refDropDown", pageScreen, triggerValues["Ref" + i])
      await action.ClickElement("SourceDropdown", pageScreen);
      await this.selectNestedElement(triggerValues["RootKey" + i], pageScreen)
    }
    console.log("RootValue " + triggerValues["RootKey" + i] + " selected");
    //Select Value
    await page.waitForTimeout(500)
    if (triggerValues["Value" + i].indexOf("->") == -1) {
      await this.selectOLTOptions(triggerValues, triggerValues["Value" + i], pageScreen)
    }
    else {
      await action.ClickElement("SourceDropdown", pageScreen);
      await this.selectNestedElement(triggerValues["Value" + i], pageScreen)
    }
  }

  async optionMapping(noOfoptionsmapping, triggerValues, pageScreen) {
    console.log("Option mapping will created");
    await page.waitForTimeout(2000)
    for (let i = 1; i <= noOfoptionsmapping; i++) {
      await action.ClickElement("addRuleButton", pageScreen);
      console.log("No of OptionMapping is " + noOfoptionsmapping);
      await action.enterText(triggerValues["Rule" + i], "Name", pageScreen);
      let loops = await ScreenMap.get(pageScreen).getElement("Loops");
      await action.ClickElement(loops);
      let createOptions = await ScreenMap.get(pageScreen).getSelector("Create Options");
      let expression = await ScreenMap.get(pageScreen).getSelector("condition expression");
      await action.dragAndDropwithoutAxis(createOptions, expression);
      let operand = await ScreenMap.get(pageScreen).getElement("Operands");
      await action.ClickElement(operand);
      console.log("The operator is :Create option");
      let destinationField = await ScreenMap.get(pageScreen).getSelector("DestinationField");
      let sourceField = await ScreenMap.get(pageScreen).getSelector("SourceField");
      let forEachDropField = await ScreenMap.get(pageScreen).getSelector("ForEachDropField");
      await action.dragAndDropwithoutAxis(sourceField, forEachDropField);
      await page.waitForTimeout(500);
      await action.ClickElement(loops);
      let getKey = await ScreenMap.get(pageScreen).getSelector("GetKey");
      let labelValueDrop = await ScreenMap.get(pageScreen).getSelector("LabelValueDropField");
      console.log("GETKEY operation is dropped in label and value")
      //Fill ref value
      let forVar = await page.locator("//div[text()=' FOR_EACH ']/../..//div[@class='expression']//input[@placeholder='Enter value']")
      await forVar.fill(triggerValues["Ref" + i]);
      console.log(triggerValues["Ref" + i] + " string constant value entered")
      await action.ClickElement("SourceDropdown", pageScreen);
      if (triggerValues.SourceOption) {
        if (triggerValues.SourceOption.indexOf("->") != -1) {
          await this.selectNestedElement(triggerValues.SourceOption, pageScreen)
        }
      }
      else {
        await action.mouseHoverElement('application', pageScreen)
        await action.ClickElement('root', pageScreen);
        await page.waitForTimeout(500);

      }
      //PopulateDropDown Options
      await action.ClickElement("PayloadDropdown", pageScreen);
      // await action.mouseHoverElement('application', 'transformation')
      await transformation.SelectOptionsforUI(triggerValues["Field" + i], pageScreen)
      await page.waitForTimeout(500);
      console.log("selected payload field is " + triggerValues["Field" + i]);
      let dropfield = await action.getElement('condition expression', pageScreen)
      await dropfield.scrollIntoViewIfNeeded();
      //If NestedKey
      if (triggerValues["RootKey" + i]) {
        await this.RootKey(triggerValues, pageScreen, i);
      } else {
        //SelectLabel
        await page.waitForTimeout(500)
        if (triggerValues["Label" + i].indexOf("->") == -1) {
          await action.selectDropdownbyspantext("refDropDown", pageScreen, triggerValues["Ref" + i])
          await this.selectOLTOptions(triggerValues, triggerValues["Label" + i], pageScreen)
        }
        else {
          await action.selectDropdownbyspantext("refDropDown", pageScreen, triggerValues["Ref" + i])
          await action.ClickElement("SourceDropdown", pageScreen);
          await this.selectNestedElement(triggerValues["Label" + i], pageScreen)
        }
        console.log("Label " + triggerValues["Label" + i] + " selected");
        await page.waitForTimeout(500);
        //Value
        await page.waitForTimeout(500)
        if (triggerValues["Value" + i].indexOf("->") == -1) {
          await action.selectDropdownbyspantext("refDropDown", pageScreen, triggerValues["Ref" + i])
          await this.selectOLTOptions(triggerValues, triggerValues["Value" + i], pageScreen)
        }
        else {
          await action.selectDropdownbyspantext("refDropDown", pageScreen, triggerValues["Ref" + i])
          await action.ClickElement("SourceDropdown", pageScreen);
          await this.selectNestedElement(triggerValues["Value" + i], pageScreen)
        }
      }
      console.log("Value " + triggerValues["Value" + i] + " selected");
      await page.waitForTimeout(500);
      //Default value annd key
      if (triggerValues["DefaultValue" + i]) {
        let stringConst = await ScreenMap.get(pageScreen).getSelector("String Constant");
        let compare = await ScreenMap.get(pageScreen).getElement("Compare");
        await action.ClickElement(compare);
        let Assign = await ScreenMap.get(pageScreen).getSelector("Assign");
        let dropfield = await action.getElement('condition expression', pageScreen);
        await dropfield.scrollIntoViewIfNeeded();
        await action.dragAndDropwithoutAxis(Assign, labelValueDrop);
        await action.ClickElement(operand);
        await dropfield.scrollIntoViewIfNeeded();
        await page.dragAndDrop(destinationField, forEachDropField);
        await page.dragAndDrop(stringConst, forEachDropField);
        await action.ClickElement("PayloadDropdown", pageScreen);
        await action.mouseHoverElement('application', pageScreen)
        await transformation.SelectOptionsforUI(triggerValues["Field" + i], pageScreen)
        console.log("The default field is " + triggerValues["Field" + i]);
        await page.waitForTimeout(500);
        //Default Value
        await action.enterText(triggerValues["DefaultValue" + i], "StringConstant", pageScreen);
      }
      console.log("Value " + triggerValues["Value" + i] + " selected");
      await action.ClickElement('RuleSave', pageScreen);
      await page.waitForSelector(await ScreenMap.get("transformation").getSelector("Success"), { state: 'hidden', timeout: 60000 });
      await page.waitForTimeout(5000);
    }
    await action.ClickElement('Close', pageScreen);
    await page.waitForSelector(await ScreenMap.get("transformation").getSelector("Success"), { state: 'hidden', timeout: 60000 });
    await page.waitForTimeout(2000);
    console.log('Mapping Saved and Transformations UI has been closed');
  }

  async getChildJsonkey(jsonObject, keyTosearch) {
    for (var key in jsonObject) {
      if (jsonObject[key] instanceof Object) {
        let keyValue = await this.getChildJsonkey(jsonObject[key], keyTosearch)
        if (keyValue !== null) {
          return keyValue;
        }
      }
      if (key == keyTosearch) {
        return jsonObject[key];
      }
    }
    return null;
  }

  async selectNestedElement(triggerValue, pageScreen) {
    const destElements = (triggerValue).split("->")
    for (let i = 0; i < await destElements.length; i++) {
      const destElement = destElements[i];
      console.log("element" + i + "is " + destElement)
      let fieldxpath = await ScreenMap.get(pageScreen).getSelector("options");
      let field = page.locator(
        fieldxpath.replace("elementName", destElement)
      );
      console.log(field)
      await action.mouseHoverElement(field);
      if (i == (destElements.length - 1)) {
        await action.ClickElement(field);
      }
    }
  }

  async selectOLTOptions(triggerValues, expectedText, pageScreen) {
    await action.ClickElement("SourceDropdown", pageScreen);
    await this.selectOption(triggerValues.DataList, "NewoptionsMappingoption");
    await this.selectOption("root", "NewoptionsMappingoption");
    await this.selectOption("array element of root", "NewoptionsMappingoption");
    await transformation.SelectOptionsfromDropdown(expectedText, "array element of root", "expressionBuilder")
  }
}




