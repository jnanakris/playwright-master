import { ScreenMap } from "../Utility/Source/Core";
import { CommonUtilObject } from "../Utility/Util/CommonUtil";
import { browser, context, page } from "../steps/world";
import { Actions } from "../Utility/Util/Actions";

let action: Actions = new Actions();
export class Login {
  async login(url: any, user: any) {
    let appURL = CommonUtilObject.getTestData(url);
    console.log("Application URL: " + appURL);
    if (user == 'Admin') {
      process.env.appuser = CommonUtilObject.getTestData(user);

    }
    else if (user == 'GroupAdmins') {
      let grpAdmin = CommonUtilObject.readJSONData("resources/" + process.env.Env + "TestData", user);
      let data = JSON.parse(grpAdmin);
      if(data[0]!='admin'){
      let appuser_fname = data[0].split(" ")[0];
      let appuser_lname = data[0].split(" ")[1];
      process.env.appuser = (appuser_fname.charAt(0) + appuser_lname).toLowerCase();
      }
      else{
        process.env.appuser=data[0]
      }
    }
    else if (user == 'SecondGroupAdmins') {
      let grpAdmin = CommonUtilObject.readJSONData("resources/" + process.env.Env + "TestData", 'GroupAdmins');
      let data = JSON.parse(grpAdmin);
      let appuser_fname = data[1].split(" ")[0];
      let appuser_lname = data[1].split(" ")[1];
      process.env.appuser = (appuser_fname.charAt(0) + appuser_lname).toLowerCase();
    }

    else if (user.startsWith("#")) {
      let UserName = user.replace("#", "")
      process.env.appuser = UserName
      CommonUtilObject.writeUsecaseTestData(process.env.FileName, "Updateduser", UserName);
    }
    console.log("Login User: " + process.env.appuser);
    await page.goto(appURL, { timeout: 100000 });
    await action.fillText(process.env.appuser, "username", "LoginPage");
    if (process.env.Infra !== "cloud" && process.env.appuser != "admin" && user.startsWith("#")) {
      await action.fillText("Konfig@123", "password", "LoginPage");
      
    } else if (process.env.Infra == "cloud" && user.startsWith("#")) {
      await console.log("process.env.appuser"+process.env.appuser)
      await action.fillText(process.env.appuser, "password", "LoginPage");
      
    } 
    else {
      await action.fillText(process.env.appuser, "password", "LoginPage");
    }
    let submit: any = await ScreenMap.get("LoginPage").getElement("btn_login");
    await submit.click();
  }

  async payloadlogin(url: any, agentNumber) {
    let appURL = CommonUtilObject.readUsecaseTestData(process.env.FileName, url);
    console.log("Application URL: " + appURL);
    let appusername = CommonUtilObject.readUsecaseTestData(process.env.FileName, "FO_Agent");
    appusername = appusername.toLowerCase();
    console.log("Login User: " + appusername);
    let appusers, appuser_fname, appuser_lname;
    console.log(appusername.includes(','))
    await page.goto(appURL, { timeout: 100000 });
    if (appusername.includes(',')) {
      let noOfAgents = appusername.match(/,/gi).length;
      console.log("noOfAgents is " + noOfAgents);
      appusers = appusername.split(",")[Number(agentNumber) - 1];
      appuser_fname = appusers.split(" ")[0];
      appuser_lname = appusers.split(" ")[1];
      console.log(
        " Payload App Login UserId for " + agentNumber + " : " + appuser_fname.charAt(0) + appuser_lname
      );
    }
    else {
      appuser_fname = appusername.split(" ")[0];
      appuser_lname = appusername.split(" ")[1];
      console.log(
        " Payload App Login UserId: " + appuser_fname.charAt(0) + appuser_lname
      );
    }
    let appuser = appuser_fname.charAt(0) + appuser_lname;
    await action.fillText(appuser, "username", "LoginPage");
    if (process.env.Env == "Cloud" && appuser != "admin") {
      await action.fillText("Konfig@123", "password", "LoginPage");
    }
    else {
      await action.fillText(appuser, "password", "LoginPage");
    }
    let submit: any = await ScreenMap.get("LoginPage").getElement("btn_login");
    await submit.click();
  }

  async logout(element: any, pageScreen: any) {
    await page.waitForTimeout(500);
    await Promise.all([
      page.waitForNavigation({ waitUntil: 'load', timeout: 150000 }),
      await action.ClickElement(element, pageScreen)
    ]);
    console.log("User has  logged out form the current session");
    await context.clearCookies();
  }

  async workflowUIlogin(url: any, appManagerNumber?, user?) {
    let appURL = CommonUtilObject.getTestData(url);
    console.log('User clears all the Browser Cookies')
    await context.clearCookies();
    console.log("Application URL: " + appURL);
    let appusername;
    if (user !== undefined) {
      appusername = CommonUtilObject.readUsecaseTestData(process.env.FileName, user);
    } else {
      appusername = (CommonUtilObject.readUsecaseTestData(process.env.FileName, 'AssignedTo')).trim();
    }
    appusername = appusername.replace("[", "");
    appusername = appusername.replace("]", "");
    appusername = appusername.toLowerCase();
    console.log("Login User: " + appusername);
    let appusers, appuser_fname, appuser_lname;
    console.log(appusername.includes(','))
    await page.goto(appURL, { timeout: 100000 });
    if (appusername.includes(',')) {
      let noOfAgents = appusername.match(/,/gi).length;
      console.log("noOfAgents is " + noOfAgents);
      appusers = appusername.split(",")[Number(appManagerNumber) - 1];
      appuser_fname = appusers.split(" ")[0];
      appuser_lname = appusers.split(" ")[1];
      console.log(
        " Workflow App Login UserId for " + appManagerNumber + " : " + appuser_fname.charAt(0) + appuser_lname
      );
    }
    else {
      appuser_fname = appusername.split(" ")[0];
      appuser_lname = appusername.split(" ")[1];
      console.log(
        " Workflow App Login UserId: " + appuser_fname.charAt(0) + appuser_lname
      );
    }
    let appuser = appuser_fname.charAt(0) + appuser_lname;
    await action.fillText(appuser, "username", "LoginPage");
    if (process.env.Env == "Cloud" && appuser != "admin") {
      await action.fillText("Konfig@123", "password", "LoginPage");
    }
    else {
      await action.fillText(appuser, "password", "LoginPage");
    }
    let submit: any = await ScreenMap.get("LoginPage").getElement("btn_login");
    await submit.click();
  }

  async Oktalogin(url: any, user: any) {
    let appURL = CommonUtilObject.getTestData(url);
    console.log("Application URL: " + appURL);
    if (user == 'Admin') {
      let Admin = CommonUtilObject.readUsecaseTestData("resources/Login", process.env.Env + "_Admin");
      process.env.appuser = Admin.split(" ")[0];
      process.env.password = Admin.split(" ")[1];
    }
    else if (user == 'GroupAdmins') {
      let grpAdmin = CommonUtilObject.readJSONData("resources/" + process.env.Env + "TestData", user);
      let data = JSON.parse(grpAdmin);
      await this.getLoginDetails(data[0], "Members")
    } 
    else if (user == 'SecondGroupAdmins') {
      let grpAdmin = CommonUtilObject.readJSONData("resources/" + process.env.Env + "TestData", 'GroupAdmins');
      let data = JSON.parse(grpAdmin);
      await this.getLoginDetails(data[1], "Members")
    }

    else if (user.startsWith("#")) {
      let UserName = user.replace("#", "")
      await this.getLoginDetails(UserName, "Members")
      CommonUtilObject.writeUsecaseTestData(process.env.FileName, "Updateduser", UserName);
    }
    console.log("Login User: " + process.env.appuser);
    await page.goto(appURL, { waitUntil: 'networkidle', timeout: 120000 });
    let loginwithSSO: any = await ScreenMap.get("LoginPage").getElement("okta_LoginwithSSO");

    // Click the login button and wait for navigation
    await Promise.all([
      page.waitForNavigation({ waitUntil: 'load', timeout: 120000 }),
      await loginwithSSO.click()
    ]);
    await page.waitForLoadState("networkidle", { timeout: 120000 });
    let elementExist = await page.isVisible(await ScreenMap.get("LoginPage").getSelector("okta_username")).then(async (exist) => {
      return exist;
    });
    if (elementExist == true) {
      await action.fillText(process.env.appuser, "okta_username", "LoginPage");
      await action.fillText(process.env.password, "okta_password", "LoginPage");
      let submit: any = await ScreenMap.get("LoginPage").getElement("okta_signIn");
      await Promise.all([
        page.waitForNavigation({ waitUntil: 'load', timeout: 120000 }),
        await submit.click() // Click the login button
      ]);
      await page.waitForLoadState("networkidle", { timeout: 120000 });
    }
    else {
      console.log("user already logged in");
      await page.waitForTimeout(500);
      await page.waitForLoadState("networkidle", { timeout: 120000 });
    }

  }

  async payloadoktalogin(url: any, agentNumber) {
    await context.clearCookies();
    let appURL = CommonUtilObject.readUsecaseTestData(process.env.FileName, url);
    console.log("Application URL: " + appURL);
    let appusername = CommonUtilObject.readJSONData(process.env.FileName, "FO_Agent");
    let data = JSON.parse(appusername);
    const agents = data.split(',')[Number(agentNumber) - 1];
    await this.getLoginDetails(agents, "Members")

    await page.goto(appURL, { waitUntil: 'networkidle',timeout: 120000 });
    let loginwithSSO: any = await ScreenMap.get("LoginPage").getElement("okta_LoginwithSSO");
    // Click the login button and wait for navigation
    await Promise.all([
      page.waitForNavigation({ waitUntil: 'load', timeout: 120000 }),
      await loginwithSSO.click()
    ]);
    await page.waitForLoadState("networkidle", { timeout: 120000 });
    let elementExist = await page.isVisible(await ScreenMap.get("LoginPage").getSelector("okta_username")).then(async (exist) => {
      return exist;
    });
    if (elementExist == true) {
      await action.fillText(process.env.appuser, "okta_username", "LoginPage");
      await action.fillText(process.env.password, "okta_password", "LoginPage");
      let submit: any = await ScreenMap.get("LoginPage").getElement("okta_signIn");
      await Promise.all([
        page.waitForNavigation({ waitUntil: 'load', timeout: 120000 }),
        await submit.click() // Click the login button
      ]);
      await page.waitForLoadState("networkidle", { timeout: 120000 });
    }
    else {
      console.log("user already logged in");
      await page.waitForTimeout(500);
      await page.waitForLoadState("networkidle", { timeout: 120000 });
    }

  }

  async getLoginDetails(userName, loginUser) {
    let grpAdmin = CommonUtilObject.readJSONData("resources/Login", process.env.Env + "_" + loginUser);
    let data = JSON.parse(grpAdmin);
    for (let k = 0; k < await data.length; k++) {
      let appuser_username = data[k].split(",")[0];
      if (appuser_username == userName) {
        let appuser_userid = data[k].split(",")[1];
        let appuser_password = data[k].split(",")[2];
        process.env.appuser = appuser_userid;
        process.env.password = appuser_password;
        break;
      }
    }
  }

  async workflowUIOktalogin(url: any, appManagerNumber?, user?) {
    let appURL = CommonUtilObject.getTestData(url);
    console.log("Application URL: " + appURL);
    let appusername;
    if (user !== undefined) {
      appusername = CommonUtilObject.readJSONData(process.env.FileName, user);
    } else {
      appusername = (CommonUtilObject.readJSONData(process.env.FileName, 'AssignedTo')).trim();
    }
    let data = JSON.parse(appusername);
    let agents;
    if (appManagerNumber) {
      agents = data.split(',')[Number(appManagerNumber) - 1];
      agents = agents.trim();
    }
    else {
      agents = data.trim();
    }
    await this.getLoginDetails(agents, "Members")
    await page.goto(appURL, { waitUntil: 'networkidle',timeout: 120000 });
    let loginwithSSO: any = await ScreenMap.get("LoginPage").getElement("okta_LoginwithSSO");
    // Click the login button and wait for navigation
    await Promise.all([
      page.waitForNavigation({ waitUntil: 'load', timeout: 120000 }),
      await loginwithSSO.click()
    ]);
    await page.waitForLoadState("networkidle", { timeout: 120000 });
    let elementExist = await page.isVisible(await ScreenMap.get("LoginPage").getSelector("okta_username")).then(async (exist) => {
      return exist;
    });
    if (elementExist == true) {
      await action.fillText(process.env.appuser, "okta_username", "LoginPage");
      await action.fillText(process.env.password, "okta_password", "LoginPage");
      let submit: any = await ScreenMap.get("LoginPage").getElement("okta_signIn");
      await Promise.all([
        page.waitForNavigation({ waitUntil: 'load', timeout: 120000 }),
        await submit.click() // Click the login button
      ]);
      await page.waitForLoadState("networkidle", { timeout: 130000 });
    }
    else {
      console.log("user already logged in");
      await page.waitForTimeout(500);
      await page.waitForLoadState("networkidle", { timeout: 140000 });
    }
  }
}

