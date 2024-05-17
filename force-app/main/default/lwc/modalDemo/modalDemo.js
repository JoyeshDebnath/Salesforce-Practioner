import { LightningElement } from 'lwc';
import MyModal from 'c/myModal';

export default class ModalDemo extends LightningElement {

    async handleClick () { 
        await MyModal.open({
            size: 'large',
            description: 'Sample Modal Demo',
            content:'Content Coming from Parent ..'
        })
    }
}