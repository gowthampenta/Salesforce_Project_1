import { LightningElement, track } from 'lwc';
import getOpportunityRecordTypes from '@salesforce/apex/OpportunityOverrideController.getOpportunityRecordTypes';
import getFieldsByRecordType from '@salesforce/apex/OpportunityOverrideController.getFieldsByRecordType';
import getAccountDetails from '@salesforce/apex/OpportunityOverrideController.getAccountDetails';

export default class OpportunityOverride extends LightningElement {

    @track recordTypeOptions = [];
    @track selectedRecordTypeId;
    @track fields = [];

    @track isStepOne = true;
    @track isStepTwo = false;

    connectedCallback() {
        this.loadRecordTypes();
    }

    // Load Record Types
    loadRecordTypes() {
        getOpportunityRecordTypes()
            .then(result => {
                this.recordTypeOptions = result.map(rt => {
                    return { label: rt.name, value: rt.recordTypeId };
                });
            })
            .catch(error => {
                console.error(error);
            });
    }

    // Handle Record Type selection
    handleRTChange(event) {
        this.selectedRecordTypeId = event.detail.value;
    }

    // Next button
    handleNext() {
        if (!this.selectedRecordTypeId) {
            alert('Please select Record Type');
            return;
        }

        getFieldsByRecordType({ recordTypeId: this.selectedRecordTypeId })
            .then(result => {
                this.fields = result;
                this.isStepOne = false;
                this.isStepTwo = true;
            })
            .catch(error => {
                console.error(error);
            });
    }

    // Handle Account Auto-fill
    handleAccountChange(event) {
        if (event.target.fieldName === 'AccountId') {
            const accId = event.detail.value;

            if (accId) {
                getAccountDetails({ accId })
                    .then(result => {
                        console.log('Account Data:', result);
                        // You can extend this later to auto-fill fields
                    })
                    .catch(error => {
                        console.error(error);
                    });
            }
        }
    }

    // Success Handler
    handleSuccess() {
        alert('Opportunity Created Successfully!');
    }
}