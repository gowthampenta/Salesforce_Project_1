import { LightningElement, track, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import searchAccounts from '@salesforce/apex/AccountSearchController.searchAccounts';

export default class AccountSearch extends LightningElement {

    @track searchKey = '';
    @track accounts = [];
    columns = [
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
        searchAccounts({ searchKey: this.searchKey })
            .then(result => {
                this.accounts = result;
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }

    
    handleSearchChange(event) {
        this.searchKey = event.target.value;
        const url = new URL(window.location.href);
        url.searchParams.set('searchKey', this.searchKey);
        window.history.pushState({}, '', url);
        this.loadAccounts();
    }
}