import { LightningElement } from 'lwc';

export default class C2bParentCompo extends LightningElement {
    showModal=false;
    eventMsg;
    eventId;
    clickHandler(event){
        event.preventDefault();
        this.showModal=true; 
    }

    closeHandler(event){
        this.eventMsg=event.detail["msg"];
        this.eventId=event.detail["id"]

        this.showModal=false;
    }
}