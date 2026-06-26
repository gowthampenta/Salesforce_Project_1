import { LightningElement, track } from 'lwc';
import getAccounts from '@salesforce/apex/PaginationController3.getAccounts';
import getPreviousAccounts from '@salesforce/apex/PaginationController3.getPreviousAccounts';

export default class PaginationExample extends LightningElement {

    @track records = [];
    @track columns = [];

    pageSize = 10;
    nextSize = 5;

    firstRecordId;
    lastRecordId;

    pageStack = [];

    disablePrevious = true;
    disableNext = false;

    startIndex = 0; // 🔥 for S.No

    connectedCallback() {
        this.loadInitial();
    }

    // 🔹 INITIAL LOAD
    loadInitial() {
        getAccounts({ lastId: null, limitSize: this.pageSize })
            .then(result => {

                this.startIndex = 0;

                this.records = result.records.map((rec, index) => ({
                    ...rec,
                    serialNumber: this.startIndex + index + 1
                }));

                this.setColumns(result.columns);

                this.firstRecordId = this.records[0]?.Id;
                this.lastRecordId = this.records[this.records.length - 1]?.Id;

                this.pageStack = [];
                this.disablePrevious = true;
                this.disableNext = result.records.length < this.pageSize;
            });
    }

    // 🔹 SET COLUMNS (ADD S.NO)
    setColumns(cols){
        this.columns = [
            { label: 'S.No', fieldName: 'serialNumber' }, // 🔥 S.No
            ...cols.map(col => ({
                label: col.label,
                fieldName: col.fieldName
            }))
        ];
    }

    // 🔹 NEXT
    handleNext() {

        this.pageStack.push({
            firstId: this.firstRecordId,
            lastId: this.lastRecordId,
            startIndex: this.startIndex
        });

        getAccounts({ lastId: this.lastRecordId, limitSize: this.nextSize })
            .then(result => {

                if(result.records.length === 0){
                    this.disableNext = true;
                    return;
                }

                this.startIndex += this.records.length;

                this.records = result.records.map((rec, index) => ({
                    ...rec,
                    serialNumber: this.startIndex + index + 1
                }));

                this.setColumns(result.columns);

                this.firstRecordId = this.records[0].Id;
                this.lastRecordId = this.records[this.records.length - 1].Id;

                this.disablePrevious = false;
                this.disableNext = result.records.length < this.nextSize;
            });
    }

    // 🔹 PREVIOUS
    handlePrevious() {

        if(this.pageStack.length === 0){
            this.disablePrevious = true;
            return;
        }

        const prevState = this.pageStack.pop();

        let limitValue = this.pageStack.length === 0 ? this.pageSize : this.nextSize;

        getPreviousAccounts({ firstId: this.firstRecordId, limitSize: limitValue })
            .then(result => {

                let data = [...result.records].reverse();

                this.startIndex = prevState.startIndex;

                this.records = data.map((rec, index) => ({
                    ...rec,
                    serialNumber: this.startIndex + index + 1
                }));

                this.setColumns(result.columns);

                this.firstRecordId = data[0].Id;
                this.lastRecordId = data[data.length - 1].Id;

                this.disableNext = false;
                this.disablePrevious = this.pageStack.length === 0;
            });
    }

    // 🔹 REFRESH
    handleRefresh() {
        this.firstRecordId = null;
        this.lastRecordId = null;
        this.pageStack = [];
        this.startIndex = 0;
        this.disableNext = false;
        this.disablePrevious = true;

        this.loadInitial();
    }
}