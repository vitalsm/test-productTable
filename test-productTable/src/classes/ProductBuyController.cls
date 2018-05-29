public class ProductBuyController {
    
    private Product_Table__c prodInfo;
    private Contact cont;
    private Order_Table__c order;
    
    public ProductBuyController() {
        prodInfo = [SELECT Id, Name, Image_Url__c, Info__c, Product_Description__c, Unit_Price__c, Units_Available__c 
       	FROM Product_Table__c WHERE Id = :ApexPages.currentPage().getParameters().get('Id')];
        cont = new Contact();
        order = new Order_Table__c();
    }
    
    public Product_Table__c getProdInfo() {
        return prodInfo;
    }
    public Contact getContact() {
        return cont;
    }
    public Order_Table__c getOrder() {
        return order;
    }
    
    public PageReference buy() {
        List<Contact> con = [SELECT Id, Email, FirstName, LastName FROM Contact
                           WHERE Email = :cont.Email LIMIT 1];
        if(!con.isEmpty()) {            
            con[0].FirstName = cont.FirstName;
            con[0].LastName = cont.LastName;
            update con;
        }
        else {
            cont = new Contact(Email = cont.Email,
                              FirstName = cont.FirstName,
                              LastName = cont.LastName);
            insert cont;
        }
         
        
        Contact contId = [SELECT Id FROM Contact WHERE Email = :cont.Email];
        
        Order_Table__c newOrder = new Order_Table__c(Product__c = prodInfo.Id,
                                                    Units__c = Order.Units__c,
                                                    Order_Amount__c = Order.Units__c * prodInfo.Unit_Price__c,
                                                    Contact__c = contId.Id);
        
        
        if((prodInfo.Units_Available__c - newOrder.Units__c) >= 0 ) {
            prodInfo.Units_Available__c = prodInfo.Units_Available__c - newOrder.Units__c;
            update prodInfo;
            insert newOrder;
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO, 'The order was successfully issued!', 'ok'));
            return null;
        }
        else {
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING, 'Max units available: '+prodInfo.Units_Available__c,'warn'));
            return null;
        }
       // PageReference main = new PageReference('/apex/ProductList');
       // return main;
        
    }
    
}