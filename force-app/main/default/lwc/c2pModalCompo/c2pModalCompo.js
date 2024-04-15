import { LightningElement } from 'lwc';

export default class C2pModalCompo extends LightningElement {

    dataPassed = {
        topic: "Data Passing Through Events from child to parent ",
        isHard:false
    }
    closeHandler (event) { 
        console.log('clicked ')
        const myEvent = new CustomEvent('close', {
            detail:this.dataPassed
        });
        this.dispatchEvent(myEvent);
    }
}