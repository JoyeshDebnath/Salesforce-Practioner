import LightningDatatable from 'lightning/datatable';
import CustomNameTemplate from './customName.html';
import CustomPrictureTemplate from './customPircture.html';
import CustomRankTemplate from './customRank.html';
import CustomPicklistTemplate from './customPicklist.html';
import CustomPicklistEditTemplate from './customPicklistEdit.html'
export default class CustomDataType_LightningDatatable extends LightningDatatable {
    static customTypes={
        customName:{
            template:CustomNameTemplate,
            standardCellLayout:true,
            typeAttributes:['contactName'],
        },
        customRank:{
            template:CustomRankTemplate,
            standardCellLayout:false,
            typeAttributes:['rankIcon']
        },
        customPicture:{
            template:CustomPrictureTemplate,
            standardCellLayout:true,
            typeAttributes:['pictureUrl']
        },
        customPicklist:{
            template:CustomPicklistTemplate,
            editTemplate:CustomPicklistEditTemplate,
            standardCellLayout:true,
            typeAttributes:['options','value','context']
        }
    }

}