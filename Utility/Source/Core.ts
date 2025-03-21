const fs = require("fs");
import { Screen } from "./models/Screen";
import { Locator } from "./models/Locator";
const yaml = require("js-yaml");

export var ScreenMap: Map<String, Screen> = new Map();

export class Core {
  loadAllPageObjectScreen(pathOfPageObject) {
    var files = fs.readdirSync(pathOfPageObject);
    files.forEach((file) => {
      let scrObj: Screen = this.getScreenObj(pathOfPageObject, file);
      ScreenMap.set(scrObj.getPageName(), scrObj);
    });
  }

  getScreenObj(pathOfPageObject, file) {
    let screen: Screen = new Screen();
    let screen1: Screen = new Screen();
    try {
      var doc = yaml.load(
        fs.readFileSync(pathOfPageObject + "/" + file),
        "utf8"
      );
      screen = JSON.parse(JSON.stringify(doc)) as Screen;
      Object.assign(screen1, screen);
      let locJson = screen1.locator;
      let mapEntryArr = JSON.stringify(locJson).split("},");
      mapEntryArr.forEach((entry) => {
        let tempArr = JSON.stringify(entry).split(":");
        let loc = new Locator();
        let keyOfLocatorMap = tempArr[0];
        keyOfLocatorMap = keyOfLocatorMap.replace("{", "");
        keyOfLocatorMap = keyOfLocatorMap.replace("'", "");
        keyOfLocatorMap = keyOfLocatorMap.replace('"', "");
        keyOfLocatorMap = keyOfLocatorMap.replace('\\"', "");
        keyOfLocatorMap = keyOfLocatorMap.replace('\\"', "");
        let data1 = locJson[keyOfLocatorMap];
        data1 = data1["typeOfLocator"];
        loc.setTypeOfLocator(data1);
        let data2 = locJson[keyOfLocatorMap];
        data2 = data2["attributeValue"];
        loc.setAttributeValue(data2);
        screen1.setMainLocatorMap(keyOfLocatorMap, loc);
      });
    } catch (e) {
      console.log("e->", e);
    }
    return screen1;
  }
}
