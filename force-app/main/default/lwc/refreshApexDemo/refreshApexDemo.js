//Scenerio : 
/**
 * Show the list of Accounts in a Datatable 
 * Select One Row and Delete it 
 * Refresh the Datatable 
 */

import { LightningElement,wire,api,track } from 'lwc';
import {refreshApex} from '@salesforce/apex';
import {deleteRecord} from 'lightning/uiRecordApi';
import getAccounts from '@salesforce/apex/AccountController.getAllAccounts';

const columns=[
    {label:'Name',fieldName:'Name',type:'text'},
    {label:'Phone',fieldName:'Phone',type:'phone'},
    {label:'Industry',fieldName:'Industry',type:'text'},
]
export default class RefreshApexDemo extends LightningElement {
    accountsData;
    columns=columns;
    selectedRecord;
    wiredAccountList=[];//To hold result for using in refersh  apex 

    @wire(getAccounts)
    wiredAccountsResponse(result){
        this.wiredAccountList=result;//to hold result 

        if(result.data){
            this.accountsData=result.data;
        }
        if(result.error){
            console.log(result.error);
        }
    }

    handleRowSelection(event){
            if(event.detail.selectedRows.length>0){
                    this.selectedRecord=event.detail.selectedRows[0].Id;
            }
    }

    handleDelete(){
            deleteRecord(this.selectedRecord)
            .then(()=>{
                refreshApex(this.wiredAccountList);
            })
            .catch((err)=>{
                console.log(err);
            })
    }
}