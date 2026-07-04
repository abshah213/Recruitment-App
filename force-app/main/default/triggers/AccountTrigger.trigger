trigger AccountTrigger on Account (before insert) {

    
    if(trigger.isInsert)
    {

            if(trigger.isBefore)
            {
                AccountTriggerHandler.updateRating(trigger.New);
            }

	}
}