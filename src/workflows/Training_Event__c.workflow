<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Custom_Training_Event_Change_Notif</fullName>
        <description>Custom Training Event Change Notif</description>
        <protected>false</protected>
        <recipients>
            <recipient>jspainhour@natsem.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>On_site_Ops/Custom_Training_Event_Change_Notif</template>
    </alerts>
    <alerts>
        <fullName>Notice_of_New_Training_Event</fullName>
        <ccEmails>OSSalesForms@skillpath.com</ccEmails>
        <description>Notice of New Training Event</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>On_site_Ops/TE_Created_Notice</template>
    </alerts>
    <alerts>
        <fullName>Notice_of_New_Training_Event_Urgent</fullName>
        <ccEmails>OSSalesForms@skillpath.com</ccEmails>
        <description>Notice of New Training Event - Urgent</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>On_site_Ops/TE_Created_Notice_Urgent</template>
    </alerts>
    <alerts>
        <fullName>Notification_of_Canceled_TE</fullName>
        <description>Notification of Canceled TE</description>
        <protected>false</protected>
        <recipients>
            <recipient>astrong@natsem.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/TE_cancelled_or_TBD</template>
    </alerts>
    <alerts>
        <fullName>Send_Internal_Post_TE_Survey</fullName>
        <description>Send Internal Post Training Event Survey</description>
        <protected>false</protected>
        <recipients>
            <field>Original_TE_Owner__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>On_site_Ops/Post_Event_Internal_Surve</template>
    </alerts>
    <alerts>
        <fullName>Send_Post_Training_Event_Survey</fullName>
        <ccEmails>lnhartman@natsem.net</ccEmails>
        <description>Send Post Training Event Survey</description>
        <protected>false</protected>
        <recipients>
            <field>Decision_Maker__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>On_site_Ops/Post_Event_Survey</template>
    </alerts>
    <alerts>
        <fullName>TE_Webinar_Recording_Required</fullName>
        <description>TE Webinar Recording Required</description>
        <protected>false</protected>
        <recipients>
            <recipient>sdenyeart@natsem.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>On_site_Ops/Webinar_Recording_Required</template>
    </alerts>
    <fieldUpdates>
        <fullName>Clear_Start_Date_when_Date_Options_Exist</fullName>
        <field>Training_Start_Date__c</field>
        <name>Clear Start Date when Date Options Exist</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Pre_FY15_Qtr_Performed_Update</fullName>
        <description>If the event is completed, stamp the record with the quarter of the Training End Date in the Quarter Performed field, through Q4 of FY15</description>
        <field>Quarter_Performed__c</field>
        <formula>IF( Training_End_Date__c &lt; DATE(2007, 6, 3), &quot;QX&quot;, 
IF( AND( Training_End_Date__c &gt;= DATE(2007, 6, 3), Training_End_Date__c &lt; DATE(2007, 9, 2)), &quot;Q1&quot;, 
IF( AND( Training_End_Date__c &gt;= DATE(2007, 9, 2), Training_End_Date__c &lt; DATE(2007, 12, 2)), &quot;Q2&quot;, 
IF( AND( Training_End_Date__c &gt;= DATE(2007, 12, 2), Training_End_Date__c &lt; DATE(2008, 3, 2)), &quot;Q3&quot;, 
IF( AND( Training_End_Date__c &gt;= DATE(2008, 3, 2), Training_End_Date__c &lt; DATE(2008, 6, 1)), &quot;Q4&quot;, 
IF( AND( Training_End_Date__c &gt;= DATE(2008, 6, 1), Training_End_Date__c &lt; DATE(2008, 8, 31)), &quot;Q1&quot;, 
IF( AND( Training_End_Date__c &gt;= DATE(2008, 8, 31), Training_End_Date__c &lt; DATE(2008, 11, 30)), &quot;Q2&quot;, 
IF( AND( Training_End_Date__c &gt;= DATE(2008, 11, 30), Training_End_Date__c &lt; DATE(2009, 3, 1)), &quot;Q3&quot;, 
IF( AND( Training_End_Date__c &gt;= DATE(2009, 3, 1), Training_End_Date__c &lt; DATE(2009, 5, 31)), &quot;Q4&quot;, 
IF( AND( Training_End_Date__c &gt;= DATE(2009, 5, 31), Training_End_Date__c &lt; DATE(2009, 8, 30)), &quot;Q1&quot;, 
IF( AND( Training_End_Date__c &gt;= DATE(2009, 8, 30), Training_End_Date__c &lt; DATE(2009, 11, 29)), &quot;Q2&quot;, 
IF( AND( Training_End_Date__c &gt;= DATE(2009, 11, 29), Training_End_Date__c &lt; DATE(2010, 2, 28)), &quot;Q3&quot;, 
IF( AND( Training_End_Date__c &gt;= DATE(2010, 2, 28), Training_End_Date__c &lt; DATE(2010, 5, 30)), &quot;Q4&quot;, 
IF( AND( Training_End_Date__c &gt;= DATE(2010, 5, 30), Training_End_Date__c &lt; DATE(2010, 8, 29)), &quot;Q1&quot;, 
IF( AND( Training_End_Date__c &gt;= DATE(2010, 8, 29), Training_End_Date__c &lt; DATE(2010, 11, 28)), &quot;Q2&quot;, 
IF( AND( Training_End_Date__c &gt;= DATE(2010, 11, 28), Training_End_Date__c &lt; DATE(2011, 2, 27)), &quot;Q3&quot;, 
IF( AND( Training_End_Date__c &gt;= DATE(2011, 2, 27), Training_End_Date__c &lt; DATE(2011, 6, 5)), &quot;Q4&quot;, 
IF( AND( Training_End_Date__c &gt;= DATE(2011, 6, 5), Training_End_Date__c &lt; DATE(2011, 9, 4)), &quot;Q1&quot;, 
IF( AND( Training_End_Date__c &gt;= DATE(2011, 9, 4), Training_End_Date__c &lt; DATE(2011, 12, 4)), &quot;Q2&quot;, 
IF( AND( Training_End_Date__c &gt;= DATE(2011, 12, 4), Training_End_Date__c &lt; DATE(2012, 3, 4)), &quot;Q3&quot;, 
IF( AND( Training_End_Date__c &gt;= DATE(2012, 3, 4), Training_End_Date__c &lt; DATE(2012, 6, 3)), &quot;Q4&quot;, 
IF( AND( Training_End_Date__c &gt;= DATE(2012, 6, 3), Training_End_Date__c &lt; DATE(2012, 9, 2)), &quot;Q1&quot;, 
IF( AND( Training_End_Date__c &gt;= DATE(2012, 9, 2), Training_End_Date__c &lt; DATE(2012, 12, 2)), &quot;Q2&quot;, 
IF( AND( Training_End_Date__c &gt;= DATE(2012, 12, 2), Training_End_Date__c &lt; DATE(2013, 3, 3)), &quot;Q3&quot;, 
IF( AND( Training_End_Date__c &gt;= DATE(2013, 3, 3), Training_End_Date__c &lt; DATE(2013, 6, 2)), &quot;Q4&quot;, 
IF( AND( Training_End_Date__c &gt;= DATE(2013, 6, 2), Training_End_Date__c &lt; DATE(2013, 9, 1)), &quot;Q1&quot;, 
IF( AND( Training_End_Date__c &gt;= DATE(2013, 9, 1), Training_End_Date__c &lt; DATE(2013, 12, 1)), &quot;Q2&quot;, 
IF( AND( Training_End_Date__c &gt;= DATE(2013, 12, 1), Training_End_Date__c &lt; DATE(2014,3, 2)), &quot;Q3&quot;, 
IF( AND( Training_End_Date__c &gt;= DATE(2014, 3, 2), Training_End_Date__c &lt; DATE(2014, 6, 1)), &quot;Q4&quot;, 
IF( AND( Training_End_Date__c &gt;= DATE(2014, 6, 1), Training_End_Date__c &lt; DATE(2014, 8, 31)), &quot;Q1&quot;, 
IF( AND( Training_End_Date__c &gt;= DATE(2014, 8, 31), Training_End_Date__c &lt; DATE(2014, 11, 30)), &quot;Q2&quot;, 
IF( AND( Training_End_Date__c &gt;= DATE(2014, 11, 30), Training_End_Date__c &lt; DATE(2015, 3, 1)), &quot;Q3&quot;, 
IF( AND( Training_End_Date__c &gt;= DATE(2015, 3, 1), Training_End_Date__c &lt; DATE(2015, 5, 31)), &quot;Q4&quot;, 
&quot;XQ&quot;) 
))))))))))))))))))))))))))))))))</formula>
        <name>Pre-FY15 Qtr Performed Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Training_Date_Is_Changed_Count</fullName>
        <field>Training_Date_Change_Tracking__c</field>
        <formula>IF(Training_Date_Change_Tracking__c&lt;&gt;0,
  Training_Date_Change_Tracking__c +1
,1)</formula>
        <name>Training Date Is Changed Count</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Conversion_Rate</fullName>
        <field>Conversion_Rate__c</field>
        <formula>Billing_Currency__r.Conversion_Rate__c</formula>
        <name>Update Conversion Rate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Clear Start Date when Date Options Exist</fullName>
        <actions>
            <name>Clear_Start_Date_when_Date_Options_Exist</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Training_Event__c.Date_Options__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Custom Training Event Change</fullName>
        <actions>
            <name>Custom_Training_Event_Change_Notif</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>CONTAINS(Opportunity__r.Legacy_Record_Type_Name__c, &apos;Custom&apos;) &amp;&amp; ( (TEXT(Status__c) = &apos;Canceled&apos; &amp;&amp; TEXT(PRIORVALUE(Status__c)) != &apos;Canceled&apos;) || (TEXT(Status__c) = &apos;TBD&apos; &amp;&amp; TEXT(PRIORVALUE(Status__c)) != &apos;TBD&apos;) || ISCHANGED( Training_Start_Date__c ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notice of TE Created</fullName>
        <actions>
            <name>Notice_of_New_Training_Event</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>Training_Start_Date__c - TODAY() &gt;= 24</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Notice of TE Created - Urgent Due to Timing</fullName>
        <actions>
            <name>Notice_of_New_Training_Event_Urgent</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>Training_Start_Date__c - TODAY() &lt; 24 || ISBLANK(Training_Start_Date__c)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Quarter Performed Update</fullName>
        <actions>
            <name>Pre_FY15_Qtr_Performed_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Training_Event__c.Status__c</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Training_Event__c.Quarter_Performed__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>If the event is completed, stamp the record with the quarter of the Training End Date in the Quarter Performed field on the Training Event</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Post Training Event Survey</fullName>
        <actions>
            <name>Send_Internal_Post_TE_Survey</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Send_Post_Training_Event_Survey</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>NOT( Decision_Maker__r.Is_Exclude_from_Post_Event_Survey__c ) &amp;&amp; ISPICKVAL( Status__c, &quot;Performed&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TE Webinar Recording Required</fullName>
        <actions>
            <name>TE_Webinar_Recording_Required</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Training_Event__c.Webinar_Recording_Required__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TE canceled or TBD</fullName>
        <actions>
            <name>Notification_of_Canceled_TE</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Training_Event__c.Status__c</field>
            <operation>equals</operation>
            <value>TBD,Canceled</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Training Date Is Changed Count Calculation</fullName>
        <actions>
            <name>Training_Date_Is_Changed_Count</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED( Training_Start_Date__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Conversion Rate</fullName>
        <actions>
            <name>Update_Conversion_Rate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED( Billing_Currency__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
