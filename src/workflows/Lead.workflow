<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Lead_Owner_and_Manager_Alert</fullName>
        <description>Lead Owner and Manager Alert</description>
        <protected>false</protected>
        <recipients>
            <field>Email_for_Lead_Owner_s_Manager__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/LeadsNewassignmentnotificationSAMPLE</template>
    </alerts>
    <fieldUpdates>
        <fullName>Lead_gen_quota</fullName>
        <field>Lead_Gen_Quota__c</field>
        <formula>Owner:User.Appt_Min__c</formula>
        <name>Lead gen quota</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Manager_Email_Field</fullName>
        <field>Email_for_Lead_Owner_s_Manager__c</field>
        <formula>Owner:User.Manager.Email</formula>
        <name>Set Manager Email Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Owner_s_Mgr_Email_field</fullName>
        <field>Email_for_Lead_Owner_s_Manager__c</field>
        <formula>Owner:User.Manager.Email</formula>
        <name>Update Owner&apos;s Mgr Email field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <outboundMessages>
        <fullName>IS_Lead_Convert_to_Opp</fullName>
        <apiVersion>32.0</apiVersion>
        <endpointUrl>https://powerstandings.insidesales.com/kpi/qualopp</endpointUrl>
        <fields>Id</fields>
        <fields>LastModifiedById</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>jspainhour@natsem.com</integrationUser>
        <name>IS - Lead Convert to Opp</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <outboundMessages>
        <fullName>Lead_Qualified_Status</fullName>
        <apiVersion>32.0</apiVersion>
        <endpointUrl>https://powerstandings.insidesales.com/kpi/apptsset</endpointUrl>
        <fields>Id</fields>
        <fields>LastModifiedById</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>jspainhour@natsem.com</integrationUser>
        <name>Lead Qualified Status</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <rules>
        <fullName>Fill Lead Gen Quota</fullName>
        <actions>
            <name>Lead_gen_quota</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If the lead is converted and the owner is on the lead gen team, populate their current quota for the month.</description>
        <formula>IsConverted = TRUE &amp;&amp;  ISPICKVAL( Owner:User.User_Team__c , &quot;LEAD GEN&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>IS - Lead Convert to Opp</fullName>
        <actions>
            <name>IS_Lead_Convert_to_Opp</name>
            <type>OutboundMessage</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.IsConverted</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>InsideSales counter for Leads converted to Opportunities</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>IS - Lead Qualified Status</fullName>
        <actions>
            <name>Lead_Qualified_Status</name>
            <type>OutboundMessage</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Qualified</value>
        </criteriaItems>
        <description>InsideSales Counter for Leads moved to Qualified Status</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Owner and Manager Email Alert</fullName>
        <actions>
            <name>Lead_Owner_and_Manager_Alert</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Update_Owner_s_Mgr_Email_field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Sends an email alert to owner and owner&apos;s manager when a lead changes ownership.</description>
        <formula>( ISNEW() )   ||    ( ISCHANGED(OwnerId) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Manager Email Field</fullName>
        <actions>
            <name>Set_Manager_Email_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>When a lead is created or the owner changes, the manager&apos;s email field is set</description>
        <formula>ISNEW() || ISCHANGED(OwnerId)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
