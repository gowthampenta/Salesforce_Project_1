import { LightningElement, api } from 'lwc';

export default class Child extends LightningElement {
    @api student;

    changeName() {
        const updatedStudent = {
            ...this.student,
            name: 'Changed in Child'
        };

        // Send to parent
        this.dispatchEvent(
            new CustomEvent('update', { detail: updatedStudent })
        );
    }
}