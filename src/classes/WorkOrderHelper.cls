public class WorkOrderHelper {

    public static boolean isFirstRun = true; 
    private static Date dateToday = System.today();

    public static void updateWorkOrders(List<Work_Order__c> workOrders, Map<Id,Work_Order__c> oldWorkOrdersMap, boolean isBefore){
        isFirstRun = false;

        if (isBefore){

            //do nothing
            System.debug('isBefore');

        } else {

            System.debug('isAfter');

            List<Work_Order__c> nextMaintenanceList = new List<Work_Order__c>();
        
            for (Work_Order__c order : [SELECT Id, Account__c, Equipment__c, Status__c, Type__c, Account__r.Name, Equipment__r.Name, Equipment__r.Maintenance_Cycle__c
                                        FROM Work_Order__c
                                        WHERE Status__c = 'Closed' AND
                                              Id IN: workOrders ])
            {
                System.debug(order);
                System.debug(oldWorkOrdersMap.get(order.Id));
                if (order.Status__c != oldWorkOrdersMap.get(order.Id).Status__c){
                    System.debug('creating new order');
                    Work_Order__c newOrder = new Work_Order__c();
                    newOrder.Name = order.Account__r.Name + ' ' + order.Equipment__r.Name + ' ' + 'Maintenance';
                    newOrder.Status__c = 'Open';
                    newOrder.Type__c = 'Routine Maintenance';
                    newOrder.Equipment__c = order.Equipment__c;
                    newOrder.Account__c = order.Account__c;
                    newOrder.Date_Reported__c = dateToday;
                    newOrder.Date_Due__c = dateToday.addDays(Integer.valueOf(order.Equipment__r.Maintenance_Cycle__c));
                    nextMaintenanceList.add(newOrder);
                }
            }

            insert nextMaintenanceList;
        }


        isFirstRun = true;
    }

}