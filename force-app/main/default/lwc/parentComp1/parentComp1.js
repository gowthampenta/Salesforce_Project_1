import { LightningElement } from 'lwc';
export default class ParentComp1 extends LightningElement {
     messageFromParent = 'Hello From Parent Component';

     callChildMethod(){
         const child = this.template.querySelector('c-child-Comp1');
         alert('Message From Parent');
     }
}