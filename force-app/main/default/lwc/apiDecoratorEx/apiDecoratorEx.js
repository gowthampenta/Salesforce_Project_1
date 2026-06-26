import { LightningElement, api, track} from 'lwc';
export default class ApiDecoratorEx extends LightningElement {
    @api mobileName = 'Iphone';
    @track customerName = 'Sai';

    handleOnClick(){
        this.mobileName = 'Samsung S25 Ultra';
        this.customerName = 'Gowtham';
    }
}