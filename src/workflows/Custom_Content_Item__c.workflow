<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Notice_of_Custom_Content_Item_Changed_by_Production</fullName>
        <ccEmails>OSIDTeam@skillpath.com</ccEmails>
        <description>Notice of Custom Content Item Changed by Production</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>On_site_Ops/Notice_of_CCI_Completed_by_Production</template>
    </alerts>
    <alerts>
        <fullName>Notice_of_Custom_Content_Item_to_Production</fullName>
        <ccEmails>OSIDTeam@skillpath.com</ccEmails>
        <description>Notice of Custom Content Item to Production</description>
        <protected>false</protected>
        <recipients>
            <recipient>ahoux@natsem.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>cpio@natsem.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jseiter@natsem.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>On_site_Ops/CCI_Assigned_Production</template>
    </alerts>
    <alerts>
        <fullName>Notice_of_New_Custom_Content_Item</fullName>
        <description>Notice of New Custom Content Item to IDs</description>
        <protected>false</protected>
        <recipients>
            <recipient>astrong@natsem.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sdenyeart@natsem.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>On_site_Ops/Notice_of_Custom_Content_Item_Created</template>
    </alerts>
    <alerts>
        <fullName>Notice_of_New_Custom_Content_Item_3rd_Party</fullName>
        <ccEmails>OSIDTeam@skillpath.com</ccEmails>
        <description>Notice of New Custom Content Item to IDs - 3rd Party</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>On_site_Ops/Notice_of_Custom_Content_Item_Created</template>
    </alerts>
    <fieldUpdates>
        <fullName>Fill_Content_Team_Due_Date</fullName>
        <field>Content_Team_Due_Date__c</field>
        <formula>Topic__r.Training_Event__r.Training_Start_Date__c -45</formula>
        <name>Fill Content Team Due Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Fill_Production_Due_Date</fullName>
        <field>Production_Due_Date__c</field>
        <formula>Topic__r.Training_Event__r.Training_Start_Date__c - 30</formula>
        <name>Fill Production Due Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Pre_sale_field</fullName>
        <field>Pre_sales_Request__c</field>
        <literalValue>1</literalValue>
        <name>Update Pre-sale field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Auto-fill Due Dates</fullName>
        <actions>
            <name>Fill_Content_Team_Due_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Fill_Production_Due_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Custom_Content_Item__c.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Auto-fill Pre-sale Request</fullName>
        <actions>
            <name>Update_Pre_sale_field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Custom_Content_Item__c.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Custom_Content_Item__c.Pre_sales_Request__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.IsWon</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Custom_Content_Item__c.Date_Submitted__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notice of CCI to Production</fullName>
        <actions>
            <name>Notice_of_Custom_Content_Item_to_Production</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Custom_Content_Item__c.Production_Status__c</field>
            <operation>equals</operation>
            <value>New</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notice of Custom Content Item Created</fullName>
        <actions>
            <name>Notice_of_New_Custom_Content_Item</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>1=1</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Notice of Custom Content Item Production Status Change</fullName>
        <actions>
            <name>Notice_of_Custom_Content_Item_Changed_by_Production</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Custom_Content_Item__c.Production_Status__c</field>
            <operation>equals</operation>
            <value>Completed,In Progress,Missing Information</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notice of Custom Content Item sent to Production</fullName>
        <actions>
            <name>Notice_of_Custom_Content_Item_to_Production</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Custom_Content_Item__c.Production_Status__c</field>
            <operation>equals</operation>
            <value>New</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
