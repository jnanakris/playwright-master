import { page } from "../steps/world";
import { Actions } from "../Utility/Util/Actions";
import { Assertions } from "../Utility/Util/Assertions";


let action: Actions = new Actions();
let assertion: Assertions = new Assertions();

export class API {

    async ApiGenerator(serviceProvider, pageScreen, formValues) {


        await action.ClickElement("createAPI_btn", pageScreen);
        console.table(formValues);
        await page.waitForTimeout(2000);
        //Enter API Name
        await action.enterText(formValues.Name, "createAPINameInputBox", pageScreen);
        console.log("Name entered as: " + formValues.Name);
        //Enter API Description
        await action.enterText(formValues.Description, "createAPIDescInputBox", pageScreen);
        console.log("Description entered as: " + formValues.Description);
        //Enter Endpoint
        await action.enterText(formValues.EndPoint, "createAPIEndPointInputBox", pageScreen);
        console.log("EndPoint entered as: " + formValues.EndPoint);
        //upload JSON file
        const handle = await page.locator("//input[@type='file']");
        await handle.setInputFiles("CreateAPI/" + formValues.apiSchema + ".json");
        console.log(formValues.apiSchema + ".json has been uploaded");
        await page.waitForTimeout(2000);
        //Configure GeneratedField
        if (formValues.Prefix || formValues.MaxLength) {
            let field = await page.locator("//mat-expansion-panel//span[text()='" + formValues.uniqueField + "']")
            await field.click();
            await action.ClickElement("GeneratedField", pageScreen);
            await action.enterText(formValues.Prefix, "PrefixText", pageScreen);
            await action.enterText(formValues.MaxLength, "MaxLength", pageScreen)
            await action.enterText("1", "StartOrder", pageScreen);
            await action.ClickElement("save", pageScreen);
            await page.waitForTimeout(500);

        }
    }
}



