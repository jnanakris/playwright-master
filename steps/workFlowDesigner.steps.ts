import { Given, When, Then, DataTable } from "@cucumber/cucumber";
import { page } from "./world";
import { UniqueWidgets } from "../Main/UniqueWidgets";
import { Actions } from "../Utility/Util/Actions";
import { CommonUtilObject } from "../Utility/Util/CommonUtil";
import { ScreenMap } from "../Utility/Source/Core";
import { NewTransformationUI } from "../Main/New TransformationUI";
import { Assertions } from "../Utility/Util/Assertions";
import { Payload } from "../Main/Payload";

let Uwidgets: UniqueWidgets = new UniqueWidgets();
let action: Actions = new Actions();
let transformation: NewTransformationUI = new NewTransformationUI();
let assertion: Assertions = new Assertions();
let payload: Payload = new Payload();

Then(
  "User will Drag and Drop below task on {string} in {string} screen",
  async (destElement, pageScreen, table: DataTable) => {
    try {
      console.log("User should drag and drop task on Workflow Designer");
      const formValues = table.hashes();
      for (let i = 0; i < formValues.length; i++) {
        console.log(formValues[i]);
        console.log(formValues[i].Widget);
        await page.waitForTimeout(500);
        await Uwidgets.WorkflowDesignerWidget(
          destElement,
          pageScreen,
          formValues[i]
        );
        if (formValues[i].Widget == "API Task") {
          await action.waitforInvisibilityOfSpinner();
          await action.enterText(
            formValues[i].TaskName,
            "TaskNameInput",
            pageScreen
          );
          await page.waitForTimeout(500)
          // Select Data Source
          await action.selectDropdownbytagName(
            "div",
            "Data Source",
            formValues[i].DataSource,
            pageScreen
          );
          await page.waitForTimeout(2000)
          await action.waitforInvisibilityOfSpinner();
          // Select Data List
          await action.selectDropdownbytagName(
            "span",
            "Data List",
            formValues[i].DataList,
            pageScreen
          );
          process.env.DataList = formValues[i].DataList
          // await action.ClickElement("SuccessResponse", pageScreen);
          // await page.waitForTimeout(500);
          // await action.selectDropdownbytagName(
          //   "span",
          //   "SuccessActionStatus",
          //   formValues[i].SuccesStatus,
          //   pageScreen
          // );
          // await page.waitForTimeout(500);
          // await action.ClickElement("FailedResponse", pageScreen);
          // await page.waitForTimeout(500);
          // await action.selectDropdownbytagName(
          //   "span",
          //   "FailedActionStatus",
          //   formValues[i].FailedStatus,
          //   pageScreen
          // );
          await page.waitForTimeout(500);
          await action.selectDropdownbytagName(
            "span",
            "FailureTaskRole",
            formValues[i].FailureTaskRole,
            pageScreen
          );
          if(formValues[i].Resources){
          await action.ClickElement("Resources_Response Mapping", pageScreen);
          let resources = page.locator("//div[normalize-space(text())='" + formValues[i].Resources + "']/../../..//li")
          await action.ClickElement(resources);
          }
          
            if(formValues[i].Transaction_Mode && formValues[i].Transaction_Mode=="Yes"){
              const checkbox=await action.getElement("Transactional Mode", "tasks")
              // Evaluate if the checkbox is already checked by inspecting the class
              const isChecked = await checkbox.evaluate((el) =>
              el.classList.contains('p-checkbox-checked')
            );
            // If the checkbox is not checked, click it
            if (!isChecked) {
              await action.ClickElement("Transactional Mode", "tasks");
              }
            }
            if(formValues[i].Process_all_transactions && formValues[i].Process_all_transactions=="Yes"){
              await action.ClickElement("Process all transactions", "tasks");
            }
            if(formValues[i].BatchTransactions && formValues[i].BatchTransactions=="Yes"){
              await action.ClickElement("APITask_BatchTransaction", "tasks");
              await action.fillText(formValues[i].ChunkSize,"Chunk_Size","tasks")
            }
            
          await action.ClickElement("Save", pageScreen);
          await page.waitForTimeout(500);
        }
        else if (formValues[i].Widget == "Response Mapping") {
          await action.enterText(
            formValues[i].TaskName,
            "TaskNameInput",
            pageScreen
          );
          await page.waitForTimeout(500);
          // Select Resources
          await action.ClickElement("Resources_Response Mapping", pageScreen);
          if ((formValues[i].ResourcesCount)) {
            let resourceCount=formValues[i].ResourcesCount
            await console.log("resourcesCpount "+resourceCount);
            for (let k = 1; k <= resourceCount; k++) {
              await console.log("formValues[i]"+formValues[i]["Resources"+k])
              let resources = page.locator("//div[normalize-space(text())='" + formValues[i]["Resources"+k] + "']/../../..//li")
              await action.ClickElement(resources);
            }
            
          } else {
            let resources = page.locator("//div[normalize-space(text())='" + formValues[i].Resources + "']/../../..//li")
            await action.ClickElement(resources);
          }
         
          // await action.ClickElement("Resources_Response Mapping", pageScreen);
          // await action.selectDropdownbyText(
          //   "Resources_Response Mapping",
          //   pageScreen, formValues[i].Resources
          // );
          process.env.RMResources = formValues[i].Resources;
          // await action.ClickElement("SuccessResponse", pageScreen);
          // await page.waitForTimeout(500);
          // await action.selectDropdownbytagName(
          //   "span",
          //   "SuccessActionStatus",
          //   formValues[i].SuccesStatus,
          //   pageScreen
          // );
          // await page.waitForTimeout(500);
          // await action.ClickElement("FailedResponse", pageScreen);
          // await page.waitForTimeout(500);
          // await action.selectDropdownbytagName(
          //   "span",
          //   "FailedActionStatus",
          //   formValues[i].FailedStatus,
          //   pageScreen
          // );
          if(formValues[0].Process_Type && formValues[0].Process_Type=="Distinct"){
            await action.ClickElement("ProcessType_Distinct", "tasks");
          }
          await page.waitForTimeout(500);
          let failureTaskRole = await ScreenMap.get(pageScreen).getElement('FailureTaskRole');
          await failureTaskRole.scrollIntoViewIfNeeded();
          await action.selectDropdownbytagName(
            "span",
            "FailureTaskRole",
            formValues[i].FailureTaskRole,
            pageScreen
          );
          await action.ClickElement("Save", pageScreen);
          await page.waitForTimeout(500);
        }
        else if (formValues[i].Widget == "Merge") {
          await page.waitForTimeout(500);
          if (process.env.Env == 'Demo') {
            await action.ClickElement('MergeEdit', pageScreen)
            await action.ClickElement('TaskEdit', pageScreen)
          } else {
            await action.fillText(
              formValues[i].TaskName,
              "TaskNameInput",
              pageScreen
            );
          }
          await page.waitForTimeout(500);
          // await action.selectDropdownbyText(
          //   "Status", pageScreen, formValues[i].Status
          // );
          await action.ClickElement("Save", pageScreen);
          await page.waitForTimeout(500);
          await payload.waitforInvisibilityOfSpinner();
          await page.waitForTimeout(500);
        } else if (formValues[i].Widget == "Email") {
          await action.enterText(
            formValues[i].TaskName,
            "TaskNameInput",
            pageScreen
          );
          await page.waitForTimeout(500);
          if(formValues[0].Attach_a_File && formValues[0].Attach_a_File=="Yes"){
            await action.ClickElement("Attach a file Checkbox", "tasks");
            await action.selectDropdownbytagName(
              "span",
              "Email Task SelectFile",
              CommonUtilObject.readUsecaseTestData(process.env.FileName, "FileNameinFileSetup"),
              pageScreen
            );
          }
          await action.selectDropdownbytagName(
            "span",
            "FailureTaskRole",
            formValues[i].FailureTaskRole,
            pageScreen
          );
          await page.waitForTimeout(500);
          await action.ClickElement("DesignTemplate", pageScreen);
          let emailTo;
          if (formValues[i].To.startsWith("#")) {
            emailTo = CommonUtilObject.readUsecaseTestData(process.env.FileName, formValues[i].To.replace("#", ""));
        } else {
            emailTo=formValues[i].To
        }
          await action.enterText(emailTo, "EmailTo", pageScreen);
          // await page.keyboard.press("ArrowDown");
          await page.keyboard.press("Tab");
          let Sub = CommonUtilObject.readUsecaseTestData(process.env.FileName, formValues[i].Sub);
          await action.enterText(Sub, "EmailSubject", pageScreen);
          await page.waitForTimeout(500);
          // await page.keyboard.press("ArrowDown");
          // await page.waitForTimeout(500);
          await page.keyboard.press("Tab");
          let Temp = CommonUtilObject.readUsecaseTestData(process.env.FileName, formValues[i].Template);
          await action.fillText(Temp, "Template", pageScreen);
          await page.waitForTimeout(500);
          // await page.keyboard.press("ArrowDown");
          await page.waitForTimeout(500);
          await page.keyboard.press("Tab");
          await page.waitForTimeout(2000);
          await action.ClickElement("EmailSave", pageScreen);
          await page.waitForTimeout(500);
          await action.ClickElement("Save", pageScreen);
          await page.waitForTimeout(2000);
        } else if (formValues[i].Widget == "Task") {
          await action.enterText(
            formValues[i].TaskName,
            "TaskNameInput",
            pageScreen
          );
          await action.selectDropdownbyText(
            "RoleDropDown",
            pageScreen,
            formValues[i].Role
          );
          if (formValues[i].SLAHours) {
            await action.ClickElement("SLADurationInput", pageScreen);
            await action.enterText(
              formValues[i].SLAHours,
              "SLAHoursInput",
              pageScreen
            );
            await action.ClickElement("SLAOkButton", pageScreen);
          }
          if (formValues[i].SLADays) {
            await action.ClickElement("SLADurationInput", pageScreen);
            await action.enterText(
              formValues[i].SLADays,
              "SLADaysInput",
              pageScreen
            );
            await action.ClickElement("SLAOkButton", pageScreen);
          }
          console.log(formValues[i].noOfActions);
          for (let j = 1; j <= formValues[i].noOfActions; j++) {
            if (j != 1) {
              await action.ClickElement("ActionsAddButton", pageScreen);
            }
            console.log(formValues[i]["Action" + j]);
            console.log(formValues[i]["Action" + j + "Status"]);
            let ActionNameInput = await action.getElement(
              "ActionNameInput",
              pageScreen
            );
            console.log(ActionNameInput.nth(j - 1));
            await action.enterText(
              formValues[i]["Action" + j],
              ActionNameInput.nth(j - 1)
            );
            // let ActionStatus = await action.getElement(
            //   "ActionStatus",
            //   pageScreen
            // );
            // console.log(ActionStatus.nth(j - 1));
            // await action.selectDropdownbytagName(
            //   "span",
            //   ActionStatus.nth(j - 1),
            //   formValues[i]["Action" + j + "Status"]
            // );
          }
          // add reason and comment
          if (formValues[i].NoofReason) {
            await action.ClickElement("ReasonRequired", pageScreen);
            await action.ClickElement("ReasonsButton", pageScreen);
            for (let j = 1; j <= formValues[i].NoofReason; j++) {
              await action.ClickElement("ReasonAddButton", pageScreen);
              let ReasonInputbox = await action.getElement(
                "ReasonInputbox",
                pageScreen
              );
              await action.enterText(
                formValues[i]["Reason" + j],
                ReasonInputbox.nth(j - 1)
              );
            }
            await action.ClickElement("ReasonSaveButton", pageScreen);
          }
          if (formValues[i].IsComment) {
            await action.ClickElement("CommentRequired", pageScreen);
          }
          if (formValues[i].AssignNextTask) {
            await action.ClickElement("AssignNextTaskToTaskOriginator", pageScreen);
            process.env['AssigntoOriginator'] = "yes"
          }
          await action.ClickElement("Save", pageScreen);
          await page.waitForTimeout(500);
        }
        else if (formValues[i].Widget == "SystemTask") {
          await action.enterText(
            formValues[i].TaskName,
            "TaskNameInput",
            pageScreen
          );
          await action.selectDropdownbyText(
            "RoleDropDown",
            pageScreen,
            formValues[i].Role
          );
          await action.selectDropdownbyText(
            "SourceDropDown",
            pageScreen,
            formValues[i].Source
          );
          console.log(formValues[i].noOfActions);
          await action.ClickElement("SuccessResponse", pageScreen);
          await page.waitForTimeout(500);
          await action.selectDropdownbytagName(
            "span",
            "SuccessActionStatus",
            formValues[i].SuccesStatus,
            pageScreen
          );
          await page.waitForTimeout(500);
          await action.ClickElement("SystemresponseFailure", pageScreen);
          await page.waitForTimeout(500);
          await action.selectDropdownbytagName(
            "span",
            "FailedActionStatus",
            formValues[i].FailedStatus,
            pageScreen
          );
          await page.waitForTimeout(500);
          await action.ClickElement("Save", pageScreen);
          await page.waitForTimeout(500);
        }
        else if (formValues[i].Widget == "QueueTask" || formValues[i].Widget == "FileTask") {
          await action.enterText(
            formValues[i].TaskName,
            "TaskNameInput",
            pageScreen
          );
          await page.waitForTimeout(2000);
          let fileName;
            if (formValues[i].FileName.startsWith("#"))
              fileName = CommonUtilObject.readUsecaseTestData(process.env.FileName, formValues[i].FileName.replace("#", ""))
            else
              fileName=formValues[i].FileName;
              if (formValues[i].Widget == "QueueTask") {
                await action.selectDropdownbyText(
                  "SelectQueue",
                  pageScreen,
                  fileName
                );    
          } else if (formValues[i].Widget == "FileTask") {
            await action.selectDropdownbyText(
              "SelectFile",
              pageScreen,
              fileName
            );
          }
          if(formValues[i].Resources){
          await action.ClickElement("Resources_Response Mapping", pageScreen);
          let resources = page.locator("//div[normalize-space(text())='" + formValues[i].Resources + "']/../../..//li")
          await action.ClickElement(resources);
          // await action.ClickElement(formValues[i].Mode, pageScreen);
          }
          // await action.ClickElement("SuccessResponse", pageScreen);
          // await page.waitForTimeout(500);
          // await action.selectDropdownbytagName(
          //   "span",
          //   "SuccessActionStatus",
          //   formValues[i].SuccesStatus,
          //   pageScreen
          // );
          // await page.waitForTimeout(500);
          // await action.ClickElement("QueueFailResponse", pageScreen);
          // await page.waitForTimeout(500);
          // await action.selectDropdownbytagName(
          //   "span",
          //   "FailedActionStatus",
          //   formValues[i].FailedStatus,
          //   pageScreen
          // );
          await page.waitForTimeout(500);
          await action.selectDropdownbytagName(
            "span",
            "FailureTaskRole",
            formValues[i].FailureTaskRole,
            pageScreen
          );
          if(formValues[0].TransactionType && formValues[0].TransactionType=="Both"){
            await action.ClickElement("Transaction Type_Both", "tasks");
          }
          await action.ClickElement("Save", pageScreen);
          await page.waitForTimeout(500);
        } else if (formValues[i].Widget == "Conditions Check") {
          await action.enterText(
            formValues[i].TaskName,
            "TaskNameInput",
            pageScreen
          );
          await page.waitForTimeout(2000);
          await action.selectDropdownbyspantext(
            "FailureTaskRole",
            pageScreen,
            formValues[i].FailureTaskRole
          );
          await page.waitForTimeout(500);
          await action.enterText(
            formValues[i].Email,
            "EmailInput",
            pageScreen
          );
          await page.waitForTimeout(2000);
          await action.ClickElement("AddCondition", pageScreen);
          await page.waitForTimeout(500);
        }
        else if (formValues[i].Widget == "End") {
          if (formValues[i].TaskName) {
            await action.ClickElement("EndEdit", pageScreen);
            await page.waitForTimeout(500);
            await action.ClickElement('TaskEdit', pageScreen)
            await page.waitForTimeout(2000);
            await action.fillText(
              formValues[i].TaskName,
              "EndTaskName",
              pageScreen
            );
            await page.waitForTimeout(500);
            await action.ClickElement("Save", pageScreen);
            await page.waitForTimeout(500);
            await payload.waitforInvisibilityOfSpinner();
            await page.waitForTimeout(500);
          }
        }
        else if (formValues[i].Widget == "Validate Task") {
          await action.enterText(
            formValues[i].TaskName,
            "TaskNameInput",
            pageScreen
          );
          await page.waitForTimeout(500);
          await action.selectDropdownbytagName(
            "span",
            "FailureTaskRole",
            formValues[i].FailureTaskRole,
            pageScreen
          );
          await action.ClickElement("Save", pageScreen);
          await page.waitForTimeout(500);
        }
      } if (formValues[0].Widget == "Conditions Check") {
        console.log("Add Condition page is opened");
      } else {
        await action.ClickElement("WorkflowSave", pageScreen);
      }

    } catch (err) {
      throw err;
    }
  }
);

Then("User will delete the task {string} in {string} page", async (elementName, pageScreen) => {

  console.log("User will delete the task " + elementName + " in " + pageScreen + " page")
  try {
    let reqElement = await page.locator(
      "//div[normalize-space(text())='" +
      elementName +
      "']/../..//span[@class='option-icon']//i"
    );
    await reqElement.click();
    await action.ClickElement("DeleteTask", pageScreen)
    await page.waitForTimeout(500);
    await action.ClickElement("DeleteSubmit", pageScreen);
    await page.waitForTimeout(500);
    await console.log(elementName + "Task has been deleted successfully")

  } catch (error) {
    throw error;
  }
})

Then("User will edit the {string} task in {string} page", async (elementName, pageScreen, table: DataTable) => {
  try {
    const formValues = table.hashes();
    console.log("User will edit the " + elementName + " task in " + pageScreen + " page")
    let reqElement = await page.locator(
      "//div[normalize-space(text())='" +
      elementName +
      "']/../..//span[@class='option-icon']//i"
    );
    await reqElement.click();
    await action.ClickElement("EditTask", pageScreen);
    for (let i = 0; i < formValues.length; i++) {
      await page.waitForTimeout(500);
      await action.fillText(
        formValues[i].TaskName,
        "TaskNameInput",
        pageScreen
      );
      console.log("Taskname chnaged")
      await page.waitForTimeout(500);
      await action.selectDropdownbyText(
        "RoleDropDown",
        pageScreen,
        formValues[i].Role
      );
      console.log("Role chnaged")
      let Action = await page.locator("//app-task-actions//div[@class='group-label']");
      let TotalAction = await Action.count();
      console.log("Action count is " + TotalAction)
      for (let j = 0; j <= TotalAction - 1; j++) {
        console.log("Action count is " + TotalAction)
        let ActionName = await Action.nth(j).textContent();
        console.log("Action name is" + ActionName);
        console.log("formValues[i].Action is " + formValues[i]["Action" + (j + 1)]);
        if (ActionName.trim() == formValues[i]["Action" + (j + 1)]) {
          let Name = await page.locator("//div[text()=' " + formValues[i]["Action" + (j + 1)] + " ']/../../../../..//div[text()=' Name']/../..//input");
          let actionClick = await page.locator("//app-task-actions//div[text()=' " + formValues[i]["Action" + (j + 1)] + " ']")
          await actionClick.click();
          await page.waitForTimeout(2000);
          await Name.fill(formValues[i]["ActionEdit" + (j + 1)]);
          await page.waitForTimeout(500);
          console.log("Edited Action Name" + ActionName)
        } else {
          break;
        }
      }
      console.log("Rename done")
      await action.ClickElement("Save", pageScreen);
      await page.waitForTimeout(500);
    }
  } catch (error) {
    throw error;
  }
})

Then("User will delete the action {string} in {string} task in {string} screen", async (ActionName, Task, pageScreen) => {

  try {

    console.log("Then User will delete the action " + ActionName + " in " + Task + " task in " + pageScreen + " screen");
    let reqElement = await page.locator(
      "//div[normalize-space(text())='" +
      Task +
      "']/../..//span[@class='option-icon']//i"
    );
    console.log("click task")
    await reqElement.click();
    console.log("Edit task")
    await page.waitForTimeout(4000);
    await action.ClickElement("EditTask", pageScreen);
    console.log("Edit task")
    await page.waitForTimeout(4000);
    let DeleteAction = await ScreenMap.get(pageScreen).getSelector("ActionDelete");
    let Action = page.locator(await DeleteAction.replace("elementName", ActionName));
    await page.waitForTimeout(500);
    await Action.click();
    console.log("Selected Action is deleted");
    await action.ClickElement("Save", pageScreen);
    await page.waitForTimeout(500);
  } catch (error) {
    throw error;
  }
})

Then("User will Edit the task {string} and add Followup Task in {string} page", async (elementName, pageScreen, table: DataTable) => {

  console.log("User will edit the task " + elementName + " and add Followup Task in " + pageScreen + " page")
  try {
    let reqElement = await page.locator(
      "//div[normalize-space(text())='" +
      elementName +
      "']/../..//span[@class='option-icon']//i"
    );
    await reqElement.click();
    await action.ClickElement("TaskEdit", pageScreen)
    await page.waitForTimeout(500);
    const formValues = table.hashes();
    console.log(formValues.length);
    for (let i = 0; i < formValues.length; i++) {
      console.log(formValues[i]);
      await action.ClickElement("FollowupAddButton", pageScreen);
      await page.waitForTimeout(500);
      await action.enterText(
        formValues[i].TaskName,
        "FollowupTaskNameInput",
        pageScreen
      );
      await CommonUtilObject.writeUsecaseTestData(
        process.env.FileName,
        "Followup TaskName",
        formValues[i].TaskName
      );
      await action.selectDropdownbytagName("span",
        "FollowupRoleDropDown",
        formValues[i].Role,
        pageScreen
      );
      await action.fillText(
        formValues[i].WaitTime,
        "FollowupWaitTime",
        pageScreen
      );
      await action.enterText(
        formValues[i].Frequency,
        "FollowupFrequency",
        pageScreen
      );
      await action.enterText(
        formValues[i].WhentoStart,
        "FollowupWhentoStart",
        pageScreen
      );
      if (formValues[i].SLAHours) {
        await action.ClickElement("FollowupSLADurationInput", pageScreen);
        await action.enterText(
          formValues[i].SLAHours,
          "SLAHoursInput",
          pageScreen
        );
        await action.ClickElement("SLAOkButton", pageScreen);
      }
      if (formValues[i].SLADays) {
        await action.ClickElement("FollowupSLADurationInput", pageScreen);
        await action.enterText(
          formValues[i].SLADays,
          "SLADaysInput",
          pageScreen
        );
        await action.ClickElement("SLAOkButton", pageScreen);
      }
      await action.ClickElement("Save", pageScreen);
      await page.waitForTimeout(500);
    }
  } catch (error) {
    throw error;
  }
})

When(
  "User Edit {string} {string} field to Configure Service in {string} screen",
  async (taskName,elementName, pageScreen) => {
    try {
      console.log(
        "User Edit" +
        elementName +
        " field to Configure API in " +
        pageScreen +
        " screen"
      );
      let reqElement = await page.locator(
        "//div[normalize-space(text())='" +
        elementName +
        "']/../..//span[@class='option-icon']//i"
      );
      // Edit API Task
      await reqElement.click();
      await action.ClickElement("EditWidget", "UniqueWidgetFields");
      await page.waitForTimeout(2000);
      if(taskName=='File task' || taskName=='Queue task'){
        let filePath=(await ScreenMap.get('tasks').getSelector("SelectedFile")).replace('fileName',CommonUtilObject.readUsecaseTestData(process.env.FileName, "FileNameinFileSetup"))
        console.log(filePath)
        await page.waitForSelector(filePath,{timeout:60000})
      }
      await action.waitforInvisibilityOfSpinner();
      await action.ClickElement("ConfigureService", "tasks");
      await page.waitForTimeout(500);
      let addRule=await ScreenMap.get('transformation').getSelector("addRuleButton")
      let isenabled=await page.isEnabled(addRule).then(async(exists)=>{
        return exists;
      })
      if (isenabled==true){
        console.log("Add rule button displayed")
      }
      else{
        await action.ClickElement("ConfigureService", "tasks");
      }
    } catch (err) {
      throw err;
    }
  }
);

