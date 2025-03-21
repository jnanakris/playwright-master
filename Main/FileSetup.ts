import { ScreenMap } from "../Utility/Source/Core";
import { CommonUtilObject } from "../Utility/Util/CommonUtil";
import { browser, context, page } from "../steps/world";
import { Actions } from "../Utility/Util/Actions";
import * as moment from "moment";
import { NewTransformationUI } from "./New TransformationUI";

let action: Actions = new Actions();
let transformationUI: NewTransformationUI = new NewTransformationUI();

export class FileSetup {
  async selectFilesetupDropdown(Key, elementName, pageScreen) {
    let identifierValue: any = [];
    identifierValue = CommonUtilObject.readUsecaseTestData(
      process.env.FileName,
      Key
    );
    if (identifierValue) {
      let identifier: any = [];
      identifierValue = identifierValue.replace("[", "");
      identifierValue = identifierValue.replace("]", "");
      identifierValue = identifierValue.replace("", "");
      identifier = identifierValue.split(",");
      console.log("Number of applicationIdentifier: " + identifier.length);
      let Dropdown = await ScreenMap.get(pageScreen).getElement(elementName);
      await Dropdown.scrollIntoViewIfNeeded();
      await action.ClickElement(elementName, pageScreen)
      for (let i = 0; i < identifier.length; i++) {
        if (identifier[i]) {
          let optionelement = page.locator(
            '//p-multiselectitem//li//div[text()="' + identifier[i] + '"]'
          );
          await optionelement.click();
          console.log(identifier[i] + "selected from Dropdown");
        }
      }
      await action.ClickElement(elementName, pageScreen)
    }
  }

  async addJSONFileSetup(fileType, fileSetup, pageScreen) {
    await action.ClickElement("addFile", pageScreen);
    await page.waitForTimeout(2000);
    console.log("User clicks on Add File button");
    await action.waitforInvisibilityOfSpinner()
    console.log(fileSetup.SourceName)
    if (fileSetup.SourceName == 'New') {
      let fileNamePrefix = CommonUtilObject.readUsecaseTestData(
        process.env.FileName,
        "FileNameinFileSetupPrefix"
      );
      const today = moment();
      let dateTime = today.format("YYYYMMDDhhmmss");

      let fileName = fileNamePrefix + dateTime;
      CommonUtilObject.writeUsecaseTestData(process.env.FileName,
        'FileNameinFileSetup', fileName
      );
    }
    let newExpText = CommonUtilObject.readUsecaseTestData(
      process.env.FileName,
      "FileNameinFileSetup"
    );

    //Enter file name
    await action.enterText(newExpText, "fileName", pageScreen);
    console.log("User entered File Name as: " + newExpText);
    // File type

    CommonUtilObject.writeUsecaseTestData(
      process.env.FileName,
      "FileType",
      fileType
    );
    CommonUtilObject.writeUsecaseTestData(
      process.env.FileName,
      "QueueName",
      process.env.queueName
    );
    await action.selectDropdownbytagName('Span',
        "fileType",
        fileType,
        pageScreen
      );
    if (fileSetup.FileSeparator)
      await action.fillText(fileSetup.FileSeparator, "fileSeparator", pageScreen);
    if (fileSetup.Destination == "Queue") {
      await action.ClickElement('queueDestination', pageScreen)
      await action.selectDropdownbytagName('Span',
        "queueName",
        process.env.queueName,
        pageScreen
      );
    }
    else if (fileSetup.Destination == "File Folder") {
      await action.ClickElement('fileFolderDestination', pageScreen)
      await action.enterText(fileSetup.ProcessedFolder, "processedFolderInput", pageScreen);
    }
    else if (fileSetup.Destination == "S3") {
      await action.ClickElement('s3Destination', pageScreen)
      let processedFolder;
      if (fileSetup.ProcessedFolder.startsWith("#"))
        processedFolder = CommonUtilObject.readUsecaseTestData(process.env.FileName, fileSetup.ProcessedFolder.replace("#", ""))
      else
        processedFolder=fileSetup.ProcessedFolder;
      await action.selectDropdownbytagName('Span',
        "processedFolderDropdown",
        processedFolder,
        pageScreen
      );
    }
    //uploadFile
    const handle = await page.locator("//input[@type='file']");
    await handle.setInputFiles("ExistApp/" + fileSetup.FileUpload);
    await action.ClickElement('next', pageScreen)
    await page.waitForTimeout(500);
    let payloadKey = CommonUtilObject.readUsecaseTestData(
      process.env.FileName,
      "PayloadKey"
    );
  }

  async addFileSetupSchema(dataTable, pageScreen) {
    const formValues = dataTable.hashes();
    for (let i = 0; i < formValues.length; i++) {
      console.log("formValues[i].Split "+formValues[i].Split)
      if (formValues[i].Split && formValues[i].Split=="Yes") {
        let split = await page.locator(
          "//div[normalize-space(text())='" +
          formValues[i].FieldName + "']/..//p-checkbox"
        ).nth(0);
        await action.ClickElement(split)
      }
      let dataType;
      if(formValues[i].Index && formValues[i].Index.length !== 0) {
        dataType = await page.locator(
          "//div[normalize-space(text())='" +
          formValues[i].FieldName + "']/..//div[contains(@class,'data-type')]//span[contains(@class,'p-dropdown-label')]"
  
        ).nth(Number(formValues[i].Index));
      }
      else{
      dataType = await page.locator(
        "//div[normalize-space(text())='" +
        formValues[i].FieldName + "']/..//div[contains(@class,'data-type')]//span[contains(@class,'p-dropdown-label')]"

      ).nth(0);
      }
      await dataType.scrollIntoViewIfNeeded();
      await page.waitForTimeout(500);
      
      await dataType.click()
      await page.waitForTimeout(500)
      let exist = await page.isVisible("//li[@role='option']").then(async (eleexist) => {
        return eleexist;
      })
      if(!exist){
        await dataType.click()
      await page.waitForTimeout(500)
      }
      await page.locator('//li//span[normalize-space(text())="' + formValues[i].DataType + '"]').click();
    //  select widget type
    

      if (formValues[i].WidgetType) {
        let widgetType;
    if(formValues[i].Index && formValues[i].Index.length !== 0) {
      widgetType =  await page.locator(
        "//div[normalize-space(text())='" +
        formValues[i].FieldName + "']/..//div[contains(@class,'widget-type')]//span[contains(@class,'p-dropdown-label')]"

      ).nth(Number(formValues[i].Index));
    }
    else{
      widgetType =  await page.locator(
      "//div[normalize-space(text())='" +
      formValues[i].FieldName + "']/..//div[contains(@class,'widget-type')]//span[contains(@class,'p-dropdown-label')]"

    ).nth(0);
    }
        await action.selectDropdownbytagName('span',
          widgetType,
          formValues[i].WidgetType
        );
      }
      if (formValues[i].IsRequired) {
        if (formValues[i].IsRequired.length !== 0) {
        let isRequired = await page.locator(
          "//div[normalize-space(text())='" +
          formValues[i].FieldName + "']/..//div[contains(@class,'checkbox ')]//div[@class='p-checkbox-box']"

        ).nth(0);
        await isRequired.click();
        }
      }
      if (formValues[i].MaxLength) {
        if (formValues[i].MaxLength.length !== 0) {
        let maxLength = page.locator(
          "//div[normalize-space(text())='" +
          formValues[i].FieldName + "']/..//div[contains(@class,'max-length')]//input"

        ).nth(0);
        await action.enterText(
          formValues[i].MaxLength,
          maxLength
        );
      }}
      console.log("User selects " + formValues[i].FieldName + " as " + formValues[i].WidgetType + " widget in " + pageScreen);

    }

  }

  async addDatalistAppsourceSetup(fileType, dataTable, requestParameters, pageScreen) {
    await action.ClickElement("addSource", pageScreen);
    await page.waitForTimeout(2000);
    console.log("User clicks on Add Source button");
    await action.ClickElement("dataListSourceType", pageScreen);
    if (dataTable.SourceName == 'New') {
      let fileNamePrefix = CommonUtilObject.readUsecaseTestData(
        process.env.FileName,
        "FileNamePrefix"
      );
      const today = moment();
      let dateTime = today.format("YYYYMMDDhhmmss");

      let fileName = fileNamePrefix + dateTime;
      CommonUtilObject.writeUsecaseTestData(process.env.FileName,
        'FileName', fileName
      );
    }
    let newExpText = CommonUtilObject.readUsecaseTestData(
      process.env.FileName,
      "FileName"
    );

    //Enter file name
    await action.enterText(newExpText, "sourceName", pageScreen);
    console.log("User entered File Name as: " + newExpText);
    await page.waitForTimeout(500);
    if(dataTable.AppMode=='Transactional'){
      await action.ClickElement("transactionalMode", pageScreen);
    }
    else if(dataTable.AppMode=='Batch'){
      await action.ClickElement("batchMode", pageScreen);
    }
    if(dataTable.BatchCategory)
      await action.ClickElement(dataTable.BatchCategory,pageScreen);
    let grpName = CommonUtilObject.getTestData(dataTable.GroupName);
    await action.selectDropdownbytagName('div',
      "group",
      grpName,
      pageScreen
    );
    await action.selectDropdownbytagName('Span',
      "dataResource",
      dataTable.DataResource,
      pageScreen
    );
    await page.waitForTimeout(500);
    if((dataTable.DataList).startsWith("#")){
      let datalistName = await CommonUtilObject.readUsecaseTestData(process.env.FileName,dataTable.DataList.replace("#", ""))
      await action.selectDropdownbytagName('Span',
      "dataList",
      datalistName,
      pageScreen
    );
      }else{
        await action.selectDropdownbytagName('Span',
        "dataList",
        dataTable.DataList,
        pageScreen
      );
      }
    if (dataTable.SourceType == "Primary") {

      await action.ClickElement(
        "primarySourceType",
        pageScreen
      );

    }
    else if (dataTable.SourceType == "Secondary") {
      await action.ClickElement(
        "secondarySourceType",
        pageScreen
      );
    }
    console.log(dataTable.SourceType + "Option selected")
    // Remove all the default parameters
    if (requestParameters) {
      let allOptions = await page.locator("//i[contains(@class,'left pi pi-trash')]");
      let optionsCount = await allOptions.count();
      for (let k = 0; k < optionsCount; k++) {
        await allOptions.nth(0).click();
        await page.waitForTimeout(500)
      }
      for (let j = 0; j < requestParameters.length; j++) {
        await action.ClickElement("requestParametersAddicon", pageScreen);
        let nameInput = await action.getElement('requestParametersName', pageScreen)
        let dataTypeDropdown = await action.getElement('requestParameterDatatype', pageScreen)
        let valueInput = await action.getElement('requestParametersValue', pageScreen)
        let optionDropdown = await action.getElement('requestParametersOption', pageScreen)
        await action.ClickElement(nameInput.nth(j))
        let namedropdown = "//i[@class='submenu-icon pi pi-angle-right']";
    let exist = await page.isVisible(namedropdown).then(async (eleexist) => {
      return eleexist;
    })
    if (exist == true) {
      let object = page.locator("//li//div[normalize-space(text())='Object']")
      await action.mouseHoverElement(object)
      let dataList = CommonUtilObject.readUsecaseTestData(
        process.env.FileName,
        'DataList'
      );
      let datalist = page.locator("//li//div[normalize-space(text())='" + dataList + "']")
      await action.mouseHoverElement(datalist)
      await transformationUI.SelectOptionsfromDropdown(requestParameters[j].Name,dataList,pageScreen)
      
    } 
    else{
      await nameInput.nth(j).click({ force: true })
      await page.waitForTimeout(500);
        await action.selectDropdownbytagName('div', nameInput.nth(j), requestParameters[j].Name)
    }
        await action.selectDropdownbytagName('span', dataTypeDropdown.nth(j), requestParameters[j].DataType)
        await action.selectDropdownbytagName('span', optionDropdown.nth(j), requestParameters[j].Option)
        if (requestParameters[j].Value.length !== 0)
          await action.enterText(requestParameters[j].Value, valueInput.nth(j))
        if (requestParameters[j].Format.length !== 0){
        let formatDropdown = await action.getElement('requestParametersFormat', pageScreen)
        await action.selectDropdownbytagName('span', formatDropdown, requestParameters[j].Format)
        }
      }
      console.log("Request Parameters are added successfully");
    }
    await action.ClickElement("next", pageScreen)
    await page.waitForTimeout(500);
    await this.selectFilesetupDropdown('ApplicationIdentifier', 'applicationIdentifiers', pageScreen)
    await page.waitForTimeout(2000)
    await this.selectFilesetupDropdown('TransactionIdentifier', 'transactionIdentifiers', pageScreen)
  }

  async addFileAppsourceSetup(fileType, dataTable, pageScreen) {
    await action.ClickElement("addSource", pageScreen);
    await page.waitForTimeout(2000);
    console.log("User clicks on Add Source button");
    await action.ClickElement("fileSourceType", pageScreen);
    if (dataTable.SourceName == 'New') {
      let fileNamePrefix = CommonUtilObject.readUsecaseTestData(
        process.env.FileName,
        "FileNamePrefix"
      );
      const today = moment();
      let dateTime = today.format("YYYYMMDDhhmmss");

      let fileName = fileNamePrefix + dateTime;
      CommonUtilObject.writeUsecaseTestData(process.env.FileName,
        'FileName', fileName
      );
    }
    let newExpText = CommonUtilObject.readUsecaseTestData(
      process.env.FileName,
      "FileName"
    );
    
    //Enter file name
    await action.enterText(newExpText, "sourceName", pageScreen);
    console.log("User entered File Name as: " + newExpText);
    if(dataTable.AppMode=='Transactional'){
      await action.ClickElement("transactionalMode", pageScreen);
    }
    else if(dataTable.AppMode=='Batch'){
      await action.ClickElement("batchMode", pageScreen);
    }
    if(dataTable.BatchCategory)
      await action.ClickElement(dataTable.BatchCategory,pageScreen);
    await action.selectDropdownbytagName('span',
        "fileType",
        dataTable.FileType,
        pageScreen
      );
    if (dataTable.FileType == "JSON" || dataTable.FileType == "XSD"||dataTable.FileType == "XML") {
      CommonUtilObject.writeUsecaseTestData(
        process.env.FileName,
        "FileType",
        dataTable.FileType
      );
      CommonUtilObject.writeUsecaseTestData(
        process.env.FileName,
        "QueueName",
        process.env.queueName
      );
      CommonUtilObject.writeUsecaseTestData(
        process.env.FileName,
        "SourceType",
        fileType
      );
      if (dataTable.SourceType == "Primary") {

        await action.ClickElement(
          "primarySourceType",
          pageScreen
        );
      }
      else if (dataTable.SourceType == "Secondary") {
        await action.ClickElement(
          "secondarySourceType",
          pageScreen
        );
      }
      console.log(dataTable.SourceType + " Option selected")
      if (dataTable.QueueIdentifier == "1Q1F") {
        await action.ClickElement(
          "1Q1F",
          pageScreen
        );
      }
      else if (dataTable.QueueIdentifier == "1QMF") {
        await action.ClickElement(
          "1QMF",
          pageScreen
        );
      }
      console.log(dataTable.QueueIdentifier + " Option selected")
      await action.selectDropdownbytagName('Span',
        "queueName",
        process.env.queueName,
        pageScreen
      );
      //uploadFile
      const handle = await page.locator("//input[@type='file']");
      await handle.setInputFiles("ExistApp/" + dataTable.FileUpload);
      await action.ClickElement('next', pageScreen)
      await page.waitForTimeout(500);
      let payloadKey = CommonUtilObject.readUsecaseTestData(
        process.env.FileName,
        "PayloadKey"
      );
      if (payloadKey) {
        let payloadDropdown = await ScreenMap.get(pageScreen).getElement('payloadKey');
        await payloadDropdown.scrollIntoViewIfNeeded();
        await action.selectDropdownbytagName(
          'span',
          'payloadKey',
          payloadKey,
          pageScreen
        );
      }
      await page.waitForTimeout(2000)
      await this.selectFilesetupDropdown('ApplicationIdentifier', 'applicationIdentifiers', pageScreen)
      await page.waitForTimeout(2000)
      await this.selectFilesetupDropdown('TransactionIdentifier', 'transactionIdentifiers', pageScreen)
    }
    else if(dataTable.FileType == "Flat File"){
      CommonUtilObject.writeUsecaseTestData(
        process.env.FileName,
        "FileType",
        dataTable.FileType
      );
      await action.fillText(dataTable.FileSeparator, "fileSeparator", pageScreen);
      if(dataTable.FolderType=='S3'){
      await action.ClickElement("s3FolderType", pageScreen);
      let sourceFolder = CommonUtilObject.readUsecaseTestData(process.env.FileName,dataTable.SourceFolder.replace("#", ""));
      let processFolder = CommonUtilObject.readUsecaseTestData(process.env.FileName,dataTable.ProcessedFolder.replace("#", ""));
      await action.selectDropdownbytagName('span',
        "sourceFolderDropdown",
        sourceFolder,
        pageScreen
      );
      await page.waitForTimeout(500)
      await action.selectDropdownbytagName('span',
        "processedFolderDropdown",
        processFolder,
        pageScreen
      );
      }
      else if(dataTable.FolderType=='File Folder'){
        await action.ClickElement("fileFolder", pageScreen);
        await action.enterText(dataTable.SourceFolder, "sourceFolderInput", pageScreen);
        await action.enterText(dataTable.ProcessedFolder, "processedFolderInput", pageScreen);
        }
        //uploadFile
      const handle = await page.locator("//input[@type='file']");
      await handle.setInputFiles("ExistApp/" + dataTable.FileUpload);
      await action.ClickElement('next', pageScreen)
      await page.waitForTimeout(500);

    }
  }
}
