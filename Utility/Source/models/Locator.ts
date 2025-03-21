import { ILocate } from "../models/ILocate";
import { page } from "../../../steps/world";

export class Locator implements ILocate {
  typeOfLocator: string;
  attributeValue: string;

  setTypeOfLocator(locatorType: string) {
    this.typeOfLocator = locatorType;
    return this;
  }

  setAttributeValue(locatorValue: string) {
    this.attributeValue = locatorValue;
    return this;
  }

  getTypeOfLocator() {
    return this.typeOfLocator;
  }

  getAttributeValue() {
    return this.attributeValue;
  }

  async getElement() {
    var elementObject: any;
    if (this.typeOfLocator == "xpath" || this.typeOfLocator == "CSS") {
      elementObject = await page.locator(this.attributeValue);
    } else if (this.typeOfLocator == "Placeholder") {
      elementObject = await page.getByPlaceholder(this.attributeValue);
    } else if (this.typeOfLocator == "Text") {
      elementObject = await page.getByText(this.attributeValue);
    }
    return elementObject;
  }
  async getAllElements() {}

  async getSelector() {
    var elementObject: any;
    elementObject = this.attributeValue;
    return elementObject;
  }
}
