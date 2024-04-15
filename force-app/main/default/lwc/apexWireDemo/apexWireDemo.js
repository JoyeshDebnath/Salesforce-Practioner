import { LightningElement,wire } from 'lwc';
import getAccountList from '@salesforce/apex/AccountController1.getAccountList';



export default class ApexWireDemo extends LightningElement {
    accountList;
    @wire(getAccountList)
    accounts

    @wire(getAccountList)
    accountsHandler ({ data, error }) { 
        if (data)
        { 
            console.log(data)
            //transform data 
            this.accountList = data.map(item => { 
                let newType = (item.Type === 'Customer - Direct') ? 'Direct' : 'Channel';
                return { ...item, newType };
            })
            console.log("transformed ",this.accountList)
        } if (error)
        { 
            console.log(error);
        }
    }
    
}