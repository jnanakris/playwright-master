import { ScreenMap } from "../Utility/Source/Core";
import { page } from "../steps/world";
import { Actions } from "../Utility/Util/Actions";
import { Assertions } from "../Utility/Util/Assertions";
import { expect } from "@playwright/test";

let action: Actions = new Actions();
let assertion: Assertions = new Assertions();

export class Payload {
  async ClickonRadioButtonOption(elementName, elementToClick, pageScreen) {
    let elementXpath = await ScreenMap.get(pageScreen).getSelector("RadioButtonPartialText");
    let options = await page.locator(elementXpath.replace("elementName", elementName));
    console.log(options)
    console.log("First Text is " + (await options.nth(0).textContent()));
    await page.waitForTimeout(2000)
    let optionsCount = await options.count();
    console.log("Options count is " + optionsCount);
    for (let j = 0; j < optionsCount; j++) {
      console.log("Actual Text " + (await options.nth(j).textContent()));
      console.log("Expected Text  " + elementToClick);
      if ((await options.nth(j).textContent()).trim() == elementToClick) {
        await action.ClickElement(await options.nth(j));
        console.log("Expected element " + elementToClick + " clicked");
        break;
      }
    }
  }

  async EnterTextInput(elementName, elementText, pageScreen) {
    let elementXpath = await ScreenMap.get(pageScreen).getSelector("TextInputPartialText");
    let inputElement = await page.locator(elementXpath.replace("elementName", elementName));
    // await inputElement.click();
    await inputElement.fill(elementText)
    console.log(elementText + " entered in " + elementName + " in " + pageScreen);
  }

  async EnterFullTextInput(elementName, elementText, pageScreen) {
    let elementXpath = await ScreenMap.get(pageScreen).getSelector("TextInput");
    let inputElement = await page.locator(elementXpath.replace("elementName", elementName));
    await inputElement.fill(elementText)
    console.log(elementText + " entered in " + elementName + " in " + pageScreen);
  }

  async SelectDropdownOption(elementName, elementText, pageScreen) {
    let elementXpath = await ScreenMap.get(pageScreen).getSelector("DropdownPartialText");
    let inputElement = await page.locator(elementXpath.replace("elementName", elementName));
    await action.selectDropdownbytagName('span', inputElement, elementText)
    console.log(elementText + " selected in " + elementName + " in " + pageScreen);
  }

  async AssertTextInput(elementName, elementText, pageScreen) {
    let elementXpath = await ScreenMap.get(pageScreen).getSelector("TextInput");
    let inputElement = page.locator(
      elementXpath.replace("elementName", elementName)
    );
    let actualText = await inputElement.inputValue()
    console.log(elementName + " value is " + actualText.replace(/,/g, ""));
    await expect(actualText?.replace(/,/g, "").trim()).toEqual(elementText);
  }
  async AssertCheckbox(elementName, elementText, pageScreen) {
    let input = await page.locator("//*[contains(text(),'" + elementName + "')]/../..//input");
    let checkedattr = await assertion.getAttributeGiven(input, 'aria-checked')
    if (elementText == "true") {
      expect(checkedattr?.trim()).toEqual(elementText);
      console.log(elementName + " checkbox is selected");
    }
    else {
      expect(checkedattr?.trim()).toEqual(elementText);
      console.log(elementName + " checkbox is not selected");
    }
  }

  async AssertRadioGroup(elementName, elementText, pageScreen) {
    let elementXpath = await ScreenMap.get(pageScreen).getSelector("RadioButton");
    let options = await page.locator(elementXpath.replace("elementName", elementName));
    let optionsCount = await options.count();
    console.log("Options count is " + optionsCount);
    for (let j = 0; j < optionsCount; j++) {
      console.log("Actual Text " + (await options.nth(j).textContent()));
      console.log("Expected Text  " + elementText);
      let input = await page.locator("//div[normalize-space(text())='" + elementName + "']/../..//input");
      if ((await options.nth(j).textContent()).trim() == elementText) {
        let checkedattr = await assertion.getAttributeGiven(input.nth(j), 'aria-checked')
        await expect(checkedattr?.trim()).toEqual("true");
        console.log("Expected element " + elementText + " is selected");
        break;
      }
    }
  }

  async waitforInvisibilityOfSpinner() {
    // Wait for the spinner to disappear
    const spinnerSelector = "//div[contains(@class,'spinner-circle-swish')]";
    let exist = await page.isVisible(spinnerSelector).then(async (exist) => {
      return exist;
    });
    if (exist == true) {
      console.log("Waiting for the spinner to disappear")
      await page.waitForSelector(spinnerSelector, { state: 'hidden',timeout: 60000});
    }
  }
}