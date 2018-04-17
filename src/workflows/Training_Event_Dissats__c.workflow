<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>New_Disssat_Created</fullName>
        <description>New Disssat Created</description>
        <protected>false</protected>
        <recipients>
            <recipient>lnhartman@natsem.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>On_site_Ops/Notice_of_TE_Dissat_created</template>
    </alerts>
    <fieldUpdates>
        <fullName>TE_Dissat_Resolved_Date</fullName>
        <field>Date_Resolved__c</field>
        <formula>Today()</formula>
        <name>TE Dissat Resolved Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_TE_Dissat_Status_to_Open</fullName>
        <field>Status__c</field>
        <literalValue>Open</literalValue>
        <name>Update TE Dissat Status to Open</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_TE_Dissat_Status_to_Resolved</fullName>
        <field>Status__c</field>
        <literalValue>Resolved</literalValue>
        <name>Update TE Dissat Status to Resolved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Notice of TE Dissat created</fullName>
        <actions>
            <name>New_Disssat_Created</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>1=1</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>TE Dissat Auto update Open Dissats</fullName>
        <actions>
            <name>Update_TE_Dissat_Status_to_Open</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 or 2 or 3 or 4</booleanFilter>
        <criteriaItems>
            <field>Training_Event_Dissats__c.Action_Taken_to_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Training_Event_Dissats__c.Description__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Training_Event_Dissats__c.Reason__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Training_Event_Dissats__c.Soft_Costs__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TE Dissat Auto update Resolved Dissats</fullName>
        <actions>
            <name>Update_TE_Dissat_Status_to_Resolved</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Training_Event_Dissats__c.Date_Resolved__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TE Dissat Resolved</fullName>
        <actions>
            <name>TE_Dissat_Resolved_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Training_Event_Dissats__c.Status__c</field>
            <operation>equals</operation>
            <value>Resolved</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
