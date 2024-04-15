import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class NavigateToRecordPageInViewAndEdit extends NavigationMixin(LightningElement) {

    navigateToRecordPage () { 
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: '0015j00001ACFdQAAX',
                objectApiName: 'Account',
                actionName: 'view',
                
            }
        })
    }

    navigateToRecordPageEditMode () { 
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: '0015j00001ACFdQAAX',
                objectApiName: 'Account',
                actionName:'edit'
            }
        })
    }
}