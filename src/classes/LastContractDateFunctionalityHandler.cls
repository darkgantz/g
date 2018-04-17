public with sharing class LastContractDateFunctionalityHandler {

	public static List<Contact> contactToUpdate = new List<Contact>(); 

	public static void insertTrainingEventRecords(List<Training_Event__c> newRecords){

		Set<Id> contactIds = new Set<Id>();
		for(Training_Event__c t : newRecords){ 
			if(t.Decision_Maker__c != null){
				contactIds.add(t.Decision_Maker__c);	
			}
		}

		Map<Id,Contact> mapContact = new Map<Id,Contact>([Select Id,Last_Contract_Date__c From Contact Where Id IN :contactIds]);
		contactToUpdate = new List<Contact>();
		Set<Id> contactsSet = new Set<Id>();
		for (Training_Event__c te : newRecords){
			if (mapContact.get(te.Decision_Maker__c) != null){

				Contact tempCon =  mapContact.get(te.Decision_Maker__c);
				system.debug('tempCon ' + tempCon);
                system.debug('tempCon LCD before IF ' + tempCon.Last_Contract_Date__c);
				if ((Date.today() > tempCon.Last_Contract_Date__c || tempCon.Last_Contract_Date__c == null) && !contactsSet.contains(tempCon.Id)){
					contactsSet.add(tempCon.Id);
					tempCon.Last_Contract_Date__c = Date.today();
                    system.debug('tempCon LCD within IF ' + tempCon.Last_Contract_Date__c);
					contactToUpdate.add(tempCon);
				}
			}
		}
		if (!contactToUpdate.isEmpty()) update contactToUpdate;
	}

	public static void updateTrainingEventRecords(List<Training_Event__c> newRecords){
		Set<Id> contactIds = new Set<Id>();
		for (Training_Event__c t : newRecords) {
			if (t.Decision_Maker__c != null){
				contactIds.add(t.Decision_Maker__c);	
			}
		}
		Map<Id,Contact> mapContact = new Map<Id,Contact>([Select Id,Last_Contract_Date__c From Contact Where Id IN :contactIds]);
		contactToUpdate = new List<Contact>();
		Set<Id> contactsSet = new Set<Id>();
		for (Training_Event__c te : newRecords){
			if (mapContact.get(te.Decision_Maker__c) != null){
				Contact tempCon =  mapContact.get(te.Decision_Maker__c);
                system.debug('tempCon ' + tempCon);
                system.debug('tempCon LCD before IF ' + tempCon.Last_Contract_Date__c);
				if ((te.CreatedDate > tempCon.Last_Contract_Date__c || tempCon.Last_Contract_Date__c == null) && !contactsSet.contains(tempCon.Id)) {
					contactsSet.add(tempCon.Id);
					tempCon.Last_Contract_Date__c = Date.valueOf(te.CreatedDate);
                    system.debug('tempCon LCD within IF ' + tempCon.Last_Contract_Date__c);
					contactToUpdate.add(tempCon);
				}
			}
		}
		if (!contactToUpdate.isEmpty()) update contactToUpdate;
	}


}