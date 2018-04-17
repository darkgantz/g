trigger TaskTrigger on Task (after insert, after update) {
	
	TaskTriggerUtilities.moveActivityDateForward(trigger.newMap.keySet());
	
	List<Task> tasksToProcess = new List<Task>();
	for (Task aTask : Trigger.new){
		if (aTask.IsClosed == true && aTask.WhoId != null){
			tasksToProcess.add(aTask);
		}
	}
	TaskTriggerUtilities.updateLastCompletedActivity(tasksToProcess);
	
}