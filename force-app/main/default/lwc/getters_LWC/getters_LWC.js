/*
getters and setters example 
getters --->> always returns a value and its generally the computation or the complex data types which is not allowed in the templates
setters -->> 

*/


import { LightningElement } from 'lwc';

export default class Getters_LWC extends LightningElement {
    users = ["John", "Smith", "Kindle", "Omeggle"];
    num1 = 10;
    num2 = 20;

    get product () { 
        return this.num1 * this.num2;
    }

    get firstUser () { 
        return this.users[0].toUpperCase();
    }
}