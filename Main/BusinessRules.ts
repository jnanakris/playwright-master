import { ScreenMap } from "../Utility/Source/Core";
import { page } from "../steps/world";
import { Actions } from "../Utility/Util/Actions";

let action: Actions = new Actions();
export class BusinessRules {

  // Fill all the require fields for Business rules If Condition
  async fillBusinessRulesforIfCondition(RuleName,
    pageScreen,
    Rulevals, RuleNumber
  ) {
    await page.waitForTimeout(500);
    //Enter name of the Business Rule
    await page.waitForTimeout(500);
    let nameElement = await action.getElement("nameInputBox", pageScreen);
    await action.enterText(RuleName, await nameElement.nth((RuleNumber - 1)));
    console.log("Rule name " + RuleName + " is entered");

    // Select all options in the Select Fields Drop down
    let selectFieldsDropdown = await this.getandReplaceElement(RuleNumber + " Rule", 'selectFieldsDropdown', pageScreen)
    await action.selectAllDropdownOptions(
      selectFieldsDropdown
    );
    await page.waitForTimeout(500);
    console.log("Select Fields Dropdown Options are  selected");
    await action.ClickElement(await nameElement.nth((RuleNumber - 1)));
    await page.waitForTimeout(500);
    for (let k = 0; k < Rulevals.IfCount; k++) {
      // Select if Fields Drop down
      let iffieldsDropdown = await this.getandReplaceElement(RuleNumber + " Rule", 'iffieldsDropdown', pageScreen)
      await iffieldsDropdown.nth(k).scrollIntoViewIfNeeded();
      await action.selectDropdownbytagName(
        "span",
        iffieldsDropdown.nth(k),
        Rulevals[`IfFields${(k + 1)}`]
      );
      await page.waitForTimeout(500);
      console.log("If Fields Drop down " + Rulevals[`IfFields${(k + 1)}`] + " is selected");

      // Select if Condition Drop down
      let ifconditionDropdown = await this.getandReplaceElement(RuleNumber + " Rule", 'ifconditionDropdown', pageScreen)
      await action.selectDropdownbytagName(
        "span",
        ifconditionDropdown.nth(k),
        Rulevals[`IfCondition${(k + 1)}`]
      );
      await page.waitForTimeout(500);
      console.log("If Condition Drop down " + Rulevals[`IfCondition${(k + 1)}`] + " is selected");

      //Enter Value for the condition
      if (Rulevals[`IfCondition${(k + 1)}`] == 'Is Not Empty' || Rulevals[`IfCondition${(k + 1)}`] == 'Is Empty') {
        console.log("No need to fill Value option as the condition is selected as Empty")
      }
      else {
        let ifvalueInputBox = await this.getandReplaceElement(RuleNumber + " Rule", 'ifvalueInputBox', pageScreen)
        await action.enterText(Rulevals[`IfValue${(k + 1)}`], ifvalueInputBox.nth(k));
        console.log("Value " + Rulevals[`IfValue${(k + 1)}`] + " is entered in If Condition");
      }
      await page.waitForTimeout(500);
      // Click on the Plus icon for If Condition
      if (k != (Rulevals.IfCount - 1)) {
        let IfPlusicon = await this.getandReplaceElement(RuleNumber + " Rule", 'IfPlusicon', pageScreen)
        await action.ClickElement(IfPlusicon);
        console.log(" User Clicked on Plus icon for If Condition");
      }
    }
    for (let k = 0; k < Rulevals.ThenCount; k++) {
      // Select Then Field Drop down
      let thenFieldDropdown = await this.getandReplaceElement(RuleNumber + " Rule", 'ifthenFieldDropdown', pageScreen)
      await thenFieldDropdown.nth(k).scrollIntoViewIfNeeded();
      await action.selectDropdownbytagName(
        "span",
        thenFieldDropdown.nth(k),
        Rulevals[`ThenField${(k + 1)}`]
      );
      await page.waitForTimeout(500);
      console.log("Then Field Drop down " + Rulevals[`ThenField${(k + 1)}`] + " is selected");

      //Enter Value for the condition
      await page.waitForTimeout(500);
      let thenValueInputBox = await this.getandReplaceElement(RuleNumber + " Rule", 'ifthenValueInputBox', pageScreen)
      await action.enterText(Rulevals[`ThenValue${(k + 1)}`], thenValueInputBox.nth(k));
      console.log("Then Value " + Rulevals[`ThenValue${(k + 1)}`] + " is entered ");

      if (k != (Rulevals.ThenCount - 1)) {
        let IfThenPlusicon = await this.getandReplaceElement(RuleNumber + " Rule", 'IfThenPlusicon', pageScreen)
        await action.ClickElement(IfThenPlusicon);
        console.log(" User Clicked on Plus icon for Then Condition");
      }
    }
    //Enter Filter condition
    await page.waitForTimeout(500);
    let filterCondition = await this.getandReplaceElement(RuleNumber + " Rule", 'iffilterCondition', pageScreen)
    await action.enterText(Rulevals.FilterCondition, filterCondition);
    console.log("Filter Condition " + Rulevals.FilterCondition + " is entered ");

  }
  // Fill all the require fields for Business rules Else Condition
  async fillBusinessRulesforElseCondition(pageScreen,
    Rulevals, RuleNumber, IterationNumber
  ) {
    await page.waitForTimeout(500);
    // Click on Condition button
    let conditionButton = await this.getandReplaceElement(RuleNumber + " Rule", 'conditionButton', pageScreen)
    await action.ClickElement(conditionButton);

    for (let k = 0; k < Rulevals.ElseCount; k++) {
      // Select if Fields Drop down
      let elsefieldsDropdown = await this.getandReplaceElement(RuleNumber + " Rule", 'elsefieldsDropdown', pageScreen)
      await elsefieldsDropdown.nth(k).scrollIntoViewIfNeeded();
      await action.selectDropdownbytagName(
        "span",
        elsefieldsDropdown.nth(k),
        Rulevals[`ElseFields${(k + 1)}`]
      );
      await page.waitForTimeout(500);
      console.log("If Fields Drop down " + Rulevals[`ElseFields${(k + 1)}`] + " is selected");

      // Select if Condition Drop down
      let elseconditionDropdown = await this.getandReplaceElement(RuleNumber + " Rule", 'elseconditionDropdown', pageScreen)
      await action.selectDropdownbytagName(
        "span",
        elseconditionDropdown.nth(k),
        Rulevals[`ElseCondition${(k + 1)}`]
      );
      await page.waitForTimeout(500);
      console.log("If Condition Drop down " + Rulevals[`ElseCondition${(k + 1)}`] + " is selected");

      //Enter Value for the condition
      if (Rulevals[`ElseCondition${(k + 1)}`] == 'Is Not Empty' || Rulevals[`ElseCondition${(k + 1)}`] == 'Is Empty') {
        console.log("No need to fill Value option as the condition is selected as Empty")
      }
      else {
        let elsevalueInputBox = await this.getandReplaceElement(RuleNumber + " Rule", 'elsevalueInputBox', pageScreen)
        await action.enterText(Rulevals[`ElseValue${(k + 1)}`], elsevalueInputBox.nth(k));
        console.log("Value " + Rulevals[`ElseValue${(k + 1)}`] + " is entered in If Condition");
      }
      if (k != (Rulevals.ElseCount - 1)) {
        let ElsePlusicon = await this.getandReplaceElement(RuleNumber + " Rule", 'ElsePlusicon', pageScreen)
        await action.ClickElement(ElsePlusicon);
        console.log(" User Clicked on Plus icon for Else Condition");
      }
    }
    for (let k = 0; k < Rulevals.ThenCount; k++) {
      // Select Then Field Drop down
      let elsethenFieldDropdown = await this.getandReplaceElement(RuleNumber + " Rule", 'elsethenFieldDropdown', pageScreen)
      await elsethenFieldDropdown.nth(k).scrollIntoViewIfNeeded();
      await action.selectDropdownbytagName(
        "span",
        elsethenFieldDropdown.nth(k),
        Rulevals[`ThenField${(k + 1)}`]
      );
      await page.waitForTimeout(500);
      console.log("Then Field Drop down " + Rulevals[`ThenField${(k + 1)}`] + " is selected");

      //Enter Value for the condition
      await page.waitForTimeout(500);
      let elsethenValueInputBox = await this.getandReplaceElement(RuleNumber + " Rule", 'elsethenValueInputBox', pageScreen)
      await action.enterText(Rulevals[`ThenValue${(k + 1)}`], elsethenValueInputBox.nth(k));
      console.log("Then Value " + Rulevals[`ThenValue${(k + 1)}`] + " is entered ");
      if (k != (Rulevals.ThenCount - 1)) {
        let ElseThenPlusicon = await this.getandReplaceElement(RuleNumber + " Rule", 'ElseThenPlusicon', pageScreen)
        await action.ClickElement(ElseThenPlusicon);
        console.log(" User Clicked on Plus icon for Else Then Condition");
      }
    }
    //Enter Filter condition
    await page.waitForTimeout(500);
    let elsefilterCondition = await this.getandReplaceElement(RuleNumber + " Rule", 'elsefilterCondition', pageScreen)
    await action.enterText(Rulevals.FilterCondition, elsefilterCondition.nth(IterationNumber));
    console.log("Filter Condition for Else " + Rulevals.FilterCondition + " is entered ");

  }

  async getandReplaceElement(replaceText, elementName, pageScreen) {
    let Field;
    try {
      let Fieldxpath = await ScreenMap.get(pageScreen).getSelector(elementName);
      Field = page.locator(
        Fieldxpath.replace("elementName", replaceText)
      );

    } catch (err) {
      throw err;
    }
    return Field;
  }

  async ValidateSelectFieldsDropdown(elementText) {
    const dropvalues = await page.locator("//ul[@role='listbox']//li")
    for (let i = 0; i < await dropvalues.count(); i++) {
      if ((await dropvalues.nth(i).textContent()).trim() == elementText) {
        console.log("Expected element " + elementText + " is Present");
        break;
      }
    }
  }
}
