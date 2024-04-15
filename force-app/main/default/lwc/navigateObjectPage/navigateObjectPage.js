import { LightningElement } from 'lwc';
import { NavigationMixin} from 'lightning/navigation'
import { encodeDefaultFieldValues } from 'lightning/pageReferenceUtils';



export default class NavigateObjectPage extends NavigationMixin(LightningElement) {

    navigateToRecord (event) {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Contact',
                actionName:'new'
            }
        })
    }

    navigateToNewRecordWithDefault (event) { 
        const defaultValues=encodeDefaultFieldValues({
            FirstName: 'Joyesh',
            LastName: 'Debnath',
            LeadSource:'Other',
        })

        this[NavigationMixin.Navigate](
            {
                type: 'standard__objectPage',
                attributes: {
                    objectApiName: 'Contact',
                    actionName: 'new'
                },
                state: {
                    defaultFieldValues:defaultValues
                }
            }
        )
    }

    navigateToListView (event) { 
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Contact',
                actionName:'list'
            },
            state: {
                filterName:'Recent'
            }
        })
    }

    navigateToFile () { 
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'ContentDocument',
                actionName:'home'
            }
        })
    }
}