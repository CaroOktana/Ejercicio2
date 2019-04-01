trigger DeletedWorkItem on WorkItem__c (after delete) {
	
    For(WorkItem__c workItem : Trigger.Old)
    {
        Sprint__c sprint = [SELECT Id, Name, Not_Completed_WorkItems_Story_Points__c, Total_WorkItems_Story_Points__c,
                          Completed_WorkItems_Story_Points__c FROM Sprint__c WHERE Id=: workItem.Sprint__c];

       if(workItem.Status__c == 'Not Started' || workItem.Status__c == 'In Progress')
        {
            sprint.Not_Completed_WorkItems_Story_Points__c = 
                sprint.Not_Completed_WorkItems_Story_Points__c - Integer.valueOf(workItem.Story_Points__c);
            
        } else
        {
            sprint.Completed_WorkItems_Story_Points__c = sprint.Completed_WorkItems_Story_Points__c - Integer.valueOf(workItem.Story_Points__c);
        }
      	sprint.Total_WorkItems_Story_Points__c = sprint.Total_WorkItems_Story_Points__c - Integer.valueOf(workItem.Story_Points__c);
        update sprint;
    }   
}