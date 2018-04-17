public with sharing class SP_ConvertTrainingEventController {

    private string oppID;
    public  string idopp{set;get;}
    
    private List<OpportunityLineItem>       listproduct;
    private List<Custom_Content_Item__c>    listCustomItems;
    private List<Topic__c>                  listSession;
    
    private Opportunity             opp;
    private Topic__c                topic;
    private Training_Event__c       trainingEvent;
    private Custom_Content_Item__c  CustomItem;
    
    public void SP_ConvertTrainingEventController(){
    
    }
     
    public PageReference init(){
        setoppID(ApexPages.currentPage().getParameters().get('id'));
        idopp = getOppID();
        opp = new Opportunity();
        opp = [Select   AccountID,  
                        Airport_Drive_time__c,
                        Billing_Contact__c,
                        Cancellation_Fee__c,
                        Webinar_Platform__c,
                        Contract_Amount__c,
                        Conversion_Rate__c,
                        Currency_Conversion__c,
                        Decision_Maker__c,
                        Fee_Adjustment__c,
                        Fee_Per_Day__c,
                        General_Session_Notes__c,
                        Mandatory_Attendance__c,
                        Max_Attendees__c,
                        name,
                        id,
                        Description,
                        RecordTypeid,
                        RecordType.name,
                        Projector_Provided__c,
                        Recommended_Hotel__c,
                        Recommended_Hotel__r.Name,
                        Related_Tax_Rate__c,
                        Date_Options_Available__c,
                        Shipping_Attention_Line__c,
               			Shipping_Contact__r.Name,
                        Shipping_Contact__c,
                        Date_Options__c,
                        Tax_Calculation__c,
                        Trainer_Requested__c,
                        Trainer_Requested__r.Name,
                        Trainer_detail__c,
                        Training_Location_Contact__c,
                        Travel_Notes__c,
                        Webinar_Hosting__c,
                        End_Time__c,
                        Start_Time__c,
                        TrainingStartDate__c,
                        //Number_of_Days__c,
                        TotalOpportunityQuantity,
                        Opportunity_Converted__c,
                        Billing_Currency__c,
                        Webinar_Attendees_Per_Session__c,
                        Webinar_Evaluation_Link__c,
                        Webinar_Notes__c,
                        Webinar_Same_Attendees_per_Session__c,
                        Webinar_Session_Times__c,
                        Webinar_Time_Zone__c,
                        Cost_Per_Additional_Attendee__c,
               			PO_Number__c,
               			Webinar_Recording_Required__c,
               			Hard_Expenses_USD__c,
               			OwnerId,
               			Owner.IsActive,
               			Training_of_Days__c,
               			Training_Location_Contact__r.Name,
               			Training_Location_Contact__r.MailingStreet,
               			Training_Location_Contact__r.MailingCity,
               			Training_Location_Contact__r.MailingState,
                        Training_Location_Contact__r.MailingPostalCode,
                        Training_Location_Contact__r.MailingCountry,
               			Invoice_Hard_Expenses__c
                from Opportunity where id=:idopp limit 1];
        listproduct = new List<OpportunityLineItem>(
                        [Select     End_Time__c,
                                    Line_Item_Commission_Percent__c,
                                    Number_of_hours__c,
                                    ProductCode,
                                    Name,
                                    Quantity,
                                    Topic_Name__c,
                                    UnitPrice,
                                    Start_Time__c,
                                    TotalPrice,
                                    Product2.Name,
                                    End_Date__c,
                                    Start_Date__c,
                                    Workbook_Country__c,
                                    Workbook_ID__c,
                                    Workbook_Location__c,
                                    Workbook_UPC__c,
                         			Content_Pack__c,
                         			Modality__c,
                         			Type__c
                          From OpportunityLineItem Where Opportunityid =:opp.id]);
                          
        trainingEvent = new Training_Event__c();
        
        // field asker from user story
        trainingEvent.Account__c                        =   opp.AccountID;
        trainingEvent.Airport_Drive_time__c             =   opp.Airport_Drive_time__c;
        
        if (opp.Billing_Contact__c != null){
            trainingEvent.Billing_Contact__c                =   opp.Billing_Contact__c;
        }
        trainingEvent.Date_Options__c                   =   opp.Date_Options__c;
        trainingEvent.Date_Options_Available__c         =   opp.Date_Options_Available__c;  
        
        // 2015-03-07 RM: removed per Jason Spainhour's request
        //trainingEvent.Cancellation_Fee__c               =   opp.Cancellation_Fee__c;
        trainingEvent.Client_Webinar_Platform__c        =   opp.Webinar_Platform__c;
        
        // 2015-03-07 RM: removed per Jason Spainhour's request
        //trainingEvent.Contract_Amount__c                =   opp.Contract_Amount__c;
        trainingEvent.Conversion_Rate__c                =   opp.Conversion_Rate__c;
        
        // 2015-03-07 RM: removed per Jason Spainhour's request
        //trainingEvent.Currency_Conversion__c            =   opp.Currency_Conversion__c;
        trainingEvent.Decision_Maker__c                 =   opp.Decision_Maker__c;
        
        // 2015-03-07 RM: remoed per Jason Spainhour's request
        //trainingEvent.Fee_Adjustment__c                 =   opp.Fee_Adjustment__c;
        
        //trainingEvent.Fee_Per_Day__c                    =   opp.Fee_Per_Day__c;
        trainingEvent.General_Session_Notes__c          =   opp.General_Session_Notes__c;
        trainingEvent.Mandatory_Attendance__c           =   opp.Mandatory_Attendance__c;
        trainingEvent.Max_Attendees__c                  =   opp.Max_Attendees__c;
        trainingEvent.name                              =   opp.name;
        trainingEvent.Opportunity__c                    =   opp.id;
        trainingEvent.Opportunity_Description__c        =   opp.Description;
        trainingEvent.Opportunity_Record_Type_Name__c   =   opp.RecordType.name;
        trainingEvent.Projector_Provided__c             =   opp.Projector_Provided__c;
        if (opp.Recommended_Hotel__r != null){
            trainingEvent.Recommended_Hotel__c              =   opp.Recommended_Hotel__r.Name;
        }
        trainingEvent.Related_Tax_Rate__c               =   opp.Related_Tax_Rate__c;
        
        // 2015-03-17 RM: added per Jason Spainhour's request
        if(opp.Shipping_Attention_Line__c != null) {
        	trainingEvent.Shipping_Attention_Line__c        =   opp.Shipping_Attention_Line__c;
        } else if(opp.Shipping_Contact__c != null) {
            trainingEvent.Shipping_Attention_Line__c = opp.Shipping_Contact__r.Name;
        }
        
        trainingEvent.Shipping_Contact__c               =   opp.Shipping_Contact__c;
        
        // 2015-03-07 RM: removed per Jason Spainhour's request
        //trainingEvent.Tax_Calculation__c                =   opp.Tax_Calculation__c;
        
        if (opp.Trainer_Requested__r != null){
            trainingEvent.Trainer_Requested__c              =   opp.Trainer_Requested__r.Name;
        }
        //trainingEvent.Trainer_detail__c                 =   opp.Trainer_detail__c;
        trainingEvent.Training_Location_Contact__c      =   opp.Training_Location_Contact__c;
        trainingEvent.Travel_Notes__c                   =   opp.Travel_Notes__c;
        trainingEvent.Webinar_Hosting__c                =   opp.Webinar_Hosting__c;
        
        trainingEvent.End_Time__c                       =   opp.End_Time__c; 
        trainingEvent.Start_Time__c                     =   opp.Start_Time__c;
        
        // 2015-09-22 RM: modified the logic to populate Training Start Date & Times if Date Options is blank
        /* 2016-01-04 RM: modified the logic to remove the previously implemented IF block
        if(opp.Date_Options__c != null) {
            trainingEvent.Training_Start_Date__c            =   null;
        } else {
            trainingEvent.Training_Start_Date__c            =   opp.TrainingStartDate__c;            
        }
        **/
        trainingEvent.Training_Start_Date__c            =   opp.TrainingStartDate__c;
        
        // 2015-10-14 RM: modified mapping to an opportunity field with this value
        trainingEvent.Training_Num_of_Days__c            =  opp.Training_of_Days__c;

        // 2015-03-25 RM: added per Jason Spainhour's request
        trainingEvent.Webinar_Attendees_Per_Session__c = opp.Webinar_Attendees_Per_Session__c;
        trainingEvent.Webinar_Evaluation_Link__c = opp.Webinar_Evaluation_Link__c;
        trainingEvent.Webinar_Notes__c = opp.Webinar_Notes__c;
        trainingEvent.Webinar_Same_Attendees_per_Session__c = opp.Webinar_Same_Attendees_per_Session__c;
        trainingEvent.Webinar_Session_Times__c = opp.Webinar_Session_Times__c;
        trainingEvent.Webinar_Time_Zone__c = opp.Webinar_Time_Zone__c;
        trainingEvent.Billing_Currency__c = opp.Billing_Currency__c;
        
        // 2015-05-07 RM: added per Jason Spainhour's request
        trainingEvent.Cost_per_Additional_Attendee__c = opp.Cost_Per_Additional_Attendee__c;
        
        // 2015-06-29 RM: added per Jason Spainhour's request
        trainingEvent.PO_Number__c = opp.PO_Number__c;
        
        // 2015-07-15 RM: added per Jason Spainhour's request
        trainingEvent.Webinar_Recording_Required__c = opp.Webinar_Recording_Required__c;
        
        // 2015-08-12 RM: added per Heidi Ballew's request
        trainingEvent.Hard_Expenses_USD__c = opp.Hard_Expenses_USD__c;
        
        // 2015-10-27 RM: added per Jason Spainhour's request
        trainingEvent.Training_Location_Contact_Name__c = opp.Training_Location_Contact__r.Name;
		trainingEvent.Training_Location_Contact_Street__c = opp.Training_Location_Contact__r.MailingStreet;
		trainingEvent.Training_Location_Contact_City__c = opp.Training_Location_Contact__r.MailingCity;
		trainingEvent.Training_Location_Contact_State__c = opp.Training_Location_Contact__r.MailingState;
		trainingEvent.Training_Location_Contact_Postal_Code__c = opp.Training_Location_Contact__r.MailingPostalCode;
		trainingEvent.Training_Location_Contact_Country__c = opp.Training_Location_Contact__r.MailingCountry;
        
        // 2015-12-09 RM: added per Jason Spainhour's request
        trainingEvent.Invoice_Hard_Expenses__c = opp.Invoice_Hard_Expenses__c;
        
        // 2015-09-01 RM: added per Jason Spainhour's request
        if(opp.Owner.IsActive) {
            trainingEvent.Original_TE_Owner__c = opp.OwnerId;
        }

        insert trainingEvent;
        
        if( (listproduct != null)&& (listproduct.size()>0) ){
            
            ListSession = new List<Topic__c> ();    
            for(OpportunityLineItem var : listproduct){
                topic = new Topic__c();

				// 2015-06-10 RM: removed "topic.Name" as object definition changed to auto-number
                topic.Topic_Name__c = var.Topic_Name__c;
                
                if (topic.Topic_Name__c == null){
                    topic.Topic_Name__c = var.Product2.Name;
                }
                
                topic.Training_Event__c = trainingEvent.id;
                
                topic.Commission_Adjustment_Percent__c  =   var.Line_Item_Commission_Percent__c;
                topic.Number_of_Hours__c                =   var.Number_of_hours__c;
                topic.Product_Code__c                   =   var.ProductCode;
                topic.Product_Name__c                   =   var.Product2.Name;
                topic.Quantity__c                       =   var.Quantity;
                topic.Sales_Price__c                    =   var.UnitPrice;                
                topic.Total_Price__c                    =   var.TotalPrice;
                topic.Product_Name__c                   =   var.Product2.Name;
                topic.Training_Start_Date__c            =   var.Start_Date__c;
                topic.Workbook_Country__c               =   var.Workbook_Country__c;
                topic.Workbook_ID__c                    =   var.Workbook_ID__c;
                topic.Workbook_Location__c              =   var.Workbook_Location__c;
                topic.Workbook_UPC__c                   =   var.Workbook_UPC__c;
                topic.Content_Pack__c                   =   var.Content_Pack__c;
				topic.Modality__c                       =   var.Modality__c;
				topic.Type__c                           =   var.Type__c;
                
                ListSession.add(topic);
                
            }
            
            insert ListSession;
            
            // converted checkbox on opportunty 
            opp.Opportunity_Converted__c = true;
            upsert opp;
            
            // update Custom Items with Training Event ID 
            
            listCustomItems = new List<Custom_Content_Item__c>([SELECT id, Training_Event_ID__c  FROM Custom_Content_Item__c WHERE Opportunity__c = :opp.id  ]);
            if((listCustomItems != null) && (listCustomItems.size() >0)){
                for( Custom_Content_Item__c var : listCustomItems ){
                    var.Training_Event_ID__c = trainingEvent.Name;
                }
                    upsert listCustomItems;
            }
        }else{}               
        
        PageReference pageRef = new PageReference('/'+trainingEvent.id);
        return pageRef;
    }
    private string getOppID(){
        return oppID;
    }
    private void setOppID(string o){
        oppID = o;
    }
}