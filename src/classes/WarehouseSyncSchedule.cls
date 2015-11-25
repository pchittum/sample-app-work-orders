global class WarehouseSyncSchedule implements Schedulable {
	global void execute(SchedulableContext sc) {
		//MyBatchClass b = new MyBatchClass();
		//database.executebatch(b);

		WarehouseCalloutService.runWarehouseEquipmentSync();



	}
}