public class ProductSelector_AddProducts_Controller {
		public Opportunity opp                      { get; set; }
		public String oppId							{ get; set; }
		public List<Product2> productsAux 			{ get; set; }
		public List<String> columnTitles 			{ get; set; }
		public List<String> fieldNames 				{ get; set; }
		public List<String> fieldTypes 				{ get; set; }
		public List<String> sortOrders 				{ get; set; }
		public List<ProductWrapper> products 		{ get; set; }
    	public List<ProductWrapper> productsEscaped	{ get; set; } //created to escape the ' in the names
		private String query						{ get; set; }

		private String orderByField					{ get; set; }
		private String order						{ get; set; }

		/** What we are sorting by */
    	public static String SORT_FIELD = '';	
    	public static String SORT_ORDER = '';			

		public ProductSelector_AddProducts_Controller(){

			this.oppId = ApexPages.currentPage().getParameters().get( 'id' );
			this.opp   = [SELECT Id, Name, Amount, Pricebook2Id FROM Opportunity WHERE Id=:this.oppId LIMIT 1];

			//get Product Selector Columns field set to know which are the fields to display
			List<Schema.FieldSetMember> fields = SObjectType.Product2.FieldSets.Product_Selector_Columns.getFields();

			query = 'Id';

			this.columnTitles = new List<String>();
			this.fieldNames   = new List<String>();
			this.sortOrders   = new List<String>();
			this.fieldTypes   = new List<String>();

			for(Schema.FieldSetMember f : fields) {

				if(f.getFieldPath()!='Id'){
					query += ',' + f.getFieldPath();
				}

				this.columnTitles.add(f.getLabel());
				this.fieldNames.add(f.getFieldPath());
				this.sortOrders.add('NONE');
				this.fieldTypes.add(String.valueOf(f.getType()));
	            
	        }

	        if(!String.isEmpty(this.opp.Pricebook2Id)){
		        query += ',(Select UnitPrice From PricebookEntries WHERE Pricebook2Id=\'' + this.opp.Pricebook2Id + '\')';
		        this.columnTitles.add('List Price');
				this.fieldNames.add('PricebookEntries');
				this.sortOrders.add('NONE');
				this.fieldTypes.add('currency');

				this.productsAux = Database.query('SELECT ' + query + ' FROM Product2 WHERE IsActive=true'); 

				this.order 			= 'DESC';
				this.orderByField 	= 'Name';
				createProductsList();
			}else{
				ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'This Opportunity hasn\'t got a Pricebook assigned.');
   				ApexPages.addMessage(myMsg);
			}

		}
		
		private void createProductsList(){

	        this.products = new List<ProductWrapper>();
            this.productsEscaped = new List<ProductWrapper>();

	        //populating the product wrapper list
	        for(Product2 prod : this.productsAux){
	        	//just add the products that belong to the pricebook related with the opportunity
                if(prod.PricebookEntries.size()>0){
	        		this.products.add( new ProductWrapper(prod) );
                	
                	//escape the ' to \'
                	Product2 prodEscaped = prod.clone(true,true,false,false);
                    prodEscaped.Name = prod.Name.replaceAll('\'', '\\\\\'');
	        		this.productsEscaped.add( new ProductWrapper(prodEscaped) );
                }
	        }

	        SORT_ORDER 	= this.order ;
	        SORT_FIELD	= this.orderByField; 

	        this.products.sort();
            this.productsEscaped.sort();
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
            productsEscaped.sort();

		}

		/** A wrapper class to make product sortable */
   		public class ProductWrapper implements Comparable {

   			public Product2 prod { get; set; }

			/**
	        * Constructor based on an product record
	        *
	        * @param product
	        */
	        public ProductWrapper(Product2 p) {
	            this.prod = p;
	        }

	        /**
	        * Sorts by a dynamic field from the product
	        * 
	        * @return the integer value of the comparison between the objects
	        */
	        public Integer compareTo(Object obj) {

	        	ProductWrapper pW = (ProductWrapper) obj;

	        	if(SORT_FIELD!='PricebookEntries'){

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

		            if (String.valueOf(this.prod.get(SORT_FIELD)) > String.valueOf(pW.prod.get(SORT_FIELD))) {
		            	if(SORT_ORDER=='ASC')
		               		return -1;
		               	else
		               		return 1;
		            }

		            if (this.prod.get(SORT_FIELD) == pW.prod.get(SORT_FIELD)) {
		                return 0;
		            }

		            if(SORT_ORDER=='ASC')
		           		return 1;
		           	else
		           		return -1;

		        }else{

		        	if (Integer.valueOf(this.prod.PricebookEntries[0].UnitPrice) > Integer.valueOf(pW.prod.PricebookEntries[0].UnitPrice)) {
		            	if(SORT_ORDER=='ASC')
		               		return -1;
		               	else
		               		return 1;
		            }

		            if (this.prod.PricebookEntries[0].UnitPrice == pW.prod.PricebookEntries[0].UnitPrice) {
		                return 0;
		            }

		            if(SORT_ORDER=='ASC')
		           		return 1;
		           	else
		           		return -1;

		        }

	        }

   		}

   		public void filterProducts(){

   			Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped( ApexPages.currentPage().getParameters().get( 'filteringOptions' ) );

   			String whereStr = 'IsActive=true ';
 
   			if(String.isEmpty((String)m.get('ByField')) == false){
   				if  ((m.get('Comparator')!='true' && m.get('Comparator')!='false') && String.isEmpty((String)m.get('Text'))){
   					ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Required fields in filter are missing.');
   					ApexPages.addMessage(myMsg);
   				}else if(m.get('Comparator')=='e'){
	   				whereStr += ' AND ' + m.get('ByField') + '=' + '\'' + m.get('Text') + '\'';
	   			}else if(m.get('Comparator')=='n'){
	   				whereStr += ' AND ' + m.get('ByField') + '!=' + '\'' + m.get('Text') + '\'';
	   			}else if(m.get('Comparator')=='s'){
	   				whereStr += ' AND ' + m.get('ByField') + ' LIKE \'' + m.get('Text') + '%\'';
	   			}else if(m.get('Comparator')=='c'){
	   				whereStr += ' AND ' + m.get('ByField') + ' LIKE \'%' + m.get('Text') + '%\'';
	   			}else if(m.get('Comparator')=='k'){
	   				whereStr += ' AND (NOT ' + m.get('ByField') + ' LIKE \'%' + m.get('Text') + '%\')';
	   			}else if(m.get('Comparator')=='l'){
	   				whereStr += ' AND ' + m.get('ByField') + '<' + '\'' + m.get('Text') + '\'';
	   			}else if(m.get('Comparator')=='g'){
	   				whereStr += ' AND ' + m.get('ByField') + '>' + '\'' + m.get('Text') + '\'';
	   			}else if(m.get('Comparator')=='m'){
	   				whereStr += ' AND ' + m.get('ByField') + '<=' + '\'' + m.get('Text') + '\'';
	   			}else if(m.get('Comparator')=='h'){
	   				whereStr += ' AND ' + m.get('ByField') + '>=' + '\'' + m.get('Text') + '\'';
	   			}else if(m.get('Comparator')=='true'){
	   				whereStr += ' AND ' + m.get('ByField') + '= TRUE';
	   			}else if(m.get('Comparator')=='false'){
	   				whereStr += ' AND ' + m.get('ByField') + '= FALSE';
   				}
   			}else{
   				whereStr += ' AND (Name Like \'%' + m.get('ByNameOrCode') + '%\' OR ProductCode Like \'%' + m.get('ByNameOrCode') + '%\')';
   			}

   			this.productsAux = Database.query('SELECT ' + query + ' FROM Product2 WHERE ' + whereStr);  

	        createProductsList();

   		}

   		public void clearResults(){

   			this.productsAux = Database.query('SELECT ' + query + ' FROM Product2 WHERE IsActive=true');  

	        createProductsList();

   		}

   		public List<FieldSetMember> getSearchByFieldOptions(){

   			List<FieldSetMember> options = new List<FieldSetMember>();

			//get Product Selector Columns field set to know which are the fields to display
			List<Schema.FieldSetMember> fields = SObjectType.Product2.FieldSets.Product_Filter_By_Field.getFields();

			for(Schema.FieldSetMember f : fields) {
				options.add( f); 
	        }

	        return options;

   		}

   		public List<SelectOption> getSearchComparatorOptions(){

   			List<SelectOption> options = new List<SelectOption>();

   			 options.add(new SelectOption('e','equals'));
			 options.add(new SelectOption('n','not equal to'));
			 options.add(new SelectOption('s','starts with'));
			 options.add(new SelectOption('c','contains'));
			 options.add(new SelectOption('k','does not contain'));
			 options.add(new SelectOption('l','less than'));
			 options.add(new SelectOption('g','greater than'));
			 options.add(new SelectOption('m','less or equal'));
			 options.add(new SelectOption('h','greater or equal'));

	        return options;

   		}

   		public void addProduct(){

			Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped( ApexPages.currentPage().getParameters().get( 'productInfo' ) );

			Id prod2Id = (Id)m.get('Id');

			List<PriceBookEntry> priceBookList = [SELECT Id, Product2Id, Product2.Id, Pricebook2Id, Product2.Name FROM PriceBookEntry WHERE Product2Id=:prod2Id AND Pricebook2Id=:this.opp.Pricebook2Id LIMIT 1];

			OpportunityLineItem oli = new OpportunityLineItem(OpportunityId=this.oppId);
			String lineDescription = (String)m.get('LineDescription'); 
			oli.PricebookEntryId = priceBookList.get(0).Id;
			oli.Description = lineDescription;
			oli.UnitPrice = Decimal.valueOf((String)m.get('SalesPrice'));
			oli.Quantity = Decimal.valueOf((String)m.get('Quantity'));
			oli.Modality__c = (String)m.get('Modality');
			oli.Type__c = (String)m.get('Type');

			Savepoint sp = Database.setSavepoint(); 

			try{

				if( m.get('Type')=='Custom Lite' || m.get('Type')=='Custom'  ){
					//create the content pack
					Content_Pack__c cp = new Content_Pack__c(Name=(String)m.get('LineName'), Opportunity__c = this.oppId, Special_Formatting_Instructions__c = lineDescription);
					
					List<Object> itemTypes = (List<Object>)m.get('itemTypes');
					
					Date minRequestDueDate =  this.getMinRequestedDueDate(itemTypes);
					
					if(minRequestDueDate != null){
						cp.Requested_Due_Date__c = minRequestDueDate;
					}
					insert cp;
					
					Map<String, Object> itemTypeMap = null;
					List<Content_Item__c> lCi = new List<Content_Item__c>();
					Content_Item__c ci = null;
					
					for(Object o : itemTypes){
						itemTypeMap = (Map<String, Object>)o;
						String formattedDueDate = (String)itemTypeMap.get('requestedDueDate');
						if(String.valueOf(itemTypeMap.get('value'))=='true'){
							ci = new Content_Item__c();
							ci.Item_Type__c = (String)itemTypeMap.get('id');
							ci.Content_Pack__c = cp.Id;
							ci.Special_Formatting_Instructions__c = lineDescription;
							//formatting due date
							if(formattedDueDate != ''){
								String[] dueDateArray = formattedDueDate.split('/');
								formattedDueDate = dueDateArray[2] + '-' + dueDateArray[0] + '-' + dueDateArray[1];
								ci.Requested_Due_Date__c = Date.valueOf(formattedDueDate);
							}
							
							lCi.add( ci );
						}
					}
					
					insert lCi;

					oli.Content_Pack__c = cp.Id;
				}	

				insert oli;

				//refresh opportunity
				refreshOpportunity();

			}catch( exception e ){
                Database.rollback( sp );   
           		ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage());
   				ApexPages.addMessage(myMsg);
            }
   		}

   		public void refreshOpportunity(){
   			this.opp   = [SELECT Id, Name, Amount, Pricebook2Id FROM Opportunity WHERE Id=:this.oppId LIMIT 1];
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
   		
   		private Date getMinRequestedDueDate(List<Object> itemTypes){
   			Map<String, Object> itemTypeMap = null;
			Date[] dates = new List<Date>();
			String requestedDueDate;
			for(Object o : itemTypes){
				itemTypeMap = (Map<String, Object>)o;
				requestedDueDate = (String)itemTypeMap.get('requestedDueDate');
				if(String.valueOf(itemTypeMap.get('value'))=='true' && requestedDueDate != ''){
					String formattedDueDate = requestedDueDate;
					String[] dueDateArray = formattedDueDate.split('/');
					dates.add(Date.valueOf(dueDateArray[2] + '-' + dueDateArray[0] + '-' + dueDateArray[1]));
				}
			}
			
			if(dates.size()>0){
				dates.sort();
				return dates[0];	
			}else{
				return null;
			}
   			
   		} 

}