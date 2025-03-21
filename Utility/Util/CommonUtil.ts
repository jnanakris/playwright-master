import { createWriteStream, readFileSync, writeFileSync } from "fs";
import * as XLSX from "xlsx";

export class CommonUtilObject {

  static getTestData(key) {
    let rawdata = readFileSync(
      "resources/" + process.env.Env + "TestData.json"
    );
    let jsondata = JSON.parse(rawdata.toString());
    let value = JSON.stringify(jsondata[key]).split('"').join("");
    return value;
  }

  static WriteTestData(expKey, expValue) {
    let content = JSON.parse(
      readFileSync("resources/" + process.env.Env + "TestData.json", "utf8")
    );
    content[expKey] = expValue;
    writeFileSync(
      "resources/" + process.env.Env + "TestData.json",
      JSON.stringify(content, null, 2)
    );
  }

  static WriteExpectedValue(expKey, expValue) {
    let content = JSON.parse(
      readFileSync("resources/ExpectedData.json", "utf8")
    );
    content[expKey] = expValue;
    writeFileSync(
      "resources/ExpectedData.json",
      JSON.stringify(content, null, 2)
    );
  }

  static getExpectedValue(key) {
    let rawdata = readFileSync("resources/ExpectedData.json");
    let jsondata = JSON.parse(rawdata.toString());
    let value = JSON.stringify(jsondata[key]).split('"').join("");
    return value;
  }

  static writeUsecaseTestData(fileName, key, value) {
    let content = JSON.parse(
      readFileSync(fileName + ".json", "utf8")
    );
    content[key] = value;
    writeFileSync(
      fileName + ".json",
      JSON.stringify(content, null, 2)
    );
  }

  static readUsecaseTestData(fileName, key) {
    let rawdata = readFileSync(fileName + ".json", "utf8")
    let jsondata = JSON.parse(rawdata.toString());
    let value: string;
    if (key in jsondata) {
      value = JSON.stringify(jsondata[key]).split('"').join("");
    } else {
      console.log(`Key "${key}" is not present in the JSON file.`);
    }
    return value;
  }

  static readTestDataFromNestedObject(fileName, key, parentObj) {
 
    let Value;
    let jsonData = JSON.parse(readFileSync(fileName + ".json", "utf8"));
    Value = jsonData[parentObj][key];
    return Value;
  }

  static readJSONFile(fileName) {
    let rawdata = readFileSync(fileName + ".json", "utf8")
    let jsondata = JSON.parse(rawdata.toString());
    let value = JSON.stringify(jsondata,null,2);
    return value;
  }

  static readJSONData(fileName, key) {
    let rawdata = readFileSync(fileName + ".json", "utf8")
    let jsondata = JSON.parse(rawdata.toString());
    let value = JSON.stringify(jsondata[key],null,2);
    return value;
  }

  static xlstoJSON(useCase: string) {
    // Get specific worksheet by name or index
    const workBook = XLSX.readFile("TestData/TestData.xlsx");
    // Alternatively, you can get the sheet by index like this:
    const sheet = workBook.Sheets[useCase];
    const jData = XLSX.utils.sheet_to_json(sheet);
    const jsonData = JSON.stringify(jData);
    const parsedData = JSON.parse(jsonData);
    CommonUtilObject.writeUsecaseTestData(useCase, "data", parsedData);
    return jsonData;
  }

  static writeTestDatatoNestedObject(fileName, key, value,parentObj) {
    let content = JSON.parse(
      readFileSync(fileName + ".json", "utf8")
    );
    console.log( fileName, key, value,parentObj)
    console.log(content[parentObj][key] )
    console.log( "value is " +value)
    content[parentObj][key] = value;
    console.log(content[parentObj][key]);
    writeFileSync(
      fileName + ".json",
      JSON.stringify(content, null, 2)
    );
  }

}
