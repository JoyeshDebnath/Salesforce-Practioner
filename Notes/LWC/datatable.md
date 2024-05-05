# Datatable in LWC 

## Custom Datatypes for Datatable 
- To modify the type we have to define *typeAttributes* and define the necessary attributes there . 
- ![alt text](image.png)

### Apply styles on a column : 
There are 2 methods tp achive this : 
 1. Using *cellAttributes*
    >cellAttributes: {
        class:'slds-theme_shade slds-theme_alert-texture'
    }
 2. USing cell atributes  and use the *fieldNAme* attribute to wire up css classes. 
   > cellAttributes:{
    class : {fieldName:'industryClass'}
   }

   ![alt text](image-1.png)

   ##  Custom Types (Out of box functionailty )
   > Synatx is shown below for the custom types ✍️
   ![alt text](image-2.png)
    ![alt text](image-3.png)

    
    
## Inline Editing  in lightning datatable ✏️✏️

![alt text](image-4.png)




    

