public class ProductListController {
    private String sortOrder = 'Name';
    public List<Product_Table__c> getProducts() {
         List<Product_Table__c> prodList = Database.query(
        	'SELECT Id, Image_Url__c, Info__c, Product_Description__c, Unit_Price__c, '+
        	'Name FROM Product_Table__c '+
            'ORDER BY ' + sortOrder + ' ASC LIMIT 100');
                
           for(Product_Table__c pt : prodList) {
                   pt.Product_Description__c = pt.Product_Description__c.subString(0,100) + '...';
                      } 
        
        return prodList;
        
    }
   
    public void sortByCost() {
        this.sortOrder = 'Unit_Price__c';
    }
    
    private Product_Table__c prodInfo;
    
    public Product_Table__c getFullProdInfo() {
        prodInfo = [SELECT Id, Name, Image_Url__c, Info__c, Product_Description__c, Unit_Price__c, Units_Available__c 
       	FROM Product_Table__c WHERE Id = :ApexPages.currentPage().getParameters().get('Id')];
        return prodInfo;
    }
}