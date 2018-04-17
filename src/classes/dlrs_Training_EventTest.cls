/**
 * Auto Generated and Deployed by the Declarative Lookup Rollup Summaries Tool package (dlrs)
 **/
@IsTest
private class dlrs_Training_EventTest
{
    @IsTest
    private static void testTrigger()
    {
        // Force the dlrs_Training_EventTrigger to be invoked, fails the test if org config or other Apex code prevents this.
        dlrs.RollupService.testHandler(new Training_Event__c());
    }
}