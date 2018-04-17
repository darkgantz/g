trigger LastContractDateFunctionality on Training_Event__c (before insert, before update) {
	if(trigger.isInsert)
		LastContractDateFunctionalityHandler.insertTrainingEventRecords(trigger.new);
	
	if(trigger.isUpdate)
		LastContractDateFunctionalityHandler.updateTrainingEventRecords(trigger.new);
}