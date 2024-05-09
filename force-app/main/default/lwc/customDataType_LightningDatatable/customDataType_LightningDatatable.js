import LightningDatatable from 'lightning/datatable';
import CustomNameTemplate from './customName.html';
import CustomPrictureTemplate from './customPircture.html';
import CustomRankTemplate from './customRank.html';

export default class CustomDataType_LightningDatatable extends LightningDatatable {
    static customTypes={
        customName:{
            template:CustomNameTemplate,
            standardCellLayout:true,
            typeAttributes:['accountName'],
        },
        customRank:{
            template:CustomRankTemplate,
            standardCellLayout:false,
            typeAttributes:['rankIcon']
        },
        customPicture:{
            template:CustomPrictureTemplate,
            standardCellLayout:false,
            typeAttributes:['pictureUrl']
        }
    }

}