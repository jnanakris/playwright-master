import { ScreenMap } from "../../Source/Core";
import { CommonUtilObject } from "../CommonUtil";
import { page } from "../../../steps/world";
import { Assertions } from "../Assertions";
import { When } from "@cucumber/cucumber";

let assertion: Assertions = new Assertions();

When('User see text {string} in {string} in {string} screen', async (expectedText, elementName, pageScreen) => {
    try {
        console.log('User see text ' + expectedText + ' in ' + elementName + ' in ' + pageScreen + ' screen')
        if (expectedText.startsWith("#")) {
            await assertion.checktext(elementName,
                pageScreen,
                CommonUtilObject.readUsecaseTestData(process.env.FileName, expectedText.replace("#", "")),

            );
        } else {
            await assertion.checktext(elementName, pageScreen, expectedText)
        }
    }
    catch (err) {
        throw err;
    }
})

When('User have text {string} in {string} in {string} screen', async (expectedText, elementName, pageScreen) => {
    try {
        console.log('User have text ' + expectedText + ' in ' + elementName + ' in ' + pageScreen + ' screen')
        if (expectedText.startsWith("#")) {
            await assertion.HaveText(elementName,
                pageScreen,
                CommonUtilObject.readUsecaseTestData(process.env.FileName, expectedText.replace("#", "")),

            );
        } else {
            await assertion.HaveText(elementName, pageScreen, expectedText)
        }

    }
    catch (err) {
        throw err;
    }
})

When('User should contain text {string} in {string} in {string} screen', async (expectedText, elementName, pageScreen) => {
    try {
        console.log('User should contain text ' + expectedText + ' in ' + elementName + ' in ' + pageScreen + ' screen')
        await assertion.ContainText(elementName, pageScreen, expectedText)
    }
    catch (err) {
        throw err;
    }
})

When('User should have page title as {string} in {string} screen', async (expectedText, pageScreen) => {
    try {
        console.log('should have page title as' + expectedText + ' in ' + ' in ' + pageScreen + ' screen')
        await assertion.HaveTitle(expectedText, pageScreen)
    }
    catch (err) {
        throw err;
    }
})

When('User should have visible {string} in {string} screen', async (elementName, pageScreen) => {
    try {
        console.log('should have visible' + elementName + ' in ' + ' in ' + pageScreen + ' screen')
        await assertion.Visible(elementName, pageScreen);
    }
    catch (err) {
        throw err;
    }
})

When('User should have count {string} in {string} in {string} screen', async (count, elementName, pageScreen) => {
    try {
        console.log('User should have count ' + count + ' in ' + elementName + ' in ' + pageScreen + ' screen')
        await assertion.haveCount(elementName, pageScreen, count);
    }
    catch (err) {
        throw err;
    }
})

When('User should have count more than {string} in {string} in {string} screen', async (count, elementName, pageScreen) => {
    try {
        console.log('User should  have count more than ' + count + ' in ' + elementName + ' in ' + pageScreen + ' screen')
        await assertion.havemoreCount(count, elementName, pageScreen,);
    }
    catch (err) {
        throw err;
    }
})

When('User should not see an element {string} in {string} screen', async (elementName, pageScreen) => {
    try {
        console.log('User should not see an element ' + elementName + ' in ' + pageScreen + ' screen')
        await assertion.checkElementnotVisible(elementName, pageScreen)
    }
    catch (err) {
        throw err;
    }
})
When('User should see an element {string} in {string} screen', async (elementName, pageScreen) => {
    try {
        console.log('User should see an element ' + elementName + ' in ' + pageScreen + ' screen')
        await assertion.checkElementVisible(elementName, pageScreen)
    }
    catch (err) {
        throw err;
    }
})
When('User check text {string} in {string} in {string} screen', async (expectedText, elementName, pageScreen) => {
    try {
        console.log('User check text ' + expectedText + ' in ' + elementName + ' in ' + pageScreen + ' screen')
        await assertion.checkgiventext(expectedText, expectedText) 
    }
    catch (err) {
        throw err;
    }
})








