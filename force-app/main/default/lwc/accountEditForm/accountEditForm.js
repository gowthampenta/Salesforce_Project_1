import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class AccountEditForm extends LightningElement {

    @api recordId;

    handleSuccess() {

        const event = new ShowToastEvent({
            title: 'Success',
            message: 'Account Updated Successfully',
            variant: 'success'
        });

        this.dispatchEvent(event);
    }
}