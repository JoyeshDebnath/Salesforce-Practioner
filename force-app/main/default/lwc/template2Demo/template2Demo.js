import { LightningElement } from 'lwc';

export default class Template2Demo extends LightningElement {
    showText=false;

    showHandler(event){
       event.preventDefault();
       this.showText=!this.showText;
    }
}