import { api } from 'lwc';
import LightningModal from 'lightning/modal';

export default class MyModal extends LightningModal {
    @api content;

    handleCancel () { 
        this.close('cancel')
    }

    handleSave () { 
        this.close('save')
    }
}