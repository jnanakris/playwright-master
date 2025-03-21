import { ScreenMap } from "../Utility/Source/Core";
import { CommonUtilObject } from "../Utility/Util/CommonUtil";
import { page } from "../steps/world";
import { Actions } from "../Utility/Util/Actions";
import { Assertions } from "../Utility/Util/Assertions";
import { expect } from "@playwright/test";
import { Login } from "../Main/Login";

let action: Actions = new Actions();
let assertion: Assertions = new Assertions();
let login: Login = new Login();

export class WorkflowUI {
  async validateTaskDetails(taskNo, fileName, pageScreen) {
    // validate Transaction number
    let txNumber = CommonUtilObject.readUsecaseTestData(
      fileName,
      "txNumber"
  );
  let transactionTableRow = await action.getElement("Transaction id Column", pageScreen,)
  if (txNumber) {
    let transactionPresent;
    for (let i = 0; i < await transactionTableRow.count(); i++) {
      const actualText = await transactionTableRow.nth(i).textContent();
      let expText = CommonUtilObject.readUsecaseTestData(fileName, "txNumber")
      if (actualText.trim() == expText) {
        console.log("ActualText is " + actualText);
        console.log("ExpectedText is " + expText);
        expect(actualText?.trim()).toEqual(expText);
        transactionPresent = true;
        break
      }
    }
    console.log("Transaction Number validated in UI is " + CommonUtilObject.readUsecaseTestData(fileName, "txNumber"))
    expect(transactionPresent).toEqual(true);
  }

    // validate Task Name
    let transactionName;
    for (let i = 0; i < await transactionTableRow.count(); i++) {
      const actualText = await transactionTableRow.nth(i).textContent();
      let expText = CommonUtilObject.readUsecaseTestData(fileName, "Task" + taskNo)
      if (actualText.trim() == expText) {
        console.log("ActualText is " + actualText);
        console.log("ExpectedText is " + expText);
        expect(actualText?.trim()).toEqual(expText);
        transactionName = true;
        break
      }
    }
    console.log("Task Name validated in UI is " + CommonUtilObject.readUsecaseTestData(fileName, "Task" + taskNo))
    expect(transactionName).toEqual(true);
    let assignedTo = await action.getText(
      "Assigned To Column Data",
      pageScreen
    );
    console.log("assignedTo is " + assignedTo);
    CommonUtilObject.writeUsecaseTestData(fileName, "AssignedTo", assignedTo);
  }
  
  async validateSLADetails(fileName, pageScreen) {
     // validate SLA
     let transactionTableRow = await action.getElement("Transaction id Column", pageScreen,)
     let transactionPresent;
     for (let i = 0; i < await transactionTableRow.count(); i++) {
       const actualText = await transactionTableRow.nth(i).textContent();
       let expText = "Yet To Start"
       if (actualText.trim() == expText) {
         console.log("ActualText is " + actualText);
         console.log("ExpectedText is " + expText);
         expect(actualText?.trim()).toEqual(expText);
         transactionPresent = true;
         break
       }
     }
     console.log("SLA validated in UI is Yet To Start")
     expect(transactionPresent).toEqual(true);

    // await assertion.checktext("SLA Column Data", pageScreen, "Yet To Start");
    await action.ClickElement("Transaction id Column Data", pageScreen);
    await page.waitForTimeout(500);
    await assertion.checktext("Details", pageScreen, "Details");
    await assertion.checktext(
      "Pagelevel_alert_messgae",
      pageScreen,
      "Task SLA Started"
    );
    await page.waitForSelector(await ScreenMap.get(pageScreen).getSelector("Pagelevel_alert_messgae"), { state: 'hidden' });
    await page.waitForTimeout(2000);
    await action.ClickElement("My Task", pageScreen);
    await action.fillText(
      CommonUtilObject.readUsecaseTestData(fileName, "txNumber"),
      "Filter Transaction id",
      pageScreen
    );
    await page.waitForTimeout(2000);
    await page.keyboard.press("Enter");
    await action.waitforInvisibilityOfSpinner();
    await page.waitForTimeout(3000);
    // validate SLA
    let transactionTableRow1 = await action.getElement("Transaction id Column", pageScreen,)
    let transactionPresent1;
    for (let i = 0; i < await transactionTableRow1.count(); i++) {
      const actualElement=await transactionTableRow1.nth(i)
      const actualText = await actualElement.textContent();
      let expText = "Mins Left"
      if (actualText.includes(expText)) {
        console.log("ActualText is " + actualText);
        console.log("ExpectedText is " + expText);
        // expect(actualText?.trim()).toEqual(expText);
        await expect(actualElement).toContainText(expText);
        transactionPresent1 = true;
        break
      }
    }
    expect(transactionPresent1).toEqual(true);
    // await assertion.ContainText("SLA Column Data", pageScreen, "Mins Left");
  }

  async validateSLASuspend(suspendHrs, fileName, pageScreen) {
    await action.ClickElement("Suspend", pageScreen);
    await page.isVisible(await ScreenMap.get(pageScreen).getSelector("Suspend_Comment")).then(async (exist) => {
      if (exist == true) {
        await action.fillText(
          "Suspend task for some time",
          "Suspend_Comment",
          pageScreen
        );
      }
    });
    await action.ClickElement("SuspendDurationInput", pageScreen);
    await action.fillText(suspendHrs, "SuspendHoursInput", pageScreen);
    await page.waitForTimeout(500);
    let okBtn = await action.getElement("SLAOkButton", pageScreen);
    await action.ClickElement(await okBtn.nth(1));
    await page.waitForTimeout(500);
    await action.ClickElement("SLAOkButton", pageScreen);
    await assertion.checktext(
      "Pagelevel_alert_messgae",
      pageScreen,
      "Task Suspended Successfully"
    );
    await page.waitForSelector(await ScreenMap.get(pageScreen).getSelector("Pagelevel_alert_messgae"), { state: 'hidden' });
    await page.waitForTimeout(2000);
    await action.ClickElement("My Task", pageScreen);
    await action.fillText(
      CommonUtilObject.readUsecaseTestData(fileName, "txNumber"),
      "Filter Transaction id",
      pageScreen
    );
    await page.waitForTimeout(2000);
    await page.keyboard.press("Enter");
    await action.waitforInvisibilityOfSpinner();
    await page.waitForTimeout(3000);
    // validate Suspend
    let transactionTableRow1 = await action.getElement("Transaction id Column", pageScreen,)
    let transactionPresent1;
    for (let i = 0; i < await transactionTableRow1.count(); i++) {
      const actualText = await transactionTableRow1.nth(i).textContent();
      let expText = "Suspended"
      if (actualText.trim() == expText) {
        console.log("ActualText is " + actualText);
        console.log("ExpectedText is " + expText);
        expect(actualText?.trim()).toEqual(expText);
        transactionPresent1 = true;
        break
      }
    }
    expect(transactionPresent1).toEqual(true);
    // await assertion.checktext("SLA Column Data", pageScreen, "Suspended");
  }

  async validateContinueSLA(fileName, pageScreen) {
    await action.ClickElement("Transaction id Column Data", pageScreen);
    await page.waitForTimeout(500);
    await assertion.checktext("Details", pageScreen, "Details");
    await assertion.checkElementnotVisible("Actions Dropdown", pageScreen);
    await action.ClickElement("ContinueSLA", pageScreen);
    await assertion.checktext(
      "Pagelevel_alert_messgae",
      pageScreen,
      "Task Sla Started"
    );
    await assertion.checkElementVisible("Actions Dropdown", pageScreen);
    await assertion.checkElementVisible("Suspend", pageScreen);
    await page.waitForTimeout(2000);
    await action.ClickElement("My Task", pageScreen);
    await action.fillText(
      CommonUtilObject.readUsecaseTestData(fileName, "txNumber"),
      "Filter Transaction id",
      pageScreen
    );
    await page.waitForTimeout(2000);
    await page.keyboard.press("Enter");
    await action.waitforInvisibilityOfSpinner();
    await page.waitForTimeout(3000);
     // validate SLA
     let transactionTableRow1 = await action.getElement("Transaction id Column", pageScreen,)
     let transactionPresent1;
     for (let i = 0; i < await transactionTableRow1.count(); i++) {
      const actualElement=await transactionTableRow1.nth(i)
      const actualText = await actualElement.textContent();
       let expText = "Mins Left"
       if (actualText.includes(expText)) {
         console.log("ActualText is " + actualText);
         console.log("ExpectedText is " + expText);
         // expect(actualText?.trim()).toEqual(expText);
         await expect(actualElement).toContainText(expText);
         transactionPresent1 = true;
         break
       }
     }
     expect(transactionPresent1).toEqual(true);
    // await assertion.ContainText("SLA Column Data", pageScreen, "Mins Left");
  }

  async validateFollowupTaskDetails(fileName, pageScreen) {
    // validate Transaction number
    let transactionTableRow = await action.getElement("Transaction id Column", pageScreen,)
    let transactionPresent;
    for (let i = 0; i < await transactionTableRow.count(); i++) {
      const actualText = await transactionTableRow.nth(i).textContent();
      let expText = CommonUtilObject.readUsecaseTestData(fileName, "txNumber")
      if (actualText.trim() == expText) {
        console.log("ActualText is " + actualText);
        console.log("ExpectedText is " + expText);
        expect(actualText?.trim()).toEqual(expText);
        transactionPresent = true;
        break
      }
    }
    console.log("Transaction Number validated in UI is " + CommonUtilObject.readUsecaseTestData(fileName, "txNumber"))
    expect(transactionPresent).toEqual(true);

    // validate Task Name
    let transactionName;
    for (let i = 0; i < await transactionTableRow.count(); i++) {
      const actualText = await transactionTableRow.nth(i).textContent();
      let expText = CommonUtilObject.readUsecaseTestData(fileName, "Followup TaskName")
      if (actualText.trim() == expText) {
        console.log("ActualText is " + actualText);
        console.log("ExpectedText is " + expText);
        expect(actualText?.trim()).toEqual(expText);
        transactionName = true;
        break
      }
    }
    console.log("Task Name validated in UI is " + CommonUtilObject.readUsecaseTestData(fileName, "Followup TaskName"))
    expect(transactionName).toEqual(true);
    
    let assignedTo = await action.getText(
      "Assigned To Column Data",
      pageScreen
    );
    console.log("assignedTo is " + assignedTo);
    CommonUtilObject.writeUsecaseTestData(fileName, "AssignedTo", assignedTo);
  }

  async validateSLAExpiry(fileName, pageScreen) {
    // add wait time for 50 min for the task to expire
    await page.waitForTimeout(50000);
    await action.ClickElement("My Task", pageScreen);
    await action.fillText(
      CommonUtilObject.readUsecaseTestData(fileName, "txNumber"),
      "Filter Transaction id",
      pageScreen
    );
    await page.waitForTimeout(2000);
    await page.keyboard.press("Enter");
    await action.waitforInvisibilityOfSpinner();
    await page.waitForTimeout(3000);
    // validate SLA
    let transactionTableRow = await action.getElement("Transaction id Column", pageScreen,)
    let transactionPresent;
    for (let i = 0; i < await transactionTableRow.count(); i++) {
      const actualText = await transactionTableRow.nth(i).textContent();
      let expText = "Expired"
      if (actualText.trim() == expText) {
        console.log("ActualText is " + actualText);
        console.log("ExpectedText is " + expText);
        expect(actualText?.trim()).toEqual(expText);
        transactionPresent = true;
        break
      }
    }
    expect(transactionPresent).toEqual(true);
    // await assertion.checktext("SLA Column Data", pageScreen, "Expired");
  }

  async getDefaultPreferenceandValidate(pageScreen) {
    let defGroup = await action.getElement('Preferences Group Name', pageScreen)
    let defGroupName = await defGroup.first().textContent();

    let defApp = await action.getElement('Preferences Applications', pageScreen)
    let defApplication = await defApp.first().textContent();

    let defRole = await action.getElement('Preferences Role', pageScreen)
    let defRoleName = await defRole.first().textContent();

    let expectedAppDetails = "groups " + defGroupName.trim() + "/" + defApplication + "/My Tasks"
    console.log("ExpectedAppDetails is " + expectedAppDetails)
    await login.logout('Logout', 'Page');
    await page.waitForTimeout(2000)
    let loginType = await CommonUtilObject.readUsecaseTestData("resources/TestData", "LoginType");
    if(loginType == 'OKTA'){
      await login.workflowUIOktalogin ('Finlevit_workflow', '1', 'AppManager');
    }else{
      await login.workflowUIlogin('Finlevit_workflow', '1', 'AppManager');
    }
    await page.waitForTimeout(5000)
    await page.waitForSelector(await ScreenMap.get("WorkFlow UI").getSelector(
      "Filter Transaction id")
    );
    let appDetails = await action.getText('My Task App Details', pageScreen)
    console.log("Actual AppDetails is" + appDetails);
    // validate Group name and app name against default Group and App Name
    await expect(appDetails.trim()).toEqual(expectedAppDetails);
    await action.ClickElement('Role Dropdown', pageScreen)
    let actRoleName = await action.getText('Roles selected', pageScreen)
    // validate Roles dropdown selected value against default role
    await expect(actRoleName).toEqual(defRoleName);
  }

  async ReorderPreferenceandValidate(pageScreen) {
    // get Last Updated On details and validate it has updated when do reorder
    let LastUpdatedOnElement = await action.getElement('Last Updated On', pageScreen)
    let LastUpdatedOn_first = await LastUpdatedOnElement.first().textContent();
    console.log("LastUpdatedOn before drag and drop" + LastUpdatedOn_first)
    let LastUpdatedOn_second = await LastUpdatedOnElement.nth(1).textContent();
    console.log("LastUpdatedOn before drag and drop" + LastUpdatedOn_second)
    let defGroup = await action.getElement('Preferences Group Name', pageScreen)

    // Drag and drop second group from the list to first
    let src = "(//div[text()='Group']/../../..//app-preference-row/..)[2]"
    let dest = "(//div[text()='Group']/../../..//app-preference-row/..)[1]"
    await page.waitForTimeout(2000)
    await page.dragAndDrop(src, dest)
    await page.waitForTimeout(3000)
    await assertion.ContainText('Success', pageScreen, 'Success')
    console.log("Reorder is done for the group")
    await page.waitForSelector(await ScreenMap.get(pageScreen).getSelector("Success"), { state: 'hidden' });
    await page.waitForTimeout(5000)
    let LastUpdatedOn_firstafter = await LastUpdatedOnElement.first().textContent();
    console.log("LastUpdatedOn after drag and drop" + LastUpdatedOn_firstafter)
    let LastUpdatedOn_secondafter = await LastUpdatedOnElement.nth(1).textContent();
    console.log("LastUpdatedOn after drag and drop" + LastUpdatedOn_secondafter)
    // await expect(LastUpdatedOn_first.trim()).not.toEqual(LastUpdatedOn_firstafter);
    // await expect(LastUpdatedOn_second.trim()).not.toEqual(LastUpdatedOn_secondafter);
    // await expect(LastUpdatedOn_firstafter.trim()).toEqual(LastUpdatedOn_secondafter);

    defGroup = await action.getElement('Preferences Group Name', pageScreen)
    let defGroupName = (await defGroup.first().textContent()).trim();
    // click on Edit button
    let editBtnElement = await ScreenMap.get(pageScreen).getSelector("Edit Button");
    let editBtn = page.locator(
      editBtnElement.replace("elementName", defGroupName)
    );
    await action.ClickElement(editBtn)

    //select application
    let appElement = await ScreenMap.get(pageScreen).getSelector("Application dropdown");
    let appdropdown = page.locator(
      appElement.replace("elementName", defGroupName)
    );
    await action.ClickElement(appdropdown)
    await page.keyboard.press("ArrowDown");
    await page.waitForTimeout(500);
    await page.keyboard.press("Tab");

    // click on set default button
    let setdefaultBtnElement = await ScreenMap.get(pageScreen).getSelector("Set Default Button");
    let setdefaultBtn = page.locator(
      setdefaultBtnElement.replace("elementName", defGroupName)
    );
    await action.ClickElement(setdefaultBtn)
    await assertion.ContainText('Success', pageScreen, 'Success')
    await this.getDefaultPreferenceandValidate(pageScreen)
  }

  async UpdatedefaultApporRoleandValidate(scenario, pageScreen) {
    let LastUpdatedOnElement = await action.getElement('Last Updated On', pageScreen)
    let LastUpdatedOn_first = await LastUpdatedOnElement.first().textContent();
    console.log("LastUpdatedOn before change Application" + LastUpdatedOn_first)
    // get group name from Testdata json file
    let groupName = CommonUtilObject.getTestData('GroupName')
    console.log("Group name is " + groupName)

    let defGroup = await action.getElement('Preferences Group Name', pageScreen)
    let defGroupName = await defGroup.first().textContent();
    if (defGroupName.trim() == groupName) {
      console.log("The given group " + groupName + " is already in first order");
    }
    else {
      // Drag and drop given group to first
      let src = "//div[normalize-space(text())='" + groupName + "']/../.."
      let dest = "(//div[text()='Group']/../../..//app-preference-row/..)[1]"
      await page.waitForTimeout(500);
      await page.dragAndDrop(src, dest)
      await page.waitForTimeout(3000)
      await assertion.ContainText('Success', pageScreen, 'Success')
      console.log("Reorder is done for the group" + groupName)
    }
    // click on Edit button
    let editBtnElement = await ScreenMap.get(pageScreen).getSelector("Edit Button");
    let editBtn = page.locator(
      editBtnElement.replace("elementName", groupName)
    );
    await action.ClickElement(editBtn)
    let appElement;
    //select application
    if (scenario == "Application") {
      appElement = await ScreenMap.get(pageScreen).getSelector("Application dropdown");
    }
    else if (scenario == "Role") {
      appElement = await ScreenMap.get(pageScreen).getSelector("Role dropdown");
    }
    let appdropdown = page.locator(
      appElement.replace("elementName", groupName)
    );
    await action.ClickElement(appdropdown)
    await page.keyboard.press("ArrowDown");
    await page.waitForTimeout(500);
    await page.keyboard.press("Tab");
    // click on set default button
    let setdefaultBtnElement = await ScreenMap.get(pageScreen).getSelector("Set Default Button");
    let setdefaultBtn = page.locator(
      setdefaultBtnElement.replace("elementName", groupName)
    );
    await action.ClickElement(setdefaultBtn)
    await page.waitForTimeout(2000)
    await assertion.ContainText('Success', pageScreen, 'Success')
    console.log(scenario + " updated successfully")
    await page.waitForSelector(await ScreenMap.get(pageScreen).getSelector("Success"), { state: 'hidden' });
    await page.waitForTimeout(3000)
    await action.waitforInvisibilityOfSpinner()
    await page.waitForTimeout(5000)
    let LastUpdatedOn_firstafter = await LastUpdatedOnElement.first().textContent();
    console.log("LastUpdatedOn after drag and drop" + LastUpdatedOn_firstafter)

    // await expect(LastUpdatedOn_first.trim()).not.toEqual(LastUpdatedOn_firstafter);
    await this.getDefaultPreferenceandValidate(pageScreen)
  }
}