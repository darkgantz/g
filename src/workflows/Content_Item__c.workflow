<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Notice_of_Content_Item_Changed_by_Production</fullName>
        <ccEmails>OSIDTeam@skillpath.com</ccEmails>
        <description>Notice of Content Item Changed by Production</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Content_Pack_and_Items/Notice_of_CI_Changed_by_Production</template>
    </alerts>
    <alerts>
        <fullName>Notice_of_Content_Item_to_Design</fullName>
        <description>Notice of Content Item to Design</description>
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
        <template>Content_Pack_and_Items/Content_Item_Assigned_to_Design</template>
    </alerts>
    <alerts>
        <fullName>Notice_of_Content_Item_to_Production</fullName>
        <description>Notice of Content Item to Production</description>
        <protected>false</protected>
        <recipients>
            <recipient>ahoux@natsem.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bschepers@natsem.com</recipient>
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
        <template>Content_Pack_and_Items/Content_Item_Assigned_to_Production</template>
    </alerts>
    <alerts>
        <fullName>Notice_of_New_Content_Item_to_IDs</fullName>
        <ccEmails>OSIDTeam@skillpath.com</ccEmails>
        <description>Notice of New Content Item to IDs</description>
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
        <template>Content_Pack_and_Items/Notice_of_Content_Item_Created</template>
    </alerts>
    <alerts>
        <fullName>Notice_of_New_Content_Item_to_IDs_3rd_Party</fullName>
        <ccEmails>OSIDTeam@skillpath.com</ccEmails>
        <description>Notice of New Content Item to IDs - 3rd Party</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Content_Pack_and_Items/Notice_of_Content_Item_Created</template>
    </alerts>
    <fieldUpdates>
        <fullName>Set_Content_Item_Name</fullName>
        <field>Name</field>
        <formula>LEFT(TEXT(Item_Type__c) + &apos;: &apos; + Content_Pack__r.Name ,80)</formula>
        <name>Set Content Item Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Notice of Content Item Created - Post-Sales</fullName>
        <actions>
            <name>Notice_of_New_Content_Item_to_IDs</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>Opp_Won__c &amp;&amp; NOT(PRIORVALUE(Opp_Won__c)) &amp;&amp; (  /* EXCLUDING PRE-SALES TYPES ALREADY BEING SENT ON OTHER ALERT */ TEXT( Item_Type__c ) &lt;&gt; &apos;Outline&apos; ||  TEXT( Item_Type__c ) &lt;&gt; &apos;Sales Proposal&apos; ||  TEXT( Item_Type__c ) &lt;&gt; &apos;RFP&apos; ||  TEXT( Item_Type__c ) &lt;&gt; &apos;Curriculum&apos; ||  TEXT( Item_Type__c ) &lt;&gt; &apos;Other&apos; ||  TEXT( Item_Type__c ) &lt;&gt; &apos;Content Sample&apos;      )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notice of Content Item Created - Post-Sales 3rd Party</fullName>
        <actions>
            <name>Notice_of_New_Content_Item_to_IDs_3rd_Party</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>Opp_Won__c &amp;&amp; NOT(PRIORVALUE(Opp_Won__c)) &amp;&amp; TEXT( Item_Type__c ) = &apos;Workbook - Logical Operations&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notice of Content Item Created - Pre-Sales</fullName>
        <actions>
            <name>Notice_of_New_Content_Item_to_IDs</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>NOT( Content_Pack__r.Opportunity__r.IsClosed ) &amp;&amp; ( TEXT( Item_Type__c ) = &apos;Outline&apos; || TEXT( Item_Type__c ) = &apos;Sales Proposal&apos; || TEXT( Item_Type__c ) = &apos;RFP&apos; || TEXT( Item_Type__c ) = &apos;Curriculum&apos; || TEXT( Item_Type__c ) = &apos;Other&apos; || TEXT( Item_Type__c ) = &apos;Content Sample&apos; )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Notice of Content Item Production Status Change</fullName>
        <actions>
            <name>Notice_of_Content_Item_Changed_by_Production</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Content_Item__c.Production_Status__c</field>
            <operation>equals</operation>
            <value>In Progress,Missing Information,Completed</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notice of Content Item sent to Design</fullName>
        <actions>
            <name>Notice_of_Content_Item_to_Design</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Content_Item__c.Design_Status__c</field>
            <operation>equals</operation>
            <value>New</value>
        </criteriaItems>
        <criteriaItems>
            <field>Content_Item__c.Content_Designer__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notice of Content Item sent to Production</fullName>
        <actions>
            <name>Notice_of_Content_Item_to_Production</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Content_Item__c.Production_Status__c</field>
            <operation>equals</operation>
            <value>New</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Content Item Name</fullName>
        <actions>
            <name>Set_Content_Item_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Content_Item__c.Item_Type__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Content_Pack__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
