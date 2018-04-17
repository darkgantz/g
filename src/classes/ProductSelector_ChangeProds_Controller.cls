public class ProductSelector_ChangeProds_Controller {

		public String oppId									{ get; set; }
		public List<OpportunityLineItem> productsAux 		{ get; set; }
		public List<String> columnTitles 					{ get; set; }
		public List<String> fieldNames 						{ get; set; }
		public List<String> fieldTypes 						{ get; set; }
		public List<String> sortOrders 						{ get; set; }
		public List<OppProductWrapper> products 			{ get; set; }
		public Map<Id,OpportunityLineItem> productsAuxMap	{ get; set; }
		private String query 								{ get; set; }
		private String orderByField							{ get; set; }
		private String order								{ get; set; }
 
		/** What we are sorting by */
    	public static String SORT_FIELD = '';
    	public static String SORT_ORDER = '';

		public ProductSelector_ChangeProds_Controller(){

			this.oppId = ApexPages.currentPage().getParameters().get( 'id' );

			//get Product Selector Columns field set to know which are the fields to display
			List<Schema.FieldSetMember> fields = SObjectType.OpportunityLineItem.FieldSets.Product_Selector_ChangeProducts_Columns.getFields();

			this.query = 'Id,Content_Pack__c,Quantity,Modality__c';

			this.columnTitles = new List<String>();
			this.fieldNames   = new List<String>();
			this.fieldTypes   = new List<String>();
			this.sortOrders   = new List<String>();

			for(Schema.FieldSetMember f : fields) {

				if(f.getFieldPath()!='Id' && f.getFieldPath()!='Content_Pack__c' 
					&& f.getFieldPath()!='Quantity' && f.getFieldPath()!='Modality__c'){
					this.query += ',' + f.getFieldPath();
				}

				this.columnTitles.add(f.getLabel());
				this.fieldNames.add(f.getFieldPath());
				this.sortOrders.add('NONE');
				this.fieldTypes.add(String.valueOf(f.getType()));
				
	            
	        }

	        this.productsAux = Database.query('SELECT ' + this.query + ' FROM OpportunityLineItem WHERE OpportunityId=\'' + this.oppId + '\'');  

	        this.productsAuxMap = new Map<Id,OpportunityLineItem>(this.productsAux);

	        this.products = new List<OppProductWrapper>();

	        //populating the product wrapper list
	        for(OpportunityLineItem prod : this.productsAux){

	        	this.products.add( new OppProductWrapper(prod) );

	        }

	        this.order 			= 'DESC';
	        SORT_ORDER 			= 'DESC';
	        this.orderByField 	= 'Product_Name__c';
	        SORT_FIELD 			= 'Product_Name__c'; 

	        this.products.sort();

		}

		public void refreshOppProductList(){

			this.productsAux = Database.query('SELECT ' + this.query + ' FROM OpportunityLineItem WHERE OpportunityId=\'' + this.oppId + '\'');  

			this.productsAuxMap = new Map<Id,OpportunityLineItem>(this.productsAux);

	        this.products = new List<OppProductWrapper>();

	        //populating the product wrapper list
	        for(OpportunityLineItem prod : this.productsAux){

	        	this.products.add( new OppProductWrapper(prod) );

	        }

	        SORT_ORDER = this.order;
	        SORT_FIELD = this.orderByField; 

	        this.products.sort();

		}

		public void sortProductsByField(){

			Integer index = Integer.valueOf(ApexPages.currentPage().getParameters().get( 'columnIndex' ));

			SORT_FIELD = this.fieldNames[index];

			if(sortOrders[index]=='NONE' || this.sortOrders[index]=='ASC')
				SORT_ORDER = 'DESC';
			else
				SORT_ORDER = 'ASC';

			this.order = SORT_ORDER;
			this.orderByField = SORT_FIELD;

			this.sortOrders.set(index, SORT_ORDER);

	        products.sort();

		}

		/** A wrapper class to make product sortable */
   		public class OppProductWrapper implements Comparable {

   			public OpportunityLineItem prod { get; set; }

			/**
	        * Constructor based on an product record
	        *
	        * @param product
	        */
	        public OppProductWrapper(OpportunityLineItem p) {
	            this.prod = p;
	        }

	        /**
	        * Sorts by a dynamic field from the product
	        * 
	        * @return the integer value of the comparison between the objects
	        */
	        public Integer compareTo(Object obj) {

	        	OppProductWrapper pW = (OppProductWrapper) obj;

	        	if(this.prod.get(SORT_FIELD)==null){
	        		if(SORT_ORDER=='ASC')
		               		return 1;
		               	else
		               		return -1;
	        	}else if(pW.prod.get(SORT_FIELD)==null){
	        		if(SORT_ORDER=='ASC')
		               		return -1;
		               	else
		               		return 1;
	        	}

	        	DisplayType fieldType = Schema.SObjectType.OpportunityLineItem.fields.getMap().get(SORT_FIELD).getDescribe().getType();

	        	if( String.valueOf(fieldType).toUpperCase() == 'CURRENCY' || String.valueOf(fieldType).toUpperCase() == 'DOUBLE' || String.valueOf(fieldType).toUpperCase() == 'INTEGER' ){
	        		if ( Integer.valueOf(this.prod.get(SORT_FIELD)) > Integer.valueOf(pW.prod.get(SORT_FIELD)) ) {
		            	if(SORT_ORDER=='ASC')
		               		return -1;
		               	else
		               		return 1;
		            }
        		}else{
        			if ( String.valueOf(this.prod.get(SORT_FIELD)) > String.valueOf(pW.prod.get(SORT_FIELD)) ) {
		            	if(SORT_ORDER=='ASC')
		               		return -1;
		               	else
		               		return 1;
		            }
        		}
	            

	            if (this.prod.get(SORT_FIELD) == pW.prod.get(SORT_FIELD)) {
	                return 0;
	            }

	            if(SORT_ORDER=='ASC')
               		return 1;
               	else
               		return -1;

	        }

   		}

   		public void saveProduct(){

			Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped( ApexPages.currentPage().getParameters().get( 'productInfo' ) );

			Id oppProdId = (Id)m.get('Id');

			OpportunityLineItem oli = this.productsAuxMap.get(oppProdId);

			oli.Description = (String)m.get('LineDescription');
			oli.UnitPrice = Decimal.valueOf((String)m.get('SalesPrice'));
			oli.Quantity = Decimal.valueOf((String)m.get('Quantity'));
			oli.Modality__c = (String)m.get('Modality');

			Savepoint sp = Database.setSavepoint(); 

			try{

				if( m.get('Type')=='Custom Lite' || m.get('Type')=='Custom'  ){
					//create the content pack
					Content_Pack__c cp = [Select Id, Name From Content_Pack__c Where Id=:oli.Content_Pack__c LIMIT 1];
					cp.Name=(String)m.get('LineName');
					update cp;

					List<Object> itemTypes = (List<Object>)m.get('itemTypes');
					Map<String, Object> itemTypeMap = null;

					List<Content_Item__c> lCi = [SELECT Id,Item_Type__c,Content_Pack__c FROM Content_Item__c WHERE Content_Pack__c=:cp.Id];
					Map<String,Content_Item__c> ciMap = new Map<String,Content_Item__c>();
					for(Content_Item__c ci: lCi){
						ciMap.put(ci.Item_Type__c,ci);
					}

					Content_Item__c ci = null;

					for(Object o : itemTypes){
						itemTypeMap = (Map<String, Object>)o;
						if(String.valueOf(itemTypeMap.get('value'))=='true'){

							//formatting due date
							String formattedDueDate = (String)itemTypeMap.get('requestedDueDate');
							if(!String.isEmpty(formattedDueDate)){
								String[] dueDateArray = formattedDueDate.split('/');
								formattedDueDate = dueDateArray[2] + '-' + dueDateArray[0] + '-' + dueDateArray[1];
							}

							if(ciMap.containsKey((String)itemTypeMap.get('id'))){
								//if the content pack already have an item with that type
								ciMap.get((String)itemTypeMap.get('id')).Removed_from_Product_Selector__c=false;
								if(!String.isEmpty(formattedDueDate))
									ciMap.get((String)itemTypeMap.get('id')).Requested_Due_Date__c = Date.valueOf(formattedDueDate);
							}else{
								ci = new Content_Item__c();
								ci.Item_Type__c = (String)itemTypeMap.get('id');
								ci.Content_Pack__c = cp.Id;
								if(!String.isEmpty(formattedDueDate))
									ci.Requested_Due_Date__c = Date.valueOf(formattedDueDate);
								lCi.add( ci );
							}
						}else if(ciMap.containsKey((String)itemTypeMap.get('id'))) {
							//if the content pack already have an item with that type
							ciMap.get((String)itemTypeMap.get('id')).Removed_from_Product_Selector__c=true;
						}
					}

					upsert lCi;

				}	

				update oli;

				//this is because we need to update formula fields
				refreshOppProductList();

			}catch( exception e ){
                Database.rollback( sp );   
           		ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage());
   				ApexPages.addMessage(myMsg);
            }
   		}

   		public void deleteProduct(){

   			OpportunityLineItem oli = this.productsAuxMap.get( ApexPages.currentPage().getParameters().get( 'oppProductId' ) );

   			Savepoint sp = Database.setSavepoint(); 

   			try{
   				delete oli;
   				refreshOppProductList();
   			}catch( exception e ){
                Database.rollback( sp );   
           		ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage());
   				ApexPages.addMessage(myMsg);
            }

   		}

   		public List<SelectOption> getContentTypes(){

		   List<SelectOption> options = new List<SelectOption>();
		        
		   Schema.DescribeFieldResult fieldResult = Content_Item__c.Item_Type__c.getDescribe();
		   List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
		        
		   for( Schema.PicklistEntry f : ple)
		   {
		      options.add(new SelectOption(f.getLabel(), f.getValue()));
		   }       
		   return options;

   		} 

   		public List<SelectOption> getModalityOptions(){

		   List<SelectOption> options = new List<SelectOption>();
		        
		   Schema.DescribeFieldResult fieldResult = OpportunityLineItem.Modality__c.getDescribe();
		   List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
		        
		   for( Schema.PicklistEntry f : ple)
		   {
		      options.add(new SelectOption(f.getLabel(), f.getValue()));
		   }       
		   return options;

   		} 


}