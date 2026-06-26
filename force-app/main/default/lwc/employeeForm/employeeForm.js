import { LightningElement } from 'lwc';
export default class EmployeeForm extends LightningElement {
     value = 'Gender'; // you can write default value as male

    get options() {
        return [
            { label: 'Male', value: 'Male' },
            { label: 'Female', value: 'Female' },
        ];
    }

    handleChange(event) {
        this.value = event.detail.value;
    }
}