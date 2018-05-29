@isTest
private class ProductTableTriggerTest {
    @isTest static void TesthandleBeforeInsert() {
       
        List<Product_Table__c> prodt = new List<Product_Table__c>();
        for(Integer i=0; i < 20; i++) {
            Product_Table__c pt = new Product_Table__c(Name='Test ' + i);
            prodt.add(pt);
        }              
        
        Test.startTest();
        insert prodt;                               
        Test.stopTest();
        
        List<Product_Table__c> verifyPt = [SELECT Id FROM Product_Table__c];
        System.assertEquals(20, verifyPt.size());    
        
        List<Warehouse__c> verifyWh = [SELECT Id FROM Warehouse__c];                              
        System.assertEquals(0, verifyWh.size());                             
    }
}