public class OpportuinityTriggerHandler {

    
        public static void setValidationOnOpportuinity(List<Opportunity> oppList)
    {




        for(Opportunity opp : oppList)
        {

            if(opp.Amount == null)
            {

                opp.addError('Please Enter Opportunity Amount pls.');

            }

        }


	}
}