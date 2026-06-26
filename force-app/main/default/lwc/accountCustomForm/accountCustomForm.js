import { LightningElement, wire, track } from 'lwc';
import getProfileName from '@salesforce/apex/UserController.getProfileName';

export default class AccountCustomForm extends LightningElement {
    @track profileName;
    @track isAdmin = false;

    @wire(getProfileName)
    wiredProfile({ data, error }) {
        if (data) {
            this.profileName = data;
            this.isAdmin = data === 'System Administrator';
            //console.log(json.JSON.stringify(data));
        } else if (error) {
           console.error(error);
        }
    }
}