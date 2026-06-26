import { LightningElement, api } from 'lwc';

export default class AccountRecordForm extends LightningElement {

    @api recordId;

    fields = [
        'Name',
        'Phone',
        'Industry'
    ];
}