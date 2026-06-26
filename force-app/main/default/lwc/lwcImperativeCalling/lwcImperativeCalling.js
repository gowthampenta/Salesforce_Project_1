import { LightningElement ,track} from 'lwc';
import getAllAccounts from "@salesforce/apex/AccountHandler1.getAllAccounts";
export default class LwcImperativeCalling extends LightningElement {
       @track accRecords;
       onShowAllAccounts(){
           getAllAccounts().then(result=>{this.accRecords=result;})
                           .catch(result=>{console.log('Error Occured'+error);})
       }
}