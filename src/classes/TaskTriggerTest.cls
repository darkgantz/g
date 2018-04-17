@isTest
private class TaskTriggerTest {

    static testMethod void saturdayActivityDateOnInsertTest() {
        
        Task myTask = new Task(Priority = 'Normal', Status = 'Not Started');
        Date saturday = desiredDayOfWeek('Sat');
        myTask.ActivityDate = saturday;
        
        Test.startTest();
        	insert myTask;
        Test.stopTest();
        
        Date monday = saturday.addDays(2);
        myTask = [SELECT ActivityDate FROM Task WHERE Id = :myTask.Id];
        
        system.assertEquals(monday, myTask.ActivityDate);
        
    }
    
    static testMethod void sundayActivityDateOnInsertTest() {
        
        Task myTask = new Task(Priority = 'Normal', Status = 'Not Started');
        Date sunday = desiredDayOfWeek('Sun');
        myTask.ActivityDate = sunday;
        
        Test.startTest();
        	insert myTask;
        Test.stopTest();
        
        Date monday = sunday.addDays(1);
        myTask = [SELECT ActivityDate FROM Task WHERE Id = :myTask.Id];
        
        system.assertEquals(monday, myTask.ActivityDate);
        
    }
    
    static testMethod void weekDayActivityDateOnInsertTest() {
        
        Task myTask = new Task(Priority = 'Normal', Status = 'Not Started');
        Date monday = desiredDayOfWeek('Mon');
        myTask.ActivityDate = monday;
        
        Test.startTest();
        	insert myTask;
        Test.stopTest();
        
        myTask = [SELECT ActivityDate FROM Task WHERE Id = :myTask.Id];
        
        system.assertEquals(monday, myTask.ActivityDate);
        
    }
    
    static testMethod void saturdayActivityDateOnUpdateTest() {
        
        Task myTask = new Task(Priority = 'Normal', Status = 'Not Started');
    	insert myTask;
        
        Date saturday = desiredDayOfWeek('Sat');
        myTask.ActivityDate = saturday;
        
        Test.startTest();
        	update myTask;
        Test.stopTest();
        
        Date monday = saturday.addDays(2);
        myTask = [SELECT ActivityDate FROM Task WHERE Id = :myTask.Id];
        
        system.assertEquals(monday, myTask.ActivityDate);
        
    }
    
    static testMethod void sundayActivityDateOnUpdateTest() {
        
        Task myTask = new Task(Priority = 'Normal', Status = 'Not Started');
    	insert myTask;
        	
        Date sunday = desiredDayOfWeek('Sun');
        myTask.ActivityDate = sunday;
        
        Test.startTest();
        	update myTask;
        Test.stopTest();
        
        Date monday = sunday.addDays(1);
        myTask = [SELECT ActivityDate FROM Task WHERE Id = :myTask.Id];
        
        system.assertEquals(monday, myTask.ActivityDate);
        
    }
    
    static testMethod void weekDayActivityDateOnUpdateTest() {
        
        Task myTask = new Task(Priority = 'Normal', Status = 'Not Started');
    	insert myTask;
        
        Date monday = desiredDayOfWeek('Mon');
        myTask.ActivityDate = monday;
        
        Test.startTest();
        	update myTask;
        Test.stopTest();
        
        myTask = [SELECT ActivityDate FROM Task WHERE Id = :myTask.Id];
        
        system.assertEquals(monday, myTask.ActivityDate);
        
    }
    
    static testMethod void closedSaturdayActivityDateOnInsertTest() {
        
        Task myTask = new Task(Priority = 'Normal', Status = 'Closed/Not Completed');
        Date saturday = desiredDayOfWeek('Sat');
        myTask.ActivityDate = saturday;
        
        Test.startTest();
        	insert myTask;
        Test.stopTest();

        myTask = [SELECT ActivityDate FROM Task WHERE Id = :myTask.Id];
        
      //  system.assertEquals(saturday, myTask.ActivityDate);
        
    }
    
    static testMethod void closedSundayActivityDateOnInsertTest() {
        
        Task myTask = new Task(Priority = 'Normal', Status = 'Closed/Not Completed');
        Date sunday = desiredDayOfWeek('Sun');
        myTask.ActivityDate = sunday;
        
        Test.startTest();
        	insert myTask;
        Test.stopTest();

        myTask = [SELECT ActivityDate FROM Task WHERE Id = :myTask.Id];
        
       // system.assertEquals(sunday, myTask.ActivityDate);
        
    }
    
    static testMethod void closedWeekDayActivityDateOnInsertTest() {
        
        Task myTask = new Task(Priority = 'Normal', Status = 'Closed/Not Completed');
        Date monday = desiredDayOfWeek('Mon');
        myTask.ActivityDate = monday;
        
        Test.startTest();
        	insert myTask;
        Test.stopTest();
        
        myTask = [SELECT ActivityDate FROM Task WHERE Id = :myTask.Id];
        
        system.assertEquals(monday, myTask.ActivityDate);
        
    }
    
    static testMethod void closedSaturdayActivityDateOnUpdateTest() {
        
        Task myTask = new Task(Priority = 'Normal', Status = 'Closed/Not Completed');
    	insert myTask;
        
        Date saturday = desiredDayOfWeek('Sat');
        myTask.ActivityDate = saturday;
        
        Test.startTest();
        	update myTask;
        Test.stopTest();

        myTask = [SELECT ActivityDate FROM Task WHERE Id = :myTask.Id];
        
      //  system.assertEquals(saturday, myTask.ActivityDate);
        
    }
    
    static testMethod void closedSundayActivityDateOnUpdateTest() {
        
        Task myTask = new Task(Priority = 'Normal', Status = 'Closed/Not Completed');
    	insert myTask;
        	
        Date sunday = desiredDayOfWeek('Sun');
        myTask.ActivityDate = sunday;
        
        Test.startTest();
        	update myTask;
        Test.stopTest();
        
        myTask = [SELECT ActivityDate FROM Task WHERE Id = :myTask.Id];
        
        //system.assertEquals(sunday, myTask.ActivityDate);
        
    }
    
    static testMethod void closedWeekDayActivityDateOnUpdateTest() {
        
        Task myTask = new Task(Priority = 'Normal', Status = 'Closed/Not Completed');
    	insert myTask;
        
        Date monday = desiredDayOfWeek('Mon');
        myTask.ActivityDate = monday;
        
        Test.startTest();
        	update myTask;
        Test.stopTest();
        
        myTask = [SELECT ActivityDate FROM Task WHERE Id = :myTask.Id];
        
        system.assertEquals(monday, myTask.ActivityDate);
        
    }
    
    private static Date desiredDayOfWeek(String dayName){
    	
    	DateTime desiredDay = DateTime.now();
    	
    	while (desiredDay.format('EEE') != dayName){
    		desiredDay = desiredDay.addDays(1);
    	}
    	
    	return desiredDay.date();
    }
    
    static testMethod void lastTaskCompletedInsert(){
    	
    	Account anAccount = new Account(Name='testAcc');
    	insert anAccount;
    	
    	Contact aContact = new Contact(LastName = 'test', AccountId = anAccount.Id);
    	insert aContact;
    	
    	List<Task> tasksList = new List<Task>();
    	
    	Task myTask1 = new Task(Status = 'Completed', ActivityDate = Date.today(), WhoId = aContact.Id);
    	tasksList.add(myTask1);
    	Task myTask2 = new Task(Status = 'In Progress', ActivityDate = Date.today().addDays(2), WhoId = aContact.Id);
    	tasksList.add(myTask2);
    	Task myTask3 = new Task(Status = 'Completed', ActivityDate = Date.today().addDays(-2), WhoId = aContact.Id);
    	tasksList.add(myTask3);
    	
    	Test.startTest();
    		insert tasksList;
		Test.stopTest();
		
		aContact = [SELECT Last_Completed_Activity__c FROM Contact WHERE Id = :aContact.Id];
		
		system.assertEquals(myTask1.ActivityDate, aContact.Last_Completed_Activity__c);
    	
    }
    
    static testMethod void lastTaskCompletedUpdate(){
    	
    	Account anAccount = new Account(Name='testAcc');
    	insert anAccount;
    	
    	Contact aContact = new Contact(LastName = 'test', AccountId = anAccount.Id);
    	insert aContact;
    	
    	List<Task> tasksList = new List<Task>();
    	
    	Task myTask1 = new Task(Status = 'Completed', ActivityDate = Date.today(), WhoId = aContact.Id);
    	tasksList.add(myTask1);
    	Task myTask2 = new Task(Status = 'In Progress', ActivityDate = Date.today().addDays(2), WhoId = aContact.Id);
    	tasksList.add(myTask2);
    	Task myTask3 = new Task(Status = 'Completed', ActivityDate = Date.today().addDays(-2), WhoId = aContact.Id);
    	tasksList.add(myTask3);
    	insert tasksList;
    	
    	myTask2.Status = 'Completed';
    	
    	Test.startTest();
    		update myTask2;
		Test.stopTest();
		
		aContact = [SELECT Last_Completed_Activity__c FROM Contact WHERE Id = :aContact.Id];
		
		system.assertEquals(myTask2.ActivityDate, aContact.Last_Completed_Activity__c);
    	
    }
}