import { Given, When, Then, DataTable } from "@cucumber/cucumber";
import { page } from "./world";
import { ScreenMap } from "../Utility/Source/Core";
import { expect } from "@playwright/test";
import { Actions } from "../Utility/Util/Actions";
import { OnloadTriggers } from "../Main/OnloadTriggers";
import { Assertions } from "../Utility/Util/Assertions";
import { CommonUtilObject } from "../Utility/Util/CommonUtil";
import { BusinessRules } from "../Main/BusinessRules";

let action: Actions = new Actions();
let onloadTrigger: OnloadTriggers = new OnloadTriggers();
let assertion: Assertions = new Assertions();
let businessRules: BusinessRules = new BusinessRules();

When(
  "User create Business Rules with {string} Condition and name it as {string} in {string} screen",
  async (typeofCondition, ruleName, pageScreen, table: DataTable) => {
    try {
      console.log(
        "User create Business Rules in " +
        pageScreen +
        " screen"
      );
      const Rulevals = table.hashes();
      console.log(Rulevals.length);
      const pageHeader = page.locator("//app-design-header[@headertitle='Business Rules']");
      await  expect(pageHeader).toBeVisible();
      console.log("Business Rules is visible");
      for (let j = 0; j < Rulevals.length; j++) {
        await page.waitForTimeout(500);
        let addButtonStateelement = await action.getElement('addRuleButton', pageScreen)
        await page.waitForTimeout(500);
        let isDisabled = await addButtonStateelement.evaluate(e => (e as HTMLInputElement).disabled);
        if (isDisabled == true) {
          console.log("Add button is disabled");
        }
        else {
          await action.ClickElement('addRuleButton', pageScreen)
        }
        // get the count of Existing Business Rules
        let expandButton = await action.getElement(
          "businessRuleExpandArrow",
          pageScreen
        );
        const count = await expandButton.count();
        console.log("count is " + count);
        console.log(Rulevals[j]);
        await businessRules.fillBusinessRulesforIfCondition(ruleName,
          pageScreen,
          Rulevals[j], count
        );
        await page.waitForTimeout(2000);
      }
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User create Business Rules with {string} Condition in {string} screen",
  async (typeofCondition, pageScreen, table: DataTable) => {
    try {
      console.log(
        "User create Business Rules in " +
        pageScreen +
        " screen"
      );
      const Rulevals = table.hashes();
      console.log(Rulevals.length);
      // get the count of Existing triggers
      let expandButton = await action.getElement(
        "businessRuleExpandArrow",
        pageScreen
      );
      const ruleCount = await expandButton.count();
      console.log("count is " + ruleCount);
      for (let j = 0; j < Rulevals.length; j++) {
        await businessRules.fillBusinessRulesforElseCondition(
          pageScreen,
          Rulevals[j], ruleCount, j);
      }
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User save Business Rules in {string} screen",
  async (pageScreen) => {
    try {
      console.log(
        "User save Business Rules " +
        pageScreen +
        " screen"
      );
      // get the count of Existing triggers
      let expandButton = await action.getElement(
        "businessRuleExpandArrow",
        pageScreen
      );
      const count = await expandButton.count();
      console.log("count is " + count);
      //save Business Rule
      let saveButtonxpath = await ScreenMap.get(pageScreen).getSelector("save");
      let saveButton = page.locator(
        saveButtonxpath.replace("elementName", count + " Rule")
      );
      await action.ClickElement(saveButton);
      await assertion.checktext(
        "SavedSuccessfully",
        pageScreen,
        "Saved Successfully"
      );
      await page.waitForTimeout(2000);
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User validate only BO fields are listed under select fields dropdown in {string} screen",
  async (pageScreen, table: DataTable) => {
    try {
      console.log(
        "User validate only BO fields are listed under select fields dropdown in " +
        pageScreen +
        " screen"
      );
      const Rulevals = table.hashes();
      let selectFieldsDropdown = await businessRules.getandReplaceElement(1 + " Rule", 'selectFieldsDropdown', pageScreen)
      await action.ClickElement(selectFieldsDropdown);
      const dropvalues = await page.locator("//ul[@role='listbox']//li")
      expect(Rulevals.length).toEqual(await dropvalues.count());
      for (let j = 0; j < Rulevals.length; j++) {
        await businessRules.ValidateSelectFieldsDropdown(Rulevals[j].FieldName)
      }
      await action.ClickElement(selectFieldsDropdown);
    } catch (err) {
      throw err;
    }
  }
);

