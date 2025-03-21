import { page } from "../steps/world";
import { ScreenMap } from "../Utility/Source/Core";
import { Actions } from "../Utility/Util/Actions";
import { Assertions } from "../Utility/Util/Assertions";

let action: Actions = new Actions();
let assertion: Assertions = new Assertions();


export class expressionBuilder {

    async conditionType(conditionCount, formValues, pageScreen) {

        try {

            for (let j = 1; j <= conditionCount; j++) {
                await page.waitForTimeout(500);
                let ConditionType = page.locator("//*[text()=' " + formValues["ConditionType" + j] + " ']");
                await ConditionType.click();
                let source = await ScreenMap.get(pageScreen).getElement("Spacer");
                await source.scrollIntoViewIfNeeded();
                await page.waitForTimeout(500);
                console.log("The condition is " + formValues["ConditionType" + j])
                await this.operatorType(formValues, j, pageScreen);

            }
        } catch (error) {
            throw error;
        }

    }

    async operatorType(formValues, j, pageScreen) {

        try {
            let Expression = "//div[@class='expression column-drop-container' or @class='expression']//div[@class='placeholder-info'][last()]"
            let condtionExpression = "//*[contains(@class,'condition-expression')]"
            let conditionTree;
            let operatorsCount = formValues["OperatorTypeCount" + j];

            for (let i = 1; i <= operatorsCount; i++) {
                await page.waitForTimeout(500);
                console.log("OperandCount" + operatorsCount);
                let Function = "//span[text()='" + formValues["ConditionType" + j + "OperatorType" + i] + "']/../..//div"
                let OperatorFunction = "//span[text()='" + formValues["ConditionType" + j + "OperatorArea" + i] + "']/../..//div"
                if (formValues["ConditionType" + j + "OperatorType" + i] == "If") {
                    await page.dragAndDrop(Function, Expression);
                    console.log("The operator is " + formValues["ConditionType" + j + "OperatorArea" + i]);
                } else if (formValues["ConditionType" + j + "OperatorType" + i] == "Else If") {
                    if (formValues.Type) {
                        conditionTree = "(//app-condition-container//div[@class='spacer'])[1]"
                        await page.dragAndDrop(Function, conditionTree);
                    } 
                    else if (formValues.DropArea) {
                        conditionTree = "(//app-condition-container//div[@class='spacer'])["+formValues.DropArea+"]"
                        await page.dragAndDrop(Function, conditionTree);
                    }else {
                        conditionTree = "(//span[contains(text(),'Rule')]//ancestor::finlevit-panel//div[@class='spacer'])[1]"
                        // await page.waitForTimeout(2000)
                        let source = await ScreenMap.get(pageScreen).getElement("Spacer");
                        await source.scrollIntoViewIfNeeded();
                        await page.waitForTimeout(2000)
                        await page.dragAndDrop(Function, conditionTree);
                    }
                    console.log("The operator is " + Function);
                } else if (formValues["ConditionType" + j + "OperatorType" + i] == "Else") {
                    console.log("formValues.Type" +formValues.Type)
                    if (formValues.Type) {
                        conditionTree = "(//app-condition-container//div[@class='spacer'])[1]"
                        await page.dragAndDrop(Function, conditionTree);
                    }else if (formValues.DropArea) {
                        conditionTree = "(//app-condition-container//div[@class='spacer'])["+formValues.DropArea+"]"
                        await page.dragAndDrop(Function, conditionTree);
                    }else {
                            conditionTree = "(//span[contains(text(),'Rule')]//ancestor::finlevit-panel//div[@class='spacer'])[1]"
                            await page.dragAndDrop(Function, conditionTree);
                        
                    }

                    console.log("The operator is " + formValues["ConditionType" + j + "OperatorArea" + i]);
                    let elseBlock = page.locator("//span[@class='title-else']");

                    // } else if (formValues["ConditionType" + j + "OperatorArea" + i]) {
                    //         console.log("Operand  drop done")
                    //         page.waitForTimeout(3000);
                    //         await page.dragAndDrop(OperatorFunction, OperationArea);
                    //         console.log("Operand drag anjhfffhd drop done")
                    //         page.waitForTimeout(3000);
                }
                else {
                    if (formValues.ConditionType1OperatorType1 == "If") {
                        let IfExpression = "(//div[text()=' IF ']/../..//*[contains(@class,'condition-expression')]//div[text()='Drop fields'])[1]"
                        await page.waitForTimeout(500);
                        await page.dragAndDrop(Function, IfExpression);
                    } else if (formValues.ConditionType1OperatorType1 == "Else If") {
                        let ElseIfExpression = "(//div[text()=' ELSE_IF ']/../..//*[contains(@class,'condition-expression')]//div[text()='Drop fields'])[1]"
                        await page.dragAndDrop(Function, ElseIfExpression);
                    }
                    else if (formValues["ConditionType" + j + "OperatorArea" + i] == "And") {
                        let dropField = formValues["Dropfield" + j];
                        let N = dropField;
                        let OperationArea = "(//div[text()='" + formValues["ConditionType" + j + "OperatorArea" + i] + "']//ancestor::app-function-container//div[contains(@class,'operation-container-area ')]//div[text()='Drop fields'])[" + N + "]";
                        console.log("Operand  drop done")
                        await page.dragAndDrop(Function, OperationArea);
                        console.log("Operand drag and drop done")
                    }
                    else if (formValues["ConditionType" + j + "OperatorArea" + i] == "For Each") {
                        let dropField = formValues["Dropfield" + j];
                        let N = dropField;
                        let OperationArea = "(//div[text()=' For Each ']/../../../../..//div[@class='loop-container']//div[contains(text(),'Drop fields')])[" + N + "]";
                        console.log("Operand  drop done")
                        await page.dragAndDrop(Function, OperationArea);
                        console.log("Operand drag and drop done")
                    } else {
                        await page.dragAndDrop(Function, Expression);
                        console.log("The operator is " + formValues["ConditionType" + j + "OperatorArea" + i]);
                    }
                    console.log("The operator is " + formValues["ConditionType" + j + "OperatorArea" + i]);
                }

            }
        } catch (error) {
            throw error;
        }


    }
}
