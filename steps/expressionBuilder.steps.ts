import { Then, DataTable, When } from "@cucumber/cucumber";
import { expressionBuilder } from "../Main/ExpresssionBuilder";
import { NewTransformationUI } from "../Main/New TransformationUI";
import { OnloadTriggers } from "../Main/OnloadTriggers";
import { TransformationUI } from "../Main/TransformationUI";
import { UniqueWidgets } from "../Main/UniqueWidgets";
import { ScreenMap } from "../Utility/Source/Core";
import { Actions } from "../Utility/Util/Actions";
import { Assertions } from "../Utility/Util/Assertions";
import { CommonUtilObject } from "../Utility/Util/CommonUtil";
import { page } from "./world";

let action: Actions = new Actions();
let assertion: Assertions = new Assertions();
let Uwidgets: UniqueWidgets = new UniqueWidgets();
let OnloadTrigger: OnloadTriggers = new OnloadTriggers();
let esbuilder: expressionBuilder = new expressionBuilder();
let transformation: NewTransformationUI = new NewTransformationUI();



Then("User enter {string} and choose the below trigger in {string} screen", async (Name, pageScreen, table: DataTable) => {


  try {
    console.log("User enter " + Name + " and choose the below trigger in " + pageScreen + " screen")
    let formValues = table.hashes();
    let expandButton = await action.getElement(
      "triggerExpandArrow",
      pageScreen
    );
    let trigger = await expandButton.count();
    console.log("Total trigger is " + trigger);
    await action.enterText(Name, "Name", pageScreen)
    page.waitForTimeout(2000);
    await action.ClickElement("Trigger", pageScreen);
    for (let i = 0; i < formValues.length; i++) {
      let element = page.locator("//div[text()='" + formValues[i].Trigger + "']/../../..//li")
      await element.click();
      console.log(formValues[i].Trigger + " trigger Selected")
    }
    await action.ClickElement("Trigger", pageScreen);
    console.log("trigger saved")
  } catch (error) {
    throw error;
  }
})
//user will delete the prepopulated if conditon

Then("User delete the prepopulated if conditon", async () => {
  try {
    let extCon = page.locator("//div[contains(text(),'IF')]/..//button[contains(@class,'icon-only')]");
    await extCon.click();
    let conDel = page.locator("//span[text()='Delete']");
    await conDel.click();
  } catch (error) {
    throw error;
  }
});
Then("User add the below conditions in {string} screen", async (pageScreen, table: DataTable) => {

  try {

    console.log("User add the below conditions in " + pageScreen + " screen")
    let formValues = table.hashes();
    for (let i = 0; i < formValues.length; i++) {
      if (formValues[i].Rule) {
        await action.ClickElement("addRuleButton", "transformation");
        await action.enterText(formValues[i].Rule, "Name", "transformation");
      }
      if (formValues[i].Variable) {
        if (i == 0) {
          await action.ClickElement("UserDefinedVariable", pageScreen)
        }
        await action.ClickElement("AddVariable", pageScreen);
        await page.waitForTimeout(500);
        // if (i == 0) {
        //   await action.ClickElement("UserDefinedVariable", pageScreen)
        //   await page.waitForTimeout(500);
        // }
        await action.enterText(formValues[i].Variable, "VariableName", pageScreen)
        await action.ClickElement("OkButtton", pageScreen);
        await console.log("Added variable is " + formValues[i].Variable);
      }
      if (formValues[i].Functions) {
     
          await action.ClickElement("CreateFunctions", pageScreen)
        await action.fillText(formValues[i].Functions, "FunctionName", pageScreen)
        await console.log("Added Functions is " + formValues[i].Functions);
        await page.waitForTimeout(500);
        let parameterCount= formValues[i].parameterCount
        for (let j = 1; j <=parameterCount; j++) {
        await action.ClickElement("AddParams",pageScreen);
        let paramElement = await action.getElement("ParamName", pageScreen);
        // await action.enterText(formValues[i]["Paramvalue"+j], await paramElement.nth((j - 1)));
        await action.fillText(formValues[i]["Paramvalue"+j],await paramElement.nth((j - 1)));
          await console.log("Paramvalue Is "+formValues[i]["Paramvalue"+j])
          await page.waitForTimeout(500);
        }
      }
      let conditionCount = formValues[i].ConditionTypeCount
      await esbuilder.conditionType(conditionCount, formValues[i], pageScreen);
    }
  } catch (error) {
    throw error;
  }
})


Then("User initiates the value for the below mentioned fields in {string} pageScreen", async (pageScreen, table: DataTable) => {

  try {
    console.log("User initiates the value for the below mentioned fields in " + pageScreen + " pageScreen");
    let formValues = table.hashes();
    for (let i = 0; i < formValues.length; i++) {
      await page.waitForTimeout(500);
      if (formValues[i].UserVariablefields) {
        await action.ClickElement("PayloadDropdown", pageScreen);
        let datalist = await page.locator("//li//div[normalize-space(text())='" + formValues[i].UserVariablefields + "']/../..//div[@tooltipposition='top']")
        await datalist.click();
        await console.log(formValues[i].UserVariablefields + " UserVariablefields value Selected")
        await page.waitForTimeout(2000);
      }
      if (formValues[i].FunctionsParams) {
        await action.ClickElement("FunctionsParams", pageScreen);
        let param= page.locator("//span[text()='"+formValues[i].FunctionsParams+"']//parent::li");
        await param.click();
      }
      if (formValues[i].CallFunction) {
        await action.ClickElement("CallFunctionDropdown", pageScreen);
        let param= page.locator("//span[text()='"+formValues[i].CallFunction+"']//parent::li");
        await param.click();
      }
      if (formValues[i].Payloadfields) {
        await action.ClickElement("PayloadDropdown", pageScreen);
        await action.mouseHoverElement('application', pageScreen)
        if (formValues[i].Type) {
          await action.mouseHoverElement('root', pageScreen);
        }
        await transformation.SelectOptionsforUI(formValues[i].Payloadfields, pageScreen)
        console.log(formValues[i].Payloadfields + "  payloadfield selected")
      }
      if (formValues[i].Destinationfields) {
        await action.ClickElement("PayloadDropdown", pageScreen);
        await console.log("DataSource type is " + formValues[i].DataSourceType);
        let datalist = page.locator("//li//div[normalize-space(text())='" + process.env.DataList + "']")
        await action.mouseHoverElement(datalist)
        await transformation.SelectOptionsforAPI(formValues[i].Destinationfields, formValues[i].UniqueField, "transformation")
        console.log(formValues[i].Destinationfields + "  DestinationFields selected")
      }
      if (formValues[i].Sourcefields) {
        await action.ClickElement("PayloadDropdown", pageScreen);
        if (formValues[i].Type) {
          let datalist = page.locator("//li//div[normalize-space(text())='" + process.env.DataList + "']")
          await action.mouseHoverElement(datalist)
          await action.ClickElement("root", pageScreen)
        } else {
          await action.mouseHoverElement('App', pageScreen)
          await action.mouseHoverElement('root', pageScreen);
          
          await transformation.SelectOptionsforUI(formValues[i].Sourcefields, pageScreen)
          await console.log(formValues[i].Sourcefields + "  Sourcefields selected")
        }
      }
      if (formValues[i].Source) {
        console.log(formValues[i].Source)
        await action.ClickElement("PayloadDropdown", pageScreen);
        const destElements = (formValues[i].Source).split("->")
        for (let i = 0; i < await destElements.length; i++) {
          let fieldxpath = await ScreenMap.get("transformation").getSelector("options");
          if (destElements[i].startsWith("#"))
            destElements[i] = CommonUtilObject.readUsecaseTestData(process.env.FileName, destElements[i].replace("#", ""))

          let field = page.locator(
            fieldxpath.replace("elementName", destElements[i].trim())
          );
          console.log(field)
          //div[@role='menuitem']//div[normalize-space(text())='elementName']
          await action.mouseHoverElement(field);
          if (i == (destElements.length - 1)) {
            await action.ClickElement(field);
          }

        }
      }
      if (formValues[i].ForeachConstant) {
        await action.fillText(formValues[i].ForeachConstant, "ForEachVar", pageScreen);
        console.log(formValues[i].ForeachConstant + " string constant value entered")
      }
      if (formValues[i].StringConstant) {
        let stringValue=formValues[i].StringConstant==='" "' ? ' ' : formValues[i].StringConstant;
        await action.enterText(stringValue, "StringConstant", pageScreen);
        console.log(formValues[i].StringConstant + " string constant value entered")
      }
      if (formValues[i].ObjectConstant) {
        await action.enterText(formValues[i].ObjectConstant, "StringConstant", pageScreen);
        console.log(formValues[i].ObjectConstant + " Object constant value entered")
      }
      if (formValues[i].NumberConstant) {
        await action.enterText(formValues[i].NumberConstant, "NumberConstant", pageScreen);
        console.log(formValues[i].NumberConstant + " Number constant value entered")
      }
      if (formValues[i].DateConstant) {
        await action.enterText(formValues[i].DateConstant, "DateConstant", pageScreen);
        console.log(formValues[i].DateConstant + " Date constant value entered")
      }
      if (formValues[i].BooleanConstant) {
        await action.selectDropdownbyspantext("BooleanConstant", pageScreen, formValues[i].BooleanConstant)
        console.log(formValues[i].BooleanConstant + " BooleanConstant value Selected")
      }
      if (formValues[i].GetkeySourceField) {
        await action.ClickElement("PayloadDropdown", pageScreen);
        let data = page.locator("//div[text()='" + formValues[i].GetkeySourceField + "']/../..//div[@tooltipposition='top']")
        await action.ClickElement(data);
      }
      if (formValues[i].GetkeyDestinationField) {
        await action.ClickElement("GetkeyDestinationField", pageScreen);
        let data = page.locator("//span[text()='" + formValues[i].GetkeyDestinationField + "']/../..//li[@role='option']")
        await action.ClickElement(data);
      }
      if (formValues[i].SetKey) {
        await action.enterText(formValues[i].SetKey, "SetKeyInput", pageScreen);
      }
      //ShowField
      if (formValues[i].ShowFieldCount) {
        let count = formValues[i].ShowFieldCount
        if (formValues[i].Condition == "IF") {
          await action.ClickElement("IfShowDropDown", pageScreen);
          for (let j = 1; j <= count; j++) {
            let Field = await page.locator("//div[text()='" + formValues[i]["ShowField" + j] + "']/../..//div[@class='p-checkbox-box']");
            await Field.click();
            console.log("show field clicked " + j)
            page.waitForTimeout(2000);
            console.log(formValues[i]["ShowField" + j] + " in If-Show dropDown value Clicked")
          }
          await action.ClickElement("IfShowDropDown", pageScreen);


        } else if (formValues[i].Condition == "Else") {
          await action.ClickElement("ElseShowDropDown", pageScreen);
          for (let j = 1; j <= count; j++) {
            let Field = await page.locator("//div[text()='" + formValues[i]["ShowField" + j] + "']/../..//div[@class='p-checkbox-box']");
            await Field.click();
            console.log("show field clicked " + j)
            page.waitForTimeout(3000);
            console.log(formValues[i]["ShowField" + j] + " in Else-Show dropDown value Clicked")
          }
          await action.ClickElement("ElseShowDropDown", pageScreen);
        }

        //HideField
      } if (formValues[i].HideFieldCount) {

        let count = formValues[i].HideFieldCount
        if (formValues[i].Condition == "IF") {
          await action.ClickElement("IfHideDropDown", pageScreen);
          for (let k = 1; k <= count; k++) {
            let Field = await page.locator("//div[text()='" + formValues[i]["HideField" + k] + "']/../..//div[@class='p-checkbox-box']");
            await Field.click();
            console.log("Hide field Clicked " + k)
            page.waitForTimeout(3000);
            console.log(formValues[i]["HideField" + k] + " in If-Hide dropDown value Clicked")
          }
          await action.ClickElement("IfHideDropDown", pageScreen);
          page.waitForTimeout(3000);
        }
        else if (formValues[i].Condition == "Else If") {
          await action.ClickElement("ElseIfHideDropDown", pageScreen);

          for (let k = 1; k <= count; k++) {
            let Field = await page.locator("//div[text()='" + formValues[i]["HideField" + k] + "']/../..//div[@class='p-checkbox-box']");
            await Field.click();
            console.log("Hide field Clicked " + k)
            page.waitForTimeout(3000);
            console.log(formValues[i]["HideField" + k] + " in Else If-Hide dropDown value Clicked")
          }
          await action.ClickElement("ElseIfHideDropDown", pageScreen);
          page.waitForTimeout(3000);
        }
        else if (formValues[i].Condition == "Else") {
          await action.ClickElement("ElseHideDropDown", pageScreen);
          for (let k = 1; k <= count; k++) {
            let Field = await page.locator("//div[text()='" + formValues[i]["HideField" + k] + "']/../..//div[@class='p-checkbox-box']");
            await Field.click();
            console.log("Hide field Clicked " + k)
            console.log(formValues[i]["HideField" + k] + " in Else-Hide dropDown value Clicked")
          }
          await action.ClickElement("ElseHideDropDown", pageScreen);
          page.waitForTimeout(3000);
        }
      }
      if (formValues[i].FieldError) {
        await action.selectDropdownbyspantext("FieldError", pageScreen, formValues[i].FieldError)
        console.log(formValues[i].FieldError + " payloadfield selected")
      } if (formValues[i].ErrorMsg) {
        await action.enterText(formValues[i].ErrorMsg, "ErrorMsg", pageScreen);
        console.log(formValues[i].ErrorMsg + " ErrorMsg value entered")
      }
    }
  } catch (error) {
    throw error;
  }
})

Then("User implements conditions in execute area for below fields in {string} screen", async (pageScreen, table: DataTable) => {

  try {
    let formValues = table.hashes();

    for (let i = 0; i < formValues.length; i++) {
      await page.waitForTimeout(500);
      let IFexecuteArea = "(//span[contains(text(),'Rule')]//ancestor::finlevit-panel//div[@class='execute-area']//div[text()='Drop fields'])[1]"
      let elseExecutiveArea = "((//span[contains(text(),'Rule')]//ancestor::finlevit-panel//div[text()=' ELSE ']/parent::div/parent::div/..//div[@class='conditions-execute-area']//div[contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'drop fields')]))[1]"
      let conditionCount = formValues[i].ConditionTypeCount
      for (let j = 1; j <= conditionCount; j++) {
        let ConditionType = page.locator("//a//span[contains(text(),'" + formValues[i]["ConditionType" + j] + "')]");
        await ConditionType.scrollIntoViewIfNeeded();
        await ConditionType.click();
        let source = await ScreenMap.get(pageScreen).getElement("Spacer");
        await source.scrollIntoViewIfNeeded();
        console.log("condition type is " + formValues[i]["ConditionType" + j] + "formValues[i].ConditionType")
        let operatorsCount = formValues[i]["OperatorTypeCount" + j];
        console.log("Drag and drop for execution area ")
        for (let k = 1; k <= operatorsCount; k++) {
          await page.waitForTimeout(500);
          console.log("OperandCount" + operatorsCount);
          let Function = "//span[text()='" + formValues[i]["ConditionType" + j + "OperatorType" + k] + "']/../..//div"
          if (formValues[i].Condition == "IF") {
            let source = await ScreenMap.get(pageScreen).getElement("Spacer");
            await source.scrollIntoViewIfNeeded();
            let IfExecutiveArea;
            if (formValues[i].DropArea) {
              let v = formValues[i].DropArea;
              IfExecutiveArea = "(//span[contains(text(),'Rule')]//ancestor::finlevit-panel//div[@class='conditions-execute-area']//div[contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'drop fields')])[" + v + "]"
              await page.dragAndDrop(Function, IfExecutiveArea);
            } else {
              IfExecutiveArea = "(//span[contains(text(),'Rule')]//ancestor::finlevit-panel//div[@class='conditions-execute-area']//div[contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'drop fields')])[1]"
              await page.dragAndDrop(Function, IfExecutiveArea);
            }
          } else if (formValues[i].Condition == "Else") {
            await page.dragAndDrop(Function, elseExecutiveArea);
          } else if (formValues[i].Condition == "Else If") {
            let elseIfExecutiveArea;
            if (formValues[i].DropArea) {
              let v = formValues[i].DropArea;
              elseIfExecutiveArea = "(//span[contains(text(),'Rule')]//ancestor::finlevit-panel//div[text()=' ELSE_IF ']/parent::div/parent::div/..//div[@class='conditions-execute-area']//div[contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'drop fields')])[" + v + "]"
              await page.dragAndDrop(Function, elseIfExecutiveArea);
            } else {
              elseIfExecutiveArea = "(//span[contains(text(),'Rule')]//ancestor::finlevit-panel//div[text()=' ELSE_IF ']/parent::div/parent::div/..//div[@class='conditions-execute-area']//div[contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'drop fields')])"
              await page.dragAndDrop(Function, elseIfExecutiveArea);
            }
          }
          else if (formValues[i].Condition == "For Each") {
            let ExecutiveArea;
            if (formValues[i].DropArea) {
              let v = formValues[i].DropArea;
              ExecutiveArea = "(//div[text()=' For Each ' or text()=' FOR_EACH ']/parent::div/parent::div/..//div[@class='loop-execute-area']//div[contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'drop fields')])[" + v + "]"
              await page.dragAndDrop(Function, ExecutiveArea);
            } else {
              ExecutiveArea = "(//div[text()=' For Each ' or text()=' FOR_EACH ']/parent::div/parent::div/..//div[@class='loop-execute-area']//div[contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'drop fields')])[1]"
              await page.dragAndDrop(Function, ExecutiveArea);

            }
          } 
          else if (formValues[i].Condition == "Function") {
            let ExecutiveArea;
            if (formValues[i].DropArea) {
              ExecutiveArea = "(//div[contains(@class,'m-2 operand-area ng-star-inserted')]//div[@class='placeholder-info'])[1]"
            await page.waitForSelector(ExecutiveArea,{state:'visible'});
            let dropField = await page.locator(ExecutiveArea)
            await dropField.scrollIntoViewIfNeeded();
            // await page.evaluate(() => {
            //   const element = document.querySelector('app-reusable-function-container') as HTMLElement;
            //   if (element) {
            //     element.style.pointerEvents = 'auto';
            //   }
            // });
            await page.dragAndDrop(Function, ExecutiveArea,{ force: true });
            }
          }else {
            let v = formValues[i].DropArea;

            console.log("Field dropped bulk data")
            // let source = await ScreenMap.get(pageScreen).getElement("Spacer");
            // await source.scrollIntoViewIfNeeded();
            await page.waitForTimeout(500);
            let ExecutiveArea = "(//span//ancestor::finlevit-panel//div[contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'drop fields')])[" + v + "]"
            // let executiveArea = await page.locator(ExecutiveArea)
            // await executiveArea.scrollIntoViewIfNeeded();
            await page.waitForSelector(ExecutiveArea,{state:'visible'});
            let dropField = await page.locator(ExecutiveArea)
            await dropField.scrollIntoViewIfNeeded();
            await page.dragAndDrop(Function, ExecutiveArea);
          }
          console.log("Operator Type" + formValues[i]["ConditionType" + j + "OperatorType" + k] + " drag and drop done")
        }
      }
    }
  } catch (error) {
    throw error;
  }
})

Then("User add the functions in the {string} operator in {string} condition", async (operator, condition, table: DataTable) => {

  try {
    console.log("User add the functions in the " + operator + " operator in " + condition + " condition");
    let formValues = table.hashes();
    for (let i = 0; i < formValues.length; i++) {
      let conditionCount = formValues[i].ConditionTypeCount
      for (let j = 1; j <= conditionCount; j++) {
        let ConditionType = page.locator("//*[text()=' " + formValues[i]["ConditionType" + j] + " ']");
        await ConditionType.click();
        console.log("The condition is " + formValues[i]["ConditionType" + j])
        page.waitForTimeout(1000)
        let source = await ScreenMap.get("expressionBuilder").getElement("Spacer");
        await source.scrollIntoViewIfNeeded();
        let Expression = "//div[@class='expression']"
        let condtionExpression = "//*[contains(@class,'condition-expression')]"
        let conditionTree = "//div[@class='spacer']"
        let operatorsCount = formValues[i]["OperatorTypeCount" + j];
        for (let k = 1; k <= operatorsCount; k++) {
          await page.waitForTimeout(500);
          console.log("OperandCount is" + operatorsCount);
          let dropField = formValues[i].DropField
          let N = dropField;
          let Function = "//span[text()='" + formValues[i]["ConditionType" + j + "OperatorType" + k] + "']/../..//div";
          let OperatorFunction = "//span[text()='" + formValues["ConditionType" + j + "OperatorArea" + k] + "']/../..//div"
          if (formValues[i]["ConditionType" + j + "OperatorType" + k] == "If") {
            await page.waitForTimeout(500);
            await page.dragAndDrop(Function, Expression);
          } else if (formValues[i]["ConditionType" + j + "OperatorType" + k] == "Else If") {
            await page.waitForTimeout(500);
            await page.dragAndDrop(Function, conditionTree);
          } else if (formValues[i]["ConditionType" + j + "OperatorType" + k] == "Else") {
            await page.waitForTimeout(500);
            await page.dragAndDrop(Function, conditionTree);
          }
          else {
            if (condition == "If") {
              let IfExpression = "(//div[normalize-space(text())='" + operator + "']//ancestor::app-function-container//div[text()=' IF ']/../..//div[text()='Drop fields'])[" + N + "]"
              await page.dragAndDrop(Function, IfExpression);
            } else if (condition == "Else If") {
              let ElseIfExpression = "(//div[normalize-space(text())='" + operator + "']//ancestor::app-function-container//div[text()=' ELSE_IF ']/../..//div[text()='Drop fields'])[" + N + "]"
              await page.dragAndDrop(Function, ElseIfExpression);
            }
          }
          console.log("operator type is " + formValues[i]["ConditionType" + j + "OperatorType" + k]);
        }
      }
    }
  } catch (error) {
    throw error;
  }
})

Then("User scrollIntoView of {string} in {string} screen",
  async (elementName, pageScreen) => {
    try {
      let source = await ScreenMap.get(pageScreen).getElement(elementName);
      await source.scrollIntoViewIfNeeded();
      console.log("Scrolled to the element " + (await source.textContent()));
      // await page.waitForTimeout(2000);
    } catch (err) {
      throw err;
    }
  }
);

Then("User implements conditions check in execute area for below fields in {string} screen", async (pageScreen, table: DataTable) => {

  try {
    let formValues = table.hashes();

    for (let i = 0; i < formValues.length; i++) {
      await page.waitForTimeout(500);
      let IFexecuteArea = "(//div[@class='conditions-execute-area']//div[contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'drop fields')])[1]"
      let elseExecutiveArea = "//div[text()=' ELSE ']/parent::div/parent::div/..//div[@class='conditions-execute-area']//div"
      let conditionCount = formValues[i].ConditionTypeCount
      for (let j = 1; j <= conditionCount; j++) {
        let ConditionType = page.locator("//a//span[contains(text(),'" + formValues[i]["ConditionType" + j] + "')]");
        await ConditionType.click();
        console.log("condition type is " + formValues[i]["ConditionType" + j] + "formValues[i].ConditionType")
        let operatorsCount = formValues[i]["OperatorTypeCount" + j];
        console.log("Drag and drop for execution area ")
        for (let k = 1; k <= operatorsCount; k++) {
          console.log("OperandCount" + operatorsCount);
          let Function = "//span[text()='" + formValues[i]["ConditionType" + j + "OperatorType" + k] + "']/../..//div"
          if (formValues[i].Condition == "IF") {
            await page.waitForTimeout(500);
            await page.dragAndDrop(Function, IFexecuteArea);
          } else if (formValues[i].Condition == "Else") {
            await page.waitForTimeout(500);
            await page.dragAndDrop(Function, elseExecutiveArea);
          } else if (formValues[i].Condition == "Else If") {
            let elseIfExecutiveArea;
            if (formValues[i].DropArea) {
              let v = formValues[i].DropArea;
              elseIfExecutiveArea = "(//span[contains(text(),'Rule')]//ancestor::finlevit-panel//div[text()=' ELSE_IF ']/parent::div/parent::div/..//div[@class='execute-area']//div[text()='Drop fields'])[" + v + "]"
              await page.dragAndDrop(Function, elseIfExecutiveArea);
            } else {
              elseIfExecutiveArea = "(//span[contains(text(),'Rule')]//ancestor::finlevit-panel//div[text()=' ELSE_IF ']/parent::div/parent::div/..//div[contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'drop fields')])"
              await page.dragAndDrop(Function, elseIfExecutiveArea);
            }
          }
          console.log("Operator Type " + formValues[i]["ConditionType" + j + "OperatorType" + k] + " drag and drop done")
        }
      }
    }
  } catch (error) {
    throw error;
  }
})

Then("User clone {string} {string} in {string} pageScreen", async (order,condition,pageScreen) => {

  try {
    console.log("User clone "+order+ " " +condition+" in " + pageScreen + " pageScreen");
    if( condition== "IF"){
    let ifBlock = await action.getElement("IfblockOptions", pageScreen);
    if(order=="last")
      await action.ClickElement(ifBlock.last())
    else if(order=="first")
      await action.ClickElement(ifBlock.first())
    await page.waitForTimeout(500)
    await action.ClickElement('Clone',pageScreen)
  }
    
  } catch (error) {
    throw error;
  }
})

Then("User delete the {string} default field from rule builder", async (refer) => {

  await console.log(" Then User delete the " + refer + " default field from rule builder");

  try {
    let field = await page.locator("(//finlevit-icon-preview[@icon='pi pi-trash'])[" + refer + "]")
    await console.log(field)
    await page.waitForTimeout(500);
    await field.click();

  } catch (error) {

  }
})

Then("User collapse rule name {string} in {string} screen", async (Name, pageScreen) => {
    console.log("User collapse rule name " + Name + " in " + pageScreen + " screen")
    let Fieldxpath = await ScreenMap.get(pageScreen).getSelector('CollapseFunction');
      let Field = page.locator(
        Fieldxpath.replace("elementName", Name)
      );
      await action.ClickElement(Field)
});