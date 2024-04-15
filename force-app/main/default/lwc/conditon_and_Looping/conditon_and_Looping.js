/*
    conditional rendering and template looping
*/


import { LightningElement } from 'lwc';

export default class Conditon_and_Looping extends LightningElement {
    isVisible = false;
    typedTxt = '';
    carList = ['Ford', 'Toyota', 'Tata', 'Audi', 'Mercedes'];

    ceoList = [
        {
            id: 1,
            company: 'Google',
            name:'Sundar Pichai'
        },
        {
            id: 2,
            company: 'Apple Inc.',
            name:'Tim Cook'
        },
        {
            id: 3,
            company: 'Facebook',
            name:'Mark Zuckerberg'
        },
        {
            id: 4,
            company: 'Amazon',
            name:'Jeff Bezos'
        },
    ]

    
    handleClick (event) { 
        this.isVisible=!this.isVisible;
    }
    changeHandler (event) { 
        this.typedTxt = event.target.value;
    }

    get checkTypedText () { 
        return (this.typedTxt==='hello') ? true : false;
    }
}