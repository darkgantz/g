@isTest(seeAllData=true)
public class SP_ConvertTrainingCoverage {
	
     static testMethod void testTrainingEvent(){
         
         Account acc = new Account(Name = 'Test Account');
         insert acc;

        // Set up some local variables
        String opportunityName = 'Opp';
        String standardPriceBookId = '';
        
        PriceBook2 pb2Standard = [select Id from Pricebook2 where isStandard=true];
        standardPriceBookId = pb2Standard.Id;
        
         RecordType test_recordtype  = [SELECT Id,name, SobjectType FROM RecordType where SobjectType ='Opportunity' and name = 'On-site: Custom'];
        // set up opp and Verify that the results are as expected.
        Opportunity o = new Opportunity(AccountId=acc.id, Name=opportunityName, 
        StageName='Needs Analysis', CloseDate=Date.today(),RecordTypeId =test_recordtype.Id);
        insert o;
         
        Opportunity opp = [SELECT Name FROM Opportunity WHERE Id = :o.Id];
        System.assertEquals(opportunityName, opp.Name);
        
        // set up product2 and Verify that the results are as expected.
        Product2 p2 = new Product2(Name='Test Product',isActive=true);
        insert p2;
        Product2 p2ex = [SELECT Name FROM Product2 WHERE Id = :p2.Id];
        System.assertEquals('Test Product', p2ex.Name);
        
        // set up PricebookEntry and Verify that the results are as expected.
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id=standardPriceBookId, Product2Id=p2.Id, UnitPrice=99, isActive=true);
        insert pbe;
        PricebookEntry pbeex = [SELECT Pricebook2Id FROM PricebookEntry WHERE Id = :pbe.Id];
        System.assertEquals(standardPriceBookId, pbeex.Pricebook2Id);
        
        // set up OpportunityLineItem and Verify that the results are as expected.
        OpportunityLineItem oli = new OpportunityLineItem(PriceBookEntryId=pbe.Id, OpportunityId=o.Id, Quantity=1, TotalPrice=99);
        oli.Number_of_hours__c = 2;
        insert oli;
        OpportunityLineItem oliex = [SELECT PriceBookEntryId FROM OpportunityLineItem WHERE Id = :oli.Id];
        System.assertEquals(pbe.Id, oliex.PriceBookEntryId); 
         
            test.startTest();
                PageReference pageRef = Page.SP_ConvertTrainingEvent;
                Test.setCurrentPage(pageRef);
                ApexPages.currentPage().getParameters().put('id', opp.id);
                SP_ConvertTrainingEventController controller = new SP_ConvertTrainingEventController();
                controller.init();
            test.stopTest();
        }    
}