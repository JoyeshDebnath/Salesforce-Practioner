import { LightningElement } from 'lwc';

export default class Template3Demo extends LightningElement {
    title='Lightning Web Component'
    selectedBtn='OFF';

    get boxStatus(){
       return this.selectedBtn==='ON'?'box green':'box red'
    }


    get getTitle(){
        return this.title.toUpperCase();
    }


    clickHandler(event){
        event.preventDefault();
        console.log(event.currentTarget.innerText);
        this.selectedBtn=event.currentTarget.innerText;
    }
}