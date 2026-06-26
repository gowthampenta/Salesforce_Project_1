import { LightningElement, track } from 'lwc';
import getMyInitiatives from '@salesforce/apex/ImportWizardController.getMyInitiatives';

export default class InitiativeManager extends LightningElement {

    @track initiatives = [];

    showImportWizard = false;

    searchText = '';
    selectedRole = 'Owner';
    selectedShow = 'All';
    selectedStatus = '';

    hideConfidential = true;

    pageSize = '10';

    ownerId;

    columns = [
        {
            label:'Initiative Name',
            fieldName:'Name'
        },
        {
            label:'Owner',
            fieldName:'OwnerName'
        },
        {
            label:'Status',
            fieldName:'Status__c'
        }
    ];

    roleOptions = [
        {
            label:'Initiative Owner',
            value:'Owner'
        },
        {
            label:'Approver',
            value:'Approver'
        }
    ];

    showOptions = [
        {
            label:'All',
            value:'All'
        },
        {
            label:'Active',
            value:'Active'
        }
    ];

    statusOptions = [
        {
            label:'On Track',
            value:'On Track'
        },
        {
            label:'Needs Attention',
            value:'Needs Attention'
        }
    ];

    pageSizeOptions = [
        {
            label:'10',
            value:'10'
        },
        {
            label:'25',
            value:'25'
        },
        {
            label:'50',
            value:'50'
        }
    ];

    handleSearch(event){
        this.searchText = event.target.value;
    }

    handleRoleChange(event){
        this.selectedRole = event.detail.value;
    }

    handleShowChange(event){
        this.selectedShow = event.detail.value;
    }

    handleStatusChange(event){
        this.selectedStatus = event.detail.value;
    }

    handleToggle(event){
        this.hideConfidential =
        event.target.checked;
    }

    handlePageSize(event){
        this.pageSize =
        event.detail.value;
    }

    handleOwnerChange(event){
        this.ownerId =
        event.detail.recordId;
    }

    connectedCallback() {
    this.loadRecords();
    }

    loadRecords() {

    getMyInitiatives()
    .then(result => {

        this.initiatives = result.map(record => {

            return {

                Id: record.Id,
                Name: record.Name,
                Status__c: record.Status__c,
                OwnerName: record.Owner__r
                    ? record.Owner__r.Name
                    : ''

            };

        });

        console.log(
            'Initiatives:',
            JSON.stringify(this.initiatives)
        );

    })
    .catch(error => {

        console.error(
            'Error loading initiatives',
            error
        );

    });

}

    exportCSV(){
        console.log('Export');
    }

    openImportWizard(){
       // console.log('Import Clicked');
        this.showImportWizard = true;
    }

    closeImportWizard(){
        this.showImportWizard = false;
    }
}