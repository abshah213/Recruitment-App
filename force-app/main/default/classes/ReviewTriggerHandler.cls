public class ReviewTriggerHandler {

    
        public static void updateReviewProvidedField(List<Review__c> reviewList)
    {
        
          List<Job_Application__c> jobAppList = new  List<Job_Application__c> ();
        
          for(Review__c rev: reviewList)
          {
              
              if(rev.Rating__c != null)
              {
                  
                  Job_Application__c jobApp = new Job_Application__c();
                  jobApp.id = rev.Job_Application__c;
                  jobApp.Review_Provided__c = 'Yes';
                  
                  jobAppList.add(jobApp);
              }
              
          }
        
        
          
         update jobAppList;



    }

    
    
}