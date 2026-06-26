import { LightningElement } from 'lwc';

export default class Parent extends LightningElement {

    receivedName = 'Enter Name in input'; // stores value from child

    // This runs when child fires event
    handleName(event) {
        this.receivedName = event.detail; // get data from child
    }
}