trigger WorkOrderUpdate on Work_Order__c (before update, after update) {

	if (WorkOrderHelper.isFirstRun){
		WorkOrderHelper.updateWorkOrders(Trigger.new, Trigger.oldMap, Trigger.isBefore);
	}	
}