import { ScreenMap } from "../Source/Core";
import { CommonUtilObject } from "./CommonUtil";
import { browser, context, page } from "../../steps/world";

export class Actions {
  async fillText(text, elementName, pageScreen?) {
    let txtElement: any
    try {
      if (pageScreen !== undefined) {
        txtElement = await ScreenMap.get(pageScreen).getElement(elementName);
      } else {
        txtElement = elementName;
      }
      await txtElement.fill(" ");
      await txtElement.fill(text);
    } catch (err) {
      throw err;
    }
  }

  async enterText(text, elementName, pageScreen?) {
    let txtElement: any
    try {
      if (pageScreen !== undefined) {
        txtElement = await ScreenMap.get(pageScreen).getElement(elementName);
      } else {
        txtElement = elementName;
      }
      await txtElement.type(text);
    } catch (err) {
      throw err;
    }
  }

  async selectDropdownbyText(elementName, pageScreen, option) {
    try {
      let txtElement: any = await ScreenMap.get(pageScreen).getElement(
        elementName
      );
      await txtElement.click();
      if (option) {
        let optionelement = page.locator('//*[contains(text(),"' + option + '")]');
        await optionelement.click();
      }
    } catch (err) {
      throw err;
    }
  }
  

  async dragAndDropWidgets(
    sourceLocator: string, 
    destLocator: string, 
    XCord: number, 
    YCord: number, 
    pageScreen: string
  ): Promise<void> {
    try {
      // Log to indicate the start of drag and drop operation
      console.log('------------Drag and Drop Starts---------------------------');
  
      // Log the parameters in a table-like format
      console.table({
        'Source Locator': sourceLocator,
        'Destination Locator': destLocator,
        'Target X Coordinate': XCord,
        'Target Y Coordinate': YCord,
        'Page Screen': pageScreen
      });
  
      // Retrieve the elements based on the locators
      let srcElement: any = await ScreenMap.get(pageScreen).getSelector(sourceLocator);
      let desElement: any = await ScreenMap.get(pageScreen).getSelector(destLocator);
      const status = await page.evaluate(
        async ({ draggableSelector, droppableSelector, targetX, targetY }: { 
          draggableSelector: string; 
          droppableSelector: string; 
          targetX: number; 
          targetY: number;
        }) => {
          async function simulateDragAndDrop(
            draggableSelector: string, 
            droppableSelector: string, 
            targetX: number, 
            targetY: number
          ): Promise<string> {
            const draggable = document.evaluate(
              draggableSelector,
              document,
              null,
              XPathResult.FIRST_ORDERED_NODE_TYPE,
              null
            ).singleNodeValue as HTMLElement;
  
            const droppable = document.evaluate(
              droppableSelector,
              document,
              null,
              XPathResult.FIRST_ORDERED_NODE_TYPE,
              null
            ).singleNodeValue as HTMLElement;
            const draggableRect = draggable.getBoundingClientRect();
            const startX = draggableRect.x + draggableRect.width / 2;
            const startY = draggableRect.y + draggableRect.height / 2;
  
            let moveX = 0;
            let moveY = 0;
  
            if (!draggable || !droppable) {
              console.error("Error: Draggable or droppable element not found.");
              return "failure";
            }
            // Function to fire mouse events
            function fireMouseEvent(type: string, target: HTMLElement, x: number, y: number): void {
              const event = new MouseEvent(type, {
                buttons: 1,
                bubbles: true,
                cancelable: true,
                composed: true,
                view: window,
                detail: 1,
                clientX: x,
                clientY: y,
              });
              target.dispatchEvent(event);
            }
  
            // Simulate Drag Start
            fireMouseEvent("mousedown", draggable, draggableRect.x, draggableRect.y);
            const steps = 5;
            for (let i = 0; i <= steps; i++) {
              moveX = startX + ((targetX - startX) * i) / steps; // Move to targetX
              moveY = startY + ((targetY - startY) * i) / steps; // Move to targetY
              fireMouseEvent("mousemove", draggable, moveX, moveY);
              await new Promise(resolve => setTimeout(resolve, 80)); // Delay for each move step
            }
            fireMouseEvent("mouseup", draggable, moveX, moveY);
            return "success";
          }
  
          return simulateDragAndDrop(draggableSelector, droppableSelector, targetX, targetY);
        },
        {
          draggableSelector: srcElement,  // Pass the retrieved srcElement
          droppableSelector: desElement,  // Pass the retrieved desElement
          targetX: XCord,  // Use the provided X coordinate for drop
          targetY: YCord   // Use the provided Y coordinate for drop
        }
      );
      // Log the result status
      console.log(`Drag and drop operation completed with status: ${status}`);
    } catch (err) {
      console.error('Error during drag and drop operation:', err);
      throw err;
    }
  }
  
  async dragAndDropFOWidgetsinBO(widgetName: string, destElement: string): Promise<void> {
    try {
      // Log to indicate the start of drag and drop operation
      console.log('------------Drag and Drop Starts---------------------------');
    
      // Get the widget element and destination element
      let srcWidget: any =  "//div[@data-test-id='"+widgetName+"']//img";
;      let desElement: any = await ScreenMap.get("UniqueWidgetFields").getSelector("CanvasBody");
      console.table({
        'Widget Path': srcWidget,
        'Destination Locator': desElement
      });
      const status = await page.evaluate(
        async ({ draggableSelector, droppableSelector, targetX, targetY }: { 
          draggableSelector: string; 
          droppableSelector: string; 
          targetX: number; 
          targetY: number;
        }) => {
          async function simulateDragAndDrop(
            draggableSelector: string, 
            droppableSelector: string, 
            targetX: number, 
            targetY: number
          ): Promise<string> {
            const draggable = document.evaluate(
              draggableSelector,
              document,
              null,
              XPathResult.FIRST_ORDERED_NODE_TYPE,
              null
            ).singleNodeValue as HTMLElement;
  
            const droppable = document.evaluate(
              droppableSelector,
              document,
              null,
              XPathResult.FIRST_ORDERED_NODE_TYPE,
              null
            ).singleNodeValue as HTMLElement;
            const draggableRect = draggable.getBoundingClientRect();
            const startX = draggableRect.x + draggableRect.width / 2;
            const startY = draggableRect.y + draggableRect.height / 2;
  
            let moveX = 0;
            let moveY = 0;
  
            if (!draggable || !droppable) {
              console.error("Error: Draggable or droppable element not found.");
              return "failure";
            }
            // Function to fire mouse events
            function fireMouseEvent(type: string, target: HTMLElement, x: number, y: number): void {
              const event = new MouseEvent(type, {
                buttons: 1,
                bubbles: true,
                cancelable: true,
                composed: true,
                view: window,
                detail: 1,
                clientX: x,
                clientY: y,
              });
              target.dispatchEvent(event);
            }
  
            // Simulate Drag Start
            fireMouseEvent("mousedown", draggable, draggableRect.x, draggableRect.y);
            const steps = 5;
            for (let i = 0; i <= steps; i++) {
              moveX = startX + ((targetX - startX) * i) / steps; // Move to targetX
              moveY = startY + ((targetY - startY) * i) / steps; // Move to targetY
              fireMouseEvent("mousemove", draggable, moveX, moveY);
              await new Promise(resolve => setTimeout(resolve, 80)); // Delay for each move step
            }
            fireMouseEvent("mouseup", draggable, moveX, moveY);
            return "success";
          }
  
          return simulateDragAndDrop(draggableSelector, droppableSelector, targetX, targetY);
        },
        {
          draggableSelector: srcWidget,  // Pass the retrieved srcElement
          droppableSelector: desElement,  // Pass the retrieved desElement
          targetX: Math.floor(Math.random() * (1000 - 200 + 1)) + 200,  // Use the provided X coordinate for drop
          targetY: Math.floor(Math.random() * (1000 - 200 + 1)) + 200  // Use the provided Y coordinate for drop
        }
      );
      // Log the result status
      console.log(`Drag and drop operation completed with status: ${status}`);
    } catch (err) {
      console.error('Error during drag and drop operation:', err);
      throw err;
    }
  }

  async expandWidgets(
    sourceLocator: string, 
    destLocator: string, 
    XCord: number, 
    YCord: number, 
    pageScreen: string
  ): Promise<void> {
    try {
      // Log to indicate the start of drag and drop operation
      console.log('------------Drag and Drop Starts---------------------------');
  
      // Log the parameters in a table-like format
      console.table({
        'Source Locator': sourceLocator,
        'Destination Locator': destLocator,
        'Target X Coordinate': XCord,
        'Target Y Coordinate': YCord,
        'Page Screen': pageScreen
      });
  
      // Retrieve the elements based on the locators
      let desElement: any = await ScreenMap.get(pageScreen).getSelector(destLocator);
      const status = await page.evaluate(
        async ({ draggableSelector, droppableSelector, targetX, targetY }: { 
          draggableSelector: string; 
          droppableSelector: string; 
          targetX: number; 
          targetY: number;
        }) => {
          async function simulateDragAndDrop(
            draggableSelector: string, 
            droppableSelector: string, 
            targetX: number, 
            targetY: number
          ): Promise<string> {
            const draggable = document.evaluate(
              draggableSelector,
              document,
              null,
              XPathResult.FIRST_ORDERED_NODE_TYPE,
              null
            ).singleNodeValue as HTMLElement;
  
            const droppable = document.evaluate(
              droppableSelector,
              document,
              null,
              XPathResult.FIRST_ORDERED_NODE_TYPE,
              null
            ).singleNodeValue as HTMLElement;
            const draggableRect = draggable.getBoundingClientRect();
            const startX = draggableRect.x + draggableRect.width / 2;
            const startY = draggableRect.y + draggableRect.height / 2;
  
            let moveX = 0;
            let moveY = 0;
  
            if (!draggable || !droppable) {
              console.error("Error: Draggable or droppable element not found.");
              return "failure";
            }
            // Function to fire mouse events
            function fireMouseEvent(type: string, target: HTMLElement, x: number, y: number): void {
              const event = new MouseEvent(type, {
                buttons: 1,
                bubbles: true,
                cancelable: true,
                composed: true,
                view: window,
                detail: 1,
                clientX: x,
                clientY: y,
              });
              target.dispatchEvent(event);
            }
  
            // Simulate Drag Start
            fireMouseEvent("mousedown", draggable, draggableRect.x, draggableRect.y);
            const steps = 5;
            for (let i = 0; i <= steps; i++) {
              moveX = startX + ((targetX - startX) * i) / steps; // Move to targetX
              moveY = startY + ((targetY - startY) * i) / steps; // Move to targetY
              fireMouseEvent("mousemove", draggable, moveX, moveY);
              await new Promise(resolve => setTimeout(resolve, 80)); // Delay for each move step
            }
            fireMouseEvent("mouseup", draggable, moveX, moveY);
            return "success";
          }
  
          return simulateDragAndDrop(draggableSelector, droppableSelector, targetX, targetY);
        },
        {
          draggableSelector: sourceLocator,  // Pass the retrieved srcElement
          droppableSelector: desElement,  // Pass the retrieved desElement
          targetX: XCord,  // Use the provided X coordinate for drop
          targetY: YCord   // Use the provided Y coordinate for drop
        }
      );
      // Log the result status
      console.log(`Drag and drop operation completed with status: ${status}`);
    } catch (err) {
      console.error('Error during drag and drop operation:', err);
      throw err;
    }
  }
  
  async dragAndDrop(sourceLocator, destLocator, XCord, YCord, pageScreen) {
    try {
      let srcElement: any = await ScreenMap.get(pageScreen).getSelector(
        sourceLocator
      );
      let desElement: any = await ScreenMap.get(pageScreen).getSelector(
        destLocator
      );
      console.log(srcElement, desElement);
      await page.dragAndDrop(srcElement, desElement, {
        targetPosition: { x: XCord, y: YCord },
      });
    } catch (err) {
      throw err;
    }
  }

  async ClickElement(elementName, pageScreen?) {
    try {
      let txtElement: any;
      if (pageScreen !== undefined) {
        txtElement = await ScreenMap.get(pageScreen).getElement(elementName);
      } else {
        txtElement = elementName;
      }
      await txtElement.click();
    } catch (err) {
      throw err;
    }
  }

  async doubleclickElement(elementName, pageScreen) {
    try {
      let txtElement: any = await ScreenMap.get(pageScreen).getSelector(
        elementName
      );
      await page.dblclick(txtElement);
    } catch (err) {
      throw err;
    }
  }

  async mouseHoverElement(elementName, pageScreen?) {
    try {
      let txtElement: any;
      if (pageScreen !== undefined) {
        txtElement = await ScreenMap.get(pageScreen).getElement(elementName);
      } else {
        txtElement = elementName;
      }
      await txtElement.hover();
    } catch (err) {
      throw err;
    }
  }

  async rightclickElement(elementName, pageScreen) {
    try {
      let txtElement: any = await ScreenMap.get(pageScreen).getElement(
        elementName
      );
      await txtElement.click({ button: "right" });
    } catch (err) {
      throw err;
    }
  }

  async SelectOption(text, elementName, pageScreen) {
    try {
      let txtElement: any = await ScreenMap.get(pageScreen).getElement(
        elementName
      );
      await txtElement.SelectOption(text);
    } catch (err) {
      throw err;
    }
  }

  async dragAndDropBO(sourceLocator, destLocator, XCord, YCord, pageScreen) {
    try {
      let srcElement: any = "//div[@data-test-id='" + sourceLocator + "']";
      console.log(srcElement);
      let desElement: any = await ScreenMap.get(pageScreen).getSelector(
        destLocator
      );
      await this.dragAndDropWidgets(srcElement, desElement, 
         XCord, YCord , pageScreen
      );
    } catch (err) {
      throw err;
    }
  }

  async selectDropdownbyspantext(elementName, pageScreen, option) {
    try {
      await page.waitForSelector(
        await ScreenMap.get(pageScreen).getSelector(elementName))
      let txtElement: any = await ScreenMap.get(pageScreen).getElement(
        elementName
      );
      await txtElement.click();
      if (option) {
        let optionelement = page.locator(
          '//li//span[contains(text(),"' + option + '")]'
        );
        await optionelement.nth(0).click();
      }
    } catch (err) {
      throw err;
    }
  }

  async selectDropdownbyMultipleText(elementName, table, pageScreen?) {
    try {
      let txtElement: any;
      if (pageScreen !== undefined) {
        txtElement = await ScreenMap.get(pageScreen).getElement(elementName);
      } else {
        txtElement = elementName;
      }
      await txtElement.click();
      const dropvalues = table;
      console.log(dropvalues.length);
      for (let i = 0; i < dropvalues.length; i++) {
        console.log(dropvalues[i]);
        if (dropvalues[i]) {
          await page.isVisible("//finlevit-lib-checkbox[@data-test-class='member']//label[normalize-space(text())='" + dropvalues[i] + "']/../..//div[contains(@class,'p-checkbox-checked')]").then(async (eleexist) => {
            console.log("Option to be selected:  "+dropvalues[i]);
            if (eleexist != true) {
              await page.click("//finlevit-lib-checkbox[@data-test-class='member']//label[normalize-space(text())='" + dropvalues[i] + "']");
              console.log("Selected Option: "+dropvalues[i]);
            }
          })

        }
      }
    } catch (err) {
      throw err;
    }
  }

  async selectDropdownbytagName(tagName, elementName, option, pageScreen?) {
    let txtElement: any
    try {
      if (pageScreen !== undefined) {
        txtElement = await ScreenMap.get(pageScreen).getElement(elementName);
      } else {
        txtElement = elementName;
      }
      await txtElement.scrollIntoViewIfNeeded()
      await txtElement.click();
      await page.waitForTimeout(500);
      if (option) {
        let optionelement = page.locator(
          '//' + tagName + '[normalize-space(text())="' + option + '"]'
        );
        await optionelement.nth(0).click();
      }
    } catch (err) {
      throw err;
    }
  }

  async uploadFile(file) {
    try {
      let uploadFile = 'resources/' + file
      console.log("UploadFile is " + uploadFile)
      await page.setInputFiles("input[type='file']", uploadFile)
    } catch (err) {
      throw err;
    }
  }

  async getElement(elementName, pageScreen) {
    let locator;
    try {
      locator = await ScreenMap.get(pageScreen).getElement(elementName);
    } catch (err) {
      throw err;
    }
    return locator;
  }

  async dragAndDropwithoutAxis(sourceLocator, destLocator) {
    try {
      console.log(sourceLocator, destLocator);
      await page.dragAndDrop(sourceLocator, destLocator);
    } catch (err) {
      throw err;
    }
  }

  async getText(elementName, pageScreen) {
    let actualText;
    try {
      let elementText: any = await ScreenMap.get(pageScreen).getElement(
        elementName
      );
      actualText = await elementText.textContent();
      console.log("ActualText is " + actualText);
    } catch (err) {
      throw err;
    }
    return actualText;
  }

  async selectAllDropdownOptions(elementName, pageScreen?) {
    let txtElement: any
    try {
      if (pageScreen !== undefined) {
        txtElement = await ScreenMap.get(pageScreen).getElement(elementName);
      } else {
        txtElement = elementName;
      }
      await txtElement.click();
      const dropvalues = await page.locator("//ul[@role='listbox']//li")
      console.log(await dropvalues.count());
      for (let i = 0; i < await dropvalues.count(); i++) {
        console.log(await dropvalues.nth(i).textContent());
        await dropvalues.nth(i).click()
      }
    } catch (err) {
      throw err;
    }
  }

  async browserZoomin() {
    await page.evaluate(() => {
      document.body.style.transform = 'scale(0.90)'
    })
    console.log("Browser zoomed in to 90%")
  }

  async browserZoomOut() {
    await page.evaluate(() => {
      document.body.style.transform = 'scale(1.0)'
    })
    console.log("Browser zoomed out to 100%")
  }

  async waitforInvisibilityOfSpinner() {
    // Wait for the spinner to disappear
    const spinnerSelector = "//div[contains(@class,'spinner-circle-swish')]";
    let exist = await page.isVisible(spinnerSelector).then(async (exist) => {
      return exist;
    });
    if (exist == true) {
      console.log("Waiting for the spinner to disappear")
      await page.waitForSelector(spinnerSelector, { state: 'hidden',timeout: 100000});
    }
  }

  async waitforVisibilityOfSpinner() {
    // Wait for the spinner to appear
    try {
      const spinnerSelector = "//div[contains(@class,'spinner-circle-swish')]";
      await page.waitForSelector(spinnerSelector);
      console.log("Waiting for the spinner to appear")
      await page.waitForTimeout(500);
    } catch (err) {
      console.log(
        "Spinner does not appears"
      );
    }
  }
  async generateRandomString(len) {
    let result = '';
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const charactersLength = characters.length;
    for (let i = 0; i < len; i++) {
      result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
  }

  async generateRandomNumber(length) {
    const min = 10 ** (length - 1);
    const max = (10 ** length) - 1;
    return Math.floor(Math.random() * (max - min + 1) + min);
  }

  async waitforgivenselector(elementName,pageScreen?) {
    // Wait for the selector to appear
    try {
      let txtElement: any = await ScreenMap.get(pageScreen).getSelector(
        elementName
      );
      await page.waitForSelector(txtElement);
      console.log("Waiting for the element " +elementName+ " to appear")
      await page.waitForTimeout(500);
    } catch (err) {
      console.log(
        "Element does not appears"
      );
    }
  }

  async waitforInvisibilityOfToastMessage() {
    // Wait for the toast message to disappear
    const msgSelector = await ScreenMap.get("payload").getSelector("Pagelevel_alert_messgae");
    let exist = await page.isVisible(msgSelector).then(async (exist) => {
      return exist;
    });
    if (exist == true) {
      console.log("Waiting for the message to disappear")
      await page.waitForSelector(msgSelector, { state: 'hidden',timeout: 60000});
    }
  }

  async getandReplaceElement(replaceText, elementName, pageScreen) {
    let Field;
    try {
      let Fieldxpath = await ScreenMap.get(pageScreen).getSelector(elementName);
      Field = page.locator(
        Fieldxpath.replace("elementName", replaceText)
      );

    } catch (err) {
      throw err;
    }
    return Field;
  }
}
