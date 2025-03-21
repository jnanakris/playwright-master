import { ScreenMap } from "../../Source/Core";
import { CommonUtilObject } from "../CommonUtil";
import { page } from "../../../steps/world";
import { Actions } from "../Actions";
import { DataTable, When } from "@cucumber/cucumber";
//import * as moment from 'moment';
import { Assertions } from "../Assertions";

let action: Actions = new Actions();
let assertion: Assertions = new Assertions();

When(
  "User click on {string} {string} in {string} screen",
  async (typeOfElement, elementName, pageScreen) => {
    try {
      console.log(
        "User click on " +
        typeOfElement +
        " " +
        elementName +
        " in " +
        pageScreen +
        " screen"
      );
      await action.ClickElement(elementName, pageScreen);
      await page.waitForTimeout(2000);
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User Fill {string} in {string} in {string} screen",
  async (expectedText, elementName, pageScreen) => {
    try {
      console.log(
        "User enter text " +
        expectedText +
        " in" +
        elementName +
        " in " +
        pageScreen +
        " screen"
      );
      await action.fillText(expectedText, elementName, pageScreen);
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User enter text {string} in {string} in {string} screen",
  async (expectedText, elementName, pageScreen) => {
    try {
      console.log(
        "User enter text " +
        expectedText +
        " in" +
        elementName +
        " in " +
        pageScreen +
        " screen"
      );
      console.log(expectedText);
      if (expectedText.startsWith("#")) {
        await action.enterText(
          CommonUtilObject.getExpectedValue(expectedText.replace("#", "")),
          elementName,
          pageScreen
        );
      } else {
        await action.enterText(expectedText, elementName, pageScreen);
      }
      await page.waitForTimeout(500);
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User select drop down option {string} in {string} in {string} screen",
  async (option, elementName, pageScreen) => {
    try {
      console.log(
        "User select drop down option " +
        option +
        " " +
        elementName +
        " in " +
        pageScreen +
        " screen"
      );
      await action.selectDropdownbyText(elementName, pageScreen, option);
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User mouseover {string} in {string} screen",
  async (elementName, pageScreen) => {
    try {
      console.log("User click" + elementName + " in " + pageScreen + " screen");
      await action.mouseHoverElement(elementName, pageScreen);
      await page.waitForTimeout(2000);
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User select All given drop down option in {string} in {string} screen",
  async (elementName, pageScreen, table: DataTable) => {
    try {
      console.log(
        "User select drop down option " +
        elementName +
        " in " +
        pageScreen +
        " screen"
      );
      await action.selectDropdownbyMultipleText(elementName, table, pageScreen);
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User select {string} tag drop down option {string} in {string} in {string} screen",
  async (tagName, option, elementName, pageScreen) => {
    try {
      console.log(
        "User select drop down option " +
        option +
        " " +
        elementName +
        " in " +
        pageScreen +
        " screen"
      );
      await action.selectDropdownbytagName(
        tagName,
        elementName,
        option,
        pageScreen
      );
      await page.waitForTimeout(500);
    } catch (err) {
      throw err;
    }
  }
);

When("User select and upload a file {string}", async (fileName) => {
  try {
    console.log("User select and upload a file");
    await action.uploadFile(fileName);
    await page.waitForTimeout(500);
  } catch (err) {
    throw err;
  }
});

When("User wait for {string}", async (time) => {
  try {
    await page.waitForTimeout(Number(time));
  } catch (err) {
    throw err;
  }
});

When(
  "User double click on {string} {string} in {string} screen",
  async (typeOfElement, elementName, pageScreen) => {
    try {
      console.log(
        "User double click on " +
        typeOfElement +
        " " +
        elementName +
        " in " +
        pageScreen +
        " screen"
      );
      await action.doubleclickElement(elementName, pageScreen);
      await page.waitForTimeout(2000);
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User right click on {string} {string} in {string} screen",
  async (typeOfElement, elementName, pageScreen) => {
    try {
      console.log(
        "User right click on " +
        typeOfElement +
        " " +
        elementName +
        " in " +
        pageScreen +
        " screen"
      );
      await action.rightclickElement(elementName, pageScreen);
      await page.waitForTimeout(2000);
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User zoom in browser to 90%",
  async () => {
    try {
      console.log(
        "User zoom in browser to 90%"
      );
      await action.browserZoomin();
      await page.waitForTimeout(2000);
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User zoom out browser to 100%",
  async () => {
    try {
      console.log(
        "User zoom out browser to 100%"
      );
      await action.browserZoomOut();
      await page.waitForTimeout(2000);
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User wait until the spinner disappears",
  async () => {
    try {
      console.log(
        "User wait until the spinner disappears"
      );
      await action.waitforInvisibilityOfSpinner();
      await page.waitForTimeout(500);
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User wait until the spinner appears",
  async () => {
    console.log(
      "User wait until the spinner appears"
    );
    await action.waitforVisibilityOfSpinner();
    await page.waitForTimeout(500);
  }
);

When(
  "User wait until the {string} appears in {string} screen",
  async (elementName,pageScreen) => {
    console.log(
      "User wait until the "+elementName+" appears in "+pageScreen+" screen"
    );
    await action.waitforInvisibilityOfSpinner()
    await action.waitforgivenselector(elementName,pageScreen);
    await page.waitForTimeout(500);
  }
);

When(
  "User wait until the toast message disappears",
  async () => {
    console.log(
      "User wait until the toast message disappears"
    );
    await action.waitforInvisibilityOfToastMessage();
    await page.waitForTimeout(500);
  }
);


