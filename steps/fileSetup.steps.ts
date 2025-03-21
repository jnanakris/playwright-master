import { Given, When, Then, DataTable } from "@cucumber/cucumber";
import { context, page } from "./world";
import { ScreenMap } from "../Utility/Source/Core";
import { expect } from "@playwright/test";
import { Actions } from "../Utility/Util/Actions";
import { Assertions } from "../Utility/Util/Assertions";
import * as moment from "moment";
import { CommonUtilObject } from "../Utility/Util/CommonUtil";
import { FileSetup } from "../Main/FileSetup";
let action: Actions = new Actions();
let assertion: Assertions = new Assertions();
let fileSetup: FileSetup = new FileSetup();
let requestParameters,appSourceRequireField,filesetupRequireField;

When('User will create file setup with {string} file in {string} screen', async (fileType, pageScreen, table: DataTable) => {
    console.log(
        "User will create file setup with " + fileType + " in " + pageScreen + " screen"
    );
    const fileSetupData = table.hashes();
    await page.waitForTimeout(5000);
    await action.waitforInvisibilityOfSpinner();
    // when the file is used in a file task, it will shown up in another filetask.so everytime creating new file
    // await action.ClickElement("fileSearch", pageScreen);
    // //file name
    // let filesetupName = CommonUtilObject.readUsecaseTestData(
    //     process.env.FileName,
    //     'FileNameinFileSetup'
    // );
    // await action.enterText(filesetupName.trim(), "fileSearch", pageScreen);
    // //click on file
    // let currentApp =
    //     '//div[contains(@class,"card-title") and contains(text(),"' +
    //     filesetupName +
    //     '")]';
    // let exist = await page.isVisible(currentApp).then(async (exist) => {
    //     return exist;
    // });
    // if (exist == true) {
    //     console.log("File setup already exist for the file " + filesetupName)
    //     process.env.createFile = "false";
    // }
    // else {
        for (let i = 0; i < fileSetupData.length; i++) {
            await fileSetup.addJSONFileSetup(fileType, fileSetupData[i], pageScreen)
            if(filesetupRequireField){
                console.log(filesetupRequireField)
                await fileSetup.addFileSetupSchema(filesetupRequireField, pageScreen)
            }
            await action.ClickElement('save', pageScreen)
            await assertion.checktext('savedSuccessfully', pageScreen, "File Created Successfully")
        }
    // }
});

Then(
    "User will search for file setup {string} in {string} screen",
    async (fileName, pageScreen) => {
        console.log(
            "User will search for file setup " +fileName+ " in " + pageScreen + " screen"
        );
        await page.waitForTimeout(5000);
    await action.waitforInvisibilityOfSpinner();
    await action.ClickElement("fileSearch", pageScreen);
    //file name
    let filesetupName = CommonUtilObject.readUsecaseTestData(
        process.env.FileName,
        fileName
    );
    await action.enterText(filesetupName.trim(), "fileSearch", pageScreen);
    //click on file
    let currentApp =
        '//div[contains(@class,"card-title") and contains(text(),"' +
        filesetupName +
        '")]';
    let exist = await page.isVisible(currentApp).then(async (exist) => {
        return exist;
    });
    if (exist == true) {
        await action.ClickElement(await page.locator(currentApp))
        await action.waitforInvisibilityOfSpinner();
        await page.waitForTimeout(2000)
    }
    else {
        console.log("File does not exists")

    }
});

When('User will create app source setup with {string} in {string} screen', async (fileType, pageScreen, table: DataTable) => {
    console.log(
        "User will create app source setup with "+fileType+ " in " + pageScreen + " screen"
    );
    const appSource = table.hashes();
    await action.ClickElement("appSourceSetupMenu", "HomePage");
    await page.waitForTimeout(5000);
    await action.waitforInvisibilityOfSpinner();
    await action.ClickElement("fileSearch", pageScreen);
    //file name
    let filesetupName = CommonUtilObject.readUsecaseTestData(
        process.env.FileName,
        'FileName'
    );
    await action.enterText(filesetupName.trim(), "fileSearch", pageScreen);
    //click on file
    let currentApp =
        '//div[contains(@class,"card-title") and normalize-space(text())="' +
        filesetupName +
        '"]';
    let exist = await page.isVisible(currentApp).then(async (exist) => {
        return exist;
    });
    if (exist == true && appSource[0].SourceName!="New") {
        console.log("App Source setup already exist for the file " + filesetupName)
        process.env.createFile = "false";
    }
    else {
        if (fileType == 'Data List') {
            for (let i = 0; i < appSource.length; i++) {
            await fileSetup.addDatalistAppsourceSetup(fileType, appSource[i], requestParameters,pageScreen)
            if(appSourceRequireField){
                console.log(appSourceRequireField)
                await fileSetup.addFileSetupSchema(appSourceRequireField, pageScreen)
            }
            await action.ClickElement('save', pageScreen)
            await assertion.checktext('savedSuccessfully', pageScreen, "Data List App Source Setup Created Successfully")
            }
        }
        else if (fileType == 'File'){
            for (let i = 0; i < appSource.length; i++) {
            await fileSetup.addFileAppsourceSetup(fileType, appSource[i],pageScreen)
            if(appSourceRequireField){
                console.log(appSourceRequireField)
                await fileSetup.addFileSetupSchema(appSourceRequireField, pageScreen)
            }
            await action.ClickElement('save', pageScreen)
            await assertion.checktext('savedSuccessfully', pageScreen, "File App Source Setup Created Successfully")
            }
        }
    }
});

When(
    "User use below {string} when create app source setup in {string} screen",
    async (typeOfParameter,pageScreen, table: DataTable) => {
      try {
        console.log(
          "User Add below "+typeOfParameter+" when create app source setup in  "
          + pageScreen +
          " screen"
        );
         // Add additional Parameters
        if(typeOfParameter=="Request Parameters")
            requestParameters = table.hashes();
        else if(typeOfParameter=="Require Fields" && pageScreen=="appSourceSetup")
            appSourceRequireField = table;
        else if(typeOfParameter=="Require Fields" && pageScreen=="fileSetup")
            filesetupRequireField = table;
         
      } catch (error) {
        throw error;
      }
  
    })