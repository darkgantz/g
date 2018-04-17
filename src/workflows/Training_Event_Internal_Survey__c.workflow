<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Send_notice_of_new_TE_internal_survey</fullName>
        <description>Send notice of new TE internal survey</description>
        <protected>false</protected>
        <recipients>
            <recipient>jmccabe@natsem.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>ljackson@natsem.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>On_site_Ops/New_Internal_Survey</template>
    </alerts>
    <rules>
        <fullName>New TE Internal Survey created</fullName>
        <actions>
            <name>Send_notice_of_new_TE_internal_survey</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Training_Event_Internal_Survey__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
