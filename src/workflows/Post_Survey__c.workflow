<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Notify_Opp_Owner_of_Results</fullName>
        <description>Notify Opp Owner of Results</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>On_site_Ops/Post_Event_Survey_Results_Received</template>
    </alerts>
    <fieldUpdates>
        <fullName>TE_Naming_Convention</fullName>
        <field>Name</field>
        <formula>Training_Event__r.Name</formula>
        <name>TE Naming Convention</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Notify Opp Owner of Results</fullName>
        <actions>
            <name>Notify_Opp_Owner_of_Results</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>TE Survey Naming</fullName>
        <actions>
            <name>TE_Naming_Convention</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
