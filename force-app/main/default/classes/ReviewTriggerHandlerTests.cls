@isTest
public class ReviewTriggerHandlerTests {

    
    
    @isTest
    static void test()
    {
        
        
        
                
          List<Job_Application__c> jobAppList = new  List<Job_Application__c> ();
        
          for(Integer i=1; i<=5 ; i++)
          {
              
             
                  Job_Application__c jobApp = new Job_Application__c();
                  jobApp.Cover_Letter__c = 'Testing' + i;
                  
                  jobAppList.add(jobApp);
          
              
          }
        
        
          
         insert jobAppList;
        
        
        
        
        
        
          List<Review__c> reviewList = new  List<Review__c> ();
        
          for(Job_Application__c jobApp : jobAppList)
          {
              
             
                  Review__c rev = new Review__c();
                  rev.Job_Application__c = jobApp.Id ;
                  rev.Rating__c = 4;
                  reviewList.add(rev);
          
              
          }
        
        
          
         insert reviewList;
        
        
        
        
        
        
         List<Job_Application__c> jobAppList1 = [Select Id,Review_Provided__c From Job_Application__c Where Id  =: jobAppList[0].Id];
         System.AssertEquals('Yes',jobAppList1[0].Review_Provided__c);
          
        
        
        
    }
    
    
    
    
}