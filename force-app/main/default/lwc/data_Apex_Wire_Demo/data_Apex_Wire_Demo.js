import { LightningElement,wire,api,track } from 'lwc';
import getAllCases from '@salesforce/apex/CaseController.getAllCases';

export default class Data_Apex_Wire_Demo extends LightningElement {
    caseData;
    @track subject;
    @track searchKey
    @wire(getAllCases, {subject:'$subject'})
    caseResponse ({ data, error }) { 
        if (data)
        { 
            this.caseData = JSON.parse(JSON.stringify(data))
            console.log(this.caseData);
        }
        if (error)
        { 
            console.log(error);
        }
    }

    handleChange (event) { 
        this.subject = event.target.value;
    }
}