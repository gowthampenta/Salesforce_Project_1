import { LightningElement } from 'lwc';
import { loadScript } from 'lightning/platformResourceLoader';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import xlsx from '@salesforce/resourceUrl/xlsx';
import createAccounts from '@salesforce/apex/Excel_Upload_Controller2.createAccounts';

export default class Upload_account_data extends LightningElement {

    workbookInitialized = false;
    excelData = [];
    isLoading = false;

    renderedCallback() {

        if (this.workbookInitialized) {
            return;
        }

        this.workbookInitialized = true;

        loadScript(
            this,
            xlsx + '/xlsx.full.min.js'
        )
        .then(() => {
            console.log('SheetJS Loaded');
        })
        .catch(error => {
            console.error(error);
        });
    }

    handleFileUpload(event) {

        const file = event.target.files[0];

        if (!file) {
            return;
        }

        const reader = new FileReader();

        reader.onload = (e) => {

            const data = e.target.result;

            const workbook =
                window.XLSX.read(
                    data,
                    {
                        type: 'binary'
                    }
                );

            const sheetName =
                workbook.SheetNames[0];

            const worksheet =
                workbook.Sheets[sheetName];

            this.excelData =
                window.XLSX.utils.sheet_to_json(
                    worksheet
                );

            console.log(
                'Excel Data => ',
                JSON.stringify(
                    this.excelData
                )
            );

            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message:
                        this.excelData.length +
                        ' records loaded from Excel',
                    variant: 'success'
                })
            );
        };

        reader.readAsBinaryString(file);
    }

    createRecords() {

        if (
            !this.excelData ||
            this.excelData.length === 0
        ) {

            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message:
                        'Please upload an Excel file first',
                    variant: 'error'
                })
            );

            return;
        }

        this.isLoading = true;

        createAccounts({
            jsonData:
                JSON.stringify(
                    this.excelData
                )
        })
        .then(batchId => {

            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message:
                        'Batch Started Successfully. Batch Id : '
                        + batchId,
                    variant: 'success'
                })
            );

            console.log(
                'Batch Id => ',
                batchId
            );

            this.excelData = [];
        })
        .catch(error => {

            console.error(
                'Error => ',
                error
            );

            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message:
                        error.body
                        ? error.body.message
                        : 'Unexpected Error',
                    variant: 'error'
                })
            );
        })
        .finally(() => {

            this.isLoading = false;

        });
    }
}