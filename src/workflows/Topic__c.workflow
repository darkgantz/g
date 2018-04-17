<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Alert_Andrea_Strong_to_topic_changes</fullName>
        <description>Alert Andrea Strong to topic changes</description>
        <protected>false</protected>
        <recipients>
            <recipient>jspainhour@natsem.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Topic_has_changed</template>
    </alerts>
    <alerts>
        <fullName>Notification_of_Topic_Modality_Content_Licence</fullName>
        <description>Notification of Topic Modality &apos;Content Licence&apos;</description>
        <protected>false</protected>
        <recipients>
            <recipient>jmccabe@natsem.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>ljackson@natsem.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>On_site_Ops/Notification_of_Topic_Modality_Content_Licence</template>
    </alerts>
    <fieldUpdates>
        <fullName>Set_Topic_Name</fullName>
        <field>Topic_Name__c</field>
        <formula>IF( ISBLANK( Content_Pack__c ),
 Product_Name__c ,
Content_Pack__r.Name)</formula>
        <name>Set Topic Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Total_Price</fullName>
        <field>Total_Price__c</field>
        <formula>Quantity__c *  Sales_Price__c</formula>
        <name>Set Total Price</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>check_clear_product_lookup</fullName>
        <field>Clear_Product_Lookup__c</field>
        <literalValue>1</literalValue>
        <name>check clear product lookup</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>update_product_code</fullName>
        <field>Product_Code__c</field>
        <formula>Fill_product_values__r.ProductCode</formula>
        <name>update product code</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>update_product_name</fullName>
        <field>Product_Name__c</field>
        <formula>Fill_product_values__r.Name</formula>
        <name>update product name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>update_workbook_id</fullName>
        <field>Workbook_ID__c</field>
        <formula>Fill_product_values__r.Workbook_UPC__c</formula>
        <name>update workbook id</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>update_workbook_location</fullName>
        <field>Workbook_Location__c</field>
        <formula>text(Fill_product_values__r.Workbook_Location__c)</formula>
        <name>update workbook location</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Content License Topic</fullName>
        <actions>
            <name>Notification_of_Topic_Modality_Content_Licence</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Topic__c.Modality__c</field>
            <operation>equals</operation>
            <value>Content License</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Topic Name</fullName>
        <actions>
            <name>Set_Topic_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Total Price</fullName>
        <actions>
            <name>Set_Total_Price</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Topic__c.Quantity__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Topic__c.Sales_Price__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update to topic with content pack</fullName>
        <actions>
            <name>Alert_Andrea_Strong_to_topic_changes</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Topic__c.Has_Content_Pack__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>update product fields on topic</fullName>
        <actions>
            <name>check_clear_product_lookup</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>update_product_code</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>update_product_name</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>update_workbook_id</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>update_workbook_location</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Topic__c.product_selected_for_prefill__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>when creating a new topic for training events. allow the selection of the prefill field fill in product related fields</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
