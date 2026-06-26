import { LightningElement } from 'lwc';

export default class ParentComponent extends LightningElement {
    messageFromParent = 'Hello from Parent Component';

    callChildMethod() {
       //  const child = this.template.querySelector('c-child-component');
       // alert(this.messageFromParent);
        this.messageFromParent = "Updated Message from Parent";

    }
}