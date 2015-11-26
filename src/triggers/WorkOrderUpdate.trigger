trigger WorkOrderUpdate on Work_Order__c (before update, after update) {

<<<<<<< HEAD
	if (WorkOrderHelper.isFirstRun){
		WorkOrderHelper.updateWorkOrders(Trigger.new, Trigger.oldMap, Trigger.isBefore);
	}	
=======
	WorkOrderHelper.updateWorkOrders(Trigger.new, Trigger.oldMap, Trigger.isBefore);

>>>>>>> shell-classes
}