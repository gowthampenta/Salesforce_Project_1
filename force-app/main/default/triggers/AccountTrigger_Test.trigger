trigger AccountTrigger_Test on Account (after update) {
    AccountTriggerTest.updateOpportunityStages(Trigger.newMap.keySet());
}