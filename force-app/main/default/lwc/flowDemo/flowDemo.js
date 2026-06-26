import { LightningElement, api } from 'lwc';

export default class FlowDemo extends LightningElement {

    @api recordId;

    get inputVariables() {

        return [
            {
                name: 'recordId',

                type: 'String',

                value: this.recordId
            }
        ];
    }
}

/*
On Account Record Page:

LWC sends:

Current Account Record Id

to Flow.

Flow will:

Display received recordId
Show confirmation screen



*/

// Account_Record_Flow - flow name

// LWC - FLOW COMMUNICATION