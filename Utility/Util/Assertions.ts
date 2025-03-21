import { ScreenMap } from "../Source/Core";
import { CommonUtilObject } from "./CommonUtil";
import { page } from "../../steps/world";
import { expect } from "@playwright/test";

export class Assertions {
  async checktext(elementName, pageScreen, expText) {
    try {
      let elementText: any = await ScreenMap.get(pageScreen).getElement(
        elementName
      );
      const actualText = await elementText.textContent({timeout:60000});
      console.log("ActualText is " + actualText);
      console.log("ExpectedText is " + expText);
      expect(actualText?.trim()).toEqual(expText);
    } catch (err) {
      throw err;
    }
  }

  async HaveText(elementName, pageScreen, expText) {
    try {
      let elementText: any = await ScreenMap.get(pageScreen).getElement(
        elementName
      );
      const actualText = await elementText.textContent();
      console.log("ActualText is " + actualText);
      console.log("ExpectedText is " + expText);
      await expect(elementText).toHaveText(expText,{timeout:5000});
    } catch (err) {
      throw err;
    }
  }

  async HaveTitle(expText, pageScreen) {
    try {
      // let elementText: any=await ScreenMap.get(pageScreen).getElement(elementName)
      // await expect (page).toHaveTitle(expText);
    } catch (err) {
      throw err;
    }
  }

  async ContainText(elementName, pageScreen, expText) {
    try {
      let elementText: any = await ScreenMap.get(pageScreen).getElement(
        elementName
      );
      const actualText = await elementText.textContent({timeout:60000});
      console.log("ActualText is " + actualText);
      console.log("ExpectedText is " + expText);
      await expect(elementText).toContainText(expText,{timeout:5000});
    } catch (err) {
      throw err;
    }
  }

  async getAttributevalue(elementName, pageScreen) {
    try {
      let elementText: any = await ScreenMap.get(pageScreen).getElement(
        elementName
      );
      const actualText = await elementText.inputValue();
      console.log("ActualText is " + actualText);
      return actualText;
    } catch (err) {
      throw err;
    }
  }

  async Visible(elementName, pageScreen) {
    try {
      let txtElement = await ScreenMap.get(pageScreen).getElement(elementName);
      await expect(txtElement).toBeVisible({timeout:50000});
    }
    catch (err) {
      throw err
    }
  }

  async checkElementVisible(elementName, pageScreen?: any) {
    try {
      let txtElement: any;
      if (pageScreen !== undefined) {
        txtElement = await ScreenMap.get(pageScreen).getSelector(elementName);
      } else {
        txtElement = elementName;
      }
      await page.isVisible(txtElement).then((exist) => {
        console.log(exist);
        expect(
          exist,
          "The element " + txtElement + "should exist in page"
        ).toEqual(true);
      });
    } catch (err) {
      throw err;
    }
  }

  async checkElementnotVisible(elementName, pageScreen?: any) {
    try {
      let txtElement: any;
      if (pageScreen !== undefined) {
        txtElement = await ScreenMap.get(pageScreen).getSelector(elementName);
      } else {
        txtElement = elementName;
      }
      await page.isVisible(txtElement).then((exist) => {
        console.log("Visibility of Element " + elementName + " is " + exist);
        expect(
          exist,
          "The element " + txtElement + "should not exist in page"
        ).toEqual(false);
      });
    } catch (err) {
      throw err;
    }
  }

  async getAttributeGiven(elementName, attribute, pageScreen?) {
    try {
      let elementText: any;
      if (pageScreen !== undefined) {
        elementText = await ScreenMap.get(pageScreen).getElement(
          elementName
        );
      } else {
        elementText = elementName;
      }
      const actualText = await elementText.getAttribute(attribute);
      console.log("ActualText is " + actualText);
      return actualText;
    } catch (err) {
      throw err;
    }
  }

  async haveCount(elementName, pageScreen, count) {
    try {
      let element: any = await ScreenMap.get(pageScreen).getElement(
        elementName)
      await expect(element).toHaveCount(Number(count));
    } catch (err) {
      throw err;
    }
  }

  async Hidden(elementName, pageScreen) {
    try {
      let elementText: any;
      if (pageScreen !== undefined) {
        elementText = await ScreenMap.get(pageScreen).getElement(
          elementName
        );
      } else {
        elementText = elementName;
      }
      await expect(elementText).toBeHidden();
    }
    catch (err) {
      throw err
    }
  }

  async havemoreCount(expCount, elementName, pageScreen) {
    try {
      let element: any = await ScreenMap.get(pageScreen).getElement(
        elementName)
      let actualValue = await element.count();
      console.log("Actual count is " + actualValue);
      console.log("Expected count is " + expCount)
      await expect(actualValue).toBeGreaterThan(Number(expCount));
    } catch (err) {
      throw err;
    }
  }

  async checkgiventext(elementName, expText) {
    try {
      let element = "//*[normalize-space(text())='"+elementName+"']"
      const actualText = await page.locator(element).textContent({timeout:30000});
      console.log("ActualText is " + actualText);
      console.log("ExpectedText is " + expText);
      expect(actualText?.trim()).toEqual(expText);
    } catch (err) {
      throw err;
    }
  }
}

