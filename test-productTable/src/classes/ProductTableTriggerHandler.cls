public class ProductTableTriggerHandler {
    public static void handleBeforeInsert (List<Product_Table__c> prod) {
       List<Warehouse__c> whList = new List<Warehouse__c>();
        
       Date addedDate = prod[0].Added_Date__c;
        if(addedDate == null) {
            addedDate = Date.today();
        }
        String addedDateStr = addedDate.format();
        
       Warehouse__c[] wh = [SELECT Id FROM Warehouse__c WHERE Period_Start__c <= :addedDate AND Period_End__c >= :addedDate LIMIT 1];
       
       Org_Configuration__c oc = Org_Configuration__c.getInstance(); 
       Integer pTerm = (Integer)oc.Period_Term__c;
       Date addDay = addedDate.addDays(pTerm);
       String addDayStr = addDay.format(); 
        
       if(!wh.isEmpty()) { 
       	for(Product_Table__c pt : prod) {
            pt.Warehouse__c = wh[0].Id;
                }
       }
           else {
               Warehouse__c newWrh = new Warehouse__c(Name = 'Warehouse '+addedDateStr + ' - ' + addDayStr,
                                          			  Period_Start__c = addedDate,
                                         			  Period_End__c = addDay);
           	   insert newWrh;
               for(Product_Table__c pt : prod) {
                   pt.Warehouse__c = newWrh.Id;
                      }
              
                }
    
           
}
}