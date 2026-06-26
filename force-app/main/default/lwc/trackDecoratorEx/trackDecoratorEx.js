import { LightningElement,track } from 'lwc';
export default class TrackDecoratorEx extends LightningElement {
         @track customerName = "Gowtham";
         onHandleChange(event){
              this.customerName = event.target.value;
         }
}





/*
import { LightningElement,track } from 'lwc';
export default class TrackDecoratorEx extends LightningElement {
          @track customerName = 'Gowtham';
          handleOnChange(event){
                 this.customerName = event.target.value;
          }
}

*/