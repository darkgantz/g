@isTest
private class ProductSelector_Test {

	public static testMethod void test1(){
        
        Test.StartTest();

        Account acc = new Account(Name='Testing Acc');
        insert acc;

        String standardPriceBookId = Test.getStandardPricebookId();
        
        Opportunity opp = new Opportunity(Name ='Testing opp',
				                        AccountID = acc.Id,
				                        StageName = 'Prospecting',
				                        Amount = 0,
				                        //Number_of_Days__c = 10,
				                        CloseDate = System.today(),
				                        RecordTypeId =  Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId());
    	
        opp.PriceBook2Id = standardPriceBookId;
        insert opp;

    	Content_Pack__c cp = new Content_Pack__c(Name='Test Pack');

    	insert cp;

		// set up product2 and Verify that the results are as expected.
		Product2 p2 = new Product2(Name='Test Product',isActive=true);
		insert p2;
		Product2 p3 = new Product2(Name='Test Product 2',isActive=true);
		insert p3;
		Product2 p4 = new Product2(Name='Test Product 2',isActive=true);
		insert p4;
		Product2 p5 = new Product2(Name='A Test Product',isActive=true);
		insert p5;

		// set up PricebookEntry and Verify that the results are as expected.
		PricebookEntry pbe = new PricebookEntry(Pricebook2Id=standardPriceBookId, Product2Id=p2.Id, UnitPrice=99, isActive=true);
		insert pbe;

		// set up PricebookEntry and Verify that the results are as expected.
		PricebookEntry pbe2 = new PricebookEntry(Pricebook2Id=standardPriceBookId, Product2Id=p3.Id, UnitPrice=99, isActive=true);
		insert pbe2;

		// set up PricebookEntry and Verify that the results are as expected.
		PricebookEntry pbe3 = new PricebookEntry(Pricebook2Id=standardPriceBookId, Product2Id=p4.Id, UnitPrice=99, isActive=true);
		insert pbe3;

		// set up PricebookEntry and Verify that the results are as expected.
		PricebookEntry pbe4 = new PricebookEntry(Pricebook2Id=standardPriceBookId, Product2Id=p5.Id, UnitPrice=99, isActive=true);
		insert pbe4;

		// set up OpportunityLineItem and Verify that the results are as expected.
		OpportunityLineItem oli = new OpportunityLineItem(PriceBookEntryId=pbe.Id, OpportunityId=opp.Id, Quantity=1, TotalPrice=99,Content_Pack__c=cp.Id);
		insert oli;

        System.currentPageReference().getParameters().put( 'Id', opp.Id );

        ProductSelector_AddProducts_Controller controller = new ProductSelector_AddProducts_Controller();

        controller.clearResults();
        controller.getSearchByFieldOptions();
        controller.getSearchComparatorOptions();
        controller.getContentTypes();
        controller.getModalityOptions();

        System.currentPageReference().getParameters().put( 'productInfo', '{"Id":"' + p2.Id + '","LineDescription":"testing desc","SalesPrice":"4200.00","Type":"Custom Lite","LineName":"testing name","Modality":"Webinar","Quantity":"1","itemTypes":[{"id":"Content License Workbook","value":true,"requestedDueDate":"04/04/2016"},{"id":"Content Sample","value":true,"requestedDueDate":"04/04/2016"},{"id":"Curriculum","value":false,"requestedDueDate":"04/04/2016"},{"id":"Custom Lite Workbooks","value":false,"requestedDueDate":"04/04/2016"},{"id":"Facilitator Guides","value":true,"requestedDueDate":"04/04/2016"},{"id":"Flyers","value":false,"requestedDueDate":"04/04/2016"},{"id":"Hand Outs","value":false,"requestedDueDate":"04/04/2016"},{"id":"Marketing Blurb","value":false,"requestedDueDate":"04/04/2016"},{"id":"Outline","value":false,"requestedDueDate":"04/04/2016"},{"id":"Previous Workbook Version","value":false,"requestedDueDate":"04/04/2016"},{"id":"RFP","value":false,"requestedDueDate":"04/04/2016"},{"id":"Sales Proposal","value":false,"requestedDueDate":"04/04/2016"},{"id":"Workbooks","value":false,"requestedDueDate":"04/04/2016"},{"id":"Other","value":false,"requestedDueDate":"04/04/2016"}]}' );
        controller.addProduct();
        System.currentPageReference().getParameters().put( 'productInfo', '{"Id":"' + p3.Id + '","LineDescription":"testing desc","SalesPrice":"4200.00","Type":"Custom Lite","LineName":"testing name","Modality":"Webinar","Quantity":"1","itemTypes":[{"id":"Content License Workbook","value":true,"requestedDueDate":"04/04/2016"},{"id":"Content Sample","value":true,"requestedDueDate":"04/04/2016"},{"id":"Curriculum","value":false,"requestedDueDate":"04/04/2016"},{"id":"Custom Lite Workbooks","value":false,"requestedDueDate":"04/04/2016"},{"id":"Facilitator Guides","value":true,"requestedDueDate":"04/04/2016"},{"id":"Flyers","value":false,"requestedDueDate":"04/04/2016"},{"id":"Hand Outs","value":false,"requestedDueDate":"04/04/2016"},{"id":"Marketing Blurb","value":false,"requestedDueDate":"04/04/2016"},{"id":"Outline","value":false,"requestedDueDate":"04/04/2016"},{"id":"Previous Workbook Version","value":false,"requestedDueDate":"04/04/2016"},{"id":"RFP","value":false,"requestedDueDate":"04/04/2016"},{"id":"Sales Proposal","value":false,"requestedDueDate":"04/04/2016"},{"id":"Workbooks","value":false,"requestedDueDate":"04/04/2016"},{"id":"Other","value":false,"requestedDueDate":"04/04/2016"}]}' );
        controller.addProduct();

        System.currentPageReference().getParameters().put( 'filteringOptions' , '{"ByNameOrCode":"","ByField":"Name","Comparator":"e","Text":"Testing","fieldType":"string"}' );
      	controller.filterProducts();
      	System.currentPageReference().getParameters().put( 'filteringOptions' , '{"ByNameOrCode":"","ByField":"Name","Comparator":"n","Text":"Testing","fieldType":"string"}' );
      	controller.filterProducts();
      	System.currentPageReference().getParameters().put( 'filteringOptions' , '{"ByNameOrCode":"","ByField":"Name","Comparator":"s","Text":"Testing","fieldType":"string"}' );
      	controller.filterProducts();
      	System.currentPageReference().getParameters().put( 'filteringOptions' , '{"ByNameOrCode":"","ByField":"Name","Comparator":"c","Text":"Testing","fieldType":"string"}' );
      	controller.filterProducts();
      	System.currentPageReference().getParameters().put( 'filteringOptions' , '{"ByNameOrCode":"","ByField":"Name","Comparator":"k","Text":"Testing","fieldType":"string"}' );
      	controller.filterProducts();
      	System.currentPageReference().getParameters().put( 'filteringOptions' , '{"ByNameOrCode":"","ByField":"Name","Comparator":"l","Text":"Testing","fieldType":"string"}' );
      	controller.filterProducts();
      	System.currentPageReference().getParameters().put( 'filteringOptions' , '{"ByNameOrCode":"","ByField":"Name","Comparator":"g","Text":"Testing","fieldType":"string"}' );
      	controller.filterProducts();
      	System.currentPageReference().getParameters().put( 'filteringOptions' , '{"ByNameOrCode":"","ByField":"Name","Comparator":"m","Text":"Testing","fieldType":"string"}' );
      	controller.filterProducts();
      	System.currentPageReference().getParameters().put( 'filteringOptions' , '{"ByNameOrCode":"","ByField":"Name","Comparator":"h","Text":"Testing","fieldType":"string"}' );
      	controller.filterProducts();

        System.currentPageReference().getParameters().put( 'columnIndex', '1' );
        controller.sortProductsByField();

        System.assertEquals(3,[SELECT ID FROM OpportunityLineItem].size());

        ProductSelector_ChangeProds_Controller controllerCP = new ProductSelector_ChangeProds_Controller();

        controllerCP.getContentTypes();
        controllerCP.getModalityOptions();
        System.currentPageReference().getParameters().put( 'columnIndex', '1' );
        controllerCP.sortProductsByField();

        String oliId = String.valueOf([SELECT Id FROM OpportunityLineItem WHERE PriceBookEntryId=:pbe2.Id LIMIT 1].Id);

        System.currentPageReference().getParameters().put( 'productInfo', '{"Id":"' + oliId + '","LineDescription":"testing desc","SalesPrice":"4200.00","Type":"Custom Lite","LineName":"testing name","Modality":"Webinar","Quantity":"1","itemTypes":[{"id":"Content License Workbook","value":true,"requestedDueDate":"04/04/2016"},{"id":"Content Sample","value":false,"requestedDueDate":"04/04/2016"},{"id":"Curriculum","value":false,"requestedDueDate":"04/04/2016"},{"id":"Custom Lite Workbooks","value":false,"requestedDueDate":"04/04/2016"},{"id":"Facilitator Guides","value":true,"requestedDueDate":"04/04/2016"},{"id":"Flyers","value":false,"requestedDueDate":"04/04/2016"},{"id":"Hand Outs","value":false,"requestedDueDate":"04/04/2016"},{"id":"Marketing Blurb","value":false,"requestedDueDate":"04/04/2016"},{"id":"Outline","value":false,"requestedDueDate":"04/04/2016"},{"id":"Previous Workbook Version","value":false,"requestedDueDate":"04/04/2016"},{"id":"RFP","value":false,"requestedDueDate":"04/04/2016"},{"id":"Sales Proposal","value":false,"requestedDueDate":"04/04/2016"},{"id":"Workbooks","value":false,"requestedDueDate":"04/04/2016"},{"id":"Other","value":false,"requestedDueDate":"04/04/2016"}]}' );
        controllerCP.saveProduct();
        System.currentPageReference().getParameters().put('oppProductId', oliId);
        controllerCP.deleteProduct();

        Test.StopTest();

    }
}