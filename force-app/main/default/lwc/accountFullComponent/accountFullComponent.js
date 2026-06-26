import { LightningElement, api, wire } from 'lwc';
import { getRecord, updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import saveRecord from '@salesforce/apex/AccountDetailController.saveRecord';
import getRecords from '@salesforce/apex/AccountDetailController.getRecords';
import deleteRecord from '@salesforce/apex/AccountDetailController.deleteRecord';

import PLAN_FIELD from '@salesforce/schema/Account.Plan_Type__c';

export default class AccountFullComponent extends LightningElement {

    @api recordId;

    plan;
    planOptions = [
        { label: 'ESOP', value: 'ESOP' },
        { label: 'KSOP', value: 'KSOP' },
        { label: 'GSOP', value: 'GSOP' },
        { label: 'MSOP', value: 'MSOP' }
    ];

    @wire(getRecord, { recordId: '$recordId', fields: [PLAN_FIELD] })
    acc({data}) {
        if(data){
            this.plan = data.fields.Plan_Type__c.value;
        }
    }

    get isDisabled(){
        return this.plan ? true : false;
    }

    handlePlan(event){
        this.plan = event.detail.value;

        updateRecord({
            fields: {
                Id: this.recordId,
                Plan_Type__c: this.plan
            }
        })
        .then(() => {
            this.toast('Success','Plan saved','success');
        });
    }

    get isESOP(){ return this.plan === 'ESOP'; }
    get isKSOP(){ return this.plan === 'KSOP'; }
    get isGSOP(){ return this.plan === 'GSOP'; }
    get isMSOP(){ return this.plan === 'MSOP'; }

    get columns(){
        let cols = [
            { label: 'Name', fieldName: 'Name' },
            { label: 'Description', fieldName: 'Description__c' },
            { label: 'Status', fieldName: 'Status__c' }
        ];

        if(this.plan){
            cols.push({ label: this.plan + ' Value', fieldName: 'Amount__c' });
        }

        cols.push({
            type: 'action',
            typeAttributes: {
                rowActions: [
                    { label: 'Edit', name: 'edit' },
                    { label: 'Delete', name: 'delete' }
                ]
            }
        });

        return cols;
    }

    records = [];

    connectedCallback(){
        this.load();
    }

    load(){
        getRecords({ accId: this.recordId })
        .then(res => this.records = res);
    }

    isModal = false;
    title = 'Add Record';

    name;
    description;
    amount;
    status;
    recId;

    statusOptions = [
        { label: 'New', value: 'New' },
        { label: 'In Progress', value: 'In Progress' },
        { label: 'Completed', value: 'Completed' }
    ];

    openModal(){ this.isModal = true; }

    closeModal(){
        this.isModal = false;
        this.name = '';
        this.description = '';
        this.amount = '';
        this.status = '';
        this.recId = null;
    }

    handleName(e){ this.name = e.target.value; }
    handleDesc(e){ this.description = e.target.value; }
    handleAmount(e){ this.amount = e.target.value; }
    handleStatus(e){ this.status = e.detail.value; }

    save(){
        if(!this.name || !this.description || !this.amount || !this.status){
            this.toast('Error','All fields required','error');
            return;
        }

        saveRecord({
            accId: this.recordId,
            name: this.name,
            description: this.description,
            amount: this.amount,
            status: this.status,
            recId: this.recId
        })
        .then(()=>{
            this.toast('Success','Saved','success');
            this.closeModal();
            this.load();
        });
    }

    handleRowAction(event){
        const action = event.detail.action.name;
        const row = event.detail.row;

        if(action === 'edit'){
            this.isModal = true;
            this.title = 'Edit Record';
            this.name = row.Name;
            this.description = row.Description__c;
            this.amount = row.Amount__c;
            this.status = row.Status__c;
            this.recId = row.Id;
        }

        if(action === 'delete'){
            deleteRecord({ recId: row.Id })
            .then(()=>{
                this.toast('Deleted','Record deleted','success');
                this.load();
            });
        }
    }

    toast(title,msg,variant){
        this.dispatchEvent(new ShowToastEvent({
            title,
            message: msg,
            variant
        }));
    }
}