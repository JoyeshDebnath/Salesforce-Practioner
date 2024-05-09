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
**File to refer:  editdatablePOC**

**We can update the values either using Apex class or By using updateRecord**


## Update Datatable Rows - (Custom Types)

To make your Custom type Editable in lightning datatable , create an additional template to implement the UI for inline Editiing of the data type . 

These high level steps add inline edit capability .
1. create an edit template 
2. Add the edit template to the Custom Type Defination 
3. Make the Custom type editable in the column defination .

- create an Edit template 
  ```html
  <lightning-input
        type='number'
        value={editValue}
        data-inputable="true"
  ></lightning-input>
  ```
**editValue is the current value of the custom cell being edited. The data-inputable="true" attribute is required for accessibility support**

```js
import LightningDatatble from 'lightning/datatble';
 import CustomNumberTemplate from './customNumber.html';
 import CustomNumberEditTemplate from './customNumberEdit.html';

 export default class MyCustomDatatable extends LightningDatatable{
     static customTypes={
        customNumber:{
            template:CustomNumberTemplate,
            editTemplate:customNumberEditTemplate
            standardCellLayout:true,
            typeAttributes:['status','min']
        },
        
     }
 }
```
```js
const COLS=[
    {label:'Employees',type:'customNumber',fieldName:'NumberOfEmployees',editable:true,
    typeAttributes:{
        status:{
            fieldName:'status'
        },
        min:0
    }
    }
]
```