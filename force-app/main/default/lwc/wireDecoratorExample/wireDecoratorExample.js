import { LightningElement,wire } from 'lwc';
import getAllAccounts from "@salesforce/apex/AccountHandler1.getAllAccounts";
export default class WireDecoratorExample extends LightningElement {
    @wire (getAllAccounts) accrecords;

}