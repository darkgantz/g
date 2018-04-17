<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Closed_Won_Notification_Below_Manager_Purview</fullName>
        <ccEmails>OSSALESFORMS@skillpath.com</ccEmails>
        <description>Closed Won Notification - Below Manager Purview</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Closed_Won_Opps/Closed_Won_Notification_Below_Manager_Purview</template>
    </alerts>
    <alerts>
        <fullName>Closed_Won_Notification_Ready_to_Convert</fullName>
        <ccEmails>OSSALESFORMS@skillpath.com</ccEmails>
        <description>Closed Won Notification - Ready to Convert</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Closed_Won_Opps/Closed_Won_Notification_Ready_to_Convert</template>
    </alerts>
    <alerts>
        <fullName>Closed_Won_Notification_Sales_Manager_Transition</fullName>
        <ccEmails>ossalesforms@skillpath.com</ccEmails>
        <description>Closed Won Notification - Sales Manager / Transition</description>
        <protected>false</protected>
        <recipients>
            <field>Email_for_Opp_Owner_s_Manager__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Closed_Won_Opps/Closed_Won_Notification_Sales_Manager_Transition</template>
    </alerts>
    <fieldUpdates>
        <fullName>Add_Quarter_Sold_FY16_FY18</fullName>
        <description>FY16- FY18, if the deal is Won, merge the correct quarter value per the formula.</description>
        <field>Quarter_Sold__c</field>
        <formula>IF( CloseDate  &gt;  DATE(2018, 6, 3), &quot;XQ&quot;,
 IF( AND( CloseDate &gt;= DATE(2015, 5, 31), CloseDate &lt; DATE(2015, 8, 30)), &quot;Q1&quot;,
  IF( AND( CloseDate &gt;= DATE(2015, 8, 30), CloseDate &lt; DATE(2015, 11, 29)), &quot;Q2&quot;,
   IF( AND( CloseDate &gt;= DATE(2015, 11, 29), CloseDate &lt; DATE(2016, 2, 28)), &quot;Q3&quot;,
    IF( AND( CloseDate &gt;= DATE(2016, 2, 28), CloseDate &lt; DATE(2016, 5, 29)), &quot;Q4&quot;,
     IF( AND( CloseDate &gt;= DATE(2016, 5, 29), CloseDate &lt; DATE(2016, 8, 28)), &quot;Q1&quot;,
      IF( AND( CloseDate &gt;= DATE(2016, 8, 28), CloseDate &lt; DATE(2016, 12, 3)), &quot;Q2&quot;,
       IF( AND( CloseDate &gt;= DATE(2016, 12, 3), CloseDate &lt; DATE(2017, 3, 5)), &quot;Q3&quot;,
        IF( AND( CloseDate &gt;= DATE(2017, 3, 5), CloseDate &lt; DATE(2017, 6, 4)), &quot;Q4&quot;,
         IF( AND( CloseDate &gt;= DATE(2017, 6, 4), CloseDate &lt; DATE(2017, 9, 3)), &quot;Q1&quot;,
          IF( AND( CloseDate &gt;= DATE(2017, 9, 3), CloseDate &lt; DATE(2017, 12, 3)), &quot;Q2&quot;,
           IF( AND( CloseDate &gt;= DATE(2017, 12, 3), CloseDate &lt; DATE(2018, 3, 4)), &quot;Q3&quot;,
            IF( AND( CloseDate &gt;= DATE(2018, 2, 27), CloseDate &lt; DATE(2005, 6, 5)), &quot;Q4&quot;,
&quot;NA&quot;)
))))))))))))</formula>
        <name>Add Quarter Sold FY16-FY18</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Auto_fill_Manager_ID</fullName>
        <field>Manager_ID__c</field>
        <formula>Owner.ManagerId</formula>
        <name>Auto-fill Manager ID</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Close_Lost_Onsite</fullName>
        <field>StageName</field>
        <literalValue>Closed Lost</literalValue>
        <name>Close Lost Onsite</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Close_Onsite_Today</fullName>
        <field>CloseDate</field>
        <formula>TODAY()</formula>
        <name>Close Onsite Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Closed_Lost_Notes</fullName>
        <field>Closed_Lost_Notes__c</field>
        <formula>&quot;Auto Closed due to Opportunity age&quot;</formula>
        <name>Closed Lost Notes</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Closed_Lost_Reason</fullName>
        <field>Closed_Lost_Reason__c</field>
        <literalValue>Auto Closed</literalValue>
        <name>Closed Lost Reason</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Manager_Name</fullName>
        <field>Manager_Name__c</field>
        <formula>Owner.Manager.FirstName + &quot; &quot; + Owner.Manager.LastName</formula>
        <name>Manager Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Closed_Date_to_Today</fullName>
        <field>CloseDate</field>
        <formula>TODAY()</formula>
        <name>Set Closed Date to Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Manager_Email_Field</fullName>
        <field>Email_for_Opp_Owner_s_Manager__c</field>
        <formula>Owner.Manager.Email</formula>
        <name>Set Manager Email Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Record_Type_as_Onsite_Locked</fullName>
        <field>RecordTypeId</field>
        <lookupValue>On_site_Locked</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Set Record Type as Onsite Locked</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_With_Record_Type</fullName>
        <field>Legacy_Record_Type_Name__c</field>
        <formula>RecordType.DeveloperName</formula>
        <name>Update With Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <outboundMessages>
        <fullName>IS_Opp_Closed_Won</fullName>
        <apiVersion>32.0</apiVersion>
        <endpointUrl>https://powerstandings.insidesales.com/kpi/oppwon</endpointUrl>
        <fields>Id</fields>
        <fields>LastModifiedById</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>jspainhour@natsem.com</integrationUser>
        <name>IS - Opp Closed Won</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <rules>
        <fullName>Auto-close Date</fullName>
        <actions>
            <name>Close_Lost_Onsite</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Close_Onsite_Today</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Closed_Lost_Notes</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Closed_Lost_Reason</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>When the Opportunity is open longer than 90 days, close the Opportunity with today&apos;s date as the Close Date.</description>
        <formula>AND( 
CreatedDate + 90 &lt;= Now(), text(StageName) &lt;&gt; &quot;Closed Won&quot;,text(StageName) &lt;&gt;&quot;Closed Lost&quot; 
)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Auto-fill Owner%27s Manager</fullName>
        <actions>
            <name>Auto_fill_Manager_ID</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Manager_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.IsClosed</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.IsWon</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Manager_ID__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Closed Won Notification - Below Manager Purview</fullName>
        <actions>
            <name>Closed_Won_Notification_Below_Manager_Purview</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND ((3 AND 4) OR (5 AND 6)) AND 7</booleanFilter>
        <criteriaItems>
            <field>Opportunity.IsWon</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.IsClosed</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>On-site: Custom,On-site Standard,On-site: Webinar</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Amount</field>
            <operation>lessThan</operation>
            <value>2500</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>On-site: License</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Amount</field>
            <operation>lessThan</operation>
            <value>10000</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Name</field>
            <operation>notEqual</operation>
            <value>UBT</value>
        </criteriaItems>
        <description>Upon changing an opportunity to closed won, an email alert is sent to sales management about amounts that fall beneath a specified threshold.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Closed Won Notification - Ready to Convert</fullName>
        <actions>
            <name>Closed_Won_Notification_Ready_to_Convert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.IsClosed</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.IsWon</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Ready_to_Convert__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Upon setting &quot;Ready to Convert&quot; to true, a notification is sent to operations informing them of the need to convert to new Training Event(s).</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Closed Won Notification - Sales Manager %2F Transition</fullName>
        <actions>
            <name>Closed_Won_Notification_Sales_Manager_Transition</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.IsWon</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.IsClosed</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Upon changing an opportunity to closed won, an email alert is sent to sales rep&apos;s manager and sales-ops transition team.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Closed-Won Field Updates</fullName>
        <actions>
            <name>Add_Quarter_Sold_FY16_FY18</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Auto_fill_Manager_ID</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Manager_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Record_Type_as_Onsite_Locked</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_With_Record_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.IsClosed</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.IsWon</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>notEqual</operation>
            <value>On-site Locked</value>
        </criteriaItems>
        <description>If the opportunity is moved to closed-won, update the owner&apos;s manager field with the manager on their user record, Fiscal Quarter, etc.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>IS - Opp Closed Won</fullName>
        <actions>
            <name>IS_Opp_Closed_Won</name>
            <type>OutboundMessage</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Closed Won</value>
        </criteriaItems>
        <description>InsideSales counter for Opps Closed Won</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Closed Date to Today</fullName>
        <actions>
            <name>Set_Closed_Date_to_Today</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.IsClosed</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.IsWon</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Manager Email Field</fullName>
        <actions>
            <name>Set_Manager_Email_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates the manager&apos;s email field on the opportunity.</description>
        <formula>ISNEW() || ISCHANGED(OwnerId)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>When auto close date updated</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Auto_CloseDate__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>notEqual</operation>
            <value>Closed Won,Closed Lost</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Close_Lost_Onsite</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>Close_Onsite_Today</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Opportunity.Auto_CloseDate__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <tasks>
        <fullName>Opportunity_Resubmit</fullName>
        <assignedToType>owner</assignedToType>
        <description>UPDATE OPPORTUNITY AND RESUBMIT TO YOUR MANAGER FOR APPROVAL</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Highly Likely</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Opportunity Resubmit</subject>
    </tasks>
</Workflow>
