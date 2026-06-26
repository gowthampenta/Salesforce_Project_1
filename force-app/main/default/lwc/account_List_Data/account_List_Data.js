import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/Account_Controller.getAccounts';
import deleteAccount from '@salesforce/apex/Account_Controller.deleteAccount';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const COLUMNS = [
    {
        label: 'Account Name',
        fieldName: 'Name',
        type: 'text'
    },
    {
        label: 'Industry',
        fieldName: 'Industry',
        type: 'text'
    },
    {
        label: 'Phone',
        fieldName: 'Phone',
        type: 'phone'
    },
    {
        type: 'action',
        typeAttributes: {
            rowActions: [
                { label: 'Delete', name: 'delete' }
            ]
        }
    }
];

export default class AccountList extends LightningElement {

    columns = COLUMNS;
    accounts = [];
    wiredAccountsResult;

    @wire(getAccounts)
    wiredAccounts(result) {

        this.wiredAccountsResult = result;

        if (result.data) {
            this.accounts = result.data;
        } else if (result.error) {
            console.error(result.error);
        }
    }

    handleRowAction(event) {

        const actionName = event.detail.action.name;
        const row = event.detail.row;

        if (actionName === 'delete') {

            deleteAccount({ accountId: row.Id })
                .then(() => {

                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Account deleted',
                            variant: 'success'
                        })
                    );

                    return refreshApex(this.wiredAccountsResult);
                })
                .catch(error => {

                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error',
                            message: error.body?.message || 'Delete failed',
                            variant: 'error'
                        })
                    );

                    console.error(error);
                });
        }
    }
}