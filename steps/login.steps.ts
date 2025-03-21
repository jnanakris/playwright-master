import { Given, When, Then } from "@cucumber/cucumber";
import { context, page } from "./world";
import { ScreenMap } from "../Utility/Source/Core";
import { expect } from "@playwright/test";
import { Login } from "../Main/Login";
import { Actions } from "../Utility/Util/Actions";
import { CommonUtilObject } from "../Utility/Util/CommonUtil";

let login: Login = new Login();

Given(
  "user login to {string} with {string} credentials",
  async function (url, username) {
    let loginType = await CommonUtilObject.readUsecaseTestData("resources/TestData", "LoginType");
    if(loginType == 'OKTA'){
      await login.Oktalogin (url, username);
    }else{
      await login.login(url, username);
    }
  }
);

Given("user login to payload application with {string} with {string} agent", async function (url, agentNumber) {
  let loginType = await CommonUtilObject.readUsecaseTestData("resources/TestData", "LoginType");
    if(loginType == 'OKTA'){
      await login.payloadoktalogin(url, agentNumber);
    }
    else{
  await login.payloadlogin(url, agentNumber);
    }
});

Then('user will clear browser cookies', async function () {
  console.log('User clears all the Browser Cookies')
  await context.clearCookies();
});

Then('User will {string} from {string} the current session', async function (elementName, pageScreen) {
  console.log('User Click logout form the current session')
  await login.logout(elementName, pageScreen);
});

Given(
  "user login to workflow UI {string} with {string} {string} credentials",
  async function (url, appManagerNumber, username) {
    console.log('User login to workflow UI ' + url + ' with ' + username + ' credentials')
    let loginType = await CommonUtilObject.readUsecaseTestData("resources/TestData", "LoginType");
    if(loginType == 'OKTA'){
      await login.workflowUIOktalogin (url, appManagerNumber,username);
    }else{
      await login.workflowUIlogin(url, appManagerNumber, username);
    }
  });
