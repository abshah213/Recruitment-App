import { LightningElement } from 'lwc';

export default class Test extends LightningElement {

    firstName = 'Pinky';
    lastName = 'Patel';
    fullName = this.firstName + ' ' + this.lastName;
}