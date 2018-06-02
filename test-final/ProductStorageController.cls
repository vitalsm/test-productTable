public with sharing class ProductStorageController {
      
   private String sortOrder = 'Name';
   private String sortDir = 'ASC';
   private List<ProductStorage__c> productStor;
   
   public String sortExpression {
   	get
   	{
   		return sortOrder;
   	}
   	set
   	{
   		if (value == sortOrder)
   		sortDir = (sortDir == 'ASC')? 'DESC' : 'ASC';
   		else
   		sortDir = 'ASC';
   		sortOrder = value;
   	}
   }
    
   public String getSortDir()
 {
    //if not column is selected 
    if (sortExpression == null || sortExpression == '')
      return 'ASC';
    else
     return sortDir;
 } 
   
   public void  setSortDir(String value) {
   	sortDir = value;
   } 
    
    public List<ProductStorage__c> getProductStor() {
        
        return productStor;
    }  
   
   public PageReference ViewData() {
   	string sortFullExp = sortExpression + ' ' + sortDir;
       
    productStor = Database.query ('SELECT Id, Name, AddedDate__c, Availability__c, Price__c, ProductType__c, '+
   		'ReleaseDate__c, quantity__c, ImageUrl__c FROM ProductStorage__c ORDER BY '+sortFullExp+' LIMIT 100'); 
    return null;
   }
    
    
   	
   }