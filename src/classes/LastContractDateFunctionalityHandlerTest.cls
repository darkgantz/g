@isTest
private class LastContractDateFunctionalityHandlerTest {
	
	@isTest static void insertLastContract() {
		Opportunity opp = new Opportunity(Name='Test 10',StageName='Aaa',CloseDate=Date.today());
		insert opp;

		Contact c = new Contact(LastName='test 1',Last_Contract_Date__c = null);
		insert c;

		Training_Event__c te = new Training_Event__c(Opportunity__c = opp.Id,Name='test',Decision_Maker__c = c.Id);
		insert te;

        Contact cResult = [SELECT Id, Last_Contract_Date__c FROM Contact WHERE Id = :c.Id];
        system.assertEquals(Date.today(), cResult.Last_Contract_Date__c);
		//system.assertEquals(true,te != null);

	}
	
	@isTest static void updateLastContract() {
		Opportunity opp = new Opportunity(Name='Test 10',StageName='Aaa',CloseDate=Date.today());
		insert opp;

		Contact c = new Contact(LastName='test 1',Last_Contract_Date__c = Date.today().addDays(-3));
		insert c;

		Training_Event__c te = new Training_Event__c(Opportunity__c = opp.Id,Name='test',Decision_Maker__c = c.Id);
		insert te;

		te.Name='223';
		update te;

        Contact cResult = [SELECT Id, Last_Contract_Date__c FROM Contact WHERE Id = :c.Id];
        system.assertEquals(Date.today(), cResult.Last_Contract_Date__c);
		//system.assertEquals(true,te != null);
	}
	@isTest static void newTrainingEventContactWithNullDate() {
		Opportunity opp = new Opportunity(Name='Test 10',StageName='Aaa',CloseDate=Date.today());
		insert opp;

		Contact c = new Contact(LastName='test 1',Last_Contract_Date__c = null);
		insert c;

		Training_Event__c te = new Training_Event__c(Opportunity__c = opp.Id,Name='test',Decision_Maker__c = c.Id);
		insert te;

        Contact cResult = [SELECT Id, Last_Contract_Date__c FROM Contact WHERE Id = :c.Id];
		system.assertEquals(Date.today(), cResult.Last_Contract_Date__c);
	}
	
	@isTest static void newTrainingEventContactWithDate() {
		Opportunity opp = new Opportunity(Name='Test 10',StageName='Aaa',CloseDate=Date.today());
		insert opp;

		Contact c = new Contact(LastName='test 1',Last_Contract_Date__c = Date.today().addDays(-10));
		insert c;

		Training_Event__c te = new Training_Event__c(Opportunity__c = opp.Id,Name='test',Decision_Maker__c = c.Id);
		insert te;
		
        Contact cResult = [SELECT Id, Last_Contract_Date__c FROM Contact WHERE Id = :c.Id];
		system.assertEquals(Date.today(), cResult.Last_Contract_Date__c);
	}

	@isTest static void updateTrainingEventContactWithNoDate() {
		Opportunity opp = new Opportunity(Name='Test 10',StageName='Aaa',CloseDate=Date.today());
		insert opp;

		Contact c1 = new Contact(LastName='test 1',Last_Contract_Date__c = null);
		insert c1;

		Contact c2 = new Contact(LastName='test 1',Last_Contract_Date__c = null);
		insert c2;

		Training_Event__c te = new Training_Event__c(Opportunity__c = opp.Id,Name='test',Decision_Maker__c = c1.Id);
		insert te;

		te.Decision_Maker__c = c2.Id;
		update te;

        Contact cResult1 = [SELECT Id, Last_Contract_Date__c FROM Contact WHERE Id = :c1.Id];
        Contact cResult2 = [SELECT Id, Last_Contract_Date__c FROM Contact WHERE Id = :c2.Id];
		system.assertEquals(Date.today(), cResult1.Last_Contract_Date__c); // This should pass because of insert
		system.assertEquals(Date.today(), cResult2.Last_Contract_Date__c); // This should pass because of update
	}

	@isTest static void updateTrainingEventContactWithDate() {
		Opportunity opp = new Opportunity(Name='Test 10',StageName='Aaa',CloseDate=Date.today());
		insert opp;

		Contact c1 = new Contact(LastName='test 1',Last_Contract_Date__c = Date.today().addDays(-10));
		insert c1;

		Contact c2 = new Contact(LastName='test 1',Last_Contract_Date__c = Date.today().addDays(-10));
		insert c2;

		Training_Event__c te = new Training_Event__c(Opportunity__c = opp.Id,Name='test',Decision_Maker__c = c1.Id);
		insert te;

		te.Decision_Maker__c = c2.Id;
		update te;

		Contact cResult1 = [SELECT Id, Last_Contract_Date__c FROM Contact WHERE Id = :c1.Id];
        Contact cResult2 = [SELECT Id, Last_Contract_Date__c FROM Contact WHERE Id = :c2.Id];
		system.assertEquals(Date.today(), cResult1.Last_Contract_Date__c); // This should pass because of insert
		system.assertEquals(Date.today(), cResult2.Last_Contract_Date__c); // This should pass because of update
	}
}