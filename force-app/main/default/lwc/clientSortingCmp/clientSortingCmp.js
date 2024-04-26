import { LightningElement,api,wire,track } from 'lwc';
import fetchOppData from '@salesforce/apex/SortingCntrl.fetchOppData';
 const columns = [
        { label: 'Id', fieldName: 'Id', type: 'text',sortable: true},
        { label: 'Name', fieldName: 'Name', type: 'text',sortable: true},
        {label:'Amount',fieldName:'Amount', type:'Number',sortable: true},
    ]
export default class ClientSortingCmp extends LightningElement {
    data=[];
    columns = columns;
    sortedBy;
    sortedDirection;
    @wire(fetchOppData)
    oppDataResponse ({ data, error }) { 
        if (data)
        { 
            
            console.log("Opp data ...", data)
            this.data = data
            console.log('this.data='+this.data)
        } if (error)
        { 
            console.log(error);
        }
    }

    handleSort (event) { 
        console.log("Event detail :", event.detail)
        const { fieldName, sortDirection } = event.detail;
        this.sortedBy = fieldName;
        this.sortedDirection = sortDirection;
        this.sortData(fieldName, sortDirection);
    }

    sortData (field, direction) {
        sortedResult = [...this.data];
        sortedResult.sort((a, b) => { 
            let valueA = a[field];
            let valueB = b[field];
            if (typeof valueA === 'string' && typeof valueB === 'string')
            { 
                valueA = valueA.toLowerCase();
                valueB = valueB.toLowerCase();
            }
            if (valueA > valueB)
            { 
                return direction === 'asc' ? 1 : -1;
            }
            else if (valueA < valueB)
                return direction === 'asc' ? -1 : 1;

            return 0;
        })
        this.data = sortedResult;
    }


}