trigger ProductTableTrigger on Product_Table__c (before insert,  before update, before
    delete, after insert, after update, after delete,  after undelete) {
    if (Trigger.isBefore && Trigger.isInsert) {
        ProductTableTriggerHandler.handleBeforeInsert(Trigger.new);
    }
}