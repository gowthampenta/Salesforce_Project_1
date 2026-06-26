import { LightningElement,api,track } from 'lwc';
export default class ApiDecorator_Ex2 extends LightningElement {
     @track mobileName  = "Samsung";
     @api employeeName = "Gowtham"; 

     handleOnChange(){
        this.mobileName = "IPhone";
        this.employeeName  = "Sai";
     }
}