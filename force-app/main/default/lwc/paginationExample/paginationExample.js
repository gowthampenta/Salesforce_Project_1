import { LightningElement, track } from 'lwc';
import getNextRecords from '@salesforce/apex/PaginationController.getNextRecords';
import getPreviousRecords from '@salesforce/apex/PaginationController.getPreviousRecords';

import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class PaginationExample extends LightningElement {

    @track records = [];
    draftValues = [];

    columns = [
        { label: 'Account Name', fieldName: 'Name', editable: true },
        { label: 'Industry', fieldName: 'Industry', editable: true },
        { label: 'Phone', fieldName: 'Phone', editable: true },
        { label: 'Rating', fieldName: 'Rating', editable: true }
    ];

    pageSize = 10;
    nextSize = 5;

    firstRecordId = null;
    lastRecordId = null;

    pageStack = [];

    disablePrevious = true;
    disableNext = false;

    startIndex = 0;

    get startDisplay() {
        return this.startIndex + 1;
    }

    get endDisplay() {
        return this.startIndex + this.records.length;
    }

    connectedCallback() {
        this.loadInitial();
    }

    loadInitial() {
        getNextRecords({ lastId: null, limitSize: this.pageSize })
            .then(result => {

                this.startIndex = 0;
                this.records = [...result];

                this.firstRecordId = result[0]?.Id;
                this.lastRecordId = result[result.length - 1]?.Id;

                this.pageStack = [];
                this.disablePrevious = true;
                this.disableNext = result.length < this.pageSize;
            })
            .catch(error => console.error(error));
    }

    handleNext() {

        this.pageStack.push({
            firstId: this.firstRecordId,
            lastId: this.lastRecordId,
            startIndex: this.startIndex
        });

        getNextRecords({ lastId: this.lastRecordId, limitSize: this.nextSize })
            .then(result => {

                if(!result || result.length === 0){
                    this.disableNext = true;
                    return;
                }

                this.startIndex += this.records.length;
                this.records = [...result];

                this.firstRecordId = result[0].Id;
                this.lastRecordId = result[result.length - 1].Id;

                this.disablePrevious = false;
                this.disableNext = result.length < this.nextSize;
            })
            .catch(error => console.error(error));
    }

    handlePrevious() {

        if(this.pageStack.length === 0){
            this.disablePrevious = true;
            return;
        }

        const prevState = this.pageStack.pop();

        let limitValue = this.pageStack.length === 0 ? this.pageSize : this.nextSize;

        getPreviousRecords({ firstId: this.firstRecordId, limitSize: limitValue })
            .then(result => {

                if(!result || result.length === 0){
                    return;
                }

                const reversedData = [...result].reverse();

                this.startIndex = prevState.startIndex;
                this.records = reversedData;

                this.firstRecordId = reversedData[0].Id;
                this.lastRecordId = reversedData[reversedData.length - 1].Id;

                this.disableNext = false;
                this.disablePrevious = this.pageStack.length === 0;
            })
            .catch(error => console.error(error));
    }

    
    handleSave(event) {

        const updatedFields = event.detail.draftValues;

        const recordInputs = updatedFields.map(draft => {
            return { fields: { ...draft } };
        });

        const promises = recordInputs.map(recordInput => updateRecord(recordInput));

        Promise.all(promises)
            .then(() => {

                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Records Updated Successfully',
                        variant: 'success'
                    })
                );

                this.draftValues = [];
                this.handleRefresh();
            })
            .catch(error => console.error(error));
    }

    
    handleRefresh() {
        this.firstRecordId = null;
        this.lastRecordId = null;
        this.pageStack = [];
        this.startIndex = 0;
        this.disableNext = false;

        this.loadInitial();
    }
}