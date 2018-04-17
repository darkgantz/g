<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>New_Change_Request_Content</fullName>
        <ccEmails>OSSALESFORMS@skillpath.com</ccEmails>
        <description>New Change Request - Content</description>
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
        <template>Change_Request_Templates/Change_Request_Content</template>
    </alerts>
    <alerts>
        <fullName>New_Change_Request_Financial</fullName>
        <ccEmails>OSSALESFORMS@skillpath.com</ccEmails>
        <description>New Change Request - Financial</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Change_Request_Templates/Change_Request_Financial</template>
    </alerts>
    <alerts>
        <fullName>New_Change_Request_Location</fullName>
        <ccEmails>OSSALESFORMS@skillpath.com</ccEmails>
        <description>New Change Request - Location</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Change_Request_Templates/Change_Request_Location</template>
    </alerts>
    <alerts>
        <fullName>New_Change_Request_People</fullName>
        <ccEmails>OSSALESFORMS@skillpath.com</ccEmails>
        <description>New Change Request - People</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Change_Request_Templates/Change_Request_People</template>
    </alerts>
    <alerts>
        <fullName>New_Change_Request_Scheduling</fullName>
        <ccEmails>OSSALESFORMS@skillpath.com</ccEmails>
        <description>New Change Request - Scheduling</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Change_Request_Templates/Change_Request_Scheduling</template>
    </alerts>
    <alerts>
        <fullName>New_Change_Request_Webinar</fullName>
        <ccEmails>OSSALESFORMS@skillpath.com</ccEmails>
        <description>New Change Request - Webinar</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Change_Request_Templates/Change_Request_Webinar</template>
    </alerts>
    <alerts>
        <fullName>Notice_of_Change_Request_Created</fullName>
        <description>Notice of Change Request Created</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>On_site_Ops/Notice_of_Change_Request_Created</template>
    </alerts>
    <rules>
        <fullName>Change Request Completed</fullName>
        <actions>
            <name>Notice_of_Change_Request_Created</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Change_Request__c.Status__c</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>New Change Request - Content</fullName>
        <actions>
            <name>New_Change_Request_Content</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Change_Request__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Content</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Change Request - Financial</fullName>
        <actions>
            <name>New_Change_Request_Financial</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Change_Request__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Financial</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Change Request - Location</fullName>
        <actions>
            <name>New_Change_Request_Location</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Change_Request__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Location</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Change Request - People</fullName>
        <actions>
            <name>New_Change_Request_People</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Change_Request__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>People</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Change Request - Scheduling</fullName>
        <actions>
            <name>New_Change_Request_Scheduling</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Change_Request__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Scheduling</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Change Request - Webinar</fullName>
        <actions>
            <name>New_Change_Request_Webinar</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Change_Request__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Webinar Details</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
