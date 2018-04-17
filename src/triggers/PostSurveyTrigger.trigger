trigger PostSurveyTrigger on Post_Survey__c (before insert) {
	
    Map<Id,Training_Event__c> teMap = new Map<Id,Training_Event__c>();
    
    for(Post_Survey__c ps : Trigger.new) {
        teMap.put(ps.Training_Event__c, null);
    }
    
    teMap = New Map<Id,Training_Event__c>([SELECT Trainer_Assigned__c, Account__c FROM Training_Event__c WHERE Id IN :teMap.keySet()]);
    
    for(Post_Survey__c ps : Trigger.new) {
        if(teMap.containsKey(ps.Training_Event__c)) {
            if(teMap.get(ps.Training_Event__c).Trainer_Assigned__c != null) {
	            ps.Trainer__c = teMap.get(ps.Training_Event__c).Trainer_Assigned__c;            
            }
            
            if(teMap.get(ps.Training_Event__c).Account__c != null) {
                ps.Account__c = teMap.get(ps.Training_Event__c).Account__c;
            }
        }
    }
}