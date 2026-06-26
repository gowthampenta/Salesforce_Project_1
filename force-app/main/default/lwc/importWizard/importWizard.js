import { LightningElement } from 'lwc';
import searchUsers from '@salesforce/apex/UserLookupController.searchUsers';
import getUserDetails from '@salesforce/apex/ImportWizardController.getUserDetails';
import getInitiativesByUser from '@salesforce/apex/ImportWizardController.getInitiativesByUser';
import getInitiativeCount from '@salesforce/apex/ImportWizardController.getInitiativeCount';
import createTeamMember from '@salesforce/apex/TeamMemberController.createTeamMember';
import getTeamMembers from '@salesforce/apex/TeamMemberController.getTeamMembers';
import transferTeamMember from '@salesforce/apex/TeamMemberController.transferTeamMember';
import deleteTeamMember from '@salesforce/apex/TeamMemberController.deleteTeamMember';

export default class ImportWizard extends LightningElement {

    currentStep = '1';

    selectedMode = '';
    selectedAction = '';

    selectedUserId;
    selectedInitiativeId;

    userName;
    userEmail;

    initiativeCount = 0;

    initiatives = [];

    showUserSection = false;
    showTeamMemberAction = false;
    showAddModal = false;

    teamMembers = [];
    showTransferGrid = false;
    showTransferPopup = false;
    selectedTeamMemberId;


    newTransferUserId;
    newTransferUserName = '';
    newTransferUserEmail = '';
    transferUsers = [];
    transferUserSearch = '';


    teamMemberAction = '';

    showTargetUserLookup = false;
    showConfirmButton = false;

    targetUserSearch = '';

    //selectedTargetUserId;

    discipline = '';

    allocation = 100;

    targetUsers = [];

    selectedTargetUserId;

    targetUserName = '';

    targetUserEmail = '';

    selectedInitiativeName = '';


    showTransferTable = false;

    showDeleteTable = false;
    

    modeOptions = [
        {
            label: 'Single/Multiple Record Update',
            value: 'single'
        },
        {
            label: 'Bulk Record Upload',
            value: 'bulk'
        }
    ];

    actionOptions = [
        {
            label:'Update Owner Of Initiatives/Workstream',
            value:'owner'
        },
        {
            label:'Update Approver Of Initiatives/Workstream',
            value:'approver'
        },
        {
            label:'Add and Remove Team members from the Initiative',
            value:'teamMember'
        }
    ];

    teamMemberOptions = [
    {
        label: 'Add',
        value: 'add'
    },
    {
        label: 'Transfer',
        value: 'transfer'
    },
    {
        label: 'Delete',
        value: 'delete'
    }
    ];


    columns = [
       {
          label:'Initiative Name',
          fieldName:'Name'
       },
       {
          label:'Phase',
          fieldName:'Phase__c'
       },
       {
          label:'Status',
          fieldName:'Status__c'
       }
    ];


    teamMemberColumns = [
      {
         label: 'Team Member Name',
         fieldName: 'Name'
      },
      {
         label: 'Discipline',
         fieldName: 'Discipline__c'
      },
      {
         label: 'Initiative',
         fieldName: 'initiativeName'
      },
      {
         label: 'Resource Time Allocation (%)',
         fieldName: 'Resource_Time_Allocation__c'
      }
     ,
      {
         type: 'button',
         typeAttributes: {
         label: 'Transfer',
         name: 'transfer',
         variant: 'brand'
      }
      },
      {
        type:'button',
        typeAttributes:{
        label:'Delete',
        name:'delete',
        variant:'destructive'
    }
}

];


   // transfer column

    transferColumns = [

{
    label:'Team Member Name',
    fieldName:'Name'
},
{
    label:'Discipline',
    fieldName:'Discipline__c'
},
{
    label:'Initiative',
    fieldName:'initiativeName'
},
{
    label:'Resource Time Allocation (%)',
    fieldName:'Resource_Time_Allocation__c'
},
{
    type:'button',
    typeAttributes:{
        label:'Transfer',
        name:'transfer',
        variant:'brand'
    }
}

];



    deleteColumns = [

{
    label:'Team Member Name',
    fieldName:'Name'
},
{
    label:'Discipline',
    fieldName:'Discipline__c'
},
{
    label:'Initiative',
    fieldName:'initiativeName'
},
{
    label:'Resource Time Allocation (%)',
    fieldName:'Resource_Time_Allocation__c'
},
{
    type:'button',
    typeAttributes:{
        label:'Delete',
        name:'delete',
        variant:'destructive'
    }
}

];

    get disableContinueStep1() {
         return !this.selectedMode;
    }

    get disableContinueStep2(){

    return !this.selectedAction ||
           !this.selectedUserId;
    }

    handleFinish() {

    this.dispatchEvent(
        new CustomEvent('close')
    );

}

    get isStep1() {
        return this.currentStep === '1';
    }

    get isStep2() {
        return this.currentStep === '2';
    }

    get isStep3() {
        return this.currentStep === '3';
    }

    handleModeChange(event) {
        this.selectedMode = event.detail.value;
    }

    handleAction(event) {

    this.selectedAction = event.detail.value;

    this.showTeamMemberAction = false;
    this.showTargetUserLookup = false;
    this.showConfirmButton = false;
    }

    handleContinue() {

        if (this.currentStep === '1') {

            if (!this.selectedMode) {
                return;
            }

            this.currentStep = '2';
        }
        else if (this.currentStep === '2') {

            if (!this.selectedAction) {
                return;
            }

            this.currentStep = '3';
        }
    }

    handleClose() {

        this.dispatchEvent(
            new CustomEvent('close')
        );

    }

    handleBack() {

    if (this.currentStep === '2') {
        this.currentStep = '1';
    }
    else if (this.currentStep === '3') {
        this.currentStep = '2';
    }

}

users = [];
searchKey = '';

handleSearch(event) {

    this.searchKey = event.target.value;

    if(this.searchKey.length < 2){
        this.users = [];
        return;
    }

    searchUsers({
        searchText : this.searchKey
    })
    .then(result => {
        this.users = result;
    });
}

selectUser(event){

    this.selectedUserId =
        event.currentTarget.dataset.id;

    this.searchKey =
        event.currentTarget.dataset.name;

    this.users = [];

    this.loadUserData();
}

loadUserData(){

    getUserDetails({
        userId:this.selectedUserId
    })
    .then(result=>{

        this.userName = result.Name;

        this.userEmail = result.Email;

        this.showUserSection = true;
    });

    getInitiativesByUser({
        userId:this.selectedUserId
    })
    .then(result=>{

        this.initiatives = result;
    });

    getInitiativeCount({
        userId:this.selectedUserId
    })
    .then(result=>{

        this.initiativeCount = result;
    });
}
    
   

   handleInitiativeSelection(event) {

    const selectedRows = event.detail.selectedRows;

    if (selectedRows.length > 0) {

        this.selectedInitiativeId = selectedRows[0].Id;
        this.selectedInitiativeName = selectedRows[0].Name;

        // Reset UI whenever initiative changes
        this.showConfirmButton = false;

        this.selectedTargetUserId = null;
        this.targetUserName = '';
        this.targetUserEmail = '';
        this.targetUserSearch = '';
        this.targetUsers = [];

        this.showTransferTable = false;
        this.showDeleteTable = false;
        this.showTargetUserLookup = false;

        if (this.selectedAction === 'teamMember') {

            this.showTeamMemberAction = true;

            this.refreshTeamMembers();

        }

    }

}


/*
    handleInitiativeSelection(event) {

    const selectedRows = event.detail.selectedRows;

    if(selectedRows.length > 0) {

        this.selectedInitiativeId =
            selectedRows[0].Id;

        this.selectedInitiativeName =
            selectedRows[0].Name;

        if(this.selectedAction === 'teamMember') {

            this.showTeamMemberAction = true;

        }
    }
}

*/

   handleTeamMemberAction(event) {

    this.teamMemberAction = event.detail.value;

    // Reset all UI
    this.showTargetUserLookup = false;
    this.showTransferTable = false;
    this.showDeleteTable = false;
    this.showConfirmButton = false;

    // Clear selected target user
    this.selectedTargetUserId = null;
    this.targetUserName = '';
    this.targetUserEmail = '';
    this.targetUserSearch = '';
    this.targetUsers = [];

    if (this.teamMemberAction === 'add') {

        this.showTargetUserLookup = true;

    }
    else if (this.teamMemberAction === 'transfer') {

        this.showTransferTable = true;

    }
    else if (this.teamMemberAction === 'delete') {

        this.showDeleteTable = true;

    }

}


   /*
   handleTargetUserSearch(event) {

    this.targetUserSearch =
        event.target.value;

    if(this.targetUserSearch &&
       this.targetUserSearch.length > 2) {

        this.showConfirmButton = true;

    } else {

        this.showConfirmButton = false;

    }
}
*/


    handleTargetUserSearch(event) {

    this.targetUserSearch =
        event.target.value;

    if(this.targetUserSearch.length < 2){

        this.targetUsers = [];

        return;
    }

    searchUsers({

        searchText : this.targetUserSearch

    })
    .then(result => {

        this.targetUsers = result;

    });
}

    openAddTeamMemberModal() {

    this.showAddModal = true;

}


    closeAddModal() {

    this.showAddModal = false;

}

    
    disciplineOptions = [
{
    label:'Developer',
    value:'Developer'
},
{
    label:'Business Analyst',
    value:'Business Analyst'
},
{
    label:'Project Manager',
    value:'Project Manager'
},
{
    label:'Architect',
    value:'Architect'
},
{
    label:'Tester',
    value:'Tester'
},
{
    label:'Admin',
    value:'Admin'
}
];

    handleDiscipline(event) {

          this.discipline = event.detail.value;
}

    handleAllocation(event) {

        this.allocation =  event.target.value;
}


    saveTeamMember() {

    if (!this.selectedTargetUserId) {

        alert('Please select a Team Member');
        return;
    }

    if (!this.discipline) {

        alert('Please select Discipline');
        return;
    }

    createTeamMember({

        userId: this.selectedTargetUserId,
        initiativeId: this.selectedInitiativeId,
        discipline: this.discipline,
        allocation: this.allocation

    })
    .then(() => {

        this.showAddModal = false;

        // Reset Add UI
        this.showConfirmButton = false;

        this.selectedTargetUserId = null;
        this.targetUserName = '';
        this.targetUserEmail = '';
        this.targetUserSearch = '';
        this.targetUsers = [];

        this.refreshTeamMembers();

        alert('Team Member Added Successfully');

    })
    .catch(error => {

        console.error(error);

    });

}
    selectTargetUser(event) {

    this.selectedTargetUserId =
        event.currentTarget.dataset.id;

    this.targetUserName =
        event.currentTarget.dataset.name;

    this.targetUserEmail =
        event.currentTarget.dataset.email;

    this.targetUserSearch =
        this.targetUserName;

    this.targetUsers = [];

    this.showConfirmButton = true;

}



    get showConfirmAddButton() {

    return this.teamMemberAction === 'add' && this.selectedTargetUserId;

    }
   

   // Transfer

    handleTransferRow(event) {

    const actionName =
        event.detail.action.name;

    const row =
        event.detail.row;

    this.selectedTeamMemberId =
        row.Id;

    if(actionName === 'transfer') {

        this.showTransferPopup = true;
    }

    else if(actionName === 'delete') {

        this.deleteMember(row.Id);
    }
    
    }



   /*

    handleTransferRow(event) {

    const row = event.detail.row;

    this.selectedTeamMemberId =  row.Id;

    this.showTransferPopup = true;

    }

    */

    
    handleTransferUserSearch(event){

    this.transferUserSearch =
        event.target.value;

    if(this.transferUserSearch.length < 2){

        this.transferUsers = [];

        return;
    }

    searchUsers({
        searchText : this.transferUserSearch
    })
    .then(result => {

        this.transferUsers = result;

    });
}


    selectTransferUser(event){

    this.newTransferUserId =
        event.currentTarget.dataset.id;

    this.newTransferUserName =
        event.currentTarget.dataset.name;

    this.newTransferUserEmail =
        event.currentTarget.dataset.email;

    this.transferUserSearch =
        this.newTransferUserName;

    this.transferUsers = [];
}


    closeTransferPopup(){

    this.showTransferPopup = false;
}


    confirmTransfer() {

    if (!this.newTransferUserId) {

        alert('Please select a Team Member.');

        return;
    }

    transferTeamMember({

        teamMemberId: this.selectedTeamMemberId,

        newUserId: this.newTransferUserId

    })
    .then(() => {

        // Close Transfer Popup
        this.showTransferPopup = false;

        // Clear selected user details
        this.newTransferUserId = null;
        this.newTransferUserName = '';
        this.newTransferUserEmail = '';
        this.transferUserSearch = '';
        this.transferUsers = [];

        // Refresh Team Members Datatable
        this.refreshTeamMembers();

        alert('Team Member Transferred Successfully');

    })
    .catch(error => {

        console.error('Transfer Error', error);

        alert('Error while transferring Team Member');

    });

}



/*


    confirmTransfer(){

    if(!this.newTransferUserId){

        alert('Please select a user');

        return;
    }

    transferTeamMember({

        teamMemberId :
            this.selectedTeamMemberId,

        newUserId :
            this.newTransferUserId

    })

    .then(() => {

        alert('Transfer Successful');

        this.showTransferPopup = false;

        return getTeamMembers({
            initiativeId :
                this.selectedInitiativeId
        });

    })
    .then(result => {

    this.teamMembers = result.map(record => {

        return {

            ...record,

            userName:
                record.User__r
                ? record.User__r.Name
                : '',

            initiativeName:
                record.Initiative__r
                ? record.Initiative__r.Name
                : ''
        };

    }
    
    
    );

}).catch(error => {

        console.error(error);

    });
}


*/



   
   //delete


    deleteMember(teamMemberId){

    if(!confirm('Are you sure you want to delete this Team Member?')){
        return;
    }

    deleteTeamMember({
        teamMemberId : teamMemberId
    })
    .then(() => {

        // Immediately remove row from UI
        this.teamMembers =
            this.teamMembers.filter(
                item => item.Id !== teamMemberId
            );

        alert('Team Member Deleted');

        // Refresh from database
        return getTeamMembers({
            initiativeId : this.selectedInitiativeId
        });

    })
    .then(result => {

        // Force datatable refresh
        this.teamMembers = [...result];

    })
    .catch(error => {

        console.error(error);

        alert('Error deleting Team Member');

    });
}

   /*

   deleteMember(teamMemberId){

    if(!confirm('Are you sure you want to delete this Team Member?')){

        return;
    }

    deleteTeamMember({
        teamMemberId : teamMemberId
    })
    .then(() => {

        alert('Team Member Deleted');

        return getTeamMembers({
            initiativeId :
                this.selectedInitiativeId
        });
    })
    .then(result => {

        this.teamMembers = result;
    })
    .catch(error => {

        console.error(error);
    });
}

*/




    // refresh team members

refreshTeamMembers() {

    getTeamMembers({
        initiativeId: this.selectedInitiativeId
    })
    .then(result => {

        console.log('Team Members:', result);

        this.teamMembers = result;

    })
    .catch(error => {

        console.error('Refresh Error', error);

    });

}
    



  


}