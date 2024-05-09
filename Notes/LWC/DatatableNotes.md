## Build Datatable With Custom Data types 

For Example To display the images , icons , badge we have to implement our own datataypes . 
Salesforce datatables supports some default datatypes like Text , Email , Phone , etc . To display our custom types we need to implement our own datatypes . 
There are steps to follow to implement the custom datatypes . 

1. Step 1: create CustomDatatable component that will extend Lightning datatable 

Create html file for each custom types.  

```js
 import LightningDatatble from 'lightning/datatble';
 import CustomNameTemplate from './customName.html';
 import CustomNumberTemplate from './customNumber.html';

 export default class MyCustomDatatable extends LightningDatatable{
     static customTypes={
        customName:{
            template:CustomNameTemplate,
            standardCellLayout:true,
            typeAttributes:['accountName']
        },
        customNumber:{
            template:CustomNumberTemplate,
            standardCellLayout:false,
            typeAttributes:['status']
        }
     }
 }
```


2. **Applying Styles on Columns**
   - to Apply Styling to all rows in a column , pass the css Classes to cellAttributes . 
  ```js
  const COLS={
    label:'Employeees',
    type:'number',
    fieldName:'NumberOfEmployees',
    cellAttributes:{
        class:'slds-theme_shade slds-theme_alert-texture'
    }
  }
  ```

  - To apply styling to particular rows use the fieldName attributes to wire up CSS classes 
  ```js
  const COLS={
    label:'Industry',
    fieldName:'Industry',
    cellAttributes:{
        fieldName:'industryClassCss'
    }
  }
  ```

  this second approach can be used to apply conditional styling . 

  ## Inline Editing in Lightning - datatable 🧪
  - specify which fields are editable by mentioning *editable:true* 
  - Clicking the Save button triggers the Save event. 
  - When the user edits a cell , the updated value is stored in the draft-values. 

```html
 <template>
        <lightning-card >
            <lightning-datatable
                key-field="Id"
                data={data}
                columns={columns}
                onsave={handleSave}
                draft-values={draftValues}
            >

            </lightning-datatable>
        </lightning-card>
 </template>
```

