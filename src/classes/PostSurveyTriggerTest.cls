@isTest
public class PostSurveyTriggerTest {
    
    static testMethod void testBeforeInsert() {

        Account a = new Account(Name = 'Test Account');
        insert a;

        Contact c = new Contact(LastName = 'Test Contact', AccountId = a.Id);
        insert c;

        Opportunity o = new Opportunity(Name = 'Test Opp', AccountId = a.Id, StageName = 'Closed Won', CloseDate = Date.newInstance(2015,1,1));
        insert o;

        Training_Event__c te = new Training_Event__c(Name = 'Test TE', Opportunity__c = o.Id, Trainer_Assigned__c = c.Id, Account__c = a.Id);
        insert te;

        Post_Survey__c ps = new Post_Survey__c(Name = 'Test TEPS', Training_Event__c = te.Id);
        insert ps;

        Post_Survey__c psCommitted = [SELECT Id, Trainer__c, Account__c FROM Post_Survey__c WHERE Id = :ps.Id];

        System.assertEquals(c.Id, psCommitted.Trainer__c);
        System.assertEquals(a.Id, psCommitted.Account__c);

    }
    
}