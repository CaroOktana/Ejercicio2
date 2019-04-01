public with sharing class WorkItemRelatedStoryPoints
{
    private final WorkItem__c workItem;
    
    public List<WorkItem__c> workItems {get; set;}
    
	public List<SelectOption> statusList {get; set;}
    
    public String statusOption {get; set;}
    
    public Sprint__c sprint;
    
    public WorkItemRelatedStoryPoints(ApexPages.StandardController stdController)
    {
        System.debug('Constructor    ' );
        this.workItem = [SELECT Id, Name, Sprint__c, Story_Points__c, Status__c FROM WorkItem__c WHERE Id =: ((WorkItem__c)stdController.getRecord()).Id];
        sprint = [SELECT Id, Project__c FROM Sprint__c WHERE Id=: this.workItem.Sprint__c];
        this.statusList = getStatusList();
        workItems = getItems();
    }
    
	private List<WorkItem__c> getItems()
    {   
        workItems = new List<WorkItem__c>();
        System.debug('Status Option    ' + statusOption);
        if(statusOption == 'All Status' || statusOption == null)
        {
            workItems = [SELECT Id, Name, Sprint__r.Project__c, Story_Points__c, Status__c
                                       FROM WorkItem__c WHERE Story_Points__c =: this.workItem.Story_Points__c AND 
                                       Sprint__r.Project__c =: sprint.Project__c];
        } else
        {
            workItems = [SELECT Id, Name, Sprint__r.Project__c, Story_Points__c, Status__c
                                       FROM WorkItem__c WHERE Story_Points__c =: this.workItem.Story_Points__c AND 
                                       Sprint__r.Project__c =: sprint.Project__c AND Status__c=: statusOption];
        }
        return workItems;
    }
    
    public List<SelectOption> getStatusList() {
        List<SelectOption> statusList = new List<SelectOption>();
        statusList.add(new SelectOption('All Status','All Status'));
		statusList.add(new SelectOption('Not Started','Not Started'));
        statusList.add(new SelectOption('In Progress','In Progress'));
        statusList.add(new SelectOption('Done','Done'));
        return statusList;
    }

    public PageReference test()
    {
        workItems = getItems();
		System.debug('entro ');
        return null;
    }
}