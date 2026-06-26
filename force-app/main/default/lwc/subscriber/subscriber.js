import { LightningElement, wire } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import SAMPLEMC from '@salesforce/messageChannel/SampleChannel__c';

export default class Subscriber extends LightningElement {
    receivedMessage = '';
    subscription = null;

    @wire(MessageContext)
    messageContext;

    connectedCallback() {
        this.subscribeToMessageChannel();
    }

    subscribeToMessageChannel() {
        if (!this.subscription) {
            this.subscription = subscribe(
                this.messageContext,
                SAMPLEMC,
                (message) => {
                    this.receivedMessage = message.text;
                }
            );
        }
    }
}