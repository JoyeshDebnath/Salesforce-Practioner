import { LightningElement } from 'lwc';

export default class LifecycleParent extends LightningElement {

    constructor(){
        super();
        console.log("Constructor hook called ")
    }
}