trigger OpportuinityTrigger on Opportunity (before insert) {

    if(trigger.isinsert)
    {

         if(trigger.isbefore)
        {
            OpportuinityTriggerHandler.setValidationOnOpportuinity(trigger.New);
        }


    }

}