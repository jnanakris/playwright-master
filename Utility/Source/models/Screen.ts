import { Locator } from "./Locator";

export class Screen {
  screen: Screen;
  pageName: string;
  locator: Map<string, Locator> = new Map();
  locator1: Map<string, Locator> = new Map();

  constructor() {}

  setPageName(pageName: string) {
    this.pageName = pageName;
    this.screen = new Screen();
    return this.screen;
  }

  setLocator(givenLocatorName: string, locate: Locator) {
    this.locator.set(
      givenLocatorName,
      new Locator()
        .setTypeOfLocator(locate.typeOfLocator)
        .setAttributeValue(locate.attributeValue)
    );
    return this.screen;
  }

  getLocator(givenLocatorName) {
    let locatorObj = new Locator();
    if (this.locator1.has(givenLocatorName)) {
      locatorObj = this.locator1.get(givenLocatorName);
    }
    return locatorObj;
  }

  setMainLocatorMap(givenLocatorName, loc: Locator) {
    this.locator1.set(givenLocatorName, loc);
  }

  getElement(givenLocatorName) {
    let locatorObj = new Locator();
    locatorObj = this.locator1.get(givenLocatorName);
    if (this.locator1.has(givenLocatorName)) {
      locatorObj = this.locator1.get(givenLocatorName);
      return locatorObj.getElement();
    }
  }

  getAllElements(givenLocatorName) {
    let locatorObj = new Locator();
    locatorObj = this.locator1.get(givenLocatorName);
    if (this.locator1.has(givenLocatorName)) {
      locatorObj = this.locator1.get(givenLocatorName);
      return locatorObj.getAllElements();
    }
  }

  getPage(pageName: string) {
    return this.screen;
  }

  getPageName() {
    return this.pageName;
  }

  getSelector(givenLocatorName) {
    let locatorObj = new Locator();
    locatorObj = this.locator1.get(givenLocatorName);
    if (this.locator1.has(givenLocatorName)) {
      locatorObj = this.locator1.get(givenLocatorName);
      return locatorObj.getSelector();
    }
  }
}
