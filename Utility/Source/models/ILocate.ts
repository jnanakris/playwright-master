export interface ILocate{
    setTypeOfLocator(locatorType:string);
    setAttributeValue(locatorValue:string);
    getTypeOfLocator();
    getAttributeValue();
    getElement();
    getAllElements();
    getSelector();
}