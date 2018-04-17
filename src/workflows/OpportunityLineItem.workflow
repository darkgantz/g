<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>ClearLocationForCustomLite</fullName>
        <field>Workbook_Location__c</field>
        <name>ClearLocationForCustomLite</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Workbook_ID</fullName>
        <field>Workbook_ID__c</field>
        <formula>Product2.Workbook_UPC__c</formula>
        <name>Set Workbook ID</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Workbook_Location</fullName>
        <field>Workbook_Location__c</field>
        <formula>TEXT(Product2.Workbook_Location__c)</formula>
        <name>Set Workbook Location</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>ClearLocationForCustomLite</fullName>
        <actions>
            <name>ClearLocationForCustomLite</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If the Topic Name is changed for a Custom Lite, clear the &quot;Warehouse&quot; entry from the location field.</description>
        <formula>and (    Topic_Name__c &lt;&gt;  Product2.Name , NOT(ISBLANK(Topic_Name__c)) ,      Opportunity.RecordType.Id  = &quot;012J00000004uxg&quot; /*CustomRecordType*/ )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Workbook Location and ID</fullName>
        <actions>
            <name>Set_Workbook_ID</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Workbook_Location</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
