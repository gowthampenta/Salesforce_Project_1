import { LightningElement } from 'lwc';
export default class Parent2 extends LightningElement {
   handleUpdate(event) {
    this.student = event.detail;
}
}