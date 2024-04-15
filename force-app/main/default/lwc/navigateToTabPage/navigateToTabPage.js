import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class NavigateToTabPage extends NavigationMixin(LightningElement) {

    navigateToTab (event) { 
        this[NavigationMixin.Navigate]({
            type: 'standard__navItemPage',
            attributes: {
                apiName: 'Lightning_Intro_Topics',
                
            }
        })
    }
}