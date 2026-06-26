import { LightningElement, wire } from 'lwc';
import getInsuranceValues from '@salesforce/apex/InsuranceController.getInsuranceValues';

export default class InsurancePicklist extends LightningElement {

    options = [];
    value = '';

    @wire(getInsuranceValues)
    wiredData({ data, error }) {
        if (data) {
            this.options = data.map(val => {
                return { label: val, value: val };
            });
        } else if (error) {
            console.error(error);
        }
    }

    handleChange(event) {
        this.value = event.target.value;
    }
}