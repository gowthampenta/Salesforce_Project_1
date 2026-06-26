import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

// Fields to fetch
const FIELDS = [
    'Account.Name',
    'Account.Phone',
    'Account.Industry'
];

export default class AccountWireExample extends LightningElement {

    @api recordId;   // automatically passed from record page

    account;
    error;

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    wiredAccount({ data, error }) {

        if (data) {
            this.account = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.account = undefined;
        }
    }

    get name() {
        return this.account?.fields?.Name?.value;
    }

    get phone() {
        return this.account?.fields?.Phone?.value;
    }

    get industry() {
        return this.account?.fields?.Industry?.value;
    }
}