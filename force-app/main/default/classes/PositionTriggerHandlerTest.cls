@isTest
private class PositionTriggerHandlerTest {

    @isTest
    static void test()
    {


        //create Single Data               For Position__c
        Position__c pos = new Position__c();
        pos.Name = 'Test' ;
        pos.Status__c = 'New Position';




        //DML Operation
        Test.StartTest();
        insert pos;
        Test.StopTest();





        //Validate Single Data						// Task is Created Or Not
        Task createdTask = [SELECT Id, Subject, WhatId, OwnerId, Status, Priority
                                    FROM Task
                                    WHERE WhatId = :pos.Id
                                    LIMIT 1];


         System.assert(createdTask != null, 'task is not created.');

         System.assertNotEquals(null, createdTask, 'Task should have been created.');
         //System.assertEquals(1, createdTask.size(), 'Task Is Not created.');





    }

}