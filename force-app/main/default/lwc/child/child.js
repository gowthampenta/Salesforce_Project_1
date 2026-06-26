import { LightningElement } from 'lwc';

export default class Child extends LightningElement {

    name = '';  // stores input value

    // Capture user input
    handleChange(event) {
        this.name = event.target.value;
    }

    // Send data to parent
    sendToParent() {
        const myEvent = new CustomEvent('sendname', {
            detail: this.name   // data being sent
        });

        this.dispatchEvent(myEvent); // fire event
    }
}