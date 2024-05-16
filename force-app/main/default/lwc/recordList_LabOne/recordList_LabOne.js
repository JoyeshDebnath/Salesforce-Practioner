import { LightningElement,api,track } from 'lwc';

export default class RecordList_LabOne extends LightningElement {
    @api record;
    @api iconname;

    handleSelect (event) { 
        //pass the id of the record selected 
        const selectEvent = new CustomEvent(
            'select',
            {
                detail: this.record.Id
            }
        )
        this.dispatchEvent(selectEvent);

    }
}