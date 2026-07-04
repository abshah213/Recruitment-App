public class PositionTriggerHandler {

    
    
    
    
    public static void updateStatusFieldonPosition(List<Position__c> posList)
    {
        
                
                for(Position__c pos : posList)
                {
        
        
                       if(pos.Days_Open__c > 30)
                       {
                           pos.Status__c = 'Closed - Filled';
                       }
                    
                    
                }
        
        
    }
    
    
    
    
    
    
    public static void createRealtedTask(List<Position__c> posList)
    {



        List<task> taskList = new List<task>();

        for(Position__c pos : posList)
        {


               if(pos.Status__c == 'New Position')
               {

                   task ta = new task();
                   ta.Status = 'In Progress';
                   ta.Subject = 'New Subject';
                   ta.Priority = 'Normal';
                   ta.ActivityDate = System.Today();            
                   ta.Description = 'New Task is Created Related To Position object.';

                   ta.OwnerId = UserInfo.getUserId();         // or pos.OwnerId        // u.Id   (Create Query for user)
                   ta.WhatId = pos.Id;
                   //ta.WhoId = ;

                   taskList.add(ta);

               }






        }


        insert taskList;


    }
    
    
    
    
    
}