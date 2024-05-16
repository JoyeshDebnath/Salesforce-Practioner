import { LightningElement,track,wire,api } from 'lwc';

export default class SearchComponent_LabOne extends LightningElement {
    @track searchVal="";

    //search 
    handleChange (event) { 
        let value = event.target.value;
        this.searchVal = value;
        //dispatch event 
        const searchEvent = new CustomEvent(
            'search',
            {
                detail: this.searchVal
            }
        )
        this.dispatchEvent(searchEvent);
    }
}