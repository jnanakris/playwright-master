import {Given, When, Then, DataTable} from "@cucumber/cucumber";
import {page} from "./world";
import {ScreenMap} from "../Utility/Source/Core";
import {expect} from "@playwright/test";
import {Actions} from "../Utility/Util/Actions";
import {CommonUtilObject} from "../Utility/Util/CommonUtil";
import {Assertions} from "../Utility/Util/Assertions";
import {API} from "../Main/API";
import {Payload} from "../Main/Payload";

let action: Actions = new Actions();
let createAPI: API = new API();
let assertion: Assertions = new Assertions();
let payload: Payload = new Payload();

When('User Drag {string} and Drop in {string} in {string} screen with {string} and {string} coordinator and name it as {string}', async (srcElement, destElement, pageScreen, xAxis, yAxis, elementName) => {
    try {
        console.log('User Drag ' + srcElement + ' and Drop in ' + destElement + ' in ' + pageScreen + ' screen')
        await page.waitForTimeout(500);
        await action.dragAndDrop(srcElement, destElement, Number(xAxis), Number(yAxis), pageScreen);
        await action.fillText(elementName, 'configNameInputBox', pageScreen)
        await action.ClickElement('configSaveButton', pageScreen)
        await page.waitForTimeout(500);
    } catch (err) {
        throw err;
    }
})

When('User Drag {string} and Drop under {string} in {string} screen and name it as {string}', async (sourceLocator, destLocator, pageScreen, elementName) => {
    try {
        console.log('User Drag ' + sourceLocator + 'and Drop under ' + destLocator + ' in ' + pageScreen + ' screen and name it as ' + elementName)
        await page.waitForTimeout(500);
        let srcElement: any = await ScreenMap.get(pageScreen).getSelector(sourceLocator);
        let txtElement = await ScreenMap.get("apiGenerator").getSelector(
            "schemaContainerElement"
        );
        let desElement = txtElement.replace("destLocator", destLocator);
        console.log(srcElement, desElement);
        await page.dragAndDrop(srcElement, desElement);
        await action.fillText(elementName, 'configNameInputBox', pageScreen)
        await action.ClickElement('configSaveButton', pageScreen)
        await page.waitForTimeout(500);
    } catch (err) {
        throw err;
    }
})

When('User Drag {string} and Drop under {string} {string} in {string} screen and name it as {string}', async (sourceLocator, typeoOfSchema, destLocator, pageScreen, elementName) => {
    try {
        console.log('User Drag ' + sourceLocator + ' and Drop under ' + typeoOfSchema + ' in ' + destLocator + 'screen and name it as ' + pageScreen)
        await page.waitForTimeout(500);
        let srcElement: any = await ScreenMap.get(pageScreen).getSelector(sourceLocator);
        let txtElement = await ScreenMap.get("apiGenerator").getSelector(
            "schemaContainerObject"
        );
        let desElement = txtElement.replace("destLocator", destLocator);
        await page.dragAndDrop(srcElement, desElement);
        await action.fillText(elementName, 'configNameInputBox', pageScreen)
        await action.ClickElement('configSaveButton', pageScreen)
        await page.waitForTimeout(500);
    } catch (err) {
        throw err;
    }
})

When(
    "User verify and create {string} serviceProvider in API generator {string} screen",
    async (serviceProvider, pageScreen, table: DataTable) => {
        try {
            console.log('User verify and create  ' + serviceProvider + 'serviceProvider in API generator' + pageScreen + 'screen');
            await action.ClickElement("API Generator", "HomePage");
            const formValues = table.hashes();
            await page.waitForTimeout(2000);
            await payload.waitforInvisibilityOfSpinner()
            
            let createAPIBtn=await ScreenMap.get(pageScreen).getSelector("createAPI_btn")
            let isenabled=await page.isVisible(createAPIBtn).then(async(exists)=>{
                return exists;
            })
            if (isenabled==true){
                console.log("create API button displayed")
            }
            else{
                await action.ClickElement("API Generator", "HomePage");
                await page.waitForTimeout(2000);
                await payload.waitforInvisibilityOfSpinner()
            }

            await action.enterText(serviceProvider, "searchAPIGenerator", pageScreen);
            await page.waitForTimeout(2000);
            let availableAPI = await ScreenMap.get(pageScreen).getSelector("availableAPI")
            let element = await page.isVisible(availableAPI).then(async (exist) => {
                return exist;
            })
            console.log("API exist is " + element)
            //If no API found
            if (element != true) {
                //Create API
                await createAPI.ApiGenerator(serviceProvider, pageScreen, formValues[0]);
                //select UniqueField
                await page.waitForTimeout(2000);
                await action.ClickElement("createAPIUniqueFieldInputBox", pageScreen);
                let field = await page.locator("//li//div[text()=' " + formValues[0].uniqueField + " ']");
                let uniqueField = await field.isVisible().then(async (exist) => {
                    return exist;
                });
                if (uniqueField == true) {
                    await field.click();
                    console.log("Unique Field selected as  " + formValues[0].uniqueField)
                    await page.waitForTimeout(2000);
                } else {
                    let menuitem = await page.locator("//i[@class='submenu-icon pi pi-angle-right']");
                    let menuitemCount = await menuitem.count();
                    await page.waitForTimeout(2000);
                    for (let i = 0; i < menuitemCount; i++) {
                        await page.waitForTimeout(2000);
                        await action.mouseHoverElement(menuitem.nth(i))
                        await page.waitForTimeout(2000);
                        let Value = await page.locator("//li//div[text()=' " + formValues[0].uniqueField + " ']");
                        let unique = await field.isVisible().then(async (exist) => {
                            return exist;
                        });
                        if (unique == true) {
                            await Value.click();
                            console.log("Unique Field selected as  " + formValues[0].UniqueField)
                            break;
                        }
                    }
                }
                //Select filterField
                await action.ClickElement("createAPIFilterInputBox", pageScreen);
                let filter = page.locator("//li//div[text()=' " + formValues[0].FilterField + " ']");
                let filterField = await filter.isVisible().then(async (exist) => {
                    return exist;
                });
                if (filterField == true) {
                    await filter.click();
                    console.log("Filter Field selected as  " + formValues[0].FilterField)
                    await page.waitForTimeout(2000);
                } else {
                    let menuitem = await page.locator("//i[@class='submenu-icon pi pi-angle-right']");
                    let menuitemCount = await menuitem.count();
                    await page.waitForTimeout(2000);
                    for (let i = 0; i < menuitemCount; i++) {
                        await page.waitForTimeout(2000);
                        await action.mouseHoverElement(menuitem.nth(i))
                        await page.waitForTimeout(2000);
                        let Value = page.locator("//li//div[text()=' " + formValues[0].uniqueField + " ']");
                        let filterValue = await field.isVisible().then(async (exist) => {
                            return exist;
                        });
                        if (filterValue == true) {
                            await Value.click();
                            console.log("Filter Field selected as  " + formValues[0].FilterField)
                            break;
                        }
                    }
                }
                await action.ClickElement("createAPIGenerateButton", pageScreen);
                await assertion.checktext('apiTitle', pageScreen, formValues[0].Name)
                await page.waitForTimeout(5000);
                //If any API is located after searching, it will match with given API name 
            } else {
                let service = await action.getElement("availableAPI", pageScreen);
                await page.waitForSelector(
                    await ScreenMap.get(pageScreen).getSelector("availableAPI")
                );
                const count = await service.count();
                console.log("Count is " + count);
                let api: boolean;
                for (let i = 0; i < count; i++) {
                    let availableAPI = await service.nth(i).textContent();
                    console.log("Available API IS " + availableAPI);
                    console.log("serviceProvider API IS " + serviceProvider);
                    //If API is available
                    if (availableAPI.trim() == serviceProvider) {
                        console.log("The Searched API already created");
                        api = true;
                        break;
                    }
                }
                console.log(api +" is already available");
                //If API is not available
                if (api != true) {
                    //Create API
                    await createAPI.ApiGenerator(serviceProvider, pageScreen, formValues[0]);
                    //select UniqueField
                    await action.ClickElement("createAPIUniqueFieldInputBox", pageScreen);
                    let field = page.locator("//li//div[text()=' " + formValues[0].uniqueField + " ']");
                    let uniqueField = await field.isVisible().then(async (exist) => {
                        return exist;
                    });
                    if (uniqueField == true) {
                        await field.click();
                        console.log("Unique Field selected as  " + formValues[0].UniqueField)
                        await page.waitForTimeout(2000);
                    } else {
                        let menuitem = await page.locator("//i[@class='submenu-icon pi pi-angle-right']");
                        let menuitemCount = await menuitem.count();
                        await page.waitForTimeout(2000);
                        for (let i = 0; i < menuitemCount; i++) {
                            // await menuitem.nth(i).click();
                            await action.mouseHoverElement(menuitem.nth(i));
                            await page.waitForTimeout(2000);
                            let Value = page.locator("//li//div[text()=' " + formValues[0].uniqueField + " ']");
                            let unique = await field.isVisible().then(async (exist) => {
                                return exist;
                            });
                            if (unique == true) {
                                await Value.click();
                                console.log("Unique Field selected as  " + formValues[0].UniqueField)
                                break;
                            }
                        }
                    }
                    //Select filterField
                    await action.ClickElement("createAPIFilterInputBox", pageScreen);
                    let filter = page.locator("//li//div[text()=' " + formValues[0].FilterField + " ']");
                    let filterField = await filter.isVisible().then(async (exist) => {
                        return exist;
                    });
                    if (filterField == true) {
                        await filter.click();
                        console.log("FilterField is " + formValues[0].FilterField);
                        await page.waitForTimeout(2000);
                    } else {
                        let menuitem = await page.locator("//i[@class='submenu-icon pi pi-angle-right']");
                        let menuitemCount = await menuitem.count();
                        await page.waitForTimeout(2000);
                        for (let i = 0; i < menuitemCount; i++) {
                            // await menuitem.nth(i).click();
                            await action.mouseHoverElement(menuitem.nth(i));
                            await page.waitForTimeout(2000);
                            let Value = page.locator("//li//div[text()=' " + formValues[0].FilterField + " ']");
                            let filterValue = await field.isVisible().then(async (exist) => {
                                return exist;
                            });
                            if (filterValue == true) {
                                await Value.click();
                                console.log("FilterField is " + formValues[0].FilterField);
                                break;
                            }
                        }
                    }
                    await action.ClickElement("createAPIGenerateButton", pageScreen);
                    await page.waitForTimeout(5000);
                    await assertion.checktext('apiTitle', pageScreen, formValues[0].Name)
                }
            }
        } catch (err) {
            throw err;
        }
    }
);

When(
    "User upload {string} data to {string} serviceProvider in {string} screen",
    async (data, serviceProvider, pageScreen) => {

        try {

            console.log("User upload " + data + " data to " + serviceProvider + " serviceProvider in " + pageScreen + " screen")
            await action.ClickElement("API Generator", "HomePage")
            await action.fillText(serviceProvider, "searchAPIGenerator", pageScreen);
            let api = await page.locator("//finlevit-card//div[@class='f-card-title ng-star-inserted' and text()=' " + serviceProvider + " ']")
            await api.click();
            let apiDataFulltext = await page.locator(await ScreenMap.get("apiGenerator").getSelector("apiDataCount")).textContent();
            console.log("Total records in " + serviceProvider + " is" + apiDataFulltext);
            let apiDataCount = apiDataFulltext.split(" ")[0].replace(/[()]/g, " ").trim();
            console.log("api data count is " + apiDataCount);
            if (apiDataCount == "0") {
                await page.waitForTimeout(2000);
                const handle = await page.locator("//finlevit-file-upload//input[@type='file']");
                await page.waitForTimeout(2000);
                await handle.setInputFiles("CreateAPI/" + data + ".json");
                await page.waitForTimeout(2000);
                await action.waitforInvisibilityOfSpinner();
                await assertion.checktext('DataImportSuccess', pageScreen, 'Data imported successfully');
            } else {
                console.log("Data with "+apiDataCount+" records is already present in: "+ serviceProvider);
            }
        } catch (error) {
            throw error;
        }
    }
);

When(
    "User verify {string} API and export service providers and DataSources to the group {string} in {string} screen",
    async (serviceProvider, groupName, pageScreen) => {

        try {
            console.log("User verify " + serviceProvider + " API and export service providers and DataSources to the group " + groupName + " in " + pageScreen + " screen")
            await page.waitForTimeout(2000);
            await action.ClickElement("API Generator", "HomePage")
            await action.fillText(serviceProvider, "searchAPIGenerator", pageScreen);
            await page.waitForTimeout(2000);
            let api = await page.locator("//finlevit-card//div[@class='f-card-title ng-star-inserted' and text()=' " + serviceProvider + " ']")
            await api.click();
            await action.ClickElement("Export To Service Providers", pageScreen)
            await page.waitForTimeout(500);
            //Export Service provider to the required group
            let Group;
            if(process.env.Browser.startsWith('moon')){
                Group = CommonUtilObject.readUsecaseTestData('resources/TestData',
                    'moon-GroupName'
                );
            }
            else{
                Group = CommonUtilObject.getTestData(groupName);
            }
            console.log("Group name to export "+Group)
            let txtElement = await page.locator("//li//span[normalize-space(text())='" + Group + "']");
            let group = await txtElement.isVisible().then(async (exist) => {
                return exist;
            });
            console.log("Group exist on the service provider is " + group)
            if (group == true) {
                await page.waitForTimeout(500);
                await txtElement.click();
                // await payload.waitforInvisibilityOfSpinner();
                await assertion.checktext('Success', pageScreen, 'Success')
                console.log("API is exported to the group" + Group);
                await page.waitForTimeout(5000);
                await action.selectDropdownbyspantext("Export To Data Resources", pageScreen, Group);
                await assertion.checktext('Success', pageScreen, 'Success')
                await payload.waitforInvisibilityOfSpinner();
            } else {
                console.log("API exists in service provider" + Group);
                await page.waitForTimeout(2000);
                await page.keyboard.press("Enter");
            }
        } catch (error) {
            throw error;
        }
    });

When(
    "User verify {string} serviceProvider and export DataSources to the group {string} in {string} screen",
    async (serviceProvider, groupName, pageScreen) => {

        try {
            console.log("User verify " + serviceProvider + " serviceProvider and export DataSources to the group " + groupName + " in " + pageScreen + " screen")
            await page.waitForTimeout(2000);
            await action.ClickElement("API Generator", "HomePage")
            await action.fillText(serviceProvider, "searchAPIGenerator", pageScreen);
            await page.waitForTimeout(2000);
            let api = await page.locator("//finlevit-card//div[@class='f-card-title ng-star-inserted' and text()=' " + serviceProvider + " ']")
            await api.click();
            await action.ClickElement("Export To Data Resources", pageScreen)
            await page.waitForTimeout(500);
            //Export Service provider to the required group
            let Group = CommonUtilObject.getExpectedValue(groupName);
            let txtElement = await page.locator("//li//span[normalize-space(text())='" + Group + "']");
            let group = await txtElement.isVisible().then(async (exist) => {
                return exist;
            });
            if (group == true) {
                await page.waitForTimeout(500);
                await txtElement.click();
                await payload.waitforInvisibilityOfSpinner();
                console.log("DataSources is exported to the group" + Group);
            } else {
                console.log("DataSources already added to the " + Group);
                await page.waitForTimeout(2000);
                await page.keyboard.press("Enter");
                // page.reload();
            }
        } catch (error) {
            throw error;
        }
    });

When(
    "User verify {string} API and export service providers to the group {string} in {string} screen",
    async (serviceProvider, groupName, pageScreen) => {

        try {
            let txtElement;
            let Group;
            console.log("User verify " + serviceProvider + " API and export service providers and DataSources to the group " + groupName + " in " + pageScreen + " screen")
            await page.waitForTimeout(2000);
            await action.ClickElement("API Generator", "HomePage")
            await action.fillText(serviceProvider, "searchAPIGenerator", pageScreen);
            await page.waitForTimeout(2000);
            let api = await page.locator("//finlevit-card//div[@class='f-card-title ng-star-inserted' and text()=' " + serviceProvider + " ']")
            await api.click();
            await action.ClickElement("Export To Service Providers", pageScreen)
            await page.waitForTimeout(500);
            //Export Service provider to the required group
            if (groupName.startsWith("#")) {

                Group = CommonUtilObject.readUsecaseTestData(process.env.FileName, groupName.replace("#",""));
                txtElement = await page.locator("//li//span[normalize-space(text())='" + Group + "']");

            } else {
                Group = CommonUtilObject.readUsecaseTestData(process.env.FileName, groupName);
                txtElement = await page.locator("//li//span[normalize-space(text())='" + Group + "']");
            }

            let group = await txtElement.isVisible().then(async (exist) => {
                return exist;
            });
            console.log("Group exist on the service provider is " + group)
            if (group == true) {
                await page.waitForTimeout(500);
                await txtElement.click();
                // await payload.waitforInvisibilityOfSpinner();
                await assertion.checktext('Success', pageScreen, 'Success')
                console.log("API is exported to the group" + Group);
                await payload.waitforInvisibilityOfSpinner();
            } else {
                console.log("API exists in service provider" + Group);
                await page.waitForTimeout(2000);
                await page.keyboard.press("Enter");
            }
        } catch (error) {
            throw error;
        }
    });