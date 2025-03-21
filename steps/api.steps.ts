import { When, Then, Given } from "@cucumber/cucumber";
import axios, { AxiosRequestConfig } from "axios";
import { CommonUtilObject } from "../Utility/Util/CommonUtil";
import https = require("https");
import fs = require("fs");
process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0";
const agent = new https.Agent({
  ca: fs.readFileSync("resources/tabner.pem"),
});
let response: any;
let admin = JSON.parse('{"userName":"admin" , "passWord":"admin"}');
Given(
  "{string} get the access token using {string} call",
  async (user, apiUrl) => {

    let admHeader = {
      "Content-Type": "application/json",
      Origin: CommonUtilObject.getTestData("Origin"),
    };
    let call: AxiosRequestConfig = {
      url: CommonUtilObject.getTestData(apiUrl),
      method: "post",
      httpsAgent: agent,
      headers: admHeader,
      data: admin,
    };
     response = await axios(call);
    let accToken = response.data["accessToken"];
    console.log(accToken);
    process.env.AccessToken = accToken;
  }
);

Given("User submits transaction for {string}", async (source) => {
  let header = {
    "Content-Type": "application/json",
    Authorization: `Bearer ${process.env.AccessToken}`,
    Origin: CommonUtilObject.getTestData("Origin")
  };
  const testJson = CommonUtilObject.readJSONFile(process.env.FileName);
  const temp = testJson.replace(/"/g, '\\"');
  const json_string1 = temp.replace(" ", "").replace(": ", ":");
  const json_string = `"${json_string1}"`;
  let ip = CommonUtilObject.getTestData(
    "ip-" + process.env.Infra +'-'+process.env.Env.toLocaleLowerCase()
  );
  let port = CommonUtilObject.getTestData(process.env.Infra+"-port");
  let topic = process.env.queueName;
  let txnPayload = testJson;
  console.log("Payload is" + txnPayload);
  let apiurl= CommonUtilObject.getTestData("Kafka")+ topic;
  console.log(apiurl)
  let call: AxiosRequestConfig = {
    url: apiurl,
    headers: header,
    httpsAgent: agent,
    data: txnPayload,
    method: "post",
  };
  response = await axios(call);
  if (response.status == 200) {
    console.log(response.status + " : " + response.statusText);
    console.log(
      "Transaction Submitted to " +
        ip +
        " on port:" +
        port +
        " and topic: " +
        topic
    );
  } else {
    console.log("Something went wrong");
  }
});
