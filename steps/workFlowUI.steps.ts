import { Given, When, Then, DataTable } from "@cucumber/cucumber";
import { context, page } from "./world";
import { ScreenMap } from "../Utility/Source/Core";
import { expect } from "@playwright/test";
import { Login } from "../Main/Login";
import { Actions } from "../Utility/Util/Actions";
import { Assertions } from "../Utility/Util/Assertions";
import { CommonUtilObject } from "../Utility/Util/CommonUtil";
import { WorkflowUI } from "../Main/WorkflowUI";
import { Payload } from "../Main/Payload";

let action: Actions = new Actions();
let assertion: Assertions = new Assertions();
let workflowUI: WorkflowUI = new WorkflowUI();
let login: Login = new Login();
let payload: Payload = new Payload();
let FileName;

Given(
  "As {string} user verify Task {string} Details under {string} in {string} screen",
  async function (appUser, taskNo, taskName, pageScreen) {
    console.log('As ' + appUser + ' user verify Task Details under ' + taskName + ' in ' + pageScreen + ' screen')
    console.log("FileName is " + FileName);
    await page.waitForTimeout(500);
    await action.selectDropdownbytagName(
      "span",
      'Role Dropdown',
      appUser, pageScreen
    );
    await page.waitForTimeout(2000)
    await action.ClickElement(taskName, pageScreen)
    await payload.waitforInvisibilityOfSpinner()
    let txNumber = CommonUtilObject.readUsecaseTestData(
      FileName,
      "txNumber"
  );
  if (txNumber) {
    await action.fillText(txNumber, 'Filter Transaction id', pageScreen)
    await page.waitForTimeout(2000)
    await page.keyboard.press("Enter");
    await payload.waitforInvisibilityOfSpinner()
    await page.waitForTimeout(3000)
  }
    // Filter Task Name
    await action.fillText(CommonUtilObject.readUsecaseTestData(FileName, "Task" + taskNo), 'Filter Task Name', pageScreen)
    await page.waitForTimeout(2000)
    await page.keyboard.press("Enter");
    await payload.waitforInvisibilityOfSpinner()
    await page.waitForTimeout(3000)
    await workflowUI.validateTaskDetails(taskNo, FileName, pageScreen)
  }
);

Given(
  "User get the Test data from {string} json file in {string} screen",
  async function (fileName, pageScreen) {
    console.log('User get the Test data from ' + fileName + ' in ' + pageScreen + ' screen')
    FileName = fileName;
    process.env.FileName = fileName;
  }
);

Given(
  "Based on the Task assigned to person logout or continue with the same user in {string} screen for {string}",
  async function (pageScreen,applicationName) {
    console.log('Based on the Task assigned to person logout or continue with the same user')
    let taskAssignedTo = CommonUtilObject.readUsecaseTestData(FileName, 'AssignedTo')
    let groupName=await action.getText('groupName',pageScreen)
    await action.mouseHoverElement('Logged in User', pageScreen);
    let appLoggedinUser = await action.getText('Logged in User Tool tip', pageScreen)
    console.log("appLoggedinUser is " + appLoggedinUser)
    console.log("taskAssignedTo " + taskAssignedTo.trim())
    if (appLoggedinUser.trim() == taskAssignedTo.trim()) {
      console.log("Logged in user is same as the Task owner");
    }
    else {
      await login.logout('Logout', 'Page')
      // await action.ClickElement('Logout', 'Page');
      await page.waitForTimeout(2000);
      let loginType = await CommonUtilObject.readUsecaseTestData("resources/TestData", "LoginType");
    console.log("Login type is " +loginType)
    if(loginType == 'OKTA'){
      console.log("inside")
      await login.workflowUIOktalogin ('Finlevit_workflow');
    }else{
      await login.workflowUIlogin('Finlevit_workflow');
    }
      await page.waitForSelector(await ScreenMap.get("WorkFlow UI").getSelector(
        "Filter Transaction id"),{timeout:100000}
      );
       //click on Konfig Logo
       await action.ClickElement('Home', 'HomePage');
       console.log('User clicked on application logo in '+pageScreen);
      // Click on Groups Icon
      await action.ClickElement("Group", 'HomePage');
      // Click on Group Searchicon
      await action.ClickElement("search_group", "Groups");
      await page.waitForTimeout(2000);
      console.log("Group Search Icon clicked");
      //Enter GroupName
      // let grpName = await CommonUtilObject.getTestData('GroupName');
      await action.enterText(groupName, "search_group_textbox", "Groups");
      console.log("User enters group name: " + groupName);
      //Click on Group
      let currentGroup =
        '//span[(@data-test-id="group-title") and (text()="' + groupName + '")]';
      await page.click(currentGroup);
      console.log(groupName + " is open now");
      //serach app
      await action.ClickElement("search_application_textbox", 'Application');
      let Appname
      
      //app name
      Appname = CommonUtilObject.readUsecaseTestData(process.env.FileName, applicationName);
      
      await action.enterText(Appname, "search_application_textbox", 'Application');
      //click on app
      let currentApp =
        '//div[contains(@class,"card-title") and contains(text(),"' +
        Appname +
        '")]';
      await page.click(currentApp);
      console.log(Appname + " is open now");
    }
  }
);

When(
  "User validate left side menu options for the Task in {string} screen",
  async (pageScreen) => {
    try {
      console.log(
        "User validate left side menu options for the Task in " +
        pageScreen +
        " screen"
      );
      await assertion.checktext('Details', pageScreen, 'Details')
      await assertion.checktext('Data Change Log', pageScreen, 'Data Change Log')
      await assertion.checktext('Task History', pageScreen, 'History')
      await assertion.checktext('Documents', pageScreen, 'Documents')
    } catch (err) {
      throw err;
    }
  }
);

Then('User validate {string} widget {string} is {string} in {string} screen', async function (typeOfWidget, elementName, expectedValue, pageScreen) {
  console.log('User validate ' + typeOfWidget + ' widget ' + elementName + ' is ' + expectedValue + ' in ' + pageScreen + 'screen')
  let inputElement;
  if (typeOfWidget == "Text Input" || typeOfWidget == "Number") {
    let elementXpath = await ScreenMap.get(pageScreen).getSelector("TextInput");
    inputElement = page.locator(
      elementXpath.replace("elementName", elementName)
    );
    let actualText = await inputElement.inputValue()
    if (expectedValue.startsWith("#")) {
      expectedValue=CommonUtilObject.readUsecaseTestData(process.env.FileName,expectedValue.replace("#", ""))   
    } 
    console.log("Expected value is "+expectedValue)
    console.log("Actual value is "+actualText)
    await expect(actualText?.trim()).toEqual(expectedValue);
  }
  else if (typeOfWidget == "Radio Group") {
    let elementXpath = await ScreenMap.get(pageScreen).getSelector("RadioButton");
    let options = await page.locator(elementXpath.replace("elementName", elementName));
    let optionsCount = await options.count();
    console.log("Options count is " + optionsCount);
    await expect(optionsCount).not.toEqual(0);
    let attributePresent;
    if (expectedValue.startsWith("#")) {
      expectedValue=CommonUtilObject.readUsecaseTestData(process.env.FileName,expectedValue.replace("#", ""))   
    } 
    for (let j = 0; j < optionsCount; j++) {
      console.log("Actual Text " + (await options.nth(j).textContent()));
      console.log("Expected Text  " + expectedValue);
      let input = await page.locator("//div[normalize-space(text())='" + elementName + "']/../..//input");
      if ((await options.nth(j).textContent()).trim() == expectedValue) {
        let checkedattr = await assertion.getAttributeGiven(input.nth(j), 'aria-checked')
        await expect(checkedattr?.trim()).toEqual("true");
        console.log("Expected element " + expectedValue + " is selected");
        attributePresent=true;
        break;
      }
    }
    expect(attributePresent).toEqual(true);
  }
  else if (typeOfWidget == "Checkbox") {
    let elementXpath = await ScreenMap.get(pageScreen).getSelector("Checkbox");
    let options = await page.locator(elementXpath.replace("elementName", elementName));
    console.log(options)
    let checkedattr = await assertion.getAttributeGiven(options, 'aria-checked')
    await expect(checkedattr?.trim()).toEqual("true");
    console.log("Expected element " + expectedValue + " is selected");   
  }
});

Then('User Fill {string} in {string} widget {string} in {string} screen', async function (expectedValue, typeOfWidget, elementName, pageScreen) {
  console.log('User Fill ' + expectedValue + ' in ' + typeOfWidget + ' widget ' + elementName + ' in ' + pageScreen + 'screen')
  let inputElement;
  if (typeOfWidget == "Text Input" || typeOfWidget == "Number") {
    let elementXpath = await ScreenMap.get(pageScreen).getSelector("TextInput");
    inputElement = page.locator(
      elementXpath.replace("elementName", elementName)
    );
    await inputElement.fill(expectedValue);
  }
  else if (typeOfWidget == "Radio Group" || typeOfWidget == "Checkbox Group") {
    let elementXpath = await ScreenMap.get(pageScreen).getSelector("RadioButton");
    let options = await page.locator(elementXpath.replace("elementName", elementName));
    let optionsCount = await options.count();
    console.log("Options count is " + optionsCount);
    for (let j = 0; j < optionsCount; j++) {
      console.log("Actual Text " + (await options.nth(j).textContent()));
      console.log("Expected Text  " + expectedValue);
      if ((await options.nth(j).textContent()).trim() == expectedValue) {
        await action.ClickElement(await options.nth(j));
        console.log("Expected element " + expectedValue + " clicked");
        break;
      }
    }
  }
  else if (typeOfWidget == "TextArea") {
    let elementXpath = await ScreenMap.get(pageScreen).getSelector("TextArea");
    inputElement = page.locator(
      elementXpath.replace("elementName", elementName)
    );
    await inputElement.fill(expectedValue);
  }
  else if (typeOfWidget == "Date") {
    let elementXpath = await ScreenMap.get(pageScreen).getSelector("Date");
    inputElement = page.locator(
      elementXpath.replace("elementName", elementName)
    );
    await action.ClickElement(inputElement);
    await action.enterText(expectedValue, inputElement);
  }
  else if (typeOfWidget == "Checkbox") {
    let elementXpath = await ScreenMap.get(pageScreen).getSelector("Checkbox");
    inputElement = page.locator(
      elementXpath.replace("elementName", elementName)
    );
    await action.ClickElement(inputElement);
  }
  await page.waitForTimeout(500);
});

When(
  "User validate Task {string} Actions and select {string} action in {string} screen",
  async (taskNumber, actionName, pageScreen) => {
    try {
      console.log(
        "User validate Task " + taskNumber + " Actions and select " + actionName + " action in " +
        pageScreen +
        " screen"
      );
      await action.ClickElement('Actions Dropdown', pageScreen)
      let options = await action.getElement(
        "Actions Dropdownoptions",
        pageScreen
      );
      let optionsCount = await options.count();
      console.log("Options count is " + optionsCount);
      let allOptions = "";
      for (let i = 0; i < optionsCount; i++) {
        allOptions = allOptions + await options.nth(i).textContent() + ","
      }
      console.log('Actions are validated ' + allOptions?.trim())
      await expect(allOptions?.trim()).toEqual(CommonUtilObject.readUsecaseTestData(FileName, 'Task' + taskNumber + '_Actions'));
      console.log("Options count is " + optionsCount);
      for (let j = 0; j < optionsCount; j++) {
        if ((await options.nth(j).textContent()) == actionName) {
          await options.nth(j).click();
          await page.waitForTimeout(500);
          console.log("Expected element " + actionName + " clicked");
          break;
        }
      }
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User validate Transaction details are removed from {string} and it is displaying under {string} on the successful workflow completion in {string} screen",
  async (Teamtask, HistoryElement, pageScreen) => {
    try {
      console.log(
        "User make sure Transaction details are removed from My task/Team task and it is displaying under " + HistoryElement + " on the successful workflow completion in " +
        pageScreen +
        " screen"
      );
      await page.waitForTimeout(500);
      await action.selectDropdownbytagName(
        "span",
        'Role Dropdown',
        "Agent", pageScreen
      );
      await action.ClickElement(Teamtask, pageScreen)
      await action.fillText(CommonUtilObject.readUsecaseTestData(FileName, 'txNumber'), 'Filter Transaction id', pageScreen)
      await page.waitForTimeout(2000)
      await page.keyboard.press("Enter");
      await page.waitForTimeout(500);
      await payload.waitforInvisibilityOfSpinner()
      await assertion.checkElementVisible("No Data Transaction Table", pageScreen)
      await action.ClickElement(HistoryElement, pageScreen)
      await payload.waitforInvisibilityOfSpinner()
      await action.ClickElement('Reload', pageScreen)
      await payload.waitforInvisibilityOfSpinner()
      await action.fillText(CommonUtilObject.readUsecaseTestData(FileName, 'txNumber'), 'Filter Transaction id', pageScreen)
      await page.waitForTimeout(2000)
      await page.keyboard.press("Enter");
      await page.waitForTimeout(500);
      await payload.waitforInvisibilityOfSpinner()
      
        await assertion.checktext('History Transaction id Column Data', pageScreen, CommonUtilObject.readUsecaseTestData(FileName, 'txNumber'));
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User validate Transaction table header under {string} in {string} screen",
  async (taskElement, pageScreen, table: DataTable) => {
    try {
      console.log(
        "User validate Transaction table header under " + taskElement + " in " +
        pageScreen +
        " screen"
      );
      await page.waitForTimeout(500);
      const headervals = table.raw()[0];
      console.log(headervals);
      for (let i = 0; i < headervals.length; i++) {
        let header = await action.getElement('Transaction table Headers', pageScreen)
        let actualText = await header.nth(i).textContent()
        console.log("Actual Header " + actualText)
        console.log("Expected Header " + headervals[i])
        expect(actualText?.trim()).toEqual(headervals[i]);
      }
    } catch (err) {
      throw err;
    }
  });

Then(
  "User validates Tasks event and Action as {string} in {string} screen",
  async (expectedText, pageScreen, table: DataTable) => {
    try {
      let formValues = table.hashes();
      for (let i = 0; i < formValues.length; i++) {
        console.log(
          "User validates " +
          formValues[i].Task +
          " Task Action as " +
          expectedText +
          " in " +
          pageScreen +
          " screen"
        );
        let boTask = page.locator(
          "//span[text()='" + formValues[i].Task + "']/../..//button"
        );
        await boTask.click();
        console.log(formValues[i].Task + " Task expanded");
        await page.waitForTimeout(3000);
        let taskEvent = page.locator(
          "//mat-expansion-panel//*[@title=\"Task '" +
          formValues[i].Task +
          "' Completed\"]"
        );
        let Event = await taskEvent.textContent();
        console.log("actualText is :" + Event);
        await expect(Event).toEqual(
          "Task '" + formValues[i].Task + "' Completed"
        );
        console.log(
          "expectedText is :" + "Task '" + formValues[i].Task + "' Completed"
        );
        let taskAction = page.locator(
          "//span[text()='" +
          formValues[i].Task +
          "']/../..//button/../../../../..//mat-expansion-panel//div[@title='" + expectedText + "']"
        );
        let actualText = await taskAction.textContent();
        console.log("actualText is :" + actualText);
        await expect(actualText).toEqual(expectedText);
        console.log("expectedText is :" + expectedText);
        await boTask.click();
      }
    } catch (error) {
      throw error;
    }
  }
);

When(
  "User validate SLA started when task is started in {string} screen",
  async (pageScreen) => {
    try {
      console.log(
        "User validate SLA started when task is started in " +
        pageScreen +
        " screen"
      );
      await workflowUI.validateSLADetails(FileName, pageScreen)
    } catch (err) {
      throw err;
    }
  }
);

When(
  "User Suspend the task for {string} hour and Continue SLA in {string} screen",
  async (suspendhrs, pageScreen) => {
    try {
      console.log(
        "User Suspend the task for " + suspendhrs + " hour and Continue SLA in " +
        pageScreen +
        " screen"
      );
      await action.ClickElement("Transaction id Column Data", pageScreen);
      await action.waitforInvisibilityOfToastMessage();
      await workflowUI.validateSLASuspend(suspendhrs, FileName, pageScreen)
      await workflowUI.validateContinueSLA(FileName, pageScreen)
    } catch (err) {
      throw err;
    }
  }
);

Then(
  "User validates SLA Tasks event and Action for {string} in {string} screen in History page",
  async (Task, pageScreen, table: DataTable) => {
    try {
      let formValues = table.hashes();
      console.log(
        "User validates SLA Tasks event and Action for " +
        Task +
        " in " +
        pageScreen +
        " screen in History page"
      );
      let boTask = page.locator("//span[text()='" + Task + "']/../..//button");
      await boTask.click();
      console.log(Task + " Task expanded");
      await page.waitForTimeout(3000);
      let noOfRows = await page
        .locator(
          "//span[text()='" + Task + "']/ancestor::finlevit-panel//finlevit-custom-table//div[contains(@class,'f-tr-group')]"
        )
        .count();
      for (let i = 2; i <= noOfRows; i++) {
        let event = await page
          .locator(
            "(//span[text()='" + Task + "']/ancestor::finlevit-panel//finlevit-custom-table//div[contains(@class,'f-tr-group')])[" +
            i +
            "]//div[(@class='cell-container')]//div[contains(@class,'td ng-star-inserted')]"
          )
          .nth(0);
        let EventText = await event.textContent();
        let action = await page
          .locator(
            "(//span[text()='" + Task + "']/ancestor::finlevit-panel//finlevit-custom-table//div[contains(@class,'f-tr-group')])[" +
            i +
            "]//div[(@class='cell-container')]//div[contains(@class,'td ng-star-inserted')]"
          )
          .nth(1);
        let ActionText = await action.textContent();
        await expect(EventText).toEqual(formValues[i - 2].Event);
        await expect(ActionText).toEqual(formValues[i - 2].Action);
        console.log(
          "Actual Event is -->" +
          EventText +
          "  Expected Event is -->" +
          formValues[i - 2].Event
        );
        console.log(
          "Actual Action is -->" +
          ActionText +
          " and Expected Event is -->" +
          formValues[i - 2].Action
        );
      }
      await boTask.click();
    } catch (error) {
      throw error;
    }
  }
);

When(
  "User validate Transaction details are removed from {string} in {string} screen",
  async (Teamtask, pageScreen) => {
    try {
      console.log(
        "User make sure Transaction details are removed from My task/Team task in " +
        pageScreen +
        " screen"
      );
      await page.waitForTimeout(500);
      await action.selectDropdownbytagName(
        "span",
        'Role Dropdown',
        "Agent", pageScreen
      );
      await action.ClickElement(Teamtask, pageScreen)
      await action.fillText(CommonUtilObject.readUsecaseTestData(FileName, 'txNumber'), 'Filter Transaction id', pageScreen)
      await page.waitForTimeout(2000)
      await page.keyboard.press("Enter");
      await page.waitForTimeout(500);
      await payload.waitforInvisibilityOfSpinner()
      await assertion.checkElementVisible("No Data Transaction Table", pageScreen)
    } catch (err) {
      throw err;
    }
  }
);

Given(
  "As {string} user verify Task {string} Followup task Details under {string} in {string} screen",
  async function (appUser, taskNo, taskName, pageScreen) {
    console.log('As ' + appUser + ' user verify Followup Task Details under ' + taskName + ' in ' + pageScreen + ' screen')
    // wiat for 1 min
    await page.waitForTimeout(500);
    await action.selectDropdownbytagName(
      "span",
      'Role Dropdown',
      appUser, pageScreen
    );
    await page.waitForTimeout(2000)
    await action.ClickElement("My Task", pageScreen)
    await page.waitForTimeout(2000)
    await action.ClickElement(taskName, pageScreen)
    // Enter Transaction Number
    await action.fillText(CommonUtilObject.readUsecaseTestData(FileName, 'txNumber'), 'Filter Transaction id', pageScreen)
    await page.waitForTimeout(2000)
    await page.keyboard.press("Enter");
    await payload.waitforInvisibilityOfSpinner()
    await page.waitForTimeout(3000)
    // Enter Task Name
    await action.fillText(CommonUtilObject.readUsecaseTestData(FileName, 'Followup TaskName'), 'Filter Task Name', pageScreen)
    await page.waitForTimeout(2000)
    await page.keyboard.press("Enter");
    await payload.waitforInvisibilityOfSpinner()
    await page.waitForTimeout(3000)
    await workflowUI.validateFollowupTaskDetails(FileName, pageScreen)
  }
);

When(
  "User validate Followup task removed from {string} in {string} screen",
  async (Teamtask, pageScreen) => {
    try {
      console.log(
        "User make sure Followup task are removed from My task/Team task in " +
        pageScreen +
        " screen"
      );
      await page.waitForTimeout(500);
      await action.selectDropdownbytagName(
        "span",
        'Role Dropdown',
        "Agent", pageScreen
      );
      await action.ClickElement(Teamtask, pageScreen)
      await action.fillText(CommonUtilObject.readUsecaseTestData(FileName, 'txNumber'), 'Filter Transaction id', pageScreen)
      await page.waitForTimeout(2000)
      await page.keyboard.press("Enter");
      await page.waitForTimeout(500);
      await payload.waitforInvisibilityOfSpinner()
      // Enter Task Name
      await action.fillText(CommonUtilObject.readUsecaseTestData(FileName, 'Followup TaskName'), 'Filter Task Name', pageScreen)
      await page.waitForTimeout(2000)
      await page.keyboard.press("Enter");
      await payload.waitforInvisibilityOfSpinner()
      await page.waitForTimeout(3000)
      await assertion.checkElementVisible("No Data Transaction Table", pageScreen)
      await action.ClickElement('Clear Task Name Filter', pageScreen)
      await action.ClickElement('Clear TransactionID Filter', pageScreen)
    } catch (err) {
      throw err;
    }
  }
);

Then(
  "User validates Followup Tasks event for {string} in {string} screen in History page",
  async (Task, pageScreen, table: DataTable) => {
    try {
      let formValues = table.hashes();
      console.log(
        "User validates Follow up Tasks event for " +
        Task +
        " in " +
        pageScreen +
        " screen in History page"
      );
      console.log(formValues.length);
      let boTask = page.locator("//span[text()='" + Task + "']/../..//button");
      await boTask.click();
      console.log(Task + " Task expanded");
      await page.waitForTimeout(3000);
      let eventPresent;
      let transactionTableRow = page.locator("//span[text()='" + Task + "']/ancestor::finlevit-panel//finlevit-custom-table//div[contains(@class,'f-tr-group')]")
      console.log(await transactionTableRow.count());
      let expText = formValues[0].Event;
      for (let i = 1; i <= await transactionTableRow.count(); i++) {
        let event = await page
          .locator(
            "(//span[text()='" + Task + "']/ancestor::finlevit-panel//finlevit-custom-table//div[contains(@class,'f-tr-group')])[" +
            (i) +
            "]//div[(@class='inner-cell-container')]"
          )
          .nth(1);
          console.log(event)
        let actualText = await event.textContent();
        if (actualText.trim() == expText) {
          console.log("ActualText is " + actualText);
          console.log("ExpectedText is " + expText);
          expect(actualText?.trim()).toEqual(expText);
          eventPresent = true;
          break
        }
      }
      expect(eventPresent).toEqual(true);
      await boTask.click();
      let taskEvent = page.locator(
        "//mat-expansion-panel//*[@title=\"Task 'End' Created\"]"
      );
      let Event = await taskEvent.textContent();
      console.log("actualText is :" + Event);
      await expect(Event).toEqual(
        "Task 'End' Created"
      );
      console.log(
        "expectedText is :" + "Task 'End' Created"
      );
      let taskAction = page.locator(
        "//span[text()='End']/ancestor::finlevit-panel//mat-expansion-panel//*[@title='Follow up task cancelled']"
      );
      let Action = await taskAction.textContent();
      console.log("actualText is :" + Action);
      await expect(Action).toEqual(
        "Follow up task cancelled"
      );
      console.log(
        "expectedText is :" + "Follow up task cancelled"
      );
    } catch (error) {
      throw error;
    }
  }
);

When(
  "User verify the task SLA expiry in {string} screen",
  async (pageScreen) => {
    try {
      console.log(
        "User verify the task SLA expiry in " +
        pageScreen +
        " screen"
      );
      await workflowUI.validateSLAExpiry(FileName, pageScreen)
    } catch (err) {
      throw err;
    }
  }
);

Given(
  "User verify group name and App Name under my task again default preference in {string} screen",
  async function (pageScreen) {
    console.log('User verify group name and App Name under my task again default preference in ' + pageScreen + ' screen')
    await page.waitForTimeout(2000);
    await workflowUI.getDefaultPreferenceandValidate(pageScreen);
  }
);

When(
  "User validate Preferences table header under {string} in {string} screen",
  async (taskElement, pageScreen, table: DataTable) => {
    try {
      console.log(
        "User validate Preferences table header under " + taskElement + " in " +
        pageScreen +
        " screen"
      );
      await page.waitForTimeout(500);
      const headervals = table.raw()[0];
      console.log(headervals);
      for (let i = 0; i < headervals.length; i++) {
        let header = await action.getElement('Preference table Headers', pageScreen)
        let actualText = await header.nth(i).textContent()
        console.log("Actual Header " + actualText)
        console.log("Expected Header " + headervals[i])
        expect(actualText?.trim()).toEqual(headervals[i]);
      }
    } catch (err) {
      throw err;
    }
  });

Given(
  "User Reorder preferences and verify group name and App Name under my task again default preference in {string} screen",
  async function (pageScreen) {
    console.log('User Reorder preferences and verify group name and App Name under my task again default preference in ' + pageScreen + ' screen')
    await page.waitForTimeout(2000);
    await action.ClickElement('Home', 'HomePage');
    await page.waitForTimeout(2000);
    await page.waitForSelector(await ScreenMap.get("Groups").getSelector(
      "search_group")
    );
    // Click on Preferences Menu
    await action.ClickElement('Preferences Menu', pageScreen)
    await workflowUI.ReorderPreferenceandValidate(pageScreen)
  }
);

Given(
  "User change default {string} and validate under my task when login in {string} screen",
  async function (scenario, pageScreen) {
    console.log('User change default ' + scenario + ' and validate under my task when login in ' + pageScreen + ' screen')
    await page.waitForTimeout(2000);
    await action.ClickElement('Home', 'HomePage');
    await page.waitForTimeout(2000);
    await page.waitForSelector(await ScreenMap.get("Groups").getSelector(
      "search_group")
    );
    // Click on Preferences Menu
    await action.ClickElement('Preferences Menu', pageScreen)
    await workflowUI.UpdatedefaultApporRoleandValidate(scenario, pageScreen)
  }
);

Given(
  "As Assign Next Task To Task Originator is set in admin the task is assigned to the previous task user in {string} screen",
  async function (pageScreen) {
    console.log('As Assigned Next Task To Task Originator is set in admin the task is assigned to the previous task user in')
    let taskAssignedTo = CommonUtilObject.readUsecaseTestData(FileName, 'AssignedTo')
    await action.mouseHoverElement('Logged in User', pageScreen);
    let appLoggedinUser = await action.getText('Logged in User Tool tip', pageScreen)
    console.log("appLoggedinUser is " + appLoggedinUser)
    console.log("taskAssignedTo " + taskAssignedTo.trim())
    expect(appLoggedinUser.trim()).toEqual(taskAssignedTo.trim())
  });

  Given(
    "User validate task is unassigned and assign to {string} user in {string} in {string} screen",
    async function (appManagerNumber, user, pageScreen) {
      console.log('User validate task is unassigned and assign to '+appManagerNumber+ " user in " +user+" in " +pageScreen+" screen")
      let taskAssignedTo = CommonUtilObject.readUsecaseTestData(FileName, 'AssignedTo')
      await expect(taskAssignedTo.trim()).toEqual("Unassigned")
      
      let appusername = CommonUtilObject.readUsecaseTestData(process.env.FileName, user);
    console.log("Login User: " + appusername);
    let appuser;
    if (appusername.includes(',')) {
      appuser = appusername.split(",")[Number(appManagerNumber) - 1];
    }
    else {
      appuser=appusername
    }
    console.log("app user is " +appuser)
    await action.ClickElement('Assigned To Column Data',pageScreen)
    let option=page.locator("//div[@class='avatar-name' and normalize-space(text())='"+appuser+"']")
    await action.ClickElement(option);
    await page.waitForTimeout(500);
    CommonUtilObject.writeUsecaseTestData(FileName, "AssignedTo", appuser);
    }
  );

  Given(
    "User assign task to {string} user in {string} in {string} screen",
    async function (appManagerNumber, user, pageScreen) {
      console.log('User assign task to  '+appManagerNumber+ " user in " +user+" in " +pageScreen+" screen")
      let appusername = CommonUtilObject.readUsecaseTestData(process.env.FileName, user);
    console.log("Login User: " + appusername);
    let appuser;
    if (appusername.includes(',')) {
      appuser = appusername.split(",")[Number(appManagerNumber) - 1];
    }
    else {
      appuser=appusername
    }
    console.log("app user is " +appuser)
    await action.ClickElement('Assigned To Column Data',pageScreen)
    await page.waitForTimeout(500);
    let option=await page.locator("//div[@role='menu']//div[@class='avatar-name' and normalize-space(text())='"+appuser+"']").first()
    await action.ClickElement(option);
    await page.waitForTimeout(500);
    CommonUtilObject.writeUsecaseTestData(FileName, "AssignedTo", appuser);
    }
  );
