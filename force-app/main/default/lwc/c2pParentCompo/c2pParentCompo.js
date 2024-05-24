import { LightningElement,wire,api } from 'lwc';

export default class C2pParentCompo extends LightningElement {
    showModal = false;
    msg;
    modalHandler (event) { 
        this.showModal = true;
    }

    closeHandler (event) { 
        this.msg = event.detail.topic;
        console.log(this.msg);
        this.showModal = false;
    }
}