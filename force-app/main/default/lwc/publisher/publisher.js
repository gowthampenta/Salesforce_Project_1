import { LightningElement, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import SAMPLEMC from '@salesforce/messageChannel/SampleChannel__c';

export default class Publisher extends LightningElement {

    @wire(MessageContext)
    messageContext;

    handleClick() {
        const message = {
            text: 'Hello from Publisher Component'
        };

        publish(this.messageContext, SAMPLEMC, message);
    }
}