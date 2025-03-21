import { ScreenMap } from "../Utility/Source/Core";
import { page } from "../steps/world";
import { Actions } from "../Utility/Util/Actions";

let action: Actions = new Actions();

export class NewTransformationUI {

  async SelectOptionsforUI(triggervals, pageScreen) {
    await page.waitForTimeout(500);
    let selectElement;
    let exist

    // selectElement = await this.SelectOptionsfromsystemfields(triggervals, pageScreen)
    let fodropdown = await ScreenMap.get(pageScreen).getSelector("Single_Screen_Payload");
    exist = await page.isVisible(fodropdown).then(async (eleexist) => {
      return eleexist;
    })
    if (exist == true) {
      await action.mouseHoverElement('Single_Screen_Payload', pageScreen)
      selectElement = await this.SelectOptionsfromDropdown(triggervals, 'Single_Screen_Payload', pageScreen)
    }
    if (selectElement !== true) {
      console.log("selecting a Back Office field")
      let bodropdown = await ScreenMap.get(pageScreen).getSelector("Back_Office_Fields");
      exist = await page.isVisible(bodropdown).then(async (eleexist) => {
        return eleexist;
      })
      if (exist == true) {
        await action.mouseHoverElement('Back_Office_Fields', pageScreen)
        selectElement = await this.SelectOptionsfromDropdown(triggervals, 'Back_Office_Fields', pageScreen)
      }
    }
    if (selectElement !== true) {
      console.log("system fields")
      let systemdropdown = await ScreenMap.get(pageScreen).getSelector("System_Fields");
      exist = await page.isVisible(systemdropdown).then(async (eleexist) => {
        return eleexist;
      })
      if (exist == true) {
        await action.mouseHoverElement('System_Fields', pageScreen)
        selectElement = await this.SelectOptionsfromDropdown(triggervals, 'System_Fields', pageScreen)
      }
    }
  }

  async SelectOptionsforAPI(configurevals, UniqueField, pageScreen) {
    // await action.ClickElement('API', pageScreen)
    if (process.env.DataList.startsWith('Save')) {
      await action.mouseHoverElement('Request', pageScreen)
      await action.mouseHoverElement('root', pageScreen);
      await this.SelectOptionsfromDropdown(configurevals, 'root', pageScreen)
    }
    else if (process.env.DataList.startsWith('Delete')) {
      await action.mouseHoverElement('Parameters', pageScreen)
      await this.SelectOptionsfromDropdown(configurevals, 'Parameters', pageScreen)
    }
    else if (process.env.DataList.startsWith('Update') || process.env.DataList.startsWith('Get')) {
      if (UniqueField == 'Yes') {
        await action.mouseHoverElement('Parameters', pageScreen)
        await this.SelectOptionsfromDropdown(configurevals, 'Parameters', pageScreen)
      }
      else {
        await action.mouseHoverElement('Request', pageScreen)
        await action.mouseHoverElement('root', pageScreen);
        await this.SelectOptionsfromDropdown(configurevals, 'root', pageScreen)
      }
    }

  }

  async SelectOptionsforDb(configurevals, UniqueField, pageScreen) {
    // await action.ClickElement('API', pageScreen)
    if (process.env.RMDataList.startsWith('Save')) {
      await action.mouseHoverElement('Parameters', pageScreen)
      await this.SelectOptionsfromDropdown(configurevals, 'Parameters', pageScreen)
    }
    else if (process.env.RMDataList.startsWith('Delete')) {
      await action.mouseHoverElement('Parameters', pageScreen)
      await this.SelectOptionsfromDropdown(configurevals, 'Parameters', pageScreen)
    }
    else if (process.env.RMDataList.startsWith('Update')) {

        await action.mouseHoverElement('Parameters', pageScreen)
        await this.SelectOptionsfromDropdown(configurevals, 'Parameters', pageScreen)
    }

  }


  async SelectOptionsfromsystemfields(triggervals, pageScreen) {
    await page.waitForTimeout(500);
    await action.ClickElement('System_Fields', pageScreen)
    let txtElement;
    txtElement = await ScreenMap.get(pageScreen).getSelector(
      "options"
    );
    let txtElementXpath = await txtElement.replace(
      "elementName", triggervals
    );
    let exist = await page.isVisible(txtElementXpath).then(async (exist) => {
      return exist;
    });
    let selectElement;
    console.log("Looking for element " + triggervals + " is " + exist);
    if (exist == true) {
      await action.ClickElement(page.locator(txtElementXpath));
      await page.waitForTimeout(500);
      selectElement = true;
    } else {
      selectElement = false;
    }
    return selectElement;
  }
  async SelectOptionsfromDropdown(triggervals, elementName, pageScreen) {
    await page.waitForTimeout(500);
    let selectElement;
    let txtElement;

    txtElement = await ScreenMap.get(pageScreen).getSelector(
      "options"
    );

    let txtElementXpath = await txtElement.replace(
      "elementName", triggervals
    );
    let exist = await page.isVisible(txtElementXpath).then(async (exist) => {
      return exist;
    });
    console.log("Looking for element " + triggervals + " is " + exist);
    if (exist == true) {
      await action.ClickElement(page.locator(txtElementXpath));
      await page.waitForTimeout(500);
      selectElement = true;
    } else {
      let allOptions = page.locator("//div[normalize-space(text())='" + elementName + "']/ancestor::div[contains(@class,'dk-overlay-connected')]/following-sibling::div//i[contains(@class,'pi-angle-right')]");
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
          selectElement = true;
          break;
        }
        else {
          selectElement=await this.selectGivenOptions(elementName,txtElementXpath)
        }
        if(selectElement== true){
          break;
        }
      }
    }
    return selectElement;
  }

  async DragandDropFieldsforTransformationUI(Input, iterateNo, pageScreen) {
    // drag and drop Assign operator
    await action.ClickElement("Compare", pageScreen)
    await page.waitForTimeout(500);
    let operatorLocator = await ScreenMap.get(pageScreen).getSelector(
      "Assign"
    );
    let Rulebody = await ScreenMap.get(pageScreen).getSelector(
      "Rule body"
    );
    let Rulebodyloc = await page.locator(Rulebody)
    await Rulebodyloc.scrollIntoViewIfNeeded();
    await page.dragAndDrop(operatorLocator, Rulebody)
    await page.waitForTimeout(2000);
    console.log("Assign operator dropped successfully for " + Input)

    // drag and drop Destination field
    await action.ClickElement("Operands", pageScreen)
    let DestinationFieldsdrop = "(//div[@class='operation-area']//div[contains(normalize-space(text()),'Drop')])[1]"
    //  console.log(DestinationFieldsdrop)
    let DestinationFieldsdrag = await ScreenMap.get(pageScreen).getSelector(
      "Destination Fields"
    );

    let DestinationFieldsdroploc = page.locator(DestinationFieldsdrop)
    await DestinationFieldsdroploc.scrollIntoViewIfNeeded();
    await page.dragAndDrop(DestinationFieldsdrag, DestinationFieldsdrop)
    console.log("Destination field dropped successfully for " + Input)
    // drag and drop source field
    let SourceFieldsdrag = await ScreenMap.get(pageScreen).getSelector(
      "Source Fields"
    );
    await page.dragAndDrop(SourceFieldsdrag, DestinationFieldsdrop)
    console.log("Source field dropped successfully for " + Input)
  }

  async SelectOptions(triggervals,pageScreen) {
    await page.waitForTimeout(500);
    let selectElement;
    let txtElement;

    txtElement = await ScreenMap.get(pageScreen).getSelector(
      "options"
    );

    let txtElementXpath = await txtElement.replace(
      "elementName", triggervals
    );
    let exist = await page.isVisible(txtElementXpath).then(async (exist) => {
      return exist;
    });
    console.log("Looking for element " + triggervals + " is " + exist);
    if (exist == true) {
      await action.ClickElement(page.locator(txtElementXpath));
      await page.waitForTimeout(500);
      selectElement = true;
    } else {
      let allOptions = page.locator("//div//i[contains(@class,'pi-angle-right')]");
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
          selectElement = true;
          break;
        }
        // else {
        //   let allOptions2 = page.locator("//div//i[contains(@class,'pi-angle-right')]");
        //   let optionsCount2 = await allOptions2.count();
        //   console.log("Inner optionsCount is " + optionsCount2);
        //   for (let i = 0; i < optionsCount2; i++) {
        //     await action.mouseHoverElement(allOptions2.nth(i));
        //     let exist1 = await page
        //       .isVisible(txtElementXpath)
        //       .then(async (exist1) => {
        //         return exist1;
        //       });
        //     console.log("Looking for element on second try " + exist);
        //     if (exist1 == true) {
        //       await action.ClickElement(page.locator(txtElementXpath));
        //       await page.waitForTimeout(500);
        //       selectElement = true;
        //       break;
        //     }
        //     else {
        //       selectElement = false;
        //     }
        //   }
        // }
      }
    }
    // return selectElement;
  }
  async selectGivenOptions(elementName,txtElementXpath) {
    let selectElement;
    let allOptions = page.locator("//div[normalize-space(text())='" + elementName + "']/ancestor::div[contains(@class,'dk-overlay-connected')]/following-sibling::div//i[contains(@class,'pi-angle-right')]");
    let optionsCount = await allOptions.count();
    console.log("optionsCount is " + optionsCount);
    for (let k = 1; k < optionsCount; k++) {
      await action.mouseHoverElement(allOptions.nth(k));
      let exist = await page
        .isVisible(txtElementXpath)
        .then(async (exist) => {
          return exist;
        });
      console.log("Looking for element on third try " + exist);
      if (exist == true) {
        console.log("inside third block true")
        await action.ClickElement(page.locator(txtElementXpath));
        await page.waitForTimeout(500);
        selectElement = true;
        break;
      }
      else {
        console.log("inside third block else")
        selectElement = false;
      }
    }
    return selectElement;
  }

  async SelectOptionsforServiceProvider(configurevals, UniqueField, pageScreen) {
    await action.mouseHoverElement('API', pageScreen)
    if (process.env.RMDataList.startsWith('Save')) {
      await action.mouseHoverElement('Request', pageScreen)
      await action.mouseHoverElement('root', pageScreen);
      await this.SelectOptionsfromDropdown(configurevals, 'root', pageScreen)
    }
    else if (process.env.RMDataList.startsWith('Delete')) 
          {
      let delParameter = await page.isVisible(await ScreenMap.get(pageScreen).getSelector("Parameters")).then(async (exist) => {
        return exist;
      });
      if (delParameter == true) {
        await action.mouseHoverElement('Parameters', pageScreen)
        await this.SelectOptionsfromDropdown(configurevals, 'Parameters', pageScreen)
      }
      else{
        await action.mouseHoverElement('Request', pageScreen)
        await action.mouseHoverElement('root', pageScreen);
        await this.SelectOptionsfromDropdown(configurevals, 'root', pageScreen)
      }
    }
    else if (process.env.RMDataList.startsWith('Update')) {
      if (UniqueField == 'Yes') {
        await action.mouseHoverElement('Parameters', pageScreen)
        await this.SelectOptionsfromDropdown(configurevals, 'Parameters', pageScreen)
      }
      else {
        await action.mouseHoverElement('Request', pageScreen)
        await action.mouseHoverElement('root', pageScreen);
        await this.SelectOptionsfromDropdown(configurevals, 'root', pageScreen)
      }
    }

  }
}


