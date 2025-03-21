import {
    After,
    Before,
    setDefaultTimeout,
    Status,
    BeforeAll,
    AfterAll,
} from "@cucumber/cucumber";
import { Browser, chromium, Page } from "playwright";
import { Core } from "../Utility/Source/Core";
import * as path from "path";
import { CommonUtilObject } from "../Utility/Util/CommonUtil";
import { formatSummary } from "@cucumber/cucumber/lib/formatter/helpers";
import * as fs from 'fs';
import { getConfigFileParsingDiagnostics } from "typescript";
import { webkit } from "playwright-webkit";
import { firefox } from "playwright-firefox";

const Env = process.env.Env
const engine = process.env.Browser
const infra: string = process.env.Infra

let page: Page;
let browser: Browser;
let context;
let browserType = process.env.Browser
setDefaultTimeout(400000);
if (infra == 'onPrem') process.env.Domain = 'konfig.io'
else if (infra == 'cloud') process.env.Domain = 'konfigai.us'
else console.log(infra + ' is incorrect')
BeforeAll(async () => {
    const directory1: string = process.cwd();
    const pathOfAllPageFolder = "pages";
    console.log(pathOfAllPageFolder);
    let core: Core = new Core();
    console.log("******* Load All Page ********");
    core.loadAllPageObjectScreen(pathOfAllPageFolder);
    console.log("********* Before method *********");
    console.log("Test Environment  is " + Env + ' - ' + infra)
    console.log('Domain is: ' + process.env.Domain);
    try {
        const envTestData = await JSON.parse(JSON.stringify(CommonUtilObject.readJSONFile('resources/TestData').replace(/ENV/g, Env.toLocaleLowerCase())));
        const infraUpdate = envTestData.replace(/DOMAIN/g, process.env.Domain);
        fs.writeFile('./resources/' + Env + 'TestData.json', infraUpdate, (err) => {
            if (err) {
                console.error(err);
            } else {
                console.log('Test Data File generated successfully! for ' + process.env.Domain + ' - ' + Env + ' environment');
            }
        });
    } catch (err) {
        throw err;
    }
});

Before(async () => {
    try {
        // Get the value of the "browser" environment variable
        const browserType = engine;
        const isHeadless = process.env.HEADLESS === 'true';
        console.log("Headless is "+isHeadless)

        // Launch the browser based on the value of the "browserType" variable
        if (browserType === 'moon-chromium') {
            const { chromium } = require('playwright');
            browser = await chromium.connect({
                timeout: 0, wsEndpoint: 'ws://10.10.5.159:4444/playwright/chromium/playwright-1.29.1?headless=false&enableVideo=true&videoName=mytestvideo.mp4',
                args: ['--start-maximized']
            });
            context = await browser.newContext({
                ignoreHTTPSErrors: true, // Ignore SSL certificate errors
                viewport: { width: 1920, height: 1080 }, // This option will ensure that the viewport uses the entire screen
            });
        }
        else if (browserType === 'chromium') {
            browser = await chromium.launch({
                headless: isHeadless,
                args: ['--start-maximized'],
            });
            context = await browser.newContext({
                ignoreHTTPSErrors: true, // Ignore SSL certificate errors
                viewport: null, // This option will ensure that the viewport uses the entire screen
            });
        } else if (browserType === 'firefox') {
            // @ts-ignore
            browser = await firefox.launch({
                headless: false,
                args: ['--start-maximized'],
            });
        } else if (browserType === 'webkit') {
            // @ts-ignore
            browser = await webkit.launch({
                headless: false,
                args: ['--start-maximized'],
            });
        } else {
            throw new Error(`Unsupported browser type: ${browserType}`);
        }
        page = await context.newPage();
        if(isHeadless){
            await page.setViewportSize({ width: 1920, height: 1080 });
        }
        console.log(`captured site title as ${await page.title()}`);
    } catch (error) {
        console.log(`browser navigation failed due to ${error}`);
        throw new Error(`browser navigation failed due to ${error}`);
    }
});

After(async function (Scenario) {
    if (Scenario.result!.status === Status.FAILED) {
        await this.attach(
            await page.screenshot({
                path: `./Screenshots/${Scenario.pickle.name}.png`,
                fullPage: true,
            }),
            "image/png"
        );
    }
    await browser.close();
});

AfterAll(async () => {
    console.log("********* AfterAll method *********");
});
export { page, browser, context };
