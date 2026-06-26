import { LightningElement,track } from 'lwc';
export default class TrackDecoratorEx2 extends LightningElement {
    @track person = { name: 'Sai', city: 'Hyderabad' };

    changeCity() {
        this.person.city = 'Chennai'; // UI updates now
    }
}