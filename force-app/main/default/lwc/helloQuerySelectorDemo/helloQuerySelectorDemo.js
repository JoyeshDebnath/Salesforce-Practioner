import { LightningElement } from 'lwc';

export default class HelloQuerySelectorDemo extends LightningElement {
    nations=['Japan','Korea','India','Switzerland','France'];
    
    fetchDetailHandler(){
        let elem=this.template.querySelector('h1')
        //adding styles dynamically 
        elem.style.border="1px solid red";
    

        const nationElements=this.template.querySelectorAll('.name')
        console.log(elem.innerText);
        Array.from(nationElements).forEach(item=>{
            console.log(item.innerText);
            item.setAttribute("title", item.innerText);
        })
    }

    lwcManualDemoHandler(event){
            event.preventDefault();
            const childElem=this.template.querySelector('.child');
            childElem.innerHTML = `<p>Hi there , I am a child element ..</p>`
    }//lwc:manual Demo 
}