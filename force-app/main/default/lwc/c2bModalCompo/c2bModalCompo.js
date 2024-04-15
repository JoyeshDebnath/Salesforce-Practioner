import { LightningElement } from 'lwc';

export default class C2bModalCompo extends LightningElement {

    closeHandler(event){
        const closeEvent = new CustomEvent('close',{
            detail:{
                id:1123,
                msg:"Hello From Modal component  !"
            }
        });
        this.dispatchEvent(closeEvent);
    }

    
}