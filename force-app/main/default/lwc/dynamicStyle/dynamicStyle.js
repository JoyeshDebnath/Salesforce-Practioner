import { LightningElement } from 'lwc';

export default class DynamicStyle extends LightningElement {

    percent=10;

    get percentage(){
        return `width:${this.percent}`;
    }
    
    changeHandler(event){
        event.preventdefault();
        this.percent=event.target.value;

    }//changeHandlert
}