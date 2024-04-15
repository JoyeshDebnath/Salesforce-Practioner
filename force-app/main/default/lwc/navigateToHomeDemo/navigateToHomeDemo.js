import { LightningElement } from 'lwc';
import {NavigationMixin} from 'lightning/navigation'

export default class NavigateToHomeDemo extends NavigationMixin(LightningElement) {

    NavigateToHome(event){
        event.preventDefault();
        this[NavigationMixin.Navigate]({
            type:'standard__namedPage',
            attributes:{
                pageName:'home'
            }
        })
    }
}