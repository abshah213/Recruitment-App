trigger ReviewTrigger on Review__c (After insert,After update) {

    
    if(trigger.isInsert)
    {

            if(trigger.isafter)
            {
                ReviewTriggerHandler.updateReviewProvidedField(trigger.New);
            }


    }

        
    if(trigger.isupdate)
    {

            if(trigger.isafter)
            {
                ReviewTriggerHandler.updateReviewProvidedField(trigger.New);
            }


    }

}