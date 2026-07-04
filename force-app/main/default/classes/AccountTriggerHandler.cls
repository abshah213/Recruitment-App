public class AccountTriggerHandler {

    
    public static void updateRating(List<Account> accList)
    {

        for(Account acc : accList)
        {

            if(acc.Industry != null && (acc.Industry == 'Media' || acc.Industry == 'Energy'))
            {
                acc.Rating = 'Hot-est';
            }





            /*
            if(acc.Industry != Null && acc.Industry == 'Media')
            {
                acc.Rating = 'Hot-est' ;
            }

            */

        }


    }

}