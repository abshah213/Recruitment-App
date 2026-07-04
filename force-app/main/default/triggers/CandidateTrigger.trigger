trigger CandidateTrigger on Candidate__c (before Insert,before update,after insert, after update) {

    
    
    if(trigger.isinsert)
    {
         if(trigger.isbefore)
        {
            //CandidateTriggerHandler.setValidationonEmailField(trigger.New);
            //CandidateTriggerHandler.updateUinNumberFieldonCandidate(trigger.New);
        }
    }
    
    
    
    
    
    if(trigger.isupdate)
    {
         if(trigger.isbefore)
        {
            //CandidateTriggerHandler.updateUinNumberFieldonCandidate(trigger.New);

        }
    }
    
    
    

    if(trigger.isinsert)
    {
         if(trigger.isafter)
        {
          // CandidateTriggerHandler.sendEmailtoCandidate(trigger.New,Null);
             CandidateTriggerHandler.createSkillandCandidateSkillRecord(trigger.New);

        }
    }


    if(trigger.isupdate)
    {
         if(trigger.isafter)
        {
            //CandidateTriggerHandler.sendEmailtoCandidate(trigger.New,trigger.OldMap);
			  CandidateTriggerHandler.createSkillandCandidateSkillRecord(trigger.New);
        }
    }
    
    
    
}