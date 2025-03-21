import { ScreenMap } from "../Utility/Source/Core";
import { CommonUtilObject } from "../Utility/Util/CommonUtil";
import { page, browser, context } from "./world";
import { Actions } from "../Utility/Util/Actions";
import { Assertions } from "../Utility/Util/Assertions";
import { DataTable, When, Then, Given, } from "@cucumber/cucumber";
import * as moment from "moment";
import { expect } from "@playwright/test";
import { UniqueWidgets } from "../Main/UniqueWidgets";
import { OnloadTriggers } from "../Main/OnloadTriggers";
import { TransformationUI } from "../Main/TransformationUI";

let action: Actions = new Actions();
let assertion: Assertions = new Assertions();
let uniqueWidgets: UniqueWidgets = new UniqueWidgets();
let OnloadTrigger: OnloadTriggers = new OnloadTriggers();
let transformationUI: TransformationUI = new TransformationUI();
var FOWidgets = [];
var BOWidgets = [];
const min = 10 ** (5 - 1);
const max = 10 ** 5 - 1;
let randomNumFO = Math.floor(Math.random() * (max - min + 1) + min);
FOWidgets[randomNumFO] = [];
let randomNumBO = Math.floor(Math.random() * (max - min + 1) + min);
BOWidgets[randomNumBO] = [];

When(
    "User enter application name {string} in {string} in {string} screen",
    async (expectedText, elementName, pageScreen) => {
        try {
            console.log(
                "User enter text " +
                CommonUtilObject.getExpectedValue(expectedText) +
                " in" +
                elementName +
                " in " +
                pageScreen +
                " screen"
            );
            const today = moment();
            let dateTime = today.format("YYYYMMDDhhmmss");
            let newExpText =
                CommonUtilObject.getExpectedValue(expectedText) + dateTime;
            console.log("new date is " + newExpText);
            process.env.applicationName = newExpText;
            CommonUtilObject.WriteExpectedValue("Application_Name", newExpText);
            await action.enterText(newExpText, elementName, pageScreen);
        } catch (err) {
            throw err;
        }
    }
);

When(
    "User Drag and Drop in BO below widgets in {string} in {string} screen",
    async (destElement, pageScreen, table: DataTable) => {
        try {
            console.log(
                "User Drag and Drop in BO below widgets in " +
                destElement +
                " in " +
                pageScreen +
                " screen"
            );
            const formValues = table.hashes();
            for (let i = 0; i < formValues.length; i++) {
                if (formValues[i].Widget == "Text Input") {
                    await uniqueWidgets.inputTypeWidget(destElement, pageScreen, formValues[i]);
                    BOWidgets[randomNumBO].push(formValues[i].FieldLabel);
                } else if (formValues[i].Widget == "Container") {
                    await uniqueWidgets.containerWidget(destElement, pageScreen, formValues[i]);
                    BOWidgets[randomNumBO].push(formValues[i].Title);
                } else if (formValues[i].Widget == "Tabs Container") {
                    await uniqueWidgets.TabcontainerWidget(
                        destElement,
                        pageScreen,
                        formValues[i]
                    );
                    await uniqueWidgets.ExpandWidget(
                        formValues[i].AddTabTabLabel,
                        destElement,
                        pageScreen,
                        Number("1100"),
                        Number("700")
                    );
                    BOWidgets[randomNumBO].push(formValues[i].AddTabTabLabel);
                } else if (formValues[i].Widget == "Button") {
                    await uniqueWidgets.ButtonWidget(destElement, pageScreen, formValues[i]);
                    BOWidgets[randomNumBO].push(formValues[i].FieldLabel);
                } else if (formValues[i].Widget == "Text") {
                    await uniqueWidgets.TextWidget(destElement, pageScreen, formValues[i]);
                    BOWidgets[randomNumBO].push(formValues[i].FieldName);
                } else if (formValues[i].Widget == "Header") {
                    await uniqueWidgets.HeaderWidget(destElement, pageScreen, formValues[i]);
                    BOWidgets[randomNumBO].push(formValues[i].FieldName);
                } else if (formValues[i].Widget == "Number") {
                    await uniqueWidgets.NumberWidget(destElement, pageScreen, formValues[i]);
                    BOWidgets[randomNumBO].push(formValues[i].FieldLabel);
                } else if (formValues[i].Widget == "Dropdown") {
                    await uniqueWidgets.DropdownWidget(destElement, pageScreen, formValues[i]);
                    BOWidgets[randomNumBO].push(formValues[i].FieldLabel);
                } else if (formValues[i].Widget == "Radio Group") {
                    await uniqueWidgets.RadioGroupWidget(destElement, pageScreen, formValues[i]);
                    BOWidgets[randomNumBO].push(formValues[i].FieldLabel);
                } else if (formValues[i].Widget == "Email") {
                    await uniqueWidgets.EmailWidget(destElement, pageScreen, formValues[i]);
                    BOWidgets[randomNumBO].push(formValues[i].FieldLabel);
                } else if (formValues[i].Widget == "SSN") {
                    await uniqueWidgets.SSNWidget(destElement, pageScreen, formValues[i]);
                    BOWidgets[randomNumBO].push(formValues[i].FieldLabel);
                } else if (formValues[i].Widget == "Phone Number") {
                    await uniqueWidgets.PhoneNumberWidget(
                        destElement,
                        pageScreen,
                        formValues[i]
                    );
                    BOWidgets[randomNumBO].push(formValues[i].FieldLabel);
                } else if (formValues[i].Widget == "Checkbox") {
                    await uniqueWidgets.CheckboxWidget(destElement, pageScreen, formValues[i]);
                    BOWidgets[randomNumBO].push(formValues[i].FieldLabel);
                } else if (formValues[i].Widget == "Date Picker") {
                    await uniqueWidgets.DatepickerWidget(destElement, pageScreen, formValues[i]);
                    BOWidgets[randomNumBO].push(formValues[i].FieldLabel);
                } else if (formValues[i].Widget == "Table") {
                    await uniqueWidgets.AdvancetableWidget(
                        destElement,
                        pageScreen,
                        formValues[i]
                    );
                    BOWidgets[randomNumBO].push(formValues[i].Name);
                } else if (formValues[i].Widget == "Address") {
                    await uniqueWidgets.AddressWidget(destElement, pageScreen, formValues[i]);
                    BOWidgets[randomNumBO].push(formValues[i].FieldLabel);
                } else if (formValues[i].Widget == "Checkbox Group") {
                    await uniqueWidgets.CheckboxGroupWidget(
                        destElement,
                        pageScreen,
                        formValues[i]
                    );
                    BOWidgets[randomNumBO].push(formValues[i].FieldLabel);
                }
            }
            await action.ClickElement("CanvasSave", pageScreen);
        } catch (err) {
            throw err;
        }
    }
);

When(
    "User Change {string} Widget backgroundcolor with {string} in {string} screen",
    async (elementName, expectedText, pageScreen) => {
        try {
            console.log(
                "User Change " +
                elementName +
                "Widget backgroundcolor with " +
                expectedText +
                "in" +
                pageScreen +
                " screen"
            );
            let reqElement = page.locator(
                "//konfig-grid-item[@class='header-container ng-star-inserted']"
            );
            await reqElement.click({ button: "right" });
            await action.ClickElement("EditWidget", pageScreen);
            await page.waitForTimeout(500);
            await action.ClickElement("STYLE", pageScreen);
            await action.ClickElement("BackgroundColor", pageScreen);
            await action.fillText(expectedText, "BackgroundColorInput", pageScreen);
            await page.waitForTimeout(500);
            await action.ClickElement("WidgetSave", pageScreen);
            console.log("Clicked on save button");
            await assertion.checktext(
                "SavedSuccessfully",
                pageScreen,
                "Saved successfully"
            );
            let actualText = await reqElement.textContent();
            console.log("actualText is" + actualText);
        } catch (err) {
            throw err;
        }
    }
);

When(
    "User Drag and Drop particular FO widgets in BO {string} in {string} screen",
    async (destElement, pageScreen, table: DataTable) => {
        try {
            console.log(
                "User User Drag and Drop particular FO widgets in  " +
                destElement +
                " in " +
                pageScreen +
                " screen"
            );
            const formValues = table.hashes();
            console.log(formValues.length);
            for (let i = 0; i < formValues.length; i++) {
                await action.ClickElement("SearchWidget", pageScreen);
                if (formValues[i].Widget.startsWith("#"))
                    formValues[i].Widget = CommonUtilObject.readUsecaseTestData(process.env.FileName, formValues[i].Widget.replace("#", ""))
                await action.enterText(formValues[i].Widget, "SearchWidget", pageScreen);
                await page.waitForTimeout(500);
                // await page.waitForTimeout(3000);
                await uniqueWidgets.dragandDropParticularWidget(
                    formValues[i].Widget
                );
                BOWidgets[randomNumBO].push(formValues[i].Widget);
                await action.ClickElement("CancelSearchWidget", pageScreen);
            }
        } catch (err) {
            throw err;
        }
    }
);

When(
    "User Drag and Drop below widgets in {string} in {string} screen",
    async (destElement, pageScreen, table: DataTable) => {
        try {
            console.log(
                "User User Drag and Drop below widgets in " +
                destElement +
                " in " +
                pageScreen +
                " screen"
            );
            const formValues = table.hashes();
            for (let i = 0; i < formValues.length; i++) {
                if (formValues[i].Widget == "Text Input" || formValues[i].Widget == 'Password') {
                    await uniqueWidgets.inputTypeWidget(destElement, pageScreen, formValues[i]);
                    FOWidgets[randomNumFO].push(formValues[i].FieldName);
                } else if (formValues[i].Widget == "Container") {
                    await uniqueWidgets.containerWidget(destElement, pageScreen, formValues[i]);
                    FOWidgets[randomNumFO].push(formValues[i].FieldName);
                } else if (formValues[i].Widget == "Tabs Container") {
                    await uniqueWidgets.TabcontainerWidget(
                        destElement,
                        pageScreen,
                        formValues[i]
                    );
                    FOWidgets[randomNumFO].push(formValues[i].FieldName);
                } else if (formValues[i].Widget == "Button") {
                    await uniqueWidgets.ButtonWidget(destElement, pageScreen, formValues[i]);
                    FOWidgets[randomNumFO].push(formValues[i].FieldName);
                } else if (formValues[i].Widget == "Text") {
                    await uniqueWidgets.TextWidget(destElement, pageScreen, formValues[i]);
                    FOWidgets[randomNumFO].push(formValues[i].FieldName);
                } else if (formValues[i].Widget == "Header") {
                    await uniqueWidgets.HeaderWidget(destElement, pageScreen, formValues[i]);
                    FOWidgets[randomNumFO].push(formValues[i].FieldName);
                } else if (formValues[i].Widget == "Number") {
                    await uniqueWidgets.NumberWidget(destElement, pageScreen, formValues[i]);
                    FOWidgets[randomNumFO].push(formValues[i].FieldName);
                } else if (formValues[i].Widget == "Dropdown") {
                    await uniqueWidgets.DropdownWidget(destElement, pageScreen, formValues[i]);
                    FOWidgets[randomNumFO].push(formValues[i].FieldName);
                } else if (formValues[i].Widget == "Radio Group") {
                    await uniqueWidgets.RadioGroupWidget(destElement, pageScreen, formValues[i]);
                    FOWidgets[randomNumFO].push(formValues[i].FieldName);
                } else if (formValues[i].Widget == "Email") {
                    await uniqueWidgets.EmailWidget(destElement, pageScreen, formValues[i]);
                    FOWidgets[randomNumFO].push(formValues[i].FieldName);
                } else if (formValues[i].Widget == "SSN") {
                    await uniqueWidgets.SSNWidget(destElement, pageScreen, formValues[i]);
                    FOWidgets[randomNumFO].push(formValues[i].FieldName);
                } else if (formValues[i].Widget == "Phone Number") {
                    await uniqueWidgets.PhoneNumberWidget(
                        destElement,
                        pageScreen,
                        formValues[i]
                    );
                    FOWidgets[randomNumFO].push(formValues[i].FieldName);
                } else if (formValues[i].Widget == "Checkbox") {
                    await uniqueWidgets.CheckboxWidget(destElement, pageScreen, formValues[i]);
                    FOWidgets[randomNumFO].push(formValues[i].FieldName);
                } else if (formValues[i].Widget == "Date Picker") {
                    await uniqueWidgets.DatepickerWidget(destElement, pageScreen, formValues[i]);
                    FOWidgets[randomNumFO].push(formValues[i].FieldName);
                } else if (formValues[i].Widget == "Divider") {
                    await uniqueWidgets.Divider(destElement, pageScreen, formValues[i]);
                    FOWidgets[randomNumFO].push(formValues[i].FieldName);
                } else if (formValues[i].Widget == "Table") {
                    await uniqueWidgets.AdvancetableWidget(
                        destElement,
                        pageScreen,
                        formValues[i]
                    );
                    FOWidgets[randomNumFO].push(formValues[i].Name);
                } else if (formValues[i].Widget == "Address") {
                    await uniqueWidgets.AddressWidget(destElement, pageScreen, formValues[i]);
                    FOWidgets[randomNumFO].push(formValues[i].FieldName);
                } else if (formValues[i].Widget == "Checkbox Group") {
                    await uniqueWidgets.CheckboxGroupWidget(
                        destElement,
                        pageScreen,
                        formValues[i]
                    );
                    FOWidgets[randomNumFO].push(formValues[i].FieldName);
                } else if (formValues[i].Widget == "Text Area") {
                    await uniqueWidgets.TextAreaWidget(
                        destElement,
                        pageScreen,
                        formValues[i]
                    );
                    FOWidgets[randomNumFO].push(formValues[i].FieldName);
                } else if (formValues[i].Widget == "Upload") {
                    await uniqueWidgets.UploadWidget(
                        destElement,
                        pageScreen,
                        formValues[i]
                    );
                    FOWidgets[randomNumFO].push(formValues[i].FieldLabel);
                }
            }
            console.log(FOWidgets[randomNumFO]);
            await action.ClickElement("CanvasSave", pageScreen);
            // await assertion.checktext(
            //   "SavedSuccessfully",
            //   pageScreen,
            //   "Saved successfully"

            // );
        } catch (err) {
            throw err;
        }
    }
);

When(
    "User write Roles {string} from {string} to JSON file",
    async (Bo_Agent, elementName) => {
        try {
            console.log("User write " + Bo_Agent + "in the JSON file");
            await page.waitForTimeout(3000);
            await action.ClickElement("roles_menu", "Roles");
            await action.ClickElement(elementName, "Roles");
            let BO_Roles_value = await assertion.getAttributevalue(
                "AddRoleMembers",
                "Roles"
            );
            CommonUtilObject.WriteExpectedValue(Bo_Agent, BO_Roles_value);
            await action.ClickElement("create_app_save_button", "Application");
        } catch (err) {
            throw err;
        }
    }
);

When(
    "User expand below widgets in {string} in {string} screen",
    async (destElement, pageScreen, table: DataTable) => {
        try {
            const formValues = table.hashes();
            for (let i = 0; i < formValues.length; i++) {
                console.log(formValues);
                await uniqueWidgets.ExpandWidget(
                    formValues[i].Widget,
                    destElement,
                    pageScreen,
                    Number(formValues[i].X),
                    Number(formValues[i].Y)
                );
            }
        } catch (err) {
            throw err;
        }
    }
);

When(
    "User make {string} field as require field in {string} screen",
    async (elementName, pageScreen) => {
        try {
            console.log(
                "User make " +
                elementName +
                "field as require field " +
                pageScreen +
                " screen"
            );
            await page.waitForTimeout(500);
            let reqElement = page.locator(
                "//konfig-grid-item//*[contains(text(),'" +
                elementName +
                "')]/parent::div"
            ).first();
            await reqElement.dblclick();
            let elementExist = await page.isVisible(await ScreenMap.get(pageScreen).getSelector("WidgetName")).then(async (exist) => {
                return exist;
            });
            if (elementExist == true) {
                console.log("Edit widget opened")
            }
            else {
                await reqElement.click({ button: "right" });
                await action.ClickElement("EditWidget", pageScreen);
            }
            await action.ClickElement("VALIDATIONS", pageScreen);
            await action.ClickElement("Required", pageScreen);
            await page.waitForTimeout(500);
            await action.ClickElement("WidgetSave", pageScreen);
            await page.waitForSelector(await ScreenMap.get(pageScreen).getSelector("SavedSuccessfully"), { timeout: 120000 });
            // await page.waitForTimeout(500);
            console.log("Clicked on save button");
            await assertion.checktext(
                "SavedSuccessfully",
                pageScreen,
                "Saved successfully"
            );
        } catch (err) {
            throw err;
        }
    }
);

Then(
    "User click {string} field and delete {string} screen",
    async (elementName, pageScreen) => {
        try {
            console.log(
                "User click " +
                elementName +
                "field and delete" +
                pageScreen +
                " screen"
            );
            let reqElement = page.locator(
                "//konfig-grid-item//*[contains(text(),'" +
                elementName +
                "')]"
            );
            await reqElement.click({ button: "right" });
            let elementExist = await page.isVisible(await ScreenMap.get(pageScreen).getSelector("DeleteWidget")).then(async (exist) => {
                return exist;
            });
            if (elementExist == true) {
                console.log("Delete widget opened")
            }
            else {
                await reqElement.click({ button: "right" });
            }
            await action.ClickElement("DeleteWidget", pageScreen);
            await page.waitForTimeout(500);
            await action.ClickElement("DeleteSubmit", pageScreen);
            await page.waitForTimeout(500);
            console.log("Clicked on save button");
            // await assertion.checktext(
            //   "SavedSuccessfully",
            //   pageScreen,
            //   "Saved successfully"
            // );
        } catch (err) {
            throw err;
        }
    }
);

When(
    "User add a Tab to {string} Container in {string} screen",
    async (elementName, pageScreen, table: DataTable) => {
        try {
            console.log(
                "User add a Tab to" +
                elementName +
                "Container in " +
                pageScreen +
                " screen"
            );
            let reqElement = page.locator(
                "//konfig-grid-item//*[contains(text(),'" +
                elementName +
                "')]"
            );
            const formValues = table.hashes();
            for (let i = 0; i < formValues.length; i++) {
                await reqElement.click({ button: "right" });
                await action.ClickElement("EditWidget", pageScreen);
                await page.waitForTimeout(500);
                await action.ClickElement("TABS", pageScreen);
                await page.waitForTimeout(500);
                await action.ClickElement("AddTab", pageScreen);
                await page.waitForTimeout(500);
                await action.fillText(
                    formValues[i].AddTabFieldName,
                    "AddTabFieldName",
                    pageScreen
                );
                await action.fillText(
                    formValues[i].AddTabTabLabel,
                    "AddTabTabLabel",
                    pageScreen
                );
                await action.ClickElement("WidgetSave", pageScreen);
                await page.waitForTimeout(500);
            }
            console.log("Clicked on save button");
            await assertion.checktext(
                "SavedSuccessfully",
                pageScreen,
                "Saved successfully"
            );
            let actualText = await reqElement.textContent();
            console.log("actualText is" + actualText);
        } catch (err) {
            throw err;
        }
    }
);

// Add columns to an Advanced table
When(
    "User click {string} and add columns in {string} screen",
    async (elementName, pageScreen, table: DataTable) => {
        try {
            console.log(
                "User click " +
                elementName +
                "and add columns in " +
                pageScreen +
                " screen"
            );
            let reqElement = page.locator(
                "//finlevit-custom-adv-table//div[@class='table-widget']"
            );
            const formValues = table.hashes();
            await reqElement.click({ button: "right" });
            await action.ClickElement("EditWidget", pageScreen);
            await page.waitForTimeout(500);
            await action.ClickElement("COLUMNS", pageScreen);
            //column1
            for (let i = 0; i < formValues.length; i++) {
                if (i == 0) {
                    await action.ClickElement("Column1", pageScreen);
                } else if (i != 0) {
                    await action.ClickElement("AddColumn", pageScreen);
                }
                await action.fillText(formValues[i].Name, "ColumnName", pageScreen);
                await action.selectDropdownbyspantext(
                    "ColumnType",
                    pageScreen,
                    formValues[i].ColumnType
                );
                await action.ClickElement(formValues[i].Alignment, pageScreen);
                await page.waitForTimeout(500);
                await action.fillText(formValues[i].FieldLabel, "FieldLabel", pageScreen);
                if (formValues[i].ColumnType == "Radio Group") {
                    await action.ClickElement("INPUT", "UniqueWidgetFields");
                    await action.ClickElement(
                        formValues[i].ValuesAlignment,
                        "UniqueWidgetFields"
                    );
                    await action.ClickElement("AddItem", "UniqueWidgetFields");
                    await page.waitForTimeout(3000);
                    await action.enterText(
                        formValues[i].Value1,
                        "ValuesValue",
                        "UniqueWidgetFields"
                    );
                    await action.ClickElement("AddItem", "UniqueWidgetFields");
                    await page.waitForTimeout(3000);
                    await action.enterText(
                        formValues[i].Value2,
                        "ValuesValue",
                        "UniqueWidgetFields"
                    );
                    await page.waitForTimeout(500);
                }
            }
            await action.ClickElement("WidgetSave", pageScreen);
            await page.waitForTimeout(500);
            console.log("Clicked on save button");
            // await assertion.checktext(
            //   "SavedSuccessfully",
            //   pageScreen,
            //   "Saved successfully"
            // );
            let actualText = await reqElement.textContent();
            console.log("actualText is" + actualText);
        } catch (err) {
            throw err;
        }
    }
);

Then(
    "User will Drag and Drop {string} on {string}",
    async (pageScreen, destElement, table: DataTable) => {
        try {
            console.log("User should drag and drop task on Workflow Designer");
            const formValues = table.hashes();
            console.log(formValues.length);
            for (let i = 0; i < formValues.length; i++) {
                console.log(formValues[i]);
                console.log(formValues[i].Widget);
                await uniqueWidgets.WorkflowDesignerWidget(
                    destElement,
                    pageScreen,
                    formValues[i]
                );
            }
        } catch (err) {
            throw err;
        }
    }
);

Then(
    "User will connect {string} in {string}",
    async (pageScreen, destElement, table: DataTable) => {
        try {
            const formValues = table.hashes();
            console.log(
                "User will connect the tasks/ actions to respective target tasks"
            );
            console.table(formValues);
            for (let i = 0; i < formValues.length; i++) {
                await page.waitForTimeout(2500);
                if (formValues[i].Source == "Start") {
                    await page.waitForTimeout(500);
                    console.log(formValues[i].Source + " -> " + formValues[i].Target);
                    let srcTask =
                        "//div[@data-test-id='START_TASK']//div[@type='node']//*[@anchorFor='ACTION']";
                    let targetTask =
                        "//div[text()=' " +
                        formValues[i].Target +
                        " ' and contains(@class,'node')]";
                    await page.locator(srcTask).dragTo(page.locator(targetTask));
                } else if (formValues[i].Source.includes("Email")||formValues[i].Source.includes("Validation")) {
                    let srcTask =
                        "//div[text()=' " +
                        formValues[i].Source +
                        " ']/..//*[@anchorFor='ACTION']";
                    let targetTask;
                    if (formValues[i].Target == "Merge") {
                        targetTask =
                            "//div[@data-test-id='MERGE_TASK' and contains(@class,'node')]";
                    } else {
                        targetTask =
                            "//div[text()=' " +
                            formValues[i].Target +
                            " ' and contains(@class,'node')]";
                    }
                    if (formValues[i].TrgIndex) {
                        await page.locator(srcTask).dragTo(await page.locator(targetTask).nth(formValues[i].TrgIndex));
                    } else {
                        await page.locator(srcTask).dragTo(await page.locator(targetTask));
                    }
                } else if (formValues[i].Source == "Merge" && formValues[i].Target != "Merge") {
                    let srcTask =
                        "//div[@data-test-id='MERGE_TASK']//*[@anchorFor='ACTION']";
                    let targetTask =
                        "//div[text()=' " +
                        formValues[i].Target +
                        " ' and contains(@class,'node')]";
                    if (formValues[i].SrcIndex) {
                        await page.locator(srcTask).nth(formValues[i].SrcIndex).dragTo(await page.locator(targetTask));
                    } else {
                        await page.locator(srcTask).dragTo(page.locator(targetTask));
                    }
                } else if (formValues[i].Target == "Merge" && formValues[i].Source != "Merge") {
                    let srcTask =
                        "//div[text()=' " +
                        formValues[i].Source +
                        " ']/../..//div[text()=' " +
                        formValues[i].Action +
                        " ']/..//*[@anchorFor='ACTION']";
                    let targetTask =
                        "//div[@data-test-id='MERGE_TASK' and contains(@class,'node')]";
                    if (formValues[i].TrgIndex) {
                        await page.locator(srcTask).dragTo(await page.locator(targetTask).nth(formValues[i].TrgIndex));
                    } else {
                        await page.locator(srcTask).dragTo(await page.locator(targetTask));
                    }
                } else if (formValues[i].Source == "Merge") {
                    let targetTask;
                    if (formValues[i].Target == "Merge") {
                        targetTask =
                            "//div[@data-test-id='MERGE_TASK' and contains(@class,'node')]";
                        console.log("Connected merge1")
                    }
                    let srcTask =
                        "//div[@data-test-id='MERGE_TASK']//*[@anchorFor='ACTION']";
                    console.log("Connected merge")
                    await page.locator(srcTask).nth(formValues[i].SrcIndex).dragTo(await page.locator(targetTask).nth(formValues[i].TrgIndex));
                } else {
                    console.log(
                        formValues[i].Source +
                        ":" +
                        formValues[i].Action +
                        " -> " +
                        formValues[i].Target
                    );
                    let srcTask =
                        "//div[text()=' " +
                        formValues[i].Source +
                        " ']/../..//div[text()=' " +
                        formValues[i].Action +
                        " ']/..//*[@anchorFor='ACTION']";
                    let targetTask =
                        "//div[text()=' " +
                        formValues[i].Target +
                        " ' and contains(@class,'node')]";
                    await page.locator(srcTask).dragTo(page.locator(targetTask));
                }
            }
            await page.waitForTimeout(500);
            await action.ClickElement("WorkflowSave", pageScreen);
            console.log("Work Flow Task connections has been saved succesfully");
            await page.waitForTimeout(500);
        } catch (err) {
            throw err;
        }
    }
);

When(
    "User should see all the {string} fields {string} in payload screen",
    async (scenario, FOFields) => {
        try {
            console.log(
                "User should see all the " +
                scenario +
                " fields " +
                FOFields +
                "in payload screen"
            );
            let appURL: any = [];
            appURL = CommonUtilObject.readUsecaseTestData(
                process.env.FileName,
                FOFields
            );
            console.log("app field is " + appURL);
            console.log("appURL length is " + appURL.length);
            let frontOfficeFields: any = [];
            appURL = appURL.replace("[", "");
            appURL = appURL.replace("]", "");
            frontOfficeFields = appURL.split(",");
            console.log("app fields are  " + frontOfficeFields.length);
            console.log("app fields are  " + frontOfficeFields[0]);
            for (let i = 0; i < frontOfficeFields.length; i++) {
                let txtElement = await ScreenMap.get("payload").getSelector(
                    "payload_field"
                );
                txtElement = txtElement.replace("widgetName", frontOfficeFields[i]);
                await page.waitForSelector(txtElement);
                await assertion.checkElementVisible(txtElement);
            }
        } catch (err) {
            throw err;
        }
    }
);

When(
    "User should not see all the {string} fields {string} in payload screen",
    async (scenario, FOFields) => {
        try {
            console.log(
                "User should not see all the " +
                scenario +
                " fields " +
                FOFields +
                "in payload screen"
            );
            let appURL: any = [];
            appURL = CommonUtilObject.getTestData(FOFields);
            console.log("app field is " + appURL);
            console.log("appURL length is " + appURL.length);
            let frontOfficeFields: any = [];
            appURL = appURL.replace("[", "");
            appURL = appURL.replace("]", "");
            frontOfficeFields = appURL.split(",");
            console.log("app fields are  " + frontOfficeFields.length);
            console.log("app fields are  " + frontOfficeFields[0]);
            for (let i = 0; i < frontOfficeFields.length; i++) {
                let txtElement = await ScreenMap.get("payload").getSelector(
                    "payload_field"
                );
                txtElement = txtElement.replace("widgetName", frontOfficeFields[i]);
                await assertion.checkElementnotVisible(txtElement);
            }
        } catch (err) {
            throw err;
        }
    }
);

When("User validate Payload app opening in a new tab", async () => {
    await action.mouseHoverElement("Preview", "Page");
    await page.waitForTimeout(500);
    console.log("User validate Payload app opening in a new tab");
    let element = page.locator(
        "//i[text()=' play_circle ']/parent::finlevit-icon-preview/parent::a"
    );
    console.log("Element from UI is " + (await element.getAttribute("href")));
    let url = await element.getAttribute("href");
    await page.waitForTimeout(500);
    CommonUtilObject.writeUsecaseTestData(
        process.env.FileName,
        "Finlevit_payload",
        url
    );
    await action.ClickElement("Preview", "Page");
    await page.waitForTimeout(500);
    let pages = await context.pages();
    await pages[1].close();
});

When(
    "User checkout the version {string} for app modification",
    async (expectedText) => {
        console.log(
            "User checkout the version " + expectedText + " for app modification"
        );
        let txtElement = await ScreenMap.get("Version").getSelector(
            "VerifyPublish"
        );
        let Version = await page.isVisible(txtElement).then(async (exist) => {
            return exist;
        });
        if (Version == true) {
            console.log(
                "version is not published for this app, cannot be checked out."
            );
        } else if (expectedText == "latest version") {
            let versions = await page.locator("//span[text()='Checkout']");
            await page.waitForTimeout(500);
            let checkout = await versions.count();
            console.log(checkout);
            let version1 = await page.locator(
                "(//span[text()='Checkout'])[" + checkout + "]"
            );
            await action.ClickElement(version1);
            await page.waitForTimeout(500);
            await action.waitforInvisibilityOfSpinner();
            let versionDesc = CommonUtilObject.readUsecaseTestData(
                process.env.FileName,
                "VersionDescription"
            );
            let versionDescTC = versionDesc.split(".")[0];
            let versionNo = (
                await page
                    .locator(
                        "((//span[text()='Checkout'])[" +
                        checkout +
                        "]/ancestor::div[contains(@class,'f-td')]/..//div)[1]"
                    )
                    .textContent()
            ).trim();
            let version = versionDescTC + "." + (Number(versionNo) + 1);
            await CommonUtilObject.writeUsecaseTestData(
                process.env.FileName,
                "VersionDescription",
                version
            );
        } else if (expectedText !== "latest version") {
            let element = page.locator(
                "//div[text()=' " +
                expectedText +
                " ']/../../../..//span[text()='Checkout']"
            );
            console.log("Version " + expectedText + " is checkedout");
            await element.click();
            await page.waitForTimeout(500);
            await action.waitforInvisibilityOfSpinner();
            let versionDesc = CommonUtilObject.readUsecaseTestData(
                process.env.FileName,
                "VersionDescription"
            );
            let versionDescTC = versionDesc.split(".")[0];
            let versionNo = (
                await page
                    .locator(
                        "(//div[text()=' " +
                        expectedText +
                        " ']/../../../..//span[text()='Checkout']/ancestor::div[contains(@class,'f-td')]/..//div)[1]"
                    )
                    .textContent()
            ).trim();
            let version = versionDescTC + "." + (Number(versionNo) + 1);
            await CommonUtilObject.writeUsecaseTestData(
                process.env.FileName,
                "VersionDescription",
                version
            );
        }
    }
);

//Group-Avoiding duplicate group creation
When(
    "User enter create group with {string} and {string} in {string} screen",
    async (expectedText, Description, pageScreen) => {
        try {
            // create unique group for moon server
            if (process.env.Browser.startsWith('moon')){
                await action.ClickElement("Group", "HomePage");
                await page.waitForTimeout(500);
                let Groupbtn = await ScreenMap.get("Groups").getSelector(
                    "create_group_button"
                );
                let checkGroupbtn = await page.isVisible(Groupbtn).then(async (exist) => {
                    return exist;
                });
                console.log("Create group button visibility is " + checkGroupbtn);
                if (checkGroupbtn == true) {
                    await action.ClickElement("create_group_button", "Groups");
                }
                else{
                    await page.waitForTimeout(3000);
                    await action.ClickElement("create_group_icon", "Groups");
                    await page.waitForTimeout(500);
                }
                const today = moment();
                let dateTime = today.format("YYYYMMDDhhmmss");
                let expGroupName = CommonUtilObject.getTestData(
                    expectedText
                );
                let newExpText = expGroupName + dateTime;
                if(process.env.Browser.startsWith('moon')){
                    CommonUtilObject.writeUsecaseTestData('resources/TestData',
                        'moon-GroupName',newExpText
                    );
                }
                else{
                    CommonUtilObject.WriteTestData(
                        expectedText,newExpText
                    );
                }
                console.log("Group Name: " + newExpText);
                await uniqueWidgets.CreateGroup(newExpText, Description);
            }
            else{
                await action.ClickElement("Group", "HomePage");
                await page.waitForTimeout(500);
                let Groupbtn = await ScreenMap.get("Groups").getSelector(
                    "create_group_button"
                );
                let checkGroupbtn = await page.isVisible(Groupbtn).then(async (exist) => {
                    return exist;
                });
                console.log("Create group button visibility is " + checkGroupbtn);
                let groupName = CommonUtilObject.getTestData(expectedText);
                if (checkGroupbtn == true) {
                    await action.ClickElement("create_group_button", "Groups");
                    await page.waitForTimeout(500);
                    await uniqueWidgets.CreateGroup(groupName, Description);
                } else {
                    await action.ClickElement("search_group", "Groups");
                    await page.waitForTimeout(500);
                    await uniqueWidgets.GroupName(
                        expectedText,
                        "search_group_textbox",
                        "Groups"
                    );
                    console.log(
                        "User enters " + expectedText + " in " + pageScreen + " screen"
                    );

                    let txtElement = "//ul[@data-test-id='groups-list']//span[text()='" + groupName + "']"
                    let checkGroup = await page
                        .isVisible(txtElement)
                        .then(async (exist) => {
                            return exist;
                        });
                    console.log("Group Name already exist " +checkGroup)
                    if (checkGroup == true) {
                        await page.waitForTimeout(500);
                        await action.ClickElement("select_first_group", "Groups");
                        await page.waitForTimeout(500);
                    } else {
                        await page.waitForTimeout(3000);
                        await action.ClickElement("Close_Search_group", "Groups");
                        await action.ClickElement("create_group_icon", "Groups");
                        await page.waitForTimeout(500);
                        await uniqueWidgets.CreateGroup(groupName, Description);
                    }
                }}
        } catch (err) {
            throw err;
        }
    }
);
//Show Clear Button
When(
    "User click {string} Inputs and choose clear button in {string} screen",
    async (elementName, pageScreen) => {
        try {
            console.log(
                "User make " +
                elementName +
                "Inputs and choose clear button in" +
                pageScreen +
                " screen"
            );
            let reqElement = page.locator(
                "//konfig-grid-item//*[contains(text(),'" +
                elementName +
                "')]"
            );
            await reqElement.click({ button: "right" });
            await action.ClickElement("EditWidget", pageScreen);
            await page.waitForTimeout(500);
            await action.ClickElement("INPUT", pageScreen);
            await action.ClickElement("ShowClearButton", pageScreen);
            await page.waitForTimeout(500);
            await action.ClickElement("WidgetSave", pageScreen);
            await page.waitForTimeout(500);
            console.log("Clicked on save button");
            await assertion.checktext(
                "SavedSuccessfully",
                pageScreen,
                "Saved successfully"
            );
            let actualText = await reqElement.textContent();
            console.log("actualText is" + actualText);
        } catch (err) {
            throw err;
        }
    }
);

When(
    "User click {string} and add tooltip as {string} in {string} screen",
    async (elementName, expectedText, pageScreen) => {
        try {
            console.log(
                "User click" +
                elementName +
                "and add tooltip as" +
                expectedText +
                "in" +
                pageScreen +
                " screen"
            );
            let reqElement = page.locator(
                "//konfig-grid-item//*[contains(text(),'" +
                elementName +
                "')]"
            );
            await reqElement.click({ button: "right" });
            await action.ClickElement("EditWidget", pageScreen);
            await page.waitForTimeout(500);
            await action.ClickElement("INPUT", pageScreen);
            await action.enterText(expectedText, "ToolTip", pageScreen);
            await page.waitForTimeout(500);
            await action.ClickElement("WidgetSave", pageScreen);
            await page.waitForTimeout(500);
            console.log("Clicked on save button");
            await assertion.checktext(
                "SavedSuccessfully",
                pageScreen,
                "Saved successfully"
            );
            let actualText = await reqElement.textContent();
            console.log("actualText is" + actualText);
        } catch (err) {
            throw err;
        }
    }
);

When(
    "User makes changes to {string} field format as in {string} screen",
    async (elementName, pageScreen, table: DataTable) => {
        try {
            console.log(
                "User makes changes to" +
                elementName +
                "field format as in " +
                pageScreen +
                " screen"
            );
            let reqElement = page.locator(
                "//konfig-grid-item//*[text()=' " +
                elementName +
                "']"
            );
            await page.waitForTimeout(500);
            const formValues = table.hashes();
            await reqElement.click({ button: "right" });
            await action.ClickElement("EditWidget", pageScreen);
            await page.waitForTimeout(500);
            await action.ClickElement("NUMBER FORMAT", pageScreen);
            await action.ClickElement("ThousandsSeparator", pageScreen);
            await action.selectDropdownbyspantext(
                "TypeOfFormat",
                pageScreen,
                formValues[0].TypeOfFormat
            );
            if (formValues[0].TypeOfFormat=='Currency') {
                await page.waitForTimeout(3000);
                await action.ClickElement("CurrencyDropdown", pageScreen);
                await action.enterText(
                    formValues[0].CurrencyCountry,
                    "CurrencySearch",
                    pageScreen
                );
                await action.ClickElement("SelectFirstCountry", pageScreen);
                await page.waitForTimeout(500);
            }else if (formValues[0].TypeOfFormat=='Decimal') {
                if (formValues[0].MinimumFraction) {
                    await action.enterText(formValues[0].MinimumFraction,"MinFraction",pageScreen)
                }
                if (formValues[0].MaximumFraction) {
                    await action.enterText(formValues[0].MaximumFraction,"MaxFraction",pageScreen)
                }
            }
            await action.ClickElement("WidgetSave", pageScreen);
            await page.waitForTimeout(500);
            console.log("Clicked on save button");
            // await assertion.checktext(
            //   "SavedSuccessfully",
            //   pageScreen,
            //   "Saved successfully"
            // );
        } catch (err) {
            throw err;
        }
    }
);


When("User write Payload app url in JSON file", async () => {
    await page.waitForTimeout(500);
    console.log("User write Payload app url in JSON file");
    await page.waitForTimeout(500);
    let payLoadUrl = await assertion.getAttributeGiven(
        "Preview_href_link",
        "Page",
        "href"
    );
    console.log("url is " + payLoadUrl);
    CommonUtilObject.WriteExpectedValue("Finlevit_payload", payLoadUrl);
});

Then(
    "User select {string} in {string} dropdown in {string} screen",
    async (option, dropDown, pageScreen) => {
        await page.waitForTimeout(500);
        console.log(option, dropDown, pageScreen);
        await action.selectDropdownbyText(dropDown, pageScreen, option);
    }
);

Then(
    "User select on {string} {string} in {string} screen",
    async (option, element, pageScreen) => {
        await page.waitForTimeout(500);
        await page.keyboard.press("ArrowDown");
        await page.waitForTimeout(500);
        await page.keyboard.press("Tab");
        await page.waitForTimeout(500);
        await page.keyboard.press("Tab");
    }
);

When(
    "User upload a {string} file in {string} screen",
    async (expectedText, pageScreen) => {
        const handle = await page.locator("//input[@type='file']");
        await handle.setInputFiles("ExistApp/" + expectedText + ".json");
    }
);

When(
    "User save {string} identifiers and fill {string} value in screen",
    async (key, elementName) => {
        const today = moment();
        let Time = today.format("hhmmss");
        let k1 = key.split(" ")[0];
        let k2 = key.split(" ")[1];
        const newKey = k1.charAt(0) + k2.charAt(0) + Time;
        // Write the Application Identifiers to the JSON file
        CommonUtilObject.writeUsecaseTestData(
            process.env.FileName,
            elementName,
            newKey
        );
        let identifiers = "//div[contains(text(),'" + elementName + "')]/..//input";
        await page.fill(
            identifiers,
            CommonUtilObject.readUsecaseTestData(process.env.FileName, elementName)
        );
    }
);

When(
    "User copy {string} save {string} in {string} json file",
    async (srcElement, dstElemen, fileName) => {
        let temp = CommonUtilObject.readUsecaseTestData(
            process.env.FileName,
            srcElement
        );
        CommonUtilObject.writeUsecaseTestData(
            "Usecase_TestData/" + fileName,
            dstElemen,
            temp
        );
        console.log(dstElemen + " for " + fileName + " is:" + temp);
    }
);

When(
    "User make below field as Read only in {string} screen",
    async (pageScreen, table: DataTable) => {
        try {
            const formValues = table.hashes();
            for (let i = 0; i < formValues.length; i++) {
                console.log(
                    "User make " +
                    formValues[i].Widget +
                    "below field as Read only in " +
                    pageScreen +
                    " screen"
                );
                await page.waitForTimeout(500);
                let reqElement = page.locator(
                    "(//konfig-grid-item//*[contains(text(),'" +
                    formValues[i].Widget +
                    "')])[1]"
                );
                await reqElement.click({ button: "right" });
                await action.ClickElement("EditWidget", pageScreen);
                await page.waitForTimeout(500);
                await action.ClickElement("CONFIGURATIONS", pageScreen);
                await action.ClickElement("ReadOnly", pageScreen);
                await page.waitForTimeout(500);
                await action.ClickElement("WidgetSave", pageScreen);
                await page.waitForTimeout(500);
                console.log("Clicked on save button");
                // await assertion.checktext(
                //   "SavedSuccessfully",
                //   pageScreen,
                //   "Saved successfully"
                // );
            }
        } catch (err) {
            throw err;
        }
    }
);

When('User generates {string} with {string} numbers and saves it to {string}', async (elementName, val, fileName) => {
    const tempID = await action.generateRandomNumber(val);
    CommonUtilObject.writeUsecaseTestData("Usecase_TestData/" + fileName + "", elementName, tempID);
});

When(
    "User choose object {string} the type {string} and the widget is {string} in screen",
    async (expectedText, options, options2) => {
        //for 1st dropdown
        let FieldObject = page.locator(
            "(//div[@class='label col-3 toggle-section']//span[contains(text(),'" +
            expectedText +
            "')]/..//./..//finlevit-lib-select//span[contains(@class,'p-dropdown-label p-inputtext ng-star-inserted')])[1]"
        );
        await FieldObject.click();
        let optionElement = page.locator(
            '//li//span[contains(text(),"' + options + '")]'
        );
        await optionElement.click();
        console.log("user choose the type as" + options);
        //for 2nd dropdown
        let FieldWidget = page.locator(
            "(//div[@class='field row justify-content-around mb-2 ml-2']//span[contains(text(),'" +
            expectedText +
            "')]/../../..//finlevit-lib-select[@placeholder='Select Widget']//span)[1]"
        );
        await FieldWidget.click();
        let Widget = page.locator(
            '//li//span[contains(text(),"' + options2 + '")]'
        );
        await Widget.click();
        console.log("user choose the type as" + options2);
    }
);


Then(
    "User will open {string} group in {string} screen",
    async (groupName, pageScreen) => {
        try {
            //click on Konfig Logo
            // await action.ClickElement('Home', pageScreen);
            console.log('User clicked on application logo in ' + pageScreen);
            // Click on Groups Icon
            await action.waitforInvisibilityOfSpinner();
            let groupElement=await action.getElement("Group", pageScreen)
            await groupElement.click({ force: true })
            // Click on Group Searchicon
            await action.ClickElement("search_group", "Groups");
            await page.waitForTimeout(500);
            console.log("Group Search Icon clicked");
            //Enter GroupName
            if(process.env.Browser.startsWith('moon') && !groupName.startsWith("#")){
                groupName='moon-GroupName'
            }
            let grpName
            if (groupName.startsWith("#")) {
                grpName = CommonUtilObject.readUsecaseTestData(process.env.FileName, groupName.replace("#", ""));
                await action.enterText(
                    grpName,
                    'search_group_textbox',
                    'Groups'
                );
            } else {
                grpName = CommonUtilObject.getTestData(groupName);
                await action.enterText(grpName, "search_group_textbox", 'Groups');
            }
            await page.waitForTimeout(500);
            console.log("User enters group name: " + grpName);
            //Click on Group
            let currentGroup =
                '//span[(@data-test-id="group-title") and (text()="' + grpName + '")]';
            await page.click(currentGroup);
            await action.waitforInvisibilityOfSpinner()
            console.log(grpName + " is open now");
            await page.waitForTimeout(500);
        } catch (err) {
            throw err;
        }
    }
);

Then(
    "User will create {string} app {string} with {string} in {string} screen",
    async (appType, applicationName, appDsp, pageScreen) => {
        try {
            await page.waitForTimeout(500);
            await action.ClickElement("New_Application_button", pageScreen);
            console.log("User clicks on New Application button");
            const today = moment();
            let dateTime = today.format("YYYYMMDDhhmmss");
            let expapplicationName = CommonUtilObject.readUsecaseTestData(
                process.env.FileName,
                applicationName
            );
            let newExpText = expapplicationName + dateTime;
            console.log("App Name: " + newExpText);
            process.env.applicationName = newExpText;
            CommonUtilObject.writeUsecaseTestData(
                process.env.FileName,
                "Application_Name",
                newExpText
            );
            //Enter App Name
            await action.enterText(newExpText, "create_application_name", pageScreen);
            console.log("User entered " + appType + " App Name as: " + newExpText);
            await page.waitForTimeout(500);
            // App type
            // New || Existing
            if (appType == "New") {
                //Select App type
                await action.ClickElement(
                    "create_application_radio_newapp",
                    pageScreen
                );
                console.log("New Application");
            } else if (appType == "Existing") {
                await action.ClickElement(
                    "create_application_radio_extapp",
                    pageScreen
                );
                console.log("Existing Application");
                //Select File for existing app
                await page.waitForTimeout(500);
                let fileType = CommonUtilObject.readUsecaseTestData(
                    process.env.FileName,
                    "FileType"
                );
                let sourceType = CommonUtilObject.readUsecaseTestData(
                    process.env.FileName,
                    "SourceType"
                );
                let frequency = CommonUtilObject.readUsecaseTestData(
                    process.env.FileName,
                    "Frequency"
                );
                if( sourceType== "Data List"){
                    await action.ClickElement("dataListSourceType", pageScreen);
                }
                else if( sourceType== "File"){
                    await action.ClickElement("fileSourceType", pageScreen);
                    await action.selectDropdownbytagName('div',
                        "fileTypeDropdown",
                        fileType,
                        pageScreen
                    );
                }

                let fileName = CommonUtilObject.readUsecaseTestData(
                    process.env.FileName,
                    "FileName"
                );
                await page.waitForTimeout(500);
                await action.selectDropdownbytagName('Span',
                    "sourceTypeDropdown",
                    fileName,
                    pageScreen
                );
                let identifierValue: any = [];
                identifierValue = CommonUtilObject.readUsecaseTestData(
                    process.env.FileName,
                    "ApplicationIdentifier"
                );
                if (identifierValue) {
                    let identifier: any = [];
                    identifierValue = identifierValue.replace("[", "");
                    identifierValue = identifierValue.replace("]", "");
                    identifierValue = identifierValue.replace("", "");
                    identifier = identifierValue.split(",");
                    console.log("Number of applicationIdentifier: " + identifier.length);
                    for (let i = 0; i < identifier.length; i++) {
                        if (identifier[i]) {
                            console.log(identifier[i])
                            await uniqueWidgets.fillAppidentifier(identifier[i])
                        }
                    }
                }
                await page.waitForTimeout(500);
                if (frequency == "Cron") {
                    await action.ClickElement(
                        "cronFrequency",
                        pageScreen
                    );
                    let cronExpression = CommonUtilObject.readUsecaseTestData(
                        process.env.FileName,
                        "CronExpression"
                    );
                    await action.enterText(cronExpression, "cronExpression", pageScreen);
                    console.log(frequency + "Option selected")

                }
                else if (frequency == "Hourly") {
                    await action.ClickElement(
                        "hourlyFrequency",
                        pageScreen
                    );
                    let hourlyExpression = CommonUtilObject.readUsecaseTestData(
                        process.env.FileName,
                        "Hours"
                    );
                    await action.selectDropdownbytagName("div[contains(@class,'p-dropdown-items')]//span", "hoursDropdown", hourlyExpression, pageScreen,);
                    console.log(frequency + "Option selected")
                }
                else if (frequency == "Daily") {
                    await action.ClickElement(
                        "Daily",
                        pageScreen
                    );
                    // PrefrdStartTime
                    let PreferredStartTime = CommonUtilObject.readUsecaseTestData(
                        process.env.FileName,
                        "PreferredStartTime"
                    );
                    await page.waitForTimeout(500);
                    await action.selectDropdownbytagName("div[contains(@class,'p-dropdown-items')]//span", "PreferredStartTime", PreferredStartTime, pageScreen,);
                    console.log(frequency + "Option selected")

                    await page.waitForTimeout(500);
                     // StartDate
                    let StartDate = CommonUtilObject.readUsecaseTestData(
                        process.env.FileName,
                        "StartDate"
                    );
                    if(StartDate){ 
                    await action.selectDropdownbytagName("div[contains(@class,'p-dropdown-items')]//span", "StartDate", StartDate, pageScreen,);
                    console.log(frequency + "StartDate selected")

                    // StartTime
                    let StartTime = CommonUtilObject.readUsecaseTestData(
                        process.env.FileName,
                        "StartTime"
                    );
                    await action.enterText(StartTime, "StartTime", pageScreen,);
                    console.log(StartTime + "StartTime selected")

                    // EndDate
                    let EndDate = CommonUtilObject.readUsecaseTestData(
                        process.env.FileName,
                        "EndDate"
                    );
                    await action.selectDropdownbytagName("div[contains(@class,'p-dropdown-items')]//span", "EndDate", EndDate, pageScreen,);
                    console.log(frequency + "EndDate selected")

                    // EndTime
                    let EndTime = CommonUtilObject.readUsecaseTestData(
                        process.env.FileName,
                        "EndTime"
                    );
                    await action.enterText(EndTime, "EndTime", pageScreen,);
                    console.log(EndTime + "EndTime selected")
                    }

                }
            } else if (appType == "Static") {
                //Select App type
                await action.ClickElement(
                    "create_application_radio_staticapp",
                    pageScreen
                );
                let frequency = CommonUtilObject.readUsecaseTestData(
                    process.env.FileName,
                    "Frequency"
                );
                if (frequency == "Cron") {
                    await action.ClickElement(
                      "cronFrequency",
                      pageScreen
                    );
                    let cronExpression = CommonUtilObject.readUsecaseTestData(
                        process.env.FileName,
                        "CronExpression"
                    );
                    await action.enterText(cronExpression, "cronExpression", pageScreen);
                    console.log(frequency + "Option selected")

                }
                else if (frequency == "Hourly") {
                    await action.ClickElement(
                        "hourlyFrequency",
                        pageScreen
                    );
                    let hourlyExpression = CommonUtilObject.readUsecaseTestData(
                        process.env.FileName,
                        "Hours"
                    );
                    await action.selectDropdownbytagName("div[contains(@class,'p-dropdown-items')]//span", "hoursDropdown", hourlyExpression, pageScreen,);
                    console.log(frequency + "Option selected")
              
                  }
                console.log("Static Application");
            }
            else {
                console.log("Application with type: " + appType + " cannot be created");
            }
            //Enter App description
            let appDescription = CommonUtilObject.readUsecaseTestData(
                process.env.FileName,
                appDsp
            );
            await action.enterText(
                appDescription,
                "create_application_description",
                pageScreen
            );
            //Add App Admins
            let admins: any = [];
            admins = CommonUtilObject.getTestData("AppAdmins");
            let appAdmins: any = [];
            admins = admins.replace("[", "");
            admins = admins.replace("]", "");
            admins = admins.replace("", "");
            appAdmins = admins.split(",");
            console.log("Number of Group Admins: " + appAdmins.length);
            console.log(appAdmins);
            await action.selectDropdownbyMultipleText(
                "create_group_Admins_Dropdown",
                appAdmins,
                "Groups"
            );
            await action.ClickElement("create_app_Admins_OK_button", pageScreen);
            console.log("Save button clicked");
            //Save Application
            await page.waitForTimeout(500);
            await action.ClickElement("create_app_save_button", pageScreen);
            await page.waitForTimeout(500);
            console.log(
                "User created " +
                appType +
                " app with name: " +
                newExpText +
                " in " +
                pageScreen
            );
        } catch (exp) {
            throw exp;
        }
    }
);

Then('user will clone {string} and save {string} in {string} screen', async (appName, clonedAppName, pageScreen) => {
    //serach app
    await action.ClickElement("search_application_textbox", pageScreen);
    //app name
    let Appname = CommonUtilObject.readUsecaseTestData(
        process.env.FileName,
        appName
    );
    await action.enterText(Appname.trim(), "search_application_textbox", pageScreen);
    //open app setting panel to clone
    let editBtn = page.locator('//div[contains(@class,"card-title") and contains(text(),"' + Appname + '")]/../../..//finlevit-options-button[@data-test-id="app-options-btn"]//button')
    await page.waitForTimeout(500);
    await editBtn.click();
    await page.waitForTimeout(500);
    //click clone
    let cloneBtn = page.locator('//span[text()="Clone"]');
    await cloneBtn.click();
    await page.waitForTimeout(500);
    //verify clone app popup
    await cloneBtn.click();
    await page.waitForTimeout(3000);
    CommonUtilObject.writeUsecaseTestData(process.env.FileName, clonedAppName, Appname + " Copy 1");
    //clikc open app
    let clonedApp = page.locator('//div[contains(@class,"card-title") and contains(text(),"' + Appname + ' Copy 1")]')
    await clonedApp.isVisible();
    console.log('Application with Name: ' + Appname + ' has been cloned Sucessfully with Name: ' + Appname + " Copy 1");
});

// Chnage the widget type in Existing Application
When(
    "User choose field {string} the type {string} and the widget is {string} in screen",
    async (FieldName, options, options2, table: DataTable) => {
        const formValues = table.hashes();

        for (let i = 0; i < formValues.length; i++) {
            await page.waitForTimeout(3000);
            console.log(FieldName, options, options2);
            //for 1st dropdown
            let FieldType = page.locator(
                "(//mat-tree-node//p[contains(text(),'" +
                formValues[i].FieldName +
                "')]/../..//finlevit-lib-select[@placeholder='Select type']//span)[1]"
            );
            await FieldType.click();
            console.log("the field name is" + formValues[i].FieldName);
            let optionElement = page.locator(
                '//li//span[contains(text(),"' + formValues[i].options + '")]'
            );
            await optionElement.click();
            console.log("user choose the type as" + formValues[i].options);
            //for 2nd dropdown
            let FieldWidget = page.locator(
                "(//mat-tree-node//p[contains(text(),'" +
                formValues[i].FieldName +
                "')]/../..//finlevit-lib-select[@placeholder='Select Widget']//span)[1]"
            );
            await FieldWidget.click();
            let Widget = page.locator(
                '//li//span[contains(text(),"' + formValues[i].options2 + '")]'
            );
            await Widget.click();
            console.log("user choose the type as" + formValues[i].options2);
        }
    }
);

Then(
    "User will search for {string} in {string} screen",
    async (appName, pageScreen) => {
        try {
            //serach app
            await action.ClickElement("search_application_textbox", pageScreen);
            //app name
            let Appname = CommonUtilObject.readUsecaseTestData(
                process.env.FileName,
                appName
            );
            await action.enterText(Appname.trim(), "search_application_textbox", pageScreen);
            await action.waitforInvisibilityOfSpinner()
            //click on app
            let currentApp =
                '//div[contains(@class,"card-title") and contains(text(),"' +
                Appname +
                '")]';
            await page.waitForSelector(currentApp, { timeout: 60000 });
            await page.click(currentApp, {timeout:60000});
            console.log(Appname + " is open now");
        } catch (err) {
            throw err;
        }
    }
);

Then(
    "User will publish the app with latest changes after adding {string} in {string} screen",
    async (expectedText, pageScreen) => {
        try {
            //click on verify and publish
            await action.ClickElement("VerifyPublish", pageScreen);
            //Save the current version
            let applicationName = CommonUtilObject.readUsecaseTestData(
                process.env.FileName,
                "Application_Name"
            );
            expectedText = CommonUtilObject.readUsecaseTestData(
                process.env.FileName,
                expectedText
            );
            console.log(
                "User enter" +
                expectedText +
                " in" +
                "Version Description" +
                " in " +
                pageScreen +
                " screen"
            );
            console.log(expectedText);
            await uniqueWidgets.VersionDescription(
                expectedText,
                "VersionDescription",
                pageScreen
            );
            let LatestVersion = await assertion.getAttributevalue(
                "VersionNo",
                "Version"
            );
            console.log(LatestVersion);
            CommonUtilObject.writeUsecaseTestData(
                process.env.FileName,
                "LatestVersionNO",
                LatestVersion
            );
            // Save Version Changes
            await action.ClickElement("SaveVersion", pageScreen);
            console.log(
                "User Published Version:" + LatestVersion + " for the App: " + applicationName
            );
            await page.waitForTimeout(500);
        } catch (err) {
            throw err;
        }
    }
);

Then(
    "User {string} the {string} role and add {string} in {string} screen",
    async (type, role, user, pageScreen) => {
        try {
            await action.ClickElement("roles_menu", pageScreen);
            console.log("User clicked on Roles tab");
            let users: any = [];
            users = CommonUtilObject.getTestData(user);
            let roleUsers: any = [];
            users = users.replace("[", "");
            users = users.replace("]", "");
            users = users.replace("", "");
            roleUsers = users.split(",");
            console.log(users);
            console.log("Number of Users: " + roleUsers.length);
            if (type == "Edit") {
                let roleEdit =
                    "//div[contains(text(),'" +
                    role +
                    "')]/../../../../..//button//span[text()='Edit']";
                await page.click(roleEdit);
                console.log("Edit Button Clicked");
                await action.selectDropdownbyMultipleText(
                    "AddRoleMembers",
                    roleUsers,
                    pageScreen
                );
            } else if (type == "Add") {
                await action.ClickElement("Add_Role", pageScreen);
                await action.fillText(role, "Add_Role_Name", pageScreen);
                let roleDes = "Role Description for Role: " + role;
                await action.fillText(roleDes, "Add_Role_Description", pageScreen);
                await action.selectDropdownbyMultipleText(
                    "AddRoleMembers",
                    roleUsers,
                    pageScreen
                );
            } else {
                console.log("Roles can only be edited or added");
            }
            CommonUtilObject.writeUsecaseTestData(process.env.FileName, user, users);
            await action.ClickElement("create_app_Manager_OK_button", "Application");
            await action.ClickElement("create_app_save_button", "Application");
            console.log(
                "User " + type + "ed " + role + " and added Users: " + roleUsers
            );
        } catch (err) {
            throw err;
        }
    }
);

When(
    "User expand {string} widgets in {string} in {string} screen",
    async (widgetType, destElement, pageScreen, table: DataTable) => {
        try {
            const formValues = table.hashes();
            for (let i = 0; i < formValues.length; i++) {
                console.log(formValues);
                await uniqueWidgets.ExpandGivenWidget(
                    widgetType,
                    formValues[i].Widget,
                    destElement,
                    pageScreen,
                    Number(formValues[i].X),
                    Number(formValues[i].Y)
                );
            }
        } catch (err) {
            throw err;
        }
    }
);

//prefixText//suffixText
When(
    "User click {string} and in {string} type as {string} in {string} screen",
    async (elementName, elementName2, expectedText, pageScreen) => {
        try {
            console.log(
                "User click" +
                elementName +
                "and in " +
                elementName2 +
                "type as " +
                expectedText +
                "in" +
                pageScreen +
                " screen"
            );
            let reqElement = page.locator(
                "//konfig-grid-item//*[contains(text(),'" +
                elementName +
                "')]"
            );
            await reqElement.click({ button: "right" });
            await action.ClickElement("EditWidget", pageScreen);
            await page.waitForTimeout(500);
            await action.ClickElement("INPUT", pageScreen);
            await action.enterText(expectedText, elementName2, pageScreen);
            await action.ClickElement("WidgetSave", pageScreen);
            await page.waitForTimeout(500);
            console.log("Clicked on save button");
            await assertion.checktext(
                "SavedSuccessfully",
                pageScreen,
                "Saved successfully"
            );
            let actualText = await reqElement.textContent();
            console.log("actualText is" + actualText);
        } catch (err) {
            throw err;
        }
    }
);

//Prefixicon//Suffixicon
When(
    "User click {string} and select {string} icon  as {string} and type as {string} in {string} screen",
    async (elementName, expectedText1, expectedText, options, pageScreen) => {
        try {
            console.log(
                "User click" +
                elementName +
                "and select" +
                expectedText1 +
                " icon  as" +
                expectedText +
                "and type as " +
                options +
                "in" +
                pageScreen +
                " screen"
            );
            let reqElement = page.locator(
                "//konfig-grid-item//*[contains(text(),'" +
                elementName +
                "')]"
            );
            await reqElement.click({ button: "right" });
            await action.ClickElement("EditWidget", pageScreen);
            await page.waitForTimeout(500);
            await action.ClickElement("INPUT", pageScreen);
            await action.ClickElement(expectedText1, pageScreen);
            await action.enterText(expectedText, "SearchIcon", pageScreen);
            await action.ClickElement("SelectIcon", pageScreen);
            await page.waitForTimeout(500);
            await action.selectDropdownbyText("IconStyle", pageScreen, options);
            await action.ClickElement("WidgetSave", pageScreen);
            await page.waitForTimeout(500);
            console.log("Clicked on save button");
            await assertion.checktext(
                "SavedSuccessfully",
                pageScreen,
                "Saved successfully"
            );
            let actualText = await reqElement.textContent();
            console.log("actualText is" + actualText);
        } catch (err) {
            throw err;
        }
    }
);

When(
    "User click {string} and add below columns in {string} screen",
    async (elementName, pageScreen, table: DataTable) => {
        try {
            const formValues = table.hashes();
            //column1
            for (let i = 0; i < formValues.length; i++) {
                console.log(
                    "User click " +
                    formValues[i].Name +
                    "and add columns in " +
                    pageScreen +
                    " screen"
                );
                let column1 = await ScreenMap.get(pageScreen).getSelector("Column1");
                await page.isVisible(column1).then(async (exist) => {
                    if (exist == true) {
                        await action.ClickElement("Column1", pageScreen);
                    } else {
                        await action.ClickElement("AddColumn", pageScreen);
                    }
                });
                await action.fillText(formValues[i].Name, "ColumnName", pageScreen);
                await action.selectDropdownbyspantext(
                    "ColumnType",
                    pageScreen,
                    formValues[i].ColumnType
                );
                await action.ClickElement(formValues[i].Alignment, pageScreen);
                await page.waitForTimeout(500);
                await action.fillText(formValues[i].FieldLabel, "FieldLabel", pageScreen);
                if (formValues[i].ColumnType == "Radio Group") {
                    await uniqueWidgets.InputItems(formValues[i], "UniqueWidgetFields");
                } else if (formValues[i].ColumnType == "Number") {
                    await uniqueWidgets.NumberFormat(formValues[i], "UniqueWidgetFields");
                } else if (formValues[i].ColumnType == "Modal") {
                    await uniqueWidgets.PagesinModal(formValues[i], pageScreen);
                } else if (formValues[i].ColumnType == "Dropdown") {
                    await uniqueWidgets.addDropdownValues(formValues[i], "UniqueWidgetFields");
                } else if (formValues[i].ColumnType == "Text Area") {
                    await uniqueWidgets.addDropdownValues(formValues[i], "UniqueWidgetFields");
                }
            }
        } catch (err) {
            throw err;
        }
    }
);

When(
    "User scroll to an element {string} in {string} screen",
    async (elementName, pageScreen) => {
        try {
            let reqElement =
                "//konfig-grid-item//*[contains(text(),'" +
                elementName +
                "')]";
            await page.waitForTimeout(500);
            await uniqueWidgets.ScrolltoElement(reqElement);
            await page.waitForTimeout(500);
        } catch (err) {
            throw err;
        }
    }
);

When(
    "User write {string} widgets in {string} in {string} screen",
    async (widgetType, widgetName, pageScreen) => {
        try {
            if (widgetType == "Front Office") {
                console.log("FOWidgets are " + FOWidgets[randomNumFO]);
                CommonUtilObject.writeUsecaseTestData(
                    process.env.FileName,
                    widgetName,
                    FOWidgets[randomNumFO]
                );
            } else if (widgetType == "Back Office") {
                console.log("BOWidgets are " + BOWidgets[randomNumBO]);
                CommonUtilObject.writeUsecaseTestData(
                    process.env.FileName,
                    widgetName,
                    BOWidgets[randomNumBO]
                );
            }
        } catch (err) {
            throw err;
        }
    }
);

When("User scroll to an element in {string} screen", async (pageScreen) => {
    try {
        await page.waitForTimeout(3000);
        let canvas = page.locator(
            "//konfig-grid//div"
        );
        await canvas.evaluate(() => {
            window.scrollBy(0, 1000);
        });
        await page.waitForTimeout(3000);
    } catch (err) {
        throw err;
    }
});

When(
    "User drag using mouse to an element {string} in {string} screen",
    async (elementName, pageScreen) => {
        try {
            const source = await page.locator(
                "//*[contains(text(),'" +
                elementName +
                "')]/ancestor::finlevit-custom-adv-table[1]/../../..//div[@class='corner bottom-right']//div[@class='resize-handle']"
            );
            const sourceBoundingBox = await source.boundingBox();
            console.log("sourceBoundingBox.width" + sourceBoundingBox.width);
            await page.mouse.move(
                sourceBoundingBox.x + sourceBoundingBox.width / 2,
                sourceBoundingBox.y + sourceBoundingBox.height / 2
            );
            await page.mouse.down();
            await page.waitForSelector(
                "//konfig-grid//div | //konfig-grid//div"
            );
            await page.mouse.move(1500, 850);
            await page.waitForTimeout(500); // wait for a second to simulate a pause during the drag and drop
            await page.mouse.up();
            console.log("Done");
            await action.ClickElement("CanvasSave", pageScreen);
            await action.ClickElement("CanvasSave", pageScreen);
        } catch (err) {
            throw err;
        }
    }
);

When("User refresh the page screen", async () => {
    await page.reload();
});

Then(
    "User select the below source and upload the payload with identifiers in {string} screen",
    async (pageScreen, table: DataTable) => {
        let formValues = table.hashes();
        for (let i = 0; i < formValues.length; i++) {
            //click upload payload button UploadPayload
            await action.ClickElement("UploadPayload", pageScreen);
            //select source SelectSource
            await action.selectDropdownbyText(
                "SelectSource",
                pageScreen,
                formValues[i].SelectSource
            );
            //uploadfile
            const handle = await page.locator("//input[@type='file']");
            await handle.setInputFiles("ExistApp/" + formValues[i].fileName + ".json");
            let count: Number = formValues[i].ValueCount;
            await uniqueWidgets.AppIdentifiers(formValues[i]);
            await action.ClickElement("PayloadSave", pageScreen);
        }
        await action.ClickElement("Next", pageScreen);
    }
);

When(
    "User set Default value {string} to the {string} field {string} in {string} screen",
    async (value, typeOfWidget, elementName, pageScreen) => {
        try {
            console.log(
                "User set Default value " +
                value +
                " to the " +
                typeOfWidget +
                " field " +
                elementName +
                " in " +
                pageScreen +
                " screen"
            );
            await page.waitForTimeout(500);
            let reqElement = page.locator(
                "//konfig-grid-item//*[contains(text(),'" +
                elementName +
                "')]/../../../.."
            );
            await reqElement.click({ button: "right" });
            await page.waitForTimeout(500);
            await action.ClickElement("EditWidget", pageScreen);
            await page.waitForTimeout(500);
            if (typeOfWidget == "Dropdown") {
                await action.ClickElement("INPUT", pageScreen);
                await action.selectDropdownbytagName(
                    "span",
                    "DefaultValueDropdown",
                    value,
                    pageScreen
                );
            }
            else if (typeOfWidget == "Text Input") {
                await action.ClickElement("INPUT", pageScreen);
                await action.enterText(
                    value,
                    "DefaultValue",
                    pageScreen
                );
            }
            else if (typeOfWidget == "Checkbox") {
                await action.ClickElement("CheckBox", pageScreen);
                await action.ClickElement("CheckBoxDefaultValueChecked", pageScreen);
            }
            await page.waitForTimeout(500);
            await action.ClickElement("WidgetSave", pageScreen);
            await page.waitForTimeout(500);
            console.log("Clicked on save button");
            await assertion.checktext(
                "SavedSuccessfully",
                pageScreen,
                "Saved successfully"
            );
        } catch (err) {
            throw err;
        }
    }
);

When("User reloads the page", async () => {
    await page.reload({ timeout: 100000 });
    console.log("User reloads the page");
});

When(
    "User create group {string} with description {string} in {string} screen",
    async (groupName, Description, pageScreen) => {
        console.log(
            "User create group " +
            groupName +
            " with " +
            Description +
            " in " +
            pageScreen +
            " screen"
        );
        try {
            await action.waitforInvisibilityOfSpinner()
            await action.ClickElement("Group", "HomePage");
            await page.waitForTimeout(500);
            let Groupbtn = await ScreenMap.get("Groups").getSelector(
                "create_group_button"
            );
            let checkGroupbtn = await page.isVisible(Groupbtn).then(async (exist) => {
                return exist;
            });
            console.log("Create group button visibility is " + checkGroupbtn);
            if (checkGroupbtn == true) {
                await action.ClickElement("create_group_button", "Groups");
                await page.waitForTimeout(500);
            } else {
                await action.ClickElement("create_group_icon", "Groups");
                await page.waitForTimeout(500);
            }
            await uniqueWidgets.AddGroup(groupName, Description, pageScreen);
            process.env.GroupName = groupName;
            await action.waitforInvisibilityOfSpinner();
        } catch (err) {
            throw err;
        }
    }
);

When(
    "User edit {string} as {string} in {string} screen",
    async (scenario, elementValue, pageScreen) => {
        console.log(
            "User User edit " +
            scenario +
            " as " +
            elementValue +
            " in " +
            pageScreen +
            " screen"
        );
        try {
            await action.ClickElement("search_group", pageScreen);
            await page.waitForTimeout(500);
            await action.enterText(
                process.env.GroupName,
                "search_group_textbox",
                pageScreen
            );
            console.log(
                "User enters " + process.env.GroupName + " in " + pageScreen + " screen"
            );
            await page.waitForTimeout(500);
            await action.ClickElement("group_menu_option", pageScreen);
            await page.waitForTimeout(500);
            await action.ClickElement("EditWidget", "UniqueWidgetFields");
            if (scenario == "Description") {
                await action.fillText(
                    elementValue,
                    "create_group_description",
                    pageScreen
                );
            } else if (scenario == "Group Admin") {
                await action.selectDropdownbytagName(
                    "label",
                    "create_group_Admins_Dropdown",
                    elementValue,
                    pageScreen
                );
                await action.ClickElement("create_group_Admins_OK_button", pageScreen);
                await page.waitForTimeout(500);
            } else if (scenario == "GroupName") {
                await action.fillText(elementValue, "create_group_name", pageScreen);
            }
            await action.ClickElement("create_group_save_button", pageScreen);
            await page.waitForTimeout(500);
            await action.ClickElement("Close_Search_group", "Groups");
        } catch (err) {
            throw err;
        }
    }
);

When(
    "User edit group name with already exist group name in {string} screen",
    async (pageScreen) => {
        console.log(
            "User edit group name with already exist group name in " +
            pageScreen +
            " screen"
        );
        try {
            let firstGroup = await action.getText("first_group_title", pageScreen);
            await action.ClickElement("search_group", pageScreen);
            await page.waitForTimeout(500);
            await action.enterText(
                process.env.GroupName,
                "search_group_textbox",
                pageScreen
            );
            console.log(
                "User enters " + firstGroup + " in " + pageScreen + " screen"
            );
            await page.waitForTimeout(500);
            await action.ClickElement("group_menu_option", pageScreen);
            await page.waitForTimeout(500);
            await action.ClickElement("EditWidget", "UniqueWidgetFields");
            await action.fillText(firstGroup, "create_group_name", pageScreen);
            await action.ClickElement("create_group_save_button", pageScreen);
            await page.waitForTimeout(500);
            let expectedText =
                "FL1109 : Group name " + firstGroup + " has already been used.";
            await assertion.checktext(
                "Group_alert_messgae",
                pageScreen,
                expectedText
            );
            await action.ClickElement("Group_alert_close", pageScreen);
            await action.ClickElement("create_group_cancel_button", pageScreen);
            await action.ClickElement("Close_Search_group", "Groups");
        } catch (err) {
            throw err;
        }
    }
);

When(
    "User delete group {string} in {string} screen",
    async (groupName, pageScreen) => {
        console.log(
            "User delete group " + groupName + " in " + pageScreen + " screen"
        );
        try {
            await action.ClickElement("search_group", pageScreen);
            await page.waitForTimeout(500);
            if (groupName.startsWith("#")) {
                groupName = CommonUtilObject.readUsecaseTestData(process.env.FileName, groupName.replace("#", ""));
                await action.enterText(
                    groupName,
                    'search_group_textbox',
                    pageScreen
                );
            } else {
                await action.enterText(groupName, "search_group_textbox", pageScreen);
            }
            console.log("User enters " + groupName + " in " + pageScreen + " screen");
            await page.waitForTimeout(500);
            // await action.waitforInvisibilityOfSpinner();
            let groupElement = "//ul[@data-test-id='groups-list']//li[normalize-space(text()='" + groupName + "')]"
            await page.isVisible(groupElement).then(async (exist) => {
                if (exist == true) {
                    await action.ClickElement("select_first_group", pageScreen);
                    await action.waitforInvisibilityOfSpinner();
                    await action.ClickElement("group_menu_option", pageScreen);
                    await page.waitForTimeout(500);
                    await action.ClickElement("DeleteWidget", "UniqueWidgetFields");
                    await action.ClickElement("DeleteSubmit", "UniqueWidgetFields");
                    await action.waitforVisibilityOfSpinner();
                    await action.waitforInvisibilityOfSpinner();
                    await action.ClickElement("Close_Search_group", "Groups");
                    await action.ClickElement("search_group", pageScreen);
                    await page.waitForTimeout(500);
                    if (groupName.startsWith("#")) {
                        await action.enterText(
                            CommonUtilObject.readUsecaseTestData(process.env.FileName, groupName.replace("#", "")),
                            'search_group_textbox',
                            pageScreen
                        );
                    } else {
                        await action.enterText(groupName, "search_group_textbox", pageScreen);
                    }
                    let first_group = await ScreenMap.get("Groups").getSelector(
                        "select_first_group"
                    );
                    await assertion.checkElementnotVisible(first_group);
                    await action.ClickElement("Close_Search_group", pageScreen);
                } else {
                    await action.ClickElement("Close_Search_group", pageScreen);
                    console.log("Group " + groupName + " does not exist")
                }
            });
        } catch (err) {
            throw err;
        }
    }
);

When(
    "User edits {string} {string} to update {string} mapping for {string} event in {string} screen",
    async (widgetType, elementName, eventType, eventName, pageScreen) => {
        try {
            //edit widget
            let reqElement = page.locator(
                "//konfig-grid-item//*[contains(text(),'" +
                elementName +
                "')]"
            );
            //expand events tab
            await reqElement.click({ button: "right" });
            await action.ClickElement("EditWidget", pageScreen);
            await page.waitForTimeout(500);
            await action.ClickElement("Events", pageScreen);
            // edit the evenName
            let tempEvent = page.locator(
                "//div[contains(text(),'" + eventName + "') and @class='ml-1']"
            );
            await tempEvent.click();
            //eventType == SP then click on configure API
            if (eventType == "Service Providers") {
                let configAPI = page.locator(
                    "//span[contains(text(),'Configure API')]"
                );
                await configAPI.click();
                console.log("User edited the " + eventType + " with name" + eventName);
            }
            await transformationUI.expandInputConfiguration();
        } catch (err) {
            throw err;
        }
    }
);

When(
    "User edit {string} action and set {string} on widget {string} in {string} screen",
    async (eventName, actionName, widget, pageScreen, dataTable) => {
        try {
            const formValues = dataTable.hashes();
            console.log(formValues.length);
            //edit widget
            let reqElement = page.locator(
                "//konfig-grid-item//*[contains(text(),'" +
                widget +
                "')]/../..//button"
            );
            await reqElement.click({ button: "right" });
            await action.ClickElement("EditWidget", pageScreen);
            await page.waitForTimeout(500);
            let elementExist = await page.isVisible(await ScreenMap.get(pageScreen).getSelector("WidgetName")).then(async (exist) => {
                return exist;
            });
            if (elementExist == true) {
                console.log("Edit widget opened")
            }
            else {
                await reqElement.dblclick();
            }

            //expand events tab
            await action.ClickElement("Events", pageScreen);
            //add edit action
            let tempEvent = page.locator(
                "//div[contains(text(),'" + eventName + "') and @class='ml-1']"
            );
            await tempEvent.click();
            //select reset fields values
            await page.waitForTimeout(500);
            await action.selectDropdownbyspantext(
                "EventClickActionInputbox",
                pageScreen,
                actionName
            );
            await page.waitForTimeout(500);
            let fieldsDropdown = page.locator(
                "//div[text()=' Fields']/../..//div//span[contains(@class,'pi-chevron-down')]"
            );
            await fieldsDropdown.click();
            // await page.waitForTimeout(500);
            // selcet all dataTable fields
            for (let i = 0; i < formValues.length; i++) {
                console.log(i);
                await page.waitForTimeout(500);
                let tempOption = page.locator(
                    "//div[text()='" +
                    formValues[i].Widgets +
                    "']/../..//div[contains(@class,'checkbox-box')]"
                );
                await tempOption.click();
            }
        } catch (err) {
            throw err;
        }
    }
);

When(
    "User create {string} App {string} with description {string} in {string} screen",
    async (typeofApp, applicationName, Description, pageScreen) => {
        console.log(
            "User create " +
            typeofApp +
            " App " +
            applicationName +
            " with description" +
            Description +
            " in " +
            pageScreen +
            " screen"
        );
        try {
            await page.waitForTimeout(500);
            await action.ClickElement("New_Application_button", pageScreen);
            await page.waitForTimeout(500);
            await uniqueWidgets.CreateApp(typeofApp, applicationName, Description, pageScreen);
            process.env.applicationName = applicationName;
        } catch (err) {
            throw err;
        }
    }
);

When(
    "User edit app {string} as {string} in {string} screen",
    async (scenario, elementValue, pageScreen) => {
        console.log(
            "User User edit app " +
            scenario +
            " as " +
            elementValue +
            " in " +
            pageScreen +
            " screen"
        );
        try {
            await action.ClickElement("search_application_textbox", pageScreen);
            await page.waitForTimeout(500);
            await action.enterText(
                process.env.applicationName,
                "search_application_textbox", pageScreen
            );
            console.log(
                "User enters " + process.env.applicationName + " in " + pageScreen + " screen"
            );
            await page.waitForTimeout(500);
            await action.ClickElement("app_menu_option", pageScreen);
            await page.waitForTimeout(500);
            await action.ClickElement("EditWidget", "UniqueWidgetFields");
            if (scenario == "Description") {
                await action.fillText(
                    elementValue,
                    "create_application_description",
                    pageScreen
                );
                process.env.AppDescription = elementValue;
            } else if (scenario == "App Admin") {
                await action.selectDropdownbytagName(
                    "label",
                    "create_group_Admins_Dropdown",
                    elementValue,
                    'Groups'
                );
                await action.ClickElement("create_group_Admins_OK_button", 'Groups');
                await page.waitForTimeout(500);
            } else if (scenario == "applicationName") {
                await action.fillText(elementValue, "create_application_name", pageScreen);
                process.env.applicationName = elementValue;
            }
            await action.ClickElement("create_app_save_button", pageScreen);
            await page.waitForTimeout(500);
            await action.ClickElement("clear_app_search", pageScreen);
            await page.waitForTimeout(500);
        } catch (err) {
            throw err;
        }
    }
);

When(
    "User edit app name with already exist app name {string} in {string} screen",
    async (dupapplicationName, pageScreen) => {
        console.log(
            "User edit app name with already exist app name in " +
            pageScreen +
            " screen"
        );
        try {
            await action.ClickElement("search_application_textbox", pageScreen);
            await page.waitForTimeout(500);
            await action.enterText(
                process.env.applicationName,
                "search_application_textbox",
                pageScreen
            );
            await page.waitForTimeout(500);
            await action.ClickElement("app_menu_option", pageScreen);
            await page.waitForTimeout(500);
            await action.ClickElement("EditWidget", "UniqueWidgetFields");
            await action.fillText(dupapplicationName, "create_application_name", pageScreen);
            await action.ClickElement("create_group_save_button", 'Groups');
            await page.waitForTimeout(500);
            let expectedText =
                "FL1057 : Application name " + dupapplicationName + " is already in use."
            await assertion.checktext(
                "Group_alert_messgae",
                'Groups',
                expectedText
            );
            await action.ClickElement("Group_alert_close", 'Groups');
            await action.ClickElement("create_app_cancel_button", pageScreen);
            await action.ClickElement("clear_app_search", pageScreen);
        } catch (err) {
            throw err;
        }
    }
);

When(
    "User delete app {string} in {string} screen",
    async (applicationName, pageScreen) => {
        console.log(
            "User delete app " + applicationName + " in " + pageScreen + " screen"
        );
        // let Appname = CommonUtilObject.readUsecaseTestData(
        //     process.env.FileName,
        //     applicationName
        // );
        try {
            await action.ClickElement("search_application_textbox", pageScreen);
            await page.waitForTimeout(500);
            let tempAppName;
            if (applicationName.startsWith("#")) {
                tempAppName = CommonUtilObject.readUsecaseTestData(
                    process.env.FileName,
                    applicationName.replace("#", ""))
            }
            else {
                tempAppName = applicationName
            }
            await action.enterText(tempAppName, "search_application_textbox", pageScreen);
            console.log("User enters " + applicationName + " in " + pageScreen + " screen");
            await page.waitForTimeout(500);
            let appElement = await ScreenMap.get(pageScreen).getSelector(
                "applicationEdit"
            );
            let elementPath;
            elementPath = await appElement.replace("elementName", tempAppName);
            await page.isVisible(elementPath).then(async (exist) => {
                if (exist == true) {
                    await action.ClickElement(page.locator(elementPath));
                    await page.waitForTimeout(500);
                    await action.ClickElement("DeleteWidget", "UniqueWidgetFields");
                    await action.ClickElement("DeleteSubmit", "UniqueWidgetFields");
                    await page.waitForTimeout(4000);
                    let alert = await ScreenMap.get("HomePage").getSelector("SystemAdminValidation")
                    await page.isVisible(alert).then(async (exist) => {
                        if (exist == true) {
                            await action.ClickElement("SystemAdminValidation", "HomePage")
                        } else {
                            console.log("no validation msg")
                        }
                    })
                    await action.waitforVisibilityOfSpinner();
                    await action.waitforInvisibilityOfSpinner();
                    await action.ClickElement("clear_app_search", pageScreen);
                    await action.ClickElement("search_application_textbox", pageScreen);
                    await page.waitForTimeout(500);
                    await action.enterText(tempAppName, "search_application_textbox", pageScreen);
                    await assertion.checkElementnotVisible(elementPath);
                    await action.ClickElement("clear_app_search", pageScreen);
                } else {
                    await action.ClickElement("clear_app_search", pageScreen);
                    console.log("Application " + applicationName + " does not Exist")
                }
            });
        } catch (err) {
            throw err;
        }
    }
);

When("User add status and name as {string} and {string} endTask in {string} screen", async (statusName, EndTask, pageScreen) => {
    console.log("User add status and name as " + statusName + " in " + pageScreen + " screen")
    try {
        await action.ClickElement("Status", pageScreen)
        await page.waitForTimeout(500);
        await action.ClickElement('AddStatus', pageScreen)
        await page.waitForTimeout(500);
        await action.enterText(statusName, 'StatusName', pageScreen);
        await page.waitForTimeout(500);
        if (EndTask == "Yes") {
            await action.ClickElement('EndTaskCheckbox', pageScreen)
            await action.ClickElement('StatusSave', pageScreen)
            await page.waitForTimeout(500);
            console.log("new status " + statusName + " is added as end task")
        } else if (EndTask == "No") {
            await action.ClickElement('StatusSave', pageScreen)
            await page.waitForTimeout(500);
            console.log("new status " + statusName + " is added")
        }
    } catch (error) {
        throw error;
    }
});

When(
    "User modify {string} FieldName as {string} and FieldLabel as {string} field in {string} screen",
    async (elementName, FieldName, FieldLabel, pageScreen) => {
        try {
            console.log(
                "User make " +
                elementName +
                "field as require field " +
                pageScreen +
                " screen"
            );
            await page.waitForTimeout(500);
            let reqElement = page.locator(
                "//konfig-grid-item//*[contains(text(),'" +
                elementName +
                "')]"
            ).first();
            await reqElement.click({ button: "right" });
            await page.waitForTimeout(500);
            await action.ClickElement("EditWidget", pageScreen);
            await page.waitForTimeout(500);
            await action.fillText(FieldName, "FieldName", pageScreen);
            await action.fillText(FieldLabel, "FieldLabel", pageScreen);
            await page.waitForTimeout(500);
            await action.ClickElement("WidgetSave", pageScreen);
            await page.waitForTimeout(500);
            console.log("Clicked on save button");
            // await assertion.checktext(
            //   "SavedSuccessfully",
            //   pageScreen,
            //   "Saved successfully"
            // );
        } catch (err) {
            throw err;
        }
    }
);

Then('User will add {string} in {string} screen', async (userGroup, pageScreen) => {

    if (userGroup == 'GroupAdmins') {
        //edit the group name
        let grpName = CommonUtilObject.readUsecaseTestData('resources/' + process.env.Env + 'TestData', 'GroupName');
        let grpEdit = page.locator('//span[text()="' + grpName + '"]/..//i[contains(@class,"ellipsis")]');
        await grpEdit.click();
        await page.locator("//span[text()='Edit']/..//i[contains(@class,'pencil')]").click();
        // select users
        let admins: any = [];
        admins = CommonUtilObject.getTestData("GroupAdmins");
        let grpAdmins: any = [];
        admins = admins.replace("[", "");
        admins = admins.replace("]", "");
        admins = admins.replace("", "");
        grpAdmins = admins.split(",");
        console.log(grpAdmins);
        console.log("Number of Group Admins: " + grpAdmins.length);

        let grpAdmin = await assertion.getAttributevalue('group_admin', 'Groups')
        if (!grpAdmin) {
            await action.selectDropdownbyMultipleText(
                "create_group_Admins_Dropdown",
                grpAdmins,
                "Groups"
            );
            await action.ClickElement("create_group_Admins_OK_button", "Groups");
            await page.waitForTimeout(500);
        }
        await action.ClickElement("create_group_save_button", "Groups");
        await page.waitForTimeout(500);
    } else if (userGroup == 'AppAdmins') {
        let applicationName = CommonUtilObject.readUsecaseTestData(
            process.env.FileName,
            "Application_Name"
        );
        //serach app
        await action.ClickElement("search_application_textbox", pageScreen);
        //app name
        await action.enterText(applicationName, "search_application_textbox", pageScreen);
        await page.waitForTimeout(3000);
        let appEdit = page.locator('//div[contains(@class,"card-title") and contains(text(),"' + applicationName + '")]/../../..//finlevit-options-button[@data-test-id="app-options-btn"]//button')
        await appEdit.click();
        await page
            .locator("//span[text()='Edit']/..//i[contains(@class,'pencil')]")
            .click();
        //Add App Admins
        let admins: any = [];
        admins = CommonUtilObject.getTestData(userGroup);
        let appAdmins: any = [];
        admins = admins.replace("[", "");
        admins = admins.replace("]", "");
        admins = admins.replace("", "");
        appAdmins = admins.split(",");
        console.log("Number of Application Admins: " + appAdmins.length);
        await action.selectDropdownbyMultipleText(
            "create_group_Admins_Dropdown",
            appAdmins,
            "Groups"
        );
        await action.ClickElement("create_app_Admins_OK_button", pageScreen);
        console.log("Save button clicked");
        //Save Application
        await page.waitForTimeout(500);
        await action.ClickElement("create_app_save_button", pageScreen);
        await page.waitForTimeout(500);
    }
});
Then(
    "User configure Field Permissions on widgets for {string} role {string} status in {string} screen",
    async (role, statusName, pageScreen, dataTable) => {
        try {
            const formValues = dataTable.hashes();
            //navigate to field permissions
            await page.waitForTimeout(500);
            await action.ClickElement("Settings", "Page");
            await page.waitForTimeout(500);
            await action.ClickElement("FiledPermissions", "Page");
            await page.waitForTimeout(500);
            let pageLimitLocator = await ScreenMap.get("Page").getSelector("PageLimit")
            if(page.isVisible(pageLimitLocator)){
                let pageLimitPresent = await page.isVisible(pageLimitLocator).then(async (exist) => {
                    return exist;
                })
                console.log("PageLimitPresent is " + pageLimitPresent)
                if (pageLimitPresent == true) {
                    await action.ClickElement("PageLimit", "Page");
                    await page.waitForTimeout(500);
                    await page.locator("//span[text()='50']").click();
                    console.log("Page Limit Set to 50 Records");
                }
            }
            //change role
            await page
                .locator(
                    "//*[@data-test-id='field-permissions-roles-dropdown']//p-dropdown"
                )
                .click();
            await page.waitForTimeout(500);
            await page.locator("//span[text()='" + role + "']").click();
            console.log(role + " has been selected");
            //change status
            await page
                .locator(
                    "//*[@data-test-id='field-permissions-status-dropdown']//p-dropdown"
                )
                .click();
            await page.waitForTimeout(500);
            await page.locator("//span[text()='" + statusName + "']").click();
            console.log(statusName + " has been selected");
            //loop for permissions

            for (let i = 0; i < formValues.length; i++) {
                if (formValues[i].Permission == "Disable") {
                    await page.waitForTimeout(500);
                    await page.locator("(//div[contains(text(),'" + formValues[i].fieldName + "')]/../../../..//div[contains(@class,'checkbox')])[1]").click();
                    await page.waitForTimeout(500);
                    console.log(formValues[i].fieldName + ' will be  Disabled');

                } else if (formValues[i].Permission == "Hide") {
                    await page.waitForTimeout(500);
                    await page.locator("(//div[contains(text(),'" + formValues[i].fieldName + "')]/../../../..//div[contains(@class,'checkbox')])[3]").click();
                    await page.waitForTimeout(500);
                    console.log(formValues[i].fieldName + ' will be  Hidden');
                } else {
                    console.log('Invalid Permission');
                }
            }
            //click save
            await action.ClickElement('Save', 'Page');
            console.log('Field permissions saved succesfully');
            await page.waitForTimeout(500);
        } catch (err) {
            console.log(err);
            throw err;
        }
    }
);
Then(
    "User Verify field permissions are working as expected in {string} screen",
    async (pageScreen, dataTable) => {
        try {
            const formValues = dataTable.hashes();
            //validate Field permissions
            console.log(
                "User will validate field permissions on " + pageScreen + " screen"
            );
            for (let i = 0; i < formValues.length; i++) {
                if (formValues[i].Permission == "Disable") {
                    //when field is disabled
                    await page.waitForTimeout(500);
                    await page
                        .locator(
                            "//div[contains(text(),'" +
                            formValues[i].fieldName +
                            "')]/../..//input"
                        )
                        .isDisabled();
                    await page.waitForTimeout(500);
                    console.log(formValues[i].fieldName + " is Disabled");
                } else if (formValues[i].Permission == "Hide") {
                    //when field is hidden
                    await page.waitForTimeout(500);
                    await page
                        .locator(
                            "//div[contains(text(),'" +
                            formValues[i].fieldName +
                            "')]/../..//input"
                        )
                        .isHidden();
                    await page.waitForTimeout(500);
                    console.log(formValues[i].fieldName + " is  Hidden");
                } else {
                    //invalid data table input
                    console.log("Invalid Permission");
                }
            }
            console.log("Field Permissions are working as expected");
        } catch (err) {
            console.log(err);
            throw err;
        }
    }
);
Then('User will rearrange the widgets {string} container in {string} screen', async (rootElement, pageScreen, dataTable) => {
    try {
        const formValues = dataTable.hashes();
        for (let i = 0; i < formValues.length; i++) {
            //scroll until view of widget
            console.log(formValues[i]);
            let srcElement = page.locator("//div[contains(text(),'" + rootElement + "')]/..//*[contains(text(),'" + formValues[i].Widget + "')]");
            //  await srcElement.scrollIntoViewIfNeeded();
            let sourceWidget;
            if (formValues[i].Widget == 'Url') {
                sourceWidget = "//div[contains(text(),'" + rootElement + "')]/..//*[contains(text(),'" + formValues[i].Widget + "')]/../..//div";
            } else {
                sourceWidget = "//div[contains(text(),'" + rootElement + "')]/..//*[contains(text(),'" + formValues[i].Widget + "')]";
            }
            //drag and drop at X & Y
            await page.dragAndDrop(
                sourceWidget,
                "//div[contains(text(),'" + rootElement + "')]/..//gridster",
                {
                    targetPosition: {
                        x: Number(formValues[i].X),
                        y: Number(formValues[i].Y),
                    },
                }
            );
            await page.waitForTimeout(3000);
        }

    } catch (err) {
        throw err;
    }
});
When(
    "User validate CSS Property for {string} style in {string} screen",
    async (scenario, pageScreen, table: DataTable) => {
        try {
            console.log(
                "User validate CSS Property for " + scenario + " in " +
                pageScreen +
                " screen"
            );
            const formValues = table.hashes();
            console.log(formValues.length);
            for (let i = 0; i < formValues.length; i++) {
                console.log(formValues[i]);
                let reqElement = await page.locator(
                    "//konfig-grid-item//*[contains(text(),'" +
                    formValues[i].WidgetName +
                    "')]"
                ).first();
                // validate label font-size, font-family and color properties
                await expect(reqElement).toHaveCSS('font-size', formValues[i].FontSize);
                await expect(reqElement).toHaveCSS('font-family', formValues[i].FontStyle);
                await expect(reqElement).toHaveCSS('color', formValues[i].Color);
                console.log("Label font-size, font-family and color properties are validated for Widget " + formValues[i].WidgetName)
                let inputElement;
                // validate input font-size, font-family and color properties
                if (formValues[i].WidgetType == "Text Input" || formValues[i].WidgetType == "Number" || formValues[i].WidgetType == "Email" || formValues[i].WidgetType == "Password" || formValues[i].WidgetType == "Phone Number" || formValues[i].WidgetType == "SSN" || formValues[i].WidgetType == "Date") {
                    inputElement = await page.locator(
                        "//konfig-grid-item//*[normalize-space(text())='" + formValues[i].WidgetName + "']/../..//input"
                    ).first();
                    await expect(inputElement).toHaveCSS('font-size', formValues[i].InputFontSize);
                    await expect(inputElement).toHaveCSS('font-family', formValues[i].InputFontStyle);
                    await expect(inputElement).toHaveCSS('color', formValues[i].InputColor);
                    console.log("Input font-size, font-family and color properties are validated for Widget " + formValues[i].WidgetName)
                }
                // validate Options font-size, font-family and color properties for Radio group
                else if (formValues[i].WidgetType == "Radio Group") {
                    let inputElement = await page.locator(
                        "//konfig-grid-item//div[normalize-space(text())='" + formValues[i].WidgetName + "']/../..//label"
                    ).first();
                    await inputElement.click();
                    let radioElement = await page.locator(
                        "//konfig-grid-item//div[normalize-space(text())='" + formValues[i].WidgetName + "']"
                    ).first();
                    await radioElement.click();
                    await expect(inputElement).toHaveCSS('font-size', formValues[i].OptionFontSize);
                    await expect(inputElement).toHaveCSS('font-family', formValues[i].OptionFontStyle);
                    await expect(inputElement).toHaveCSS('color', formValues[i].OptionLabelColor);
                    console.log("Options font-size, font-family and color properties are validated for Widget " + formValues[i].WidgetName)
                }
                // validate label font-size, font-family and color properties for Text area
                else if (formValues[i].WidgetType == "TextArea") {
                    inputElement = await page.locator(
                        "//konfig-grid-item//*[normalize-space(text())='" + formValues[i].WidgetName + "']/../..//textarea"
                    ).first();
                    await expect(inputElement).toHaveCSS('font-size', formValues[i].InputFontSize);
                    await expect(inputElement).toHaveCSS('font-family', formValues[i].InputFontStyle);
                    await expect(inputElement).toHaveCSS('color', formValues[i].InputColor);
                    console.log("Input font-size, font-family and color properties are validated for Widget " + formValues[i].WidgetName)
                }
                // validate input font-size, font-family and color properties for Drop down
                else if (formValues[i].WidgetType == "Dropdown") {
                    inputElement = await page.locator(
                        "//konfig-grid-item//div[normalize-space(text())='" + formValues[i].WidgetName + "']/../..//span[contains(@class,'p-dropdown-label')]"
                    ).first();
                    await inputElement.click();
                    let dropdownOption = page.locator(
                        "//p-dropdownitem//li//span"
                    ).first();
                    await dropdownOption.click();
                    await expect(inputElement).toHaveCSS('font-size', formValues[i].InputFontSize);
                    await expect(inputElement).toHaveCSS('font-family', formValues[i].InputFontStyle);
                    await expect(inputElement).toHaveCSS('color', formValues[i].InputColor);
                    console.log("Input font-size, font-family and color properties are validated for Widget " + formValues[i].WidgetName)
                }
                // validate Options font-size, font-family and color properties for Radio group
                else if (formValues[i].WidgetType == "Checkbox Group") {
                    let inputElement = await page.locator(
                        "//konfig-grid-item//div[normalize-space(text())='" + formValues[i].WidgetName + "']/../..//label"
                    ).first();
                    await inputElement.click();
                    await expect(inputElement).toHaveCSS('font-size', formValues[i].OptionFontSize);
                    await expect(inputElement).toHaveCSS('font-family', formValues[i].OptionFontStyle);
                    await expect(inputElement).toHaveCSS('color', formValues[i].OptionLabelColor);
                    console.log("Options font-size, font-family and color properties are validated for Widget " + formValues[i].WidgetName)
                }
                // validate background color properties for Button
                else if (formValues[i].WidgetType == "Button") {
                    inputElement = await page.locator(
                        "//konfig-grid-item//*[normalize-space(text())='" + formValues[i].WidgetName + "']/.."
                    );
                    // Check the background color of the button
                    await expect(inputElement).toHaveCSS('background-color', formValues[i].BgColor);
                    console.log("Background color property validated for Widget " + formValues[i].WidgetName)
                } else if (formValues[i].WidgetType == "Advance Table") {
                    let editbtn = await page.locator(
                        "(//div[@class='f-table']//div[@class='f-tr'])[2]//i[contains(@class,'save-icon')]/.."
                    );
                    let advTableElement = await page.locator(
                        "//konfig-grid-item//*[contains(text(),'" + formValues[i].WidgetName + "')]/../.."
                    );
                    // Check the background color of the ADv table Header
                    await expect(editbtn).toHaveCSS('font-size', formValues[i].BodyFontSize);
                    await expect(editbtn).toHaveCSS('font-family', formValues[i].BodyFontStyle);
                    await expect(editbtn).toHaveCSS('color', formValues[i].BodyColor);
                    console.log("Body font-size " + formValues[i].BodyFontSize + " font-family " + formValues[i].BodyFontStyle + " color " + formValues[i].BodyColor + "validated for Widget " + formValues[i].WidgetName)
                    await expect(advTableElement).toHaveCSS('background-color', formValues[i].FontBGColor);
                    console.log("Header Background color property " + formValues[i].FontBGColor + " validated for Widget " + formValues[i].WidgetName)
                }
            }
        } catch (err) {
            throw err;
        }
    });

When(
    "User will modify {string} on {string} screen",
    async (widgetType, pageScreen, table: DataTable) => {
        try {
            const formValues = table.hashes();
            for (let i = 0; i < formValues.length; i++) {
                // scroll to widget
                let reqElement =
                    "//konfig-grid-item//*[contains(text(),'" +
                    formValues[i].FieldName +
                    "')]";
                await page.waitForTimeout(500);
                await uniqueWidgets.ScrolltoElement(reqElement);
                await page.waitForTimeout(500);
                //edit widget
                await page.locator(reqElement).click({ button: "right" });
                await action.ClickElement("EditWidget", pageScreen);
                await page.waitForTimeout(500);
                if (widgetType == "DropDown") {
                    await uniqueWidgets.addDropdownValues(formValues[i], pageScreen);
                } else if (widgetType == "RadioGroup") {
                    await uniqueWidgets.addRadioGroupValues(pageScreen, formValues[i]);
                }
                await action.ClickElement("WidgetSave", pageScreen);
                await action.ClickElement("CancelSearchWidget", pageScreen);
                await page.waitForTimeout(500);
            }
        } catch (err) {
            throw err;
        }
    }
);

//Required field for advance table columns
When(
    "User make Advance table {string} cloumn field as require field in {string} screen",
    async (elementName, pageScreen) => {
        try {
            console.log(
                "User make " +
                elementName +
                "field as require field " +
                pageScreen +
                " screen"
            );
            await page.waitForTimeout(500);
            let reqElement = page.locator(
                "//div[text()=' " + elementName + " ']/ancestor::finlevit-custom-adv-table"
            );
            await reqElement.click({ clickCount: 2 });
            await page.waitForTimeout(500);
            await action.ClickElement("COLUMNS", pageScreen);
            let ColumnValue = page.locator("//widget-adv-table//div[contains(text(),'" + elementName + "')]/../../..//button");
            await ColumnValue.click();
            await page.waitForTimeout(500);
            await action.ClickElement("VALIDATIONS", pageScreen);
            await action.ClickElement("Required", pageScreen);
            await page.waitForTimeout(500);
            await action.ClickElement("WidgetSave", pageScreen);
            await page.waitForTimeout(500);
            console.log("Clicked on save button");
            // await assertion.checktext(
            //   "SavedSuccessfully",
            //   pageScreen,
            //   "Saved successfully"
            // );
        } catch (err) {
            throw err;
        }
    }
);

//Add field length for widgets
Then('User {string} field with {string} characters of {string} in {string} pageScreen', async (fieldName, elementName, Value, pageScreen) => {

    try {
        console.log("User " + fieldName + " field with " + elementName + " characters of " + Value + " in " + pageScreen + " pageScreen");
        await page.waitForTimeout(500);
        let reqElement = page.locator(
            "//konfig-grid-item//*[contains(text(),'" + fieldName +
            "')]"
        ).first();
        await reqElement.click({ button: "right" });
        await page.waitForTimeout(500);
        await action.ClickElement("EditWidget", pageScreen);
        await page.waitForTimeout(500);
        await action.ClickElement("VALIDATIONS", pageScreen);
        await action.enterText(Value, elementName, pageScreen)
        await action.ClickElement("WidgetSave", pageScreen);
        await page.waitForTimeout(500);
        console.log("Clicked on save button");
        // await assertion.checktext(
        //   "SavedSuccessfully",
        //   pageScreen,
        //   "Saved successfully"
        // );
    } catch (err) {
        throw err;
    }
}
);

//Add Toast Msg for button
Then('User add toast message to {string} button as {string} in {string} pageScreen', async (fieldName, Value, pageScreen) => {

    try {
        console.log("User add toast message to " + fieldName + " button as " + Value + " in " + pageScreen + " pageScreen");
        await page.waitForTimeout(500);
        let reqElement = page.locator(
            "//konfig-grid-item//*[contains(text(),'" + fieldName +
            "')]"
        ).first();
        await reqElement.click({ button: "right" });
        await page.waitForTimeout(500);
        await action.ClickElement("EditWidget", pageScreen);
        let elementExist = await page.isVisible(await ScreenMap.get(pageScreen).getSelector("WidgetName")).then(async (exist) => {
            return exist;
        });
        if (elementExist == true) {
            console.log("Edit widget opened")
        }
        else {
            await page.waitForTimeout(500);
            await reqElement.dblclick();
        }
        await page.waitForTimeout(500);
        await action.ClickElement("TOASTCONFIG", pageScreen);
        await action.enterText(Value, "ToastMsgCustom", pageScreen)
        await action.ClickElement("WidgetSave", pageScreen);
        await page.waitForTimeout(500);
        console.log("Clicked on save button");
        // await assertion.checktext(
        //   "SavedSuccessfully",
        //   pageScreen,
        //   "Saved successfully"
        // );
    } catch (err) {
        throw err;
    }
}
);
//To add default value to the field.
Then('User add default value to {string} field as {string} in {string} pageScreen', async (fieldName, Value, pageScreen) => {

    try {
        console.log("User add default value to " + fieldName + " field as " + Value + " in " + pageScreen + " pageScreen");
        await page.waitForTimeout(500);
        let reqElement = page.locator(
            "//konfig-grid-item//*[contains(text(),'" + fieldName +
            "')]"
        ).first();
        await reqElement.click({ button: "right" });
        await page.waitForTimeout(500);
        await action.ClickElement("EditWidget", pageScreen);
        await page.waitForTimeout(500);
        await action.ClickElement("INPUT", pageScreen);
        await action.fillText(Value, "DefaultValue", pageScreen)
        await action.ClickElement("WidgetSave", pageScreen);
        await page.waitForTimeout(500);
        console.log("Clicked on save button");
        // await assertion.checktext(
        //   "SavedSuccessfully",
        //   pageScreen,
        //   "Saved successfully"
        // );
    } catch (err) {
        throw err;
    }
}
);
//To add placeholder value to the field.
Then('User add placeholder value to {string} field as {string} in {string} pageScreen', async (fieldName, Value, pageScreen) => {

    try {
        console.log("User add default value to " + fieldName + " field as " + Value + " in " + pageScreen + " pageScreen");
        await page.waitForTimeout(500);
        let reqElement = page.locator(
            "//konfig-grid-item//*[contains(text(),'" + fieldName +
            "')]"
        ).first();
        await reqElement.click({ button: "right" });
        await page.waitForTimeout(500);
        await action.ClickElement("EditWidget", pageScreen);
        await page.waitForTimeout(500);
        await action.fillText(Value, "PlaceHolder", pageScreen)
        await action.ClickElement("WidgetSave", pageScreen);
        await page.waitForTimeout(500);
        console.log("Clicked on save button");
        // await assertion.checktext(
        //   "SavedSuccessfully",
        //   pageScreen,
        //   "Saved successfully"
        // );
    } catch (err) {
        throw err;
    }
});

When(
    "User validate App details in {string} screen",
    async (pageScreen) => {
        console.log(
            "User validate App details in" +
            pageScreen +
            " screen"
        );
        try {
            await action.ClickElement("search_application_textbox", pageScreen);
            await page.waitForTimeout(500);
            await action.enterText(
                process.env.applicationName,
                "search_application_textbox", pageScreen
            );
            console.log(
                "User enters " + process.env.applicationName + " in " + pageScreen + " screen"
            );
            await page.waitForTimeout(500);
            await assertion.checktext('AppTile_AppName', pageScreen, process.env.applicationName);
            await assertion.checktext('AppTile_AppDescription', pageScreen, process.env.AppDescription)
            const currentDate = new Date();
            const formattedDate = currentDate.toLocaleDateString('en-US', {
                month: 'short',
                day: 'numeric',
                year: 'numeric',
            });
            let cardInfo = "Last Updated By admin on " + formattedDate
            await assertion.checktext('AppTile_Updatedby', pageScreen, cardInfo)
            await action.mouseHoverElement('AppTile_FOIcon', pageScreen);
            await assertion.checktext('AppTile_FO_Tooltip', pageScreen, 'Front Office')
            await action.mouseHoverElement('AppTile_BOIcon', pageScreen);
            await assertion.checktext('AppTile_BO_Tooltip', pageScreen, 'Back Office')
            await action.ClickElement("clear_app_search", pageScreen);
            await page.waitForTimeout(500);
        } catch (err) {
            throw err;
        }
    }
);

When(
    "User edit application in {string} screen",
    async (pageScreen) => {
        console.log(
            "User User edit app in " +
            pageScreen +
            " screen"
        );
        try {
            await action.ClickElement("search_application_textbox", pageScreen);
            await page.waitForTimeout(500);
            let applicationName = CommonUtilObject.readUsecaseTestData(
                process.env.FileName,
                'Application_Name'
            );
            await action.enterText(
                applicationName,
                "search_application_textbox", pageScreen
            );
            console.log(
                "User enters " + applicationName + " in " + pageScreen + " screen"
            );
            await page.waitForTimeout(500);
            await action.ClickElement("app_menu_option", pageScreen);
            await page.waitForTimeout(500);
            await action.ClickElement("EditWidget", "UniqueWidgetFields");
        } catch (err) {
            throw err;
        }
    }
);

Then(
    "User verify error message for {string} in {string} in {string} screen",
    async (scenario, elementName, pageScreen) => {
        try {
            console.log("User verify error message for " + scenario + " in " + elementName + " in " + pageScreen + " screen")
            //Get Applictaion name
            let applicationName = CommonUtilObject.readUsecaseTestData(
                process.env.FileName,
                "Application_Name"
            );
            let expectedText;
            if (scenario == 'Verify & Publish') {
                let grpAdmin = CommonUtilObject.readJSONData("resources/" + process.env.Env + "TestData", 'GroupAdmins');
                let data = JSON.parse(grpAdmin);
                let appuser_fname = data[0].split(" ")[0];
                let appuser_lname = data[0].split(" ")[1];
                let lockeduser = (appuser_fname.charAt(0) + appuser_lname).toLowerCase();
                // expectedText = "FL1084 : " + applicationName + " is currently locked by " + lockeduser + ". Changes are not allowed."
                expectedText = "Changes are not allowed."
            } else if (scenario == 'Unlock') {
                expectedText = "does not have access to unlock the application " + applicationName + "."
            }
            console.log(expectedText);
            await assertion.ContainText(elementName, pageScreen, expectedText)
            await action.ClickElement('Pagelevel_alert_close', pageScreen)
            await page.waitForTimeout(500);
        } catch (err) {
            throw err;
        }
    }
);

When('User create an Event Configuration in {string} screen', async (pageScreen, table: DataTable) => {
    try {
        const triggerValues = table.hashes();
        // Navigate to Event Configuration screen
        await page.waitForTimeout(3000);
        await action.ClickElement('Settings', 'Page')
        await assertion.checktext('EventConfig', 'EventConfigurations', 'Events Configurations');
        await action.ClickElement('EventConfig', 'EventConfigurations');
        await page.waitForTimeout(3000);
        await action.waitforInvisibilityOfSpinner();
        console.log(triggerValues.length);
        //Click add config
        for (let i = 0; i < triggerValues.length; i++) {
            // Click on Add Trigger Button
            let addButtonStateelement = await action.getElement('AddEvent', pageScreen)
        await page.waitForTimeout(500);
        let isDisabled = await addButtonStateelement.evaluate(e => (e as HTMLInputElement).disabled);
        if (isDisabled == true) {
          console.log("Add button is disabled");
          await action.ClickElement('Settings', 'Page')
            await assertion.checktext('EventConfig', 'EventConfigurations', 'Events Configurations');
            await action.ClickElement('EventConfig', 'EventConfigurations');
            await action.waitforInvisibilityOfSpinner();
            await action.ClickElement('AddEvent', pageScreen)
        }
        else {
            await action.ClickElement('AddEvent', pageScreen)
        }
            // await action.ClickElement('AddEvent', pageScreen)
            console.log("Add button for Trigger " + (i + 1) + " is clicked");
            let expandButton = await action.getElement(
                "triggerExpandArrow",
                pageScreen
            );
            const count = await expandButton.count();
            console.log("count of Existing trigger is " + count);
            console.log("Add button for Trigger " + (i + 1) + " is clicked");
            console.log(triggerValues[i]);
            await OnloadTrigger.FillEventConfiguration(triggerValues[i], count - 1, pageScreen);
        }

    } catch (err) {
        throw err;
    }
}
);

Then('User will update group member with {string} in {string} screen', async (GroupMember, PageScreen) => {

    try {
        console.log("User will update group member with " + GroupMember + " in " + PageScreen + " screen");

        await action.ClickElement("GroupEdit", PageScreen);
        await action.ClickElement("EditButton", PageScreen);
        await assertion.HaveText("EditGroupAssert", PageScreen, "Edit Group");
        await action.selectDropdownbyText(
            "create_group_Admins_Dropdown",
            "Groups",
            GroupMember
        );
        await action.ClickElement("create_group_Admins_OK_button", "Groups");
        await page.waitForTimeout(500);
        await action.ClickElement("create_group_save_button", "Groups");
        await page.waitForTimeout(500);


    } catch (error) {
        throw error;
    }
});


When('User {string} {string} event in {string} screen', async (actionType, eventName, pageScreen) => {
    console.log("User will " + actionType + "  " + eventName + "  in  " + pageScreen);
    let txtElement = await ScreenMap.get(pageScreen).getSelector("EventLabel");
    let typeElement = page.locator(
        txtElement.replace("EventName", eventName)
    );
    if (actionType == "Edit") {
        // Navigate to Event Configuration screen
        await page.waitForTimeout(500);
        await action.ClickElement('Settings', 'Page')
        await assertion.checktext('EventConfig', pageScreen, 'Events Configurations');
        await action.ClickElement('EventConfig', pageScreen);
        await page.waitForTimeout(500);

        await action.ClickElement(typeElement);
        //click on Res Map cog icon
        let cogIcon = await ScreenMap.get(pageScreen).getSelector(
            "ResponseMappingCog"
        );
        await page
            .locator(cogIcon.replace("EventName", eventName))
            .click();
        console.log("User clicked on  Mapping  for " + eventName + "  in  " + pageScreen);
    } else if (actionType == "Save") {
        let SaveBtn = await ScreenMap.get(pageScreen).getSelector(
            "Save"
        );
        await page
            .locator(SaveBtn.replace("EventName", eventName))
            .click();
        console.log("User clicked on  Save  for " + eventName + "  in  " + pageScreen);

    } else if (actionType == "ResponsePopulate") {
        await page.waitForTimeout(500);
        await action.ClickElement('Settings', 'Page')
        await assertion.checktext('EventConfig', pageScreen, 'Events Configurations');
        await action.ClickElement('EventConfig', pageScreen);
        await page.waitForTimeout(500);

        await action.ClickElement(typeElement);
        //click on ResponsePopulate
        let checkBox = await ScreenMap.get(pageScreen).getSelector(
            "ResponsePopulate"
        );
        await page
            .locator(checkBox.replace("EventName", eventName))
            .click();
        //click on Res Map cog icon
        let cogIcon = await ScreenMap.get(pageScreen).getSelector(
            "ResponseMapping"
        );
        await page
            .locator(cogIcon.replace("EventName", eventName))
            .click();
        console.log("User clicked on  ResponseMapping  for " + eventName + "  in  " + pageScreen);
    }
    else {
        console.log('Event with name: ' + eventName + " is not found in" + pageScreen + " screen");
        console.log(actionType + " is not handled in " + pageScreen);
    }

});


When(
    "User delete group as group admin {string} in {string} screen",
    async (groupName, pageScreen) => {
        console.log(
            "User delete group " + groupName + " in " + pageScreen + " screen"
        );
        try {
            await action.ClickElement("search_group", pageScreen);
            await page.waitForTimeout(500);
            if (groupName.startsWith("#")) {
                groupName = CommonUtilObject.readUsecaseTestData(process.env.FileName, groupName.replace("#", ""));
                await action.enterText(
                    groupName,
                    'search_group_textbox',
                    pageScreen
                );
            } else {
                await action.enterText(groupName, "search_group_textbox", pageScreen);
            }
            console.log("User enters " + groupName + " in " + pageScreen + " screen");
            await page.waitForTimeout(500);
            await action.ClickElement("select_first_group", pageScreen);
            await action.waitforInvisibilityOfSpinner();
            await action.ClickElement("group_menu_option", pageScreen);
            await page.waitForTimeout(500);
            await action.ClickElement("DeleteWidget", "UniqueWidgetFields");
            await action.ClickElement("DeleteSubmit", "UniqueWidgetFields");

        } catch (err) {
            throw err;
        }
    }
);

When(
    "User create event configuration with {string} Options Mapping {string} in {string} screen",
    async (noOfOptionMapping, elementName, pageScreen, table: DataTable) => {
        try {
            console.log(
                "User create event configuration with " + noOfOptionMapping + "  Options Mapping " +
                elementName +
                " in " +
                pageScreen +
                " screen"
            );
            const triggerValues = table.hashes();
            console.log(triggerValues.length);
            await page.waitForTimeout(3000);
            await action.ClickElement('Settings', 'Page')
            await assertion.checktext('EventConfig', 'EventConfigurations', 'Events Configurations');
            await action.ClickElement('EventConfig', 'EventConfigurations');
            await page.waitForTimeout(3000);
            console.log(triggerValues.length);
            //Click add config
            for (let i = 0; i < triggerValues.length; i++) {
                // Click on Add Trigger Button
                await action.ClickElement('AddEvent', pageScreen)
                console.log("Add button for Trigger " + (i + 1) + " is clicked");
                let expandButton = await action.getElement(
                    "triggerExpandArrow",
                    pageScreen
                );
                const count = await expandButton.count();
                console.log("count of Existing trigger is " + count);
                console.log("Add button for Trigger " + (i + 1) + " is clicked");
                console.log(triggerValues[i]);
                await OnloadTrigger.FillEventConfigOptionMapping(triggerValues[i], count - 1, noOfOptionMapping, pageScreen);
            }
        } catch (err) {
            throw err;
        }
    }
);

When(
    "User edit {string} field in {string} screen",
    async (elementName, pageScreen) => {
        try {
            console.log(
                "User edit field " +
                elementName +
                " in " +
                pageScreen +
                " screen"
            );
            let reqElementXpath = "//konfig-grid-item//*[normalize-space(text())='" + elementName + "']";
            let reqElement = page.locator(reqElementXpath);
            await page.waitForTimeout(500);
            await reqElement.dblclick();
            let elementExist = await page.isVisible(await ScreenMap.get(pageScreen).getSelector("WidgetName")).then(async (exist) => {
                return exist;
            });
            if (elementExist == true) {
                console.log("Edit widget opened")
            }
            else {
                await reqElement.click({ button: "right" });
                await action.ClickElement("EditWidget", pageScreen);
            }
        } catch (err) {
            throw err;
        }
    });

When(
    "User test connection for the queue in {string} screen",
    async (pageScreen) => {
        try {
            console.log(
                "User test connection for the queue in " + pageScreen + " screen"
            )
            await page.waitForTimeout(500)
            await action.waitforInvisibilityOfSpinner();
            await action.ClickElement('Queue', 'HomePage')
            await action.waitforInvisibilityOfSpinner();
            let expQueueName;
            expQueueName = CommonUtilObject.readUsecaseTestData(process.env.FileName, "Queue_" + process.env.Env + "_" + process.env.Infra)
            process.env.queueName = expQueueName
            await action.enterText(expQueueName, 'searchQueue', pageScreen)
            // validate queue
            let queueTableRow = await action.getElement("queueList", pageScreen)
            let queuePresent;
            for (let i = 0; i < await queueTableRow.count(); i++) {
                let queueNames = await ScreenMap.get(pageScreen).getSelector(
                    "queueName"
                );
                let queueName = queueNames.replace(
                    "queueNo",
                    (i + 1)
                );
                let queue = await page.locator(queueName)
                const actualText = await queue.textContent();
                console.log("actual queue name  is " + actualText)
                if (actualText.trim() == expQueueName) {
                    console.log("ActualText is " + actualText);
                    console.log("ExpectedText is " + expQueueName);
                    queuePresent = true;
                    await queue.click()
                    break
                }
            }
            await action.ClickElement('testConnection', pageScreen)
            await page.waitForSelector(await ScreenMap.get(pageScreen).getSelector(
                "testConnectionSuccess"
              ),{timeout:60000})
            let connectionMsg = await action.getText('testConnectionSuccess', pageScreen)

            if (connectionMsg == " Connection established successfully ") {
                console.log("Connection established successfully for Queue: " + expQueueName);
                await action.ClickElement('cancel', pageScreen)
            } else {
                console.log(
                    connectionMsg + " for Queue: " + expQueueName
                );
                await browser.close();
            }
        } catch (err) {
            throw err;
        }
    });


When(
    "User create event configuration Options Mapping with {string} Rule {string} in {string} screen",
    async (noOfOptionMapping, elementName, pageScreen, table: DataTable) => {
        try {
            console.log(
                "User create event configuration with " + noOfOptionMapping + "  Options Mapping " +
                elementName +
                " in " +
                pageScreen +
                " screen"
            );
            const triggerValues = table.hashes();
            console.log(triggerValues.length);
            await page.waitForTimeout(3000);
            await action.ClickElement('Settings', 'Page')
            await assertion.checktext('EventConfig', 'EventConfigurations', 'Events Configurations');
            await action.ClickElement('EventConfig', 'EventConfigurations');
            await page.waitForTimeout(3000);
            console.log(triggerValues.length);
            //Click add config
            for (let i = 0; i < triggerValues.length; i++) {
                // Click on Add Trigger Button
                await action.ClickElement('AddEvent', pageScreen)
                console.log("Add button for Trigger " + (i + 1) + " is clicked");
                let expandButton = await action.getElement(
                    "triggerExpandArrow",
                    pageScreen
                );
                const count = await expandButton.count();
                console.log("count of Existing trigger is " + count);
                console.log("Add button for Trigger " + (i + 1) + " is clicked");
                console.log(triggerValues[i]);
                await OnloadTrigger.OnchangeOptionMapping(triggerValues[i], count - 1, noOfOptionMapping, pageScreen);
            }
        } catch (err) {
            throw err;
        }
    }
);

When(
    "User test connection for the document in {string} screen",
    async (pageScreen, table: DataTable) => {
        try {
            let expDocName = await CommonUtilObject.readUsecaseTestData(process.env.FileName, "DocumentSourceName");
            console.log(
                "User test connection for the document" + expDocName + " in " + pageScreen + " screen"
            )
            await page.waitForTimeout(500)
            await action.waitforInvisibilityOfSpinner();
            await action.ClickElement('document', 'HomePage')
            await action.waitforInvisibilityOfSpinner();
            process.env.docName = expDocName
            console.log(expDocName)
            await action.enterText(expDocName, 'searchDocument', pageScreen)
            // validate queue
            let queueTableRow = await action.getElement("documentList", pageScreen)
            let docPresent;
            let doccount=await queueTableRow.count();
            if(doccount>0){
                for (let i = 0; i < doccount; i++) {
                    let docNames = await ScreenMap.get(pageScreen).getSelector(
                        "documentName"
                    );
                    let docName = docNames.replace(
                        "queueNo",
                        (i + 1)
                    );
                    let queue = await page.locator(docName)
                    const actualText = await queue.textContent();
                    console.log("actual document name  is " + actualText)
                    if (actualText.trim() == expDocName) {
                        console.log("ActualText is " + actualText);
                        console.log("ExpectedText is " + expDocName);
                        docPresent = true;
                        await queue.click()
                        break
                    }
                }
                await action.ClickElement('testConnection', pageScreen)
                await page.waitForTimeout(10000)
                let connectionMsg = await action.getText('testConnectionSuccess', pageScreen)
                console.log(connectionMsg)
                if (connectionMsg == " Connection established successfully ") {
                    console.log("Connection established successfully for Queue: " + expDocName);
                    await action.ClickElement('cancel', pageScreen)
                } else {
                    console.log(
                        connectionMsg + " for Queue: " + expDocName
                    );
                    await browser.close();
                }
            }
            else{
                await action.ClickElement('addDocument', pageScreen)
                const document = table.hashes();
                for (let i = 0; i < document.length; i++) {
                    await action.selectDropdownbytagName('span','type',document[0].Type, pageScreen)
                    await action.enterText(expDocName,"name",pageScreen)
                    if(document[0].Root)
                        await action.enterText(document[0].Root,"root",pageScreen)
                    await action.enterText(document[0].AccessKey,"accessKey",pageScreen)
                    await action.enterText(document[0].SecretKey,"secretKey",pageScreen)
                    await action.enterText(document[0].BucketName,"bucketName",pageScreen)
                    await action.selectDropdownbytagName('span','awsRegion',document[0].AWSRegion, pageScreen)
                    await action.ClickElement('testConnection', pageScreen)
                    await page.waitForTimeout(500)
                    let connectionMsg = await action.getText('testConnectionSuccess', pageScreen)

                    if (connectionMsg == " Connection established successfully ") {
                        console.log("Connection established successfully for Queue: " + expDocName);
                        await action.ClickElement('save', pageScreen)
                        await page.waitForTimeout(500);
                    } else {
                        console.log(
                            connectionMsg + " for Queue: " + expDocName
                        );
                        await browser.close();
                    }

                }
            }
        } catch (err) {
            throw err;
        }
    });


When(
  "User clicks on {string} in {string} screen",
  async (elementName, pageScreen) => {
    try {
      console.log(
        "User click on " + elementName + " in " + pageScreen + " screen"
      );
      await action.ClickElement(elementName, pageScreen)
      await page.waitForTimeout(500);
    } catch (err) {
      throw err;
    }
  }
);