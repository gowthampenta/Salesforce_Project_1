import { LightningElement,track } from 'lwc';
export default class TrackEx101 extends LightningElement {
  @track employeeName = 'Gowtham';
  handleOnChange(event){
      this.employeeName=event.target.value;
  }
}