import { LightningElement, track, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import searchAccounts from '@salesforce/apex/AccountSearchController2.searchAccounts';

export default class AccountSearch2 extends LightningElement {

    @track searchKey = '';
    @track accounts = [];

    pageSize = 5;
    offset = 0;

    columns = [
        { label: 'S.No', fieldName: 'serialNumber', type: 'number' },
        { label: 'Account Name', fieldName: 'Name' },
        { label: 'Industry', fieldName: 'Industry' },
        { label: 'Phone', fieldName: 'Phone' },
        { label: 'Rating', fieldName: 'Rating' }
    ];

    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        if (currentPageReference) {
            this.searchKey = currentPageReference.state?.searchKey || '';
            this.loadAccounts();
        }
    }

    loadAccounts() {
        searchAccounts({
            searchKey: this.searchKey,
            limitSize: this.pageSize,
            offsetSize: this.offset
        })
        .then(result => {

            let temp = [];
            for (let i = 0; i < result.length; i++) {
                temp.push({
                    ...result[i],
                    serialNumber: this.offset + i + 1
                });
            }

            this.accounts = temp;
        })
        .catch(error => {
            console.error(error);
        });
    }

    handleSearchChange(event) {
        this.searchKey = event.target.value;
        this.offset = 0; 

        const url = new URL(window.location.href);
        url.searchParams.set('searchKey', this.searchKey);
        window.history.pushState({}, '', url);

        this.loadAccounts();
    }

    handleNext() {
        this.offset += this.pageSize;
        this.loadAccounts();
    }

    handlePrevious() {
        if (this.offset > 0) {
            this.offset -= this.pageSize;
            this.loadAccounts();
        }
    }
}