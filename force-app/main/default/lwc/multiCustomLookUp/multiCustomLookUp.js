import { LightningElement,api,wire } from 'lwc';
import fetchLookUpData from '@salesforce/apex/CustomLookUpController.fetchLookUpData';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class MultiCustomLookUp extends LightningElement {
    searchKey;
    hasRecords = false;//checks if there are more than or equal to 1 records or not....  
    searchOutput=[];//an array  that will contan all the records provided by our search query ./.. 
    @api objectApiName = 'Account';//this is a generic SObject name can be supplied from  the record page 
    @api label = 'Account';//generic label 
    @api placeholder = 'Search Account';//generic placeholder
    DELAY = 300;//300 milliseconds  
    delayTimeOut;//holds the settimeout value in it ... 
    @api iconName = 'standard:account';
    selectedRecords = [];//pills array for the selected items pill 
    
    get showPillContainer () { 
        return  this.selectedRecords.length>0 ?true:false
    }
    //Invoke the method ,, pass the parameter 
    @wire(fetchLookUpData, {
        searchKey: "$searchKey",
        objectApiName: "$objectApiName"
    })
    searchResult ({ data, error }) { 
        if (data)
        { 
            console.log(data);
            //check the length of data 
            this.hasRecords = (data.length > 0) ? true : false;
            this.searchOutput = data;
            return;
        }
        if (error)
        { 
            console.log(error); 
        }
    }

    //change hanldeer 
    //Logic : As user types something the value will be captured and set to searchKey with some delay . After the delay the Wire will be called 
    // 
    changeHandler (event) { 
        // clearTimeout(this.delayTimeOut);//clear the settimeout for the next entry of search key character .
        
        let value = event.target.value;
        console.log(event.target.value);
        //Delay 
        //We are storing the timeout function in a variable ..  Why? after every enter in serach we want to clear that value in timeout .. 
        
        // this.delayTimeOut = setTimeout(() => { 
            this.searchKey = value;
        // },DELAY)

    }

    //select handler for search items 
    clickHandler (event) {
        let recid = event.target.getAttribute('data-recid');
        console.log("recid", recid)
        //ass soon as the user made selection we have the recid with uis 
        //we can use this rec  id to checkj if the dupolicate esists or not 
        if (this.validateDuplicates(recid))
        { 
                let selectedRecord=this.searchOutput.find(currItem => currItem.Id === recid);
                    //based on selection you have to prepare the pill item for the display 
                    let pill = {
                        type: 'icon',
                        label: selectedRecord.Name,
                        name: recid,
                        iconName: this.iconName,
                        alternativeText: selectedRecord.Name,
                    }
                    //add the pill selected in the array of pills 
                    this.selectedRecords = [...this.selectedRecords, pill];
        }
    
    }
    // rermove the items from the pill 
    handleItemRemove(event) {
        const index = event.detail.index;
        this.selectedRecords.splice(index, 1);
    }

    //validate duplicate Entries for the search 
    validateDuplicates (selectedRecordId) { 
        let isValid = true;
        let isRecordAlreadySelected = this.selectedRecords.find(curr => curr.name === selectedRecordId);
        if (isRecordAlreadySelected)
        {
            isValid = false;
            this.dispatchEvent(new ShowToastEvent({
                title: 'Duplicate record Selected ',
                message: 'Duplicate record Selected',
                variant: 'error'
            }))
            return false;
        }else
                return true;
    }

}