import { LightningElement } from 'lwc';

export default class FirstTestingDemo extends LightningElement {


    firstName = "Abhi";
    lastName = "Shah";
    fullName = this.firstName + " " + this.lastName;

}