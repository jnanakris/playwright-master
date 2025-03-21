import { Given, When, Then, DataTable } from "@cucumber/cucumber";
import { context, page } from "./world";
import { ScreenMap } from "../Utility/Source/Core";
import { expect } from "@playwright/test";
import { Actions } from "../Utility/Util/Actions";
import { CommonUtilObject } from "../Utility/Util/CommonUtil";
import { Assertions } from "../Utility/Util/Assertions";
import { Payload } from "../Main/Payload";

let action: Actions = new Actions();
let assertion: Assertions = new Assertions();
let payload: Payload = new Payload();

Then("User get Transaction Id and save it in json file", async function () {
  console.log("User get Transaction Id and save it in json file");
  await page.waitForSelector(await ScreenMap.get("payload").getSelector(
    "Pagelevel_alert_messgae"
  ),{timeout: 60000});
  let txMessage = await action.getText("Pagelevel_alert_messgae", "payload");
  console.log("txMessage is " + txMessage);
  let txMessage1 = txMessage.split("-")[1];
  let txNumber = txMessage1.split(" ")[1];
  console.log("txNumber is " + txNumber);
  await CommonUtilObject.writeUsecaseTestData(
    process.env.FileName,
    "txNumber",
    txNumber
  );
});

Then(
  "User validate {string} widget {string} is not empty in {string} screen",
  async function (typeOfWidget, elementName, pageScreen) {
    console.log(
      "User validate " +
        typeOfWidget +
        " widget " +
        elementName +
        " is not empty in " +
        pageScreen +
        "screen"
    );
    let inputElement;
    if (
      typeOfWidget == "Text Input" ||
      typeOfWidget == "Number" ||
      typeOfWidget == "SSN / ITIN" ||
      typeOfWidget == "Phone Number" ||
      typeOfWidget == "Email"
    ) {
      let elementXpath = await ScreenMap.get(pageScreen).getSelector(
        "TextInput"
      );
      inputElement = page.locator(
        elementXpath.replace("elementName", elementName)
      );
      let actualText = await inputElement.inputValue();
      console.log(elementName + " value is " + actualText);
      await expect(inputElement).not.toBeEmpty();
    } else if (typeOfWidget == "Radio Group") {
      let elementXpath = await ScreenMap.get(pageScreen).getSelector(
        "RadioButton"
      );
      let options = await page.locator(
        elementXpath.replace("elementName", elementName)
      );
      let optionsCount = await options.count();
      let optionSelected;
      console.log("Options count is " + optionsCount);
      let input = await page.locator(
        "//div[normalize-space(text())='" + elementName + "']/../..//input"
      );
      for (let j = 0; j < optionsCount; j++) {
        let checkedattr = await assertion.getAttributeGiven(
          input.nth(j),
          "aria-checked"
        );
        if (checkedattr == "true") {
          console.log(
            "Expected element " +
              (await options.nth(j).textContent()) +
              " is selected"
          );
          optionSelected = "true";
          break;
        }
      }
      expect(optionSelected?.trim()).toEqual("true");
    }
    else if (typeOfWidget == "Dropdown") {
      let elementXpath = await ScreenMap.get(pageScreen).getSelector(
        "Dropdown"
      );
      inputElement = page.locator(
        elementXpath.replace("elementName", elementName)
      );
      let actualText = await inputElement.innerText();
      console.log(elementName + " value is " + actualText);
      await expect(actualText).not.toEqual("No results found");
      await expect(actualText).not.toEqual("Select");
      await expect(inputElement).not.toBeEmpty();
    }
  }
);

When(
  "User click on {string} widget {string} in {string} screen",
  async (typeOfElement, elementName, pageScreen) => {
    try {
      console.log(
        "User click on " +
          typeOfElement +
          " widget " +
          elementName +
          " in " +
          pageScreen +
          " screen"
      );
      if (typeOfElement == "Dropdown") {
        let elementXpath = await ScreenMap.get(pageScreen).getSelector(
          "Dropdown"
        );
        let elementLocator = await page.locator(
          elementXpath.replace("elementName", elementName)
        );
        await action.ClickElement(elementLocator);
      } else if (typeOfElement == "Button") {
        let elementXpath = await ScreenMap.get(pageScreen).getSelector(
          "Button"
        );
        let elementLocator = await page.locator(
          elementXpath.replace("elementName", elementName)
        );
        await action.ClickElement(elementLocator);
      }
      await page.waitForTimeout(2000);
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User select drop down option {string} in {string} widget in {string} screen",
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
      let elementXpath = await ScreenMap.get(pageScreen).getSelector(
        "Dropdown"
      );
      let elementLocator = await page.locator(
        elementXpath.replace("elementName", elementName)
      );
      await page.waitForTimeout(500);
      console.log(elementLocator);
      await action.selectDropdownbytagName("span", elementLocator, option);
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User Edit an Advanced table Columns in {string} screen",
  async (pageScreen, table: DataTable) => {
    try {
      console.log(
        "User Edit an Advanced table Columns in " + pageScreen + " screen"
      );
      const tablevals = table.hashes();
      await action.ClickElement(
        "Advanced table first row edit icon",
        pageScreen
      );
      let columnXpath = await action.getElement(
        "Advanced table first row columns",
        pageScreen
      );
      let randomNumber, randomString, widgetPosition;
      let header = await action.getElement("Advanced table header", pageScreen);
      //  get the position of the widget that going to edit in an advanced table
      for (let i = 0; i < tablevals.length; i++) {
        for (let j = 0; j < (await header.count()); j++) {
          if (
            (await header.nth(j).textContent()).trim() ==
            tablevals[i].WidgetName
          ) {
            widgetPosition = j;
          }
        }
        if (tablevals[i].WidgetName.startsWith("Phone")) {
          randomNumber = String(
            Math.floor(Math.random() * 8999999999 + 1000000000)
          );
          console.log(randomNumber);
          await action.ClickElement(columnXpath.nth(widgetPosition));
          await columnXpath.nth(widgetPosition).fill(randomNumber);
        } else if (tablevals[i].WidgetName.startsWith("Email")) {
          randomString = String(Math.random().toString(36).substring(2, 7));
          randomString = randomString + "@tabnerglobal.com";
          console.log(randomString);
          await action.ClickElement(columnXpath.nth(widgetPosition));
          await columnXpath.nth(widgetPosition).fill(randomString);
        } else if (tablevals[i].WidgetType == "Text Input") {
          await action.ClickElement(columnXpath.nth(widgetPosition));
          await columnXpath
            .nth(widgetPosition)
            .fill(tablevals[i].ExpectedValue);
        }
      }
      // save an advanced table and reload the page
      await action.ClickElement(
        "Advanced table first row save icon",
        pageScreen
      );
      await page.waitForTimeout(2000);
      await page.reload({ timeout: 100000 });
      await page.waitForTimeout(2000);
      await action.ClickElement(
        "Advanced table first row edit icon",
        pageScreen
      );
      await page.waitForTimeout(500);
      // valiated edit data are saved in api
      for (let i = 0; i < tablevals.length; i++) {
        for (let j = 0; j < (await header.count()); j++) {
          if (
            (await header.nth(j).textContent()).trim() ==
            tablevals[i].WidgetName
          ) {
            widgetPosition = j;
          }
        }
        const actualText = await columnXpath.nth(widgetPosition).inputValue();
        if (tablevals[i].WidgetName.startsWith("Phone")) {
          console.log(
            tablevals[i].WidgetName +
              " widget -> " +
              "Expected: " +
              randomNumber +
              "  -> Actual : " +
              actualText?.trim()
          );
          expect(actualText?.trim()).toEqual(randomNumber);
        } else if (tablevals[i].WidgetName.startsWith("Email")) {
          console.log(
            tablevals[i].WidgetName +
              " widget -> " +
              "Expected: " +
              randomString +
              "  -> Actual : " +
              actualText?.trim()
          );
          expect(actualText?.trim()).toEqual(randomString);
        } else {
          console.log(
            tablevals[i].WidgetName +
              " widget -> " +
              "Expected: " +
              tablevals[i].ExpectedValue +
              "  -> Actual : " +
              actualText?.trim()
          );
          expect(actualText?.trim()).toEqual(tablevals[i].ExpectedValue);
        }
      }
      await action.ClickElement(
        "Advanced table first row save icon",
        pageScreen
      );
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User Delete an Advanced table rows in {string} screen",
  async (pageScreen) => {
    try {
      console.log(
        "User Delete an Advanced table rows in " + pageScreen + " screen"
      );
      await page.waitForTimeout(500);
      let uniqueFieldbeforeDelete = await action.getText(
        "Advanced table first row first column",
        pageScreen
      );
      let tableDataFulltext = await page
        .locator(
          await ScreenMap.get(pageScreen).getSelector(
            "Advanced table data count"
          )
        )
        .textContent();
      let tableDataCountbeforeDelete = tableDataFulltext.split("of")[1].trim();
      await action.ClickElement(
        "Advanced table first row delete icon",
        pageScreen
      );
      await page.waitForTimeout(500);
      await action.ClickElement("Delete Confirmation Yes button", pageScreen);
      await page.waitForTimeout(5000);
      await page.reload({ timeout: 100000 });
      await page.waitForTimeout(2000);
      let uniqueFieldAfterDelete = await action.getText(
        "Advanced table first row first column",
        pageScreen
      );
      tableDataFulltext = await page
        .locator(
          await ScreenMap.get(pageScreen).getSelector(
            "Advanced table data count"
          )
        )
        .textContent();
      let tableDataCountAfterDelete = tableDataFulltext.split("of")[1].trim();
      console.log(
        "Table Data Count before delete is -> " + tableDataCountbeforeDelete
      );
      console.log(
        "Table Data Count After delete is -> " + tableDataCountAfterDelete
      );
      console.log(
        "First Field before delete a row is  -> " + uniqueFieldbeforeDelete
      );
      console.log(
        "First Field after delete a row is  -> " + uniqueFieldAfterDelete
      );
      expect(uniqueFieldbeforeDelete?.trim()).not.toEqual(
        uniqueFieldAfterDelete
      );
      expect(tableDataCountbeforeDelete?.trim()).not.toEqual(
        tableDataCountAfterDelete
      );
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User Add a new row in Advanced table in {string} screen",
  async (pageScreen, table: DataTable) => {
    try {
      console.log(
        "User Add a new row in Advanced table in " + pageScreen + " screen"
      );
      const tablevals = table.hashes();
      let tableDataFulltext = await page
        .locator(
          await ScreenMap.get(pageScreen).getSelector(
            "Advanced table data count"
          )
        )
        .textContent();
      let tableDataCountbeforeAdd = tableDataFulltext.split("of")[1].trim();
      await action.ClickElement("Advanced table add new row icon", pageScreen);
      let allRows = await action.getElement(
        "Advanced table all rows",
        pageScreen
      );
      let allRowsCount = await allRows.count();
      let addColumns = page.locator(
        "(//div[@class='f-table']//div[@class='f-tr'])[" +
          allRowsCount +
          "]//input"
      );
      let header = await action.getElement("Advanced table header", pageScreen);
      let widgetPosition;
      //  get the position of the widget that going to edit in an advanced table
      for (let i = 0; i < tablevals.length; i++) {
        for (let j = 0; j < (await header.count()); j++) {
          if (
            (await header.nth(j).textContent()).trim() ==
            tablevals[i].WidgetName
          ) {
            widgetPosition = j;
          }
        }
        if (
          tablevals[i].WidgetType == "Text Input" ||
          tablevals[i].WidgetType == "Email"
        ) {
          await action.ClickElement(addColumns.nth(widgetPosition));
          await addColumns.nth(widgetPosition).fill(tablevals[i].ExpectedValue);
          console.log(
            tablevals[i].WidgetName +
              " is entered as -> " +
              tablevals[i].ExpectedValue
          );
        }
      }
      let saveIcon = page.locator(
        "(//div[@class='f-table']//div[@class='f-tr'])[" +
          allRowsCount +
          "]//i[contains(@class,'save-icon')]"
      );
      await action.ClickElement(saveIcon);
      await page.waitForTimeout(2000);
      await page.reload();
      await page.waitForTimeout(2000);
      let tableDataCountAfterAdd = tableDataFulltext.split("of")[1].trim();
      console.log(
        "Table Data Count before add is -> " + tableDataCountbeforeAdd
      );
      console.log("Table Data Count After add is -> " + tableDataCountAfterAdd);
      expect(tableDataCountbeforeAdd?.trim()).not.toEqual(
        tableDataCountAfterAdd
      );
    } catch (err) {
      throw err;
    }
  }
);

Then(
  "User validate Business rules for Home Type in {string} screen",
  async function (pageScreen, table: DataTable) {
    console.log(
      "User validate Business rules for Home Type in " + pageScreen + " screen"
    );
    const formValues = table.hashes();
    console.log(formValues.length);
    for (let i = 1; i < formValues.length; i++) {
      console.log(formValues[i].WidgetName1);
      await payload.ClickonRadioButtonOption(
        formValues[0].WidgetName1,
        formValues[i].WidgetName1,
        pageScreen
      );
      await payload.ClickonRadioButtonOption(
        formValues[0].WidgetName2,
        formValues[i].WidgetName2,
        pageScreen
      );
      await page.waitForTimeout(2000);
      await payload.waitforInvisibilityOfSpinner();
      await page.waitForTimeout(500);
      await payload.AssertTextInput(
        formValues[0].WidgetName3,
        formValues[i].WidgetName3,
        pageScreen
      );
    }
  }
);

Then(
  "User validate Business rules for Property Tax in {string} screen",
  async function (pageScreen, table: DataTable) {
    console.log(
      "User validate Business rules for Property Tax in " +
        pageScreen +
        " screen"
    );
    const formValues = table.hashes();
    console.log(formValues.length);
    for (let i = 1; i < formValues.length; i++) {
      console.log(formValues[i].WidgetName1);
      await payload.SelectDropdownOption(
        formValues[0].WidgetName1,
        formValues[i].WidgetName1,
        pageScreen
      );
      await page.waitForTimeout(2000);
      await payload.waitforInvisibilityOfSpinner();
      await payload.AssertTextInput(
        formValues[0].WidgetName2,
        formValues[i].WidgetName2,
        pageScreen
      );
      await payload.AssertCheckbox(
        formValues[0].WidgetName3,
        formValues[i].WidgetName3,
        pageScreen
      );
    }
  }
);

Then(
  "User validate Business rules for DownPayment in {string} screen",
  async function (pageScreen, table: DataTable) {
    console.log(
      "User validate Business rules for DownPayment in " +
        pageScreen +
        " screen"
    );
    const formValues = table.hashes();
    console.log(formValues.length);
    for (let i = 1; i < formValues.length; i++) {
      console.log(formValues[i].WidgetName1);
      await payload.EnterTextInput(
        formValues[0].WidgetName1,
        formValues[i].WidgetName1,
        pageScreen
      );
      await page.waitForTimeout(2000);
      await page.keyboard.press("Tab");
      await page.waitForTimeout(2000);
      await payload.waitforInvisibilityOfSpinner();
      await payload.EnterTextInput(
        formValues[0].WidgetName2,
        formValues[i].WidgetName2,
        pageScreen
      );
      await page.keyboard.press("Tab");
      await page.waitForTimeout(2000);
      await payload.waitforInvisibilityOfSpinner();
      await page.waitForTimeout(5000);
      await payload.AssertTextInput(
        formValues[0].WidgetName3,
        formValues[i].WidgetName3,
        pageScreen
      );
    }
  }
);

Then(
  "User validate Business rules for Risk Profile in {string} screen",
  async function (pageScreen, table: DataTable) {
    console.log(
      "User validate Business rules for Risk Profile in " +
        pageScreen +
        " screen"
    );
    const formValues = table.hashes();
    console.log(formValues.length);
    for (let i = 1; i < formValues.length; i++) {
      console.log(formValues[i].WidgetName1);
      await payload.EnterTextInput(
        formValues[0].WidgetName1,
        formValues[i].WidgetName1,
        pageScreen
      );
      await page.waitForTimeout(2000);
      await page.keyboard.press("Tab");
      await page.waitForTimeout(2000);
      await payload.waitforInvisibilityOfSpinner();
      await page.waitForTimeout(2000);
      await payload.EnterFullTextInput(
        formValues[0].WidgetName2,
        formValues[i].WidgetName2,
        pageScreen
      );
      await page.keyboard.press("Tab");
      await page.waitForTimeout(2000);
      await payload.waitforInvisibilityOfSpinner();
      await page.waitForTimeout(2000);
      await payload.AssertRadioGroup(
        formValues[0].WidgetName3,
        formValues[i].WidgetName3,
        pageScreen
      );
    }
  }
);

Then(
  "User validate Business rules for Application Date in {string} screen",
  async function (pageScreen, table: DataTable) {
    console.log(
      "User validate Business rules for Application Date in " +
        pageScreen +
        " screen"
    );
    const formValues = table.hashes();
    console.log(formValues.length);
    for (let i = 1; i < formValues.length; i++) {
      console.log(formValues[i].WidgetName1);
      await payload.EnterTextInput(
        formValues[0].WidgetName1,
        formValues[i].WidgetName1,
        pageScreen
      );
      await page.waitForTimeout(3000);
      await page.keyboard.press("Tab");
      await page.waitForTimeout(2000);
      await payload.waitforInvisibilityOfSpinner();
      await page.waitForTimeout(500);
      await payload.AssertTextInput(
        formValues[0].WidgetName2,
        formValues[i].WidgetName2,
        pageScreen
      );
      await page.keyboard.press("Enter");
    }
  }
);

Then(
  "User validate Business rules for Age Classification in {string} screen",
  async function (pageScreen, table: DataTable) {
    console.log(
      "User validate Business rules for Age Classification in " +
        pageScreen +
        " screen"
    );
    const formValues = table.hashes();
    console.log(formValues.length);
    for (let i = 1; i < formValues.length; i++) {
      console.log(formValues[i].WidgetName1);
      await payload.EnterFullTextInput(
        formValues[0].WidgetName1,
        formValues[i].WidgetName1,
        pageScreen
      );
      await page.waitForTimeout(500);
      await page.keyboard.press("Tab");
      await page.waitForTimeout(2000);
      await payload.waitforInvisibilityOfSpinner();
      await page.waitForTimeout(500);
      await payload.AssertRadioGroup(
        formValues[0].WidgetName2,
        formValues[i].WidgetName2,
        pageScreen
      );
    }
  }
);

Then(
  "User validate Business rules for Interest Rate in {string} screen",
  async function (pageScreen, table: DataTable) {
    console.log(
      "User validate Business rules for Interest Rate in " +
        pageScreen +
        " screen"
    );
    const formValues = table.hashes();
    console.log(formValues.length);
    for (let i = 1; i < formValues.length; i++) {
      console.log(formValues[i].WidgetName1);
      await payload.ClickonRadioButtonOption(
        formValues[0].WidgetName1,
        formValues[i].WidgetName1,
        pageScreen
      );
      await page.waitForTimeout(500);
      await payload.waitforInvisibilityOfSpinner();
      await page.waitForTimeout(2000);
      await payload.ClickonRadioButtonOption(
        formValues[0].WidgetName2,
        formValues[i].WidgetName2,
        pageScreen
      );
      const spinnerSelector = "//div[contains(@class,'spinner-circle-swish')]";
      await page.waitForSelector(spinnerSelector);
      await payload.waitforInvisibilityOfSpinner();
      await page.waitForTimeout(500);
      await payload.AssertTextInput(
        formValues[0].WidgetName3,
        formValues[i].WidgetName3,
        pageScreen
      );
    }
  }
);

When(
  "User select Radio group option {string} in {string} widget in {string} screen",
  async (option, elementName, pageScreen) => {
    try {
      console.log(
        "User select Radio group option " +
          option +
          " " +
          elementName +
          " in " +
          pageScreen +
          " screen"
      );
      await payload.ClickonRadioButtonOption(elementName, option, pageScreen);
    } catch (err) {
      throw err;
    }
  }
);

Given(
  "User enter {string} in {string} with {string} characters",
  async (type, elementName, length) => {
    await page.waitForTimeout(500);
    let temp = "//div[text()=' " + elementName + "']/../..//input";
    await page.click(temp);
    switch (type) {
      case "text":
        const tempText = await action.generateRandomString(length);
        await page.locator(temp).fill(tempText);
        CommonUtilObject.writeUsecaseTestData(
          process.env.FileName,
          elementName,
          tempText
        );
        console.log("User enters " + elementName + "  as " + tempText);
        break;
      case "number":
        const tempNum = await action.generateRandomNumber(length);
        await page.locator(temp).fill(tempNum.toString());
        CommonUtilObject.writeUsecaseTestData(
          process.env.FileName,
          elementName,
          tempNum
        );
        console.log("User enters " + elementName + "  as " + tempNum);
        break;
      case "email":
        const email = action.generateRandomString(length);
        const extn: string = "@test.com";
        const tempEmail: string = (await email).toLowerCase().concat(extn);
        await page.locator(temp).fill(tempEmail);
        CommonUtilObject.writeUsecaseTestData(
          process.env.FileName,
          elementName,
          tempEmail
        );
        console.log("User enters " + elementName + "  as " + tempEmail);
        break;
      case "phoneNumber":
        const phoneNum = await action.generateRandomNumber(10);
        await page.locator(temp).fill(phoneNum.toString());
        CommonUtilObject.writeUsecaseTestData(
          process.env.FileName,
          elementName,
          phoneNum
        );
        console.log("User enters " + elementName + "  as " + phoneNum);
        break;
      case "SSN":
        const ssn = await action.generateRandomNumber(9);
        await page.locator(temp).fill(ssn.toString());
        CommonUtilObject.writeUsecaseTestData(
          process.env.FileName,
          elementName,
          ssn
        );
        console.log("User enters " + elementName + "  as " + ssn);
        break;
    }
  }
);

Then(
  "User validate {string} widget {string} is not displayed in {string} screen",
  async function (typeOfWidget, elementName, pageScreen) {
    console.log(
      "User validate " +
        typeOfWidget +
        " widget " +
        elementName +
        " is not displayed in " +
        pageScreen +
        "screen"
    );
    let inputElement;
    if (
      typeOfWidget == "Text Input" ||
      typeOfWidget == "Number" ||
      typeOfWidget == "SSN / ITIN"
    ) {
      let elementXpath = await ScreenMap.get(pageScreen).getSelector(
        "TextInput"
      );
      inputElement = await elementXpath.replace("elementName", elementName);
      await assertion.checkElementnotVisible(inputElement);
    } else if (typeOfWidget == "Radio Group") {
      let elementXpath = await ScreenMap.get(pageScreen).getSelector(
        "RadioButton"
      );
      let options = await elementXpath.replace("elementName", elementName);
      await assertion.checkElementnotVisible(options);
    }
    if (typeOfWidget == "Dropdown") {
      let elementXpath = await ScreenMap.get(pageScreen).getSelector(
        "Dropdown"
      );
      inputElement = elementXpath.replace("elementName", elementName);
      await assertion.checkElementnotVisible(inputElement);
    }
  }
);

When(
  "User enters {string} from test data file in {string}",
  async (key, field) => {
    await page.waitForTimeout(500);
    let temp = "//div[text()=' " + field + "']/../..//input";
    await page.click(temp);
    let tempData = CommonUtilObject.readUsecaseTestData(
      process.env.FileName,
      key
    );
    await page.locator(temp).fill(tempData.toString());
    console.log("User entered " + field + " as " + tempData);
  }
);

When(
  "User see text {string} in {string} widget in {string} screen",
  async (expectedText, elementName, pageScreen) => {
    try {
      console.log(
        "User see text " +
          expectedText +
          " in " +
          elementName +
          " widget in " +
          pageScreen +
          " screen"
      );
      let inputElement = await page
        .locator(
          "//*[contains(text(),'" +
            elementName +
            "')]/parent::div/parent::div/following-sibling::div//small"
        )
        .first();
      let actualText = await inputElement.textContent();
      console.log(elementName + " require field message is " + actualText);
      await expect(actualText?.trim()).toEqual(expectedText);
    } catch (err) {
      throw err;
    }
  }
);

Then("User click {string}", async (key) => {
  await page.keyboard.press(key);
});






