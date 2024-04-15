import { LightningElement } from 'lwc';

export default class AccessElementDemo extends LightningElement {
    userNames = ['nick', 'smith', 'Lana'];
    fetchDetailsHandler (event) {
        const elem = this.template.querySelector('h1')
        elem.style.border = "1px solid red";
        console.log(elem.innerText);


        const elems = this.template.querySelectorAll('.name');
        Array.from(elems).forEach(item => { 
            console.log(item.innerText);
            item.setAttribute("title",item.innerText)
        })

        //lwc:manual  demo .. 
        const childElement = this.template.querySelector('.child');
        childElement.innerHTML="<p>Hey I am a Child</p>"
    }


}