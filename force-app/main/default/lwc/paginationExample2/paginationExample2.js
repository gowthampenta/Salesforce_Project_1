import { LightningElement, track, api } from 'lwc';
import getAccounts from '@salesforce/apex/PaginationController2.getAccounts';

export default class PaginationExample2 extends LightningElement {

    @api pageType;

    @track records = [];
    @track columns = [];

    lastRecordId = null;
    pageSize = 10;

    connectedCallback() {
        this.loadData();
    }

    loadData() {
        getAccounts({
            pageType: this.pageType,
            lastId: this.lastRecordId,
            limitSize: this.pageSize
        })
        .then(result => {

            this.records = result.records;
            this.columns = result.columns.map(col => ({
                label: col.label,
                fieldName: col.fieldName
            }));

            if(this.records.length > 0){
                this.lastRecordId = this.records[this.records.length - 1].Id;
            }
        })
        .catch(error => console.error(error));
    }
}