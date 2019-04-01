trigger NotRepeatedWorkItems on WorkItem__c (before insert, before update)
{
	For(WorkItem__c workItem : Trigger.New)
    {
     	Sprint__c sprint = [SELECT Id, Project__c FROM Sprint__c WHERE Id=: workItem.Sprint__c];    
    
        List<WorkItem__c> possibleDuplicates = [Select Name, Sprint__r.Project__c FROM WorkItem__c
                                                    WHERE Name =: workItem.Name AND Sprint__r.Project__c =: sprint.Project__c];
        if (!possibleDuplicates.isEmpty())
        {
            workItem.AddError('The WorkItem Name "'+workItem.Name+'" is already use in another WorkItem');
        }   
    }    
}