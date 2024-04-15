import { LightningElement } from 'lwc';
import { NavigationMixin} from 'lightning/navigation'
export default class NavigateToChatter extends NavigationMixin(LightningElement) {

    navigateToChatter () { 
        this[NavigationMixin.Navigate]({
            type: 'standard__namedPage',
            attributes: {
                pageName:'chatter'
            }
        })
    }
}