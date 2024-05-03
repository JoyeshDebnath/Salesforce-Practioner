import { LightningElement,wire,api,track } from 'lwc';
import getClosedCases from '@salesforce/apex/closedCaseController.getClosedCases';
import closeSelectedCases from '@salesforce/apex/closedCaseController.closeSelectedCases';

export default class ClosedCases extends LightningElement {

    _cases = [];
    _errors;

    @wire(getClosedCases)
    closedCasesWiredResponse ({ data, error }) { 
        if (data)
        { 
            console.log('Cases data fetched ...' + data);
            this._cases = JSON.parse(JSON.stringify(data));            
        } if (error)
        { 
            console.log(error.getMessage());
        }
    }

    handleClick (event) { 
        event.preventDefault();
        console.log(this._cases)
        
        closeSelectedCases({
            caseString:JSON.stringify(this._cases)
        }).then(res => { 
            console.log('Result : \n ', res);
            window.location.reload();
        }).catch(err => { 
            console.log('Error:',err)
        })
    }

    handleCheckbox (event) { 
        //In javasceript data- is eqv to "dataset" and afterv this whatever we have used :here its "id  ie dataset.id
        //ex:2 : dataset.recordId  --> data-recordId
        
        event.preventDefault();
        let name = event.target.name;
        let checked = event.target.checked;
        let index = event.target.dataset.id;
        alert(index)
        this._cases[index][name] = checked;
    }
}