public with sharing class TaskTriggerUtilities {
	
	public static Boolean stopFlag = false;
	
	public static void moveActivityDateForward(Set<Id> taskListIds){
		
		List<Task> taskList = [SELECT ActivityDate, isClosed FROM Task WHERE Id IN :taskListIds];
		Boolean updateRecords = false;
        
		for (Task myTask : taskList){
			
			if(myTask.isClosed == false && myTask.ActivityDate != null){
				String activityDateDay = dayOfWeek(myTask.ActivityDate);
				
				if (activityDateDay.equals('Sat')){
					myTask.ActivityDate = myTask.ActivityDate.addDays(2);
                    updateRecords = true;
				} else if (activityDateDay.equals('Sun')){
					myTask.ActivityDate = myTask.ActivityDate.addDays(1);
                    updateRecords = true;
				}
			}	
		}
		
        if (updateRecords){
            update taskList;
        }
		
	}
	
	private static String dayOfWeek(Date myDate){
		
		DateTime dt = DateTime.newInstance(myDate, DateTime.now().time());
		String dateString = dt.format('EEE, d MMM yyyy HH:mm:ss Z');
		return dateString.substringBefore(',');
		
	}
	
	public static void updateLastCompletedActivity(List<Task> taskList){
		
		List<Id> contactIds = new List<Id>();
		for (Task aTask : taskList){
			contactIds.add(aTask.WhoId);
		}
		
		List<Contact> contactsList = [SELECT Last_Completed_Activity__c FROM Contact WHERE Id IN :contactIds];
		
		taskList = [SELECT ActivityDate, WhoId FROM Task WHERE WhoId IN :contactIds and IsClosed = true];
		Map<Id, List<Task>> contactToTaskMap = new Map<Id, List<Task>>();
		for (Task aTask : taskList){
			List<Task> aux = new List<Task>();
			if (contactToTaskMap.get(aTask.WhoId) != null){
				aux = contactToTaskMap.get(aTask.WhoId);
			}
			aux.add(aTask);
			contactToTaskMap.put(aTask.WhoId, aux);
		}
		
		List<Contact> contactsToUpdate = new List<Contact>();
		for (Contact aContact : contactsList){
			if (contactToTaskMap.get(aContact.Id) != null){
				for (Task aTask : contactToTaskMap.get(aContact.Id)){
					if (aContact.Last_Completed_Activity__c == null || aContact.Last_Completed_Activity__c < aTask.ActivityDate){
						aContact.Last_Completed_Activity__c = aTask.ActivityDate;
					}
				}
				contactsToUpdate.add(aContact);
			}
		}
		update contactsToUpdate;
		
	}

}