trigger PositionTrigger on Position__c (before insert,before update,after insert) {

    
    if(trigger.isInsert)
    {
        
        if(trigger.isbefore)
        {
            PositionTriggerHandler.updateStatusFieldonPosition(trigger.New);
        }


    }
    
    
    
    if(trigger.isupdate)
    {
        
        if(trigger.isbefore)
        {
            PositionTriggerHandler.updateStatusFieldonPosition(trigger.New);
        }


    }
    
    
    
        if(trigger.isInsert)
    {

            if(trigger.isafter)
            {
               // PositionTriggerHandler.createRealtedTask(trigger.New);
            }


    }
    
    
    
}