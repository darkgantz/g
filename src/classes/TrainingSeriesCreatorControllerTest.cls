@isTest
private class TrainingSeriesCreatorControllerTest {
    
    public static testMethod void test1(){
        
        Test.StartTest();
        
        String standardPriceBookId1 = Test.getStandardPricebookId();
        
        Account acc = new Account(Name='Testing Acc');
        insert acc;
        
        Product2 p1 = new Product2(Name='Test Product 1',isActive=true);
        insert p1;
        System.debug('p1.id='+p1.id+' standardPriceBookId1='+standardPriceBookId1);
        PricebookEntry pbe1 = new PricebookEntry (Pricebook2Id=standardPriceBookId1, Product2Id = p1.id, UnitPrice=50, isActive = true);
        insert pbe1;
        
        Opportunity opp = new Opportunity(Name ='Testing opp',
                                          AccountID = acc.Id,
                                          StageName = 'Prospecting',
                                          Amount = 0,
                                          Number_of_Days__c = 10,
                                          CloseDate = System.today(),
                                          Pricebook2Id = pbe1.Pricebook2Id,
                                          RecordTypeId =  Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId());
        insert opp;
        
        OpportunityLineItem[] ops = New List<OpportunityLineItem>();
        for(Integer i = 0; i<=9; i++){
            ops.add(new OpportunityLineItem(OpportunityId = opp.id, Quantity=1, TotalPrice=10.00, PricebookEntryId = pbe1.Id));
        }
        insert ops;
        
        Content_Pack__c cp = new Content_Pack__c(Name='Test Pack');
        
        insert cp;
        
        String standardPriceBookId = Test.getStandardPricebookId();
        
        // set up product2 and Verify that the results are as expected.
        Product2 p2 = new Product2(Name='Test Product',isActive=true);
        insert p2;
        
        // set up PricebookEntry and Verify that the results are as expected.
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id=standardPriceBookId, Product2Id=p2.Id, UnitPrice=99, isActive=true);
        insert pbe;
        
        // set up OpportunityLineItem and Verify that the results are as expected.
        OpportunityLineItem oli = new OpportunityLineItem(PriceBookEntryId=pbe.Id, OpportunityId=opp.Id, Quantity=1, TotalPrice=99,Content_Pack__c=cp.Id);
        insert oli;
        
        System.currentPageReference().getParameters().put( 'oppId', opp.Id );
        
        TrainingSeriesCreatorController tSeriesCreatorController = new TrainingSeriesCreatorController( new ApexPages.StandardController( new Training_Series__c() ) );
        
        tSeriesCreatorController.listOfInnerTrainingEvents.get(0).tEvent.Name = 'Testing event 1';
        tSeriesCreatorController.listOfInnerTrainingEvents.get(0).tEvent.Training_Start_Date__c = System.today();
        tSeriesCreatorController.listOfInnerTrainingEvents.get(0).tEvent.Training_Num_of_Days__c = 2;
        tSeriesCreatorController.listOfInnerTrainingEvents.get(0).tEventProducts.get(0).isSelected = true;
        tSeriesCreatorController.listOfInnerTrainingEvents.get(0).tEventProducts.get(0).quantity = '2';
        tSeriesCreatorController.listOfInnerTrainingEvents.get(0).tEventProducts.get(0).numberOfWorkbooks = '2';
        
        tSeriesCreatorController.addEvent();
        
        tSeriesCreatorController.listOfInnerTrainingEvents.get(1).tEvent.Name = 'Testing event 2';
        tSeriesCreatorController.listOfInnerTrainingEvents.get(1).tEvent.Training_Start_Date__c = System.today();
        tSeriesCreatorController.listOfInnerTrainingEvents.get(1).tEvent.Training_Num_of_Days__c = 5;
        tSeriesCreatorController.listOfInnerTrainingEvents.get(1).tEventProducts.get(0).isSelected = true;
        tSeriesCreatorController.listOfInnerTrainingEvents.get(1).tEventProducts.get(0).quantity = '2';
        tSeriesCreatorController.listOfInnerTrainingEvents.get(1).tEventProducts.get(0).numberOfWorkbooks = '2';
        
        tSeriesCreatorController.quickSave();
        
        tSeriesCreatorController.saveAll();
        
        System.assertEquals(2,[SELECT Id FROM Training_Event__c].size());
        
        
        
        Test.StopTest();
        
    }
    
}