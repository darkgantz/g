public with sharing class TrainingSeriesCreatorController {
    
    //Opportunity 
    public Opportunity opp {get;set;}
    
    //Opportunity Topics
    public List<OpportunityLineItem> listOppProd {get;set;}
    private Map<String,Topic__c> topicMap {get;set;}
    
    //Training Event
    private List<Training_Event__c> listOfTrainingEvents {get;set;}
    public List<InnerTrainingEvent> listOfInnerTrainingEvents {get;set;}
    
    //Important variables
    private Map<Id, Set<String>> mapEventWithOppLineItems = new Map<Id, Set<String>>() ;
    
    //String to be used as Training Series Id or Opportunity Id
    private String sObjectId {get;set;}
    
    public List<String> errorMessage {get;set;}
    
    public Boolean modifyAllProfile { get; set; }
    
    
    public TrainingSeriesCreatorController(ApexPages.StandardController stdCon) {
        Map<Id, Profile> modifyAllProfilesMap = new Map<Id, Profile>([select Name from Profile where Name IN ('Operations', 'System Administrator')]);
        this.modifyAllProfile = modifyAllProfilesMap.containsKey(UserInfo.getProfileId()) ? true : false;
        //Training Events to be created based on Opp Topics
        listOfTrainingEvents = new List<Training_Event__c>();
        listOfInnerTrainingEvents = new List<InnerTrainingEvent>();
        
        errorMessage = new List<String>();
        errorMessage.add('');
        
        //Opportunity Record
        sObjectId = ApexPages.currentPage().getParameters().get('oppId');
        
        this.opp = getOpportunity();
        
        
        if(sObjectId != null){
            
            
            listOfTrainingEvents = [Select Id,
                                    Name,
                                    Training_Num_of_Days__c,
                                    Training_Location_Contact__c,
                                    Start_Time__c,
                                    Training_Start_Date__c,
                                    Training_End_Date__c,
                                    Trainer_Requested_Contact__c,
                                    Date_Options__c,
                                    Training_Location_Address__c,
                                    End_Time__c,
                                    Number_of_Training__c,
                                    Status__c,
                                    Billing_Contact__c,
                                    Logistical_Contact__c,
                                    Logistical_Contact2__c,
                                    Shipping_Contact__c,
                                    Shipping_Attention_Line__c,
                                    Webinar_Session_Times__c
                                    From Training_Event__c 
                                    Where Opportunity__c = :this.opp.Id ORDER BY CreatedDate ASC];
            
            if(listOfTrainingEvents.isEmpty()){
                listOfTrainingEvents = new List<Training_Event__c>();
                listOfTrainingEvents.add(new Training_Event__c(Opportunity__c = this.opp.Id));
            }
            
        }
        
        listOppProd = new List<OpportunityLineItem>(
            [Select     
             Content_Pack__c,
             ListPrice,
             Product_Name__c,
             End_Time__c,
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
             Modality__c,
             Type__c
             From OpportunityLineItem Where Opportunityid =:sObjectId]);
        
        initializeEventsAndProducts();
        
    }
    
    private void initializeEventsAndProducts(){
        
        //LOGIC to CREATE EVENT TOPICS
        if(!listOppProd.isEmpty() && !listOfTrainingEvents.isEmpty()){
            
            Set<Id> trainingEventsIds = new Set<Id>();
            
            topicMap = new Map<String,Topic__c>();
            
            for(Training_Event__c te1 : this.listOfTrainingEvents) trainingEventsIds.add(te1.Id);
            
            for(Topic__c topic : [Select Id, Training_Event__c, Opportunity_LineItem_ID__c, Quantity__c, Number_of_workbooks__c From Topic__c Where Training_Event__c IN :trainingEventsIds]){
                if(mapEventWithOppLineItems.get(topic.Training_Event__c) == null){
                    mapEventWithOppLineItems.put(topic.Training_Event__c, new Set<String>());    
                }
                if(topic.Opportunity_LineItem_ID__c != null)
                    mapEventWithOppLineItems.get(topic.Training_Event__c).add(topic.Opportunity_LineItem_ID__c);
                
                topicMap.put(topic.Training_Event__c + '-' + topic.Opportunity_LineItem_ID__c,topic);
            }
            
            for(Training_Event__c te : listOfTrainingEvents){
                errorMessage.add('');
                List<InnerOppProduct> listOppProductTemp = new List<InnerOppProduct>();
                InnerOppProduct io;
                for(OpportunityLineItem oppProd: listOppProd){
                    
                    io = new InnerOppProduct();
                    io.oppProd = oppProd;
                    io.isSelected = false;
                    
                    if(mapEventWithOppLineItems.get(te.Id) != null){
                        if(mapEventWithOppLineItems.get(te.Id).contains(oppProd.id)){
                            io.isSelected = true;
                            io.quantity = String.valueOf(topicMap.get(te.Id + '-' + oppProd.id).Quantity__c);
                            io.numberOfWorkbooks = String.valueOf(topicMap.get(te.Id + '-' + oppProd.id).Number_of_workbooks__c);
                        }else{
                            io.quantity = null;
                            io.numberOfWorkbooks = null;
                        }
                    }
                    
                    listOppProductTemp.add(io);
                }
                
                InnerTrainingEvent ite = new InnerTrainingEvent();
                
           
                if(te.Start_Time__c == null)
                    te.Start_Time__c = this.opp.Start_Time__c;
                if(te.End_Time__c == null)
                    te.End_Time__c = this.opp.End_Time__c;
            
                
                if(te.Name == null || te.Name == '')
                    te.Name = this.generateTraningEventName(this.opp.Name, 1, this.opp.Account.Name);
       			
                te.Account__c =  this.opp.AccountID;
                
                if(String.isEmpty(te.Id)){
                    te.Shipping_Attention_Line__c = this.opp.Shipping_Attention_Line__c;
                    te.Opportunity__c = this.opp.Id;
                    te.Logistical_Contact2__c = this.opp.Logistical_Contact__c;
                    te.Training_Location_Contact__c = this.opp.Training_Location_Contact__c;
                    te.Training_Location_Contact_Name__c = this.opp.Training_Location_Contact__r.Name;
                    te.Training_Location_Contact_Street__c = this.opp.Training_Location_Contact__r.MailingStreet;
                    te.Training_Location_Contact_City__c = this.opp.Training_Location_Contact__r.MailingCity;
                    te.Training_Location_Contact_State__c = this.opp.Training_Location_Contact__r.MailingState;
                    te.Training_Location_Contact_Postal_Code__c = this.opp.Training_Location_Contact__r.MailingPostalCode;
                    te.Training_Location_Contact_Country__c = this.opp.Training_Location_Contact__r.MailingCountry;
                    te.Date_Options__c = this.opp.Date_Options__c;
					te.Date_Options_Available__c = opp.Date_Options_Available__c; 
                    te.Webinar_Session_Times__c = this.opp.Webinar_Session_Times__c;
                    te.Billing_Contact__c = this.opp.Billing_Contact__c;
                    te.Shipping_Contact__c = this.opp.Shipping_Contact__c;
    
                    if(te.Trainer_Requested_Contact__c == null)
                        te.Trainer_Requested_Contact__c = this.opp.Trainer_Requested__c;
                }
                
                ite.tEvent = te;
                ite.tEventProducts = listOppProductTemp;
                listOfInnerTrainingEvents.add( ite );
                
            }
            
        }
    }
    
    public Decimal getNumberOfDayRemaining(){
        
        Decimal totalDays = 0;
        for(Training_Event__c t : listOfTrainingEvents){
            if(t.Training_Num_of_Days__c!=null)
                totalDays =  totalDays + t.Training_Num_of_Days__c ;
        }
        
        return (this.opp.Product_Quantity__c - totalDays);
    }
    
    /**
* @descp: Method to add event to the related List. 
*
**/
    
    public PageReference addEvent (){
       
        try{
            if(!listOfTrainingEvents.isEmpty()){
                
                Decimal daysRemaining = 0;
                
                for(Training_Event__c t : listOfTrainingEvents){
                    daysRemaining =  daysRemaining + t.Training_Num_of_Days__c ;
                }
                if(daysRemaining > this.opp.Product_Quantity__c){
                    
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'You cannot add more events. Number of Event Days is greater/equal than Number of Opp Days'));
                    return null; 
                    
                }else{
                    //Update training events : Validates if there is days available use. 
                    if(daysRemaining != this.opp.Product_Quantity__c){
                        Training_Event__c teTemp =  new Training_Event__c();
                        teTemp.Opportunity__c = this.opp.Id;
                        teTemp.Account__c =  this.opp.AccountID;
                        teTemp.Logistical_Contact2__c = this.opp.Logistical_Contact__c;
                        teTemp.Training_Location_Contact__c = this.opp.Training_Location_Contact__c;
                        teTemp.Training_Location_Contact_Name__c = this.opp.Training_Location_Contact__r.Name;
                        teTemp.Training_Location_Contact_Street__c = this.opp.Training_Location_Contact__r.MailingStreet;
                        teTemp.Training_Location_Contact_City__c = this.opp.Training_Location_Contact__r.MailingCity;
                        teTemp.Training_Location_Contact_State__c = this.opp.Training_Location_Contact__r.MailingState;
                        teTemp.Training_Location_Contact_Postal_Code__c = this.opp.Training_Location_Contact__r.MailingPostalCode;
                        teTemp.Training_Location_Contact_Country__c = this.opp.Training_Location_Contact__r.MailingCountry;
                        teTemp.Date_Options__c = this.opp.Date_Options__c;
                        teTemp.Date_Options_Available__c = this.opp.Date_Options_Available__c; 
                        teTemp.Webinar_Session_Times__c = this.opp.Webinar_Session_Times__c;
                        teTemp.Billing_Contact__c = this.opp.Billing_Contact__c;
                        if(teTemp.Start_Time__c == null)
                            teTemp.Start_Time__c = this.opp.Start_Time__c;
                        if(teTemp.End_Time__c == null)
                            teTemp.End_Time__c = this.opp.End_Time__c;
                        teTemp.Shipping_Contact__c = this.opp.Shipping_Contact__c;
                        teTemp.Shipping_Attention_Line__c = this.opp.Shipping_Attention_Line__c;
                        teTemp.Name = this.generateTraningEventName(this.opp.Name, listOfTrainingEvents.size() + 1,this.opp.Account.Name);
                        if(teTemp.Trainer_Requested_Contact__c == null)
                            teTemp.Trainer_Requested_Contact__c = this.opp.Trainer_Requested__c;
                        
                        errorMessage.add('');
                        listOfTrainingEvents.add(teTemp); 
                        
                        List<InnerOppProduct> listOppProductTemp = new List<InnerOppProduct>();
                        InnerOppProduct io;
                        for(OpportunityLineItem oppProd: listOppProd){
                            
                            io = new InnerOppProduct();
                            io.oppProd = oppProd;
                            io.isSelected = false;
                            io.quantity = null;
                            io.numberOfWorkbooks = null;
                            
                            listOppProductTemp.add(io);
                        }
                        
                        InnerTrainingEvent ite = new InnerTrainingEvent();
                        ite.tEvent = teTemp;
                        ite.tEventProducts = listOppProductTemp;
                        listOfInnerTrainingEvents.add( ite );
                        
                    }
                    
                } 
                
            }    
            
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
        }
        return null;
    }
    
    /**
* @descp: Logic to save Training Series with its Event Topic,etc. 
*
**/
    
    public PageReference saveAll(){
        Boolean success = true; 
        Savepoint sp = Database.setSavepoint(); 
        try{
            
            success = saveTS();
            
            if(success)
                return new PageReference('/'+this.opp.Id);
            else
                return null;
            
        }catch(Exception e){
            
            Database.rollback( sp );
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,e.getMessage()));
           
        }
        
        return null;
        
    }
    
    public PageReference quickSave(){
        Boolean success = true; 
        Savepoint sp = Database.setSavepoint(); 
        try{
            
            success = saveTS();
            
            if(success){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Quick save Successfully saved'));
            }
                
            
        }catch(Exception e){
            
            Database.rollback( sp );
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,e.getMessage()));
            
        }
        
        return null;
    }
    
    private Boolean saveTS(){
        
        Decimal totalDays = 0;
        for(InnerTrainingEvent ite : listOfInnerTrainingEvents){
            totalDays += ite.tEvent.Training_Num_of_Days__c; 
        }
        
        if(this.opp.Product_Quantity__c != null && totalDays > this.opp.Product_Quantity__c){
            
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Sum of Training Event Days greater than Number of Opp Days.'));
            return false;
            
        }else{
            Set<Id> trainingLocationContactsIds = new Set<Id>();
            for(Training_Event__c trainingEvent : listOfTrainingEvents){
                if(!String.isEmpty(trainingEvent.Training_Location_Contact__c)){
                	trainingLocationContactsIds.add(trainingEvent.Training_Location_Contact__c);
                }
            }
            
            Map<Id,Contact> trainingLocationContactsMap = new Map<Id,Contact>( [SELECT Name,MailingStreet,MailingCity,MailingState,MailingPostalCode,MailingCountry FROM Contact WHERE Id IN :trainingLocationContactsIds] );
            
            Integer n = 0;
            List<Training_Event__c> teToUpsert = new List<Training_Event__c>();
            for(Training_Event__c trainingEvent : listOfTrainingEvents){
                
                if(String.isEmpty(String.valueOf(trainingEvent.Training_Start_Date__c))){
                    errorMessage[n] = 'Error: Value cannot be empty';
                    throw new applicationException('Event ' + trainingEvent.Name + ': Training event start date cannot be empty');
                }else{
                    errorMessage[n] = '';
                }

                if((Training_Event__c.sObjectType.getDescribe().isUpdateable() && getCanUserEditTopic()) || String.isEmpty(trainingEvent.Id)){
                    trainingEvent.Account__c                        =   opp.AccountID;
                    trainingEvent.Airport_Drive_time__c             =   opp.Airport_Drive_time__c;
    
                    trainingEvent.Client_Webinar_Platform__c        =   opp.Webinar_Platform__c;
                    trainingEvent.Conversion_Rate__c                =   opp.Conversion_Rate__c;
                    trainingEvent.Decision_Maker__c                 =   opp.Decision_Maker__c;  
                    trainingEvent.General_Session_Notes__c          =   opp.General_Session_Notes__c;
                    trainingEvent.Mandatory_Attendance__c           =   opp.Mandatory_Attendance__c;
                    trainingEvent.Max_Attendees__c                  =   opp.Max_Attendees__c;
                    trainingEvent.Opportunity__c                    =   opp.id;
                    trainingEvent.Opportunity_Description__c        =   opp.Description;
                    trainingEvent.Opportunity_Record_Type_Name__c   =   opp.RecordType.name;
                    trainingEvent.Projector_Provided__c             =   opp.Projector_Provided__c;
                    
                    if (opp.Recommended_Hotel__r != null){
                        trainingEvent.Recommended_Hotel__c              =   opp.Recommended_Hotel__r.Name;
                    }
                    trainingEvent.Related_Tax_Rate__c               =   opp.Related_Tax_Rate__c;
                    
                    if(String.isEmpty(trainingEvent.Shipping_Attention_Line__c)){
                        if(opp.Shipping_Attention_Line__c != null) {
                            trainingEvent.Shipping_Attention_Line__c        =   opp.Shipping_Attention_Line__c;
                        } else if(opp.Shipping_Contact__c != null) {
                            trainingEvent.Shipping_Attention_Line__c = opp.Shipping_Contact__r.Name;
                        }
                    }
                    
                    trainingEvent.Travel_Notes__c                   =   opp.Travel_Notes__c;
                    trainingEvent.Webinar_Hosting__c                =   opp.Webinar_Hosting__c;
                    trainingEvent.Webinar_Attendees_Per_Session__c = opp.Webinar_Attendees_Per_Session__c;
                    trainingEvent.Webinar_Evaluation_Link__c = opp.Webinar_Evaluation_Link__c;
                    trainingEvent.Webinar_Notes__c = opp.Webinar_Notes__c;
                    trainingEvent.Webinar_Same_Attendees_per_Session__c = opp.Webinar_Same_Attendees_per_Session__c;
                    trainingEvent.Webinar_Time_Zone__c = opp.Webinar_Time_Zone__c;
                    trainingEvent.Billing_Currency__c = opp.Billing_Currency__c;
                    trainingEvent.Cost_per_Additional_Attendee__c = opp.Cost_Per_Additional_Attendee__c;
                    trainingEvent.PO_Number__c = opp.PO_Number__c;
                    trainingEvent.Webinar_Recording_Required__c = opp.Webinar_Recording_Required__c;
                    trainingEvent.Hard_Expenses_USD__c = opp.Hard_Expenses_USD__c;
                    
                    trainingEvent.Invoice_Hard_Expenses__c = opp.Invoice_Hard_Expenses__c;
                    
                    if(opp.Owner.IsActive) {
                        trainingEvent.Original_TE_Owner__c = opp.OwnerId;
                    }
                    
                    if(String.isEmpty(trainingEvent.Date_Options__c)){
                        trainingEvent.Date_Options_Available__c = false; 
                    }else if(String.isEmpty(trainingEvent.Date_Options__c.trim())){
                        trainingEvent.Date_Options_Available__c = false; 
                    }

                   	if(!String.isEmpty(trainingEvent.Training_Location_Contact__c)){
                        if(trainingLocationContactsMap.containsKey(trainingEvent.Training_Location_Contact__c)){
                            Contact tlc = trainingLocationContactsMap.get(trainingEvent.Training_Location_Contact__c);
                            trainingEvent.Training_Location_Contact_Name__c = tlc.Name;
                            trainingEvent.Training_Location_Contact_Street__c = tlc.MailingStreet;
                            trainingEvent.Training_Location_Contact_City__c = tlc.MailingCity;
                            trainingEvent.Training_Location_Contact_State__c = tlc.MailingState;
                            trainingEvent.Training_Location_Contact_Postal_Code__c = tlc.MailingPostalCode;
                            trainingEvent.Training_Location_Contact_Country__c = tlc.MailingCountry;
                        }
                    }else{
                        trainingEvent.Training_Location_Contact_Name__c = '';
                        trainingEvent.Training_Location_Contact_Street__c = '';
                        trainingEvent.Training_Location_Contact_City__c = '';
                        trainingEvent.Training_Location_Contact_State__c = '';
                        trainingEvent.Training_Location_Contact_Postal_Code__c = '';
                        trainingEvent.Training_Location_Contact_Country__c = '';
                    }
                    
                    teToUpsert.add(trainingEvent);
                }
                n++;
            } 
            Boolean prodSelected;
            Boolean quantityError;
            Boolean numberOfWorkbooksError;
            for(InnerTrainingEvent innTe : listOfInnerTrainingEvents){
                prodSelected = false;
                quantityError = false;
                numberOfWorkbooksError = false;
                if (!modifyAllProfile && !String.isBlank(innTe.tEvent.Id)) {
                    prodSelected = true;
                } else {
                    for(InnerOppProduct  oppi : innTe.tEventProducts){
                        if(oppi.isSelected){
                            prodSelected = true;
                            if(String.isEmpty(oppi.quantity) || Decimal.valueOf(oppi.quantity)<0){
                                quantityError = true;
                                break;
                            }

                            if(String.isEmpty(oppi.numberOfWorkbooks) || Integer.valueOf(oppi.numberOfWorkbooks)<0){
                                numberOfWorkbooksError = true;
                                break;
                            }
                        }
                    }
                }
                if(!prodSelected){
                    throw new applicationException('Event ' + innTe.tEvent.Name + ': You need to select at least one topic');
                }
                if(quantityError){
                    throw new applicationException('Event ' + innTe.tEvent.Name + ': Topic quantity cannot be null and must be greater or equal to 0');
                }
                if(numberOfWorkbooksError){
                    throw new applicationException('Event ' + innTe.tEvent.Name + ': Number of Workbooks cannot be null and must be greater or equal to 0');
                }
            }
			System.debug(teToUpsert);
            upsert teToUpsert;
    
            List<Topic__c> listEventTopicToInsert = new List<Topic__c>();
            Set<Id> oppLineItemToDelete = new Set<Id>();
            Set<Id> trainingEventsIds = new Set<Id>();
            for(InnerTrainingEvent ite : listOfInnerTrainingEvents){

                    Topic__c topic;
                    
                    for(InnerOppProduct  i : ite.tEventProducts){                   
                        if(mapEventWithOppLineItems.get(ite.tEvent.Id) != null){
                            if (modifyAllProfile) {
                                if(i.isSelected && (!mapEventWithOppLineItems.get(ite.tEvent.Id).contains(i.oppProd.Id) || topicMap.get(ite.tEvent.Id + '-' + i.oppProd.Id)==null ) ){
                                    topic = new Topic__c();
                                    topic = this.buildTopic(i.oppProd, topic, ite.tEvent.Id , ite.tEvent.Training_Num_of_Days__c);
                                    topic.Quantity__c = Decimal.valueOf(i.quantity).setscale(2);
                        			topic.Number_of_workbooks__c = Decimal.valueOf(i.numberOfWorkbooks);
                                    topicMap.put(ite.tEvent.Id + '-' + i.oppProd.Id,topic);
                                    listEventTopicToInsert.add(topic);
                                } else if (!i.isSelected && mapEventWithOppLineItems.get(ite.tEvent.Id).contains(i.oppProd.Id) ){        
                                    oppLineItemToDelete.add(i.oppProd.id);
                                    trainingEventsIds.add(ite.tEvent.Id);
                                    topicMap.remove(ite.tEvent.Id + '-' + i.oppProd.Id);
                                }else if(i.isSelected){
                                    topic = topicMap.get(ite.tEvent.Id + '-' + i.oppProd.Id);
                                    topic.Quantity__c = Decimal.valueOf(i.quantity).setscale(2);
                        			topic.Number_of_workbooks__c = Decimal.valueOf(i.numberOfWorkbooks);
                                    listEventTopicToInsert.add(topic);
                                }
                            }
                        }else if(i.isSelected){
                            topic = new Topic__c();
                            topic = this.buildTopic(i.oppProd, topic, ite.tEvent.Id, ite.tEvent.Training_Num_of_Days__c);
                            topic.Quantity__c = Decimal.valueOf(i.quantity).setscale(2);
                            topic.Number_of_workbooks__c = Decimal.valueOf(i.numberOfWorkbooks);
                            listEventTopicToInsert.add(topic);
                        }
                        
                    }
        
            }
            
            upsert listEventTopicToInsert;
            
            for(Topic__c topic : listEventTopicToInsert){
                if(mapEventWithOppLineItems.get(topic.Training_Event__c) == null){
                    mapEventWithOppLineItems.put(topic.Training_Event__c, new Set<String>());    
                }
                if(topic.Opportunity_LineItem_ID__c != null){
                    mapEventWithOppLineItems.get(topic.Training_Event__c).add(topic.Opportunity_LineItem_ID__c);
                }
            }
            
            if(!oppLineItemToDelete.isEmpty()){
                delete [Select Id From Topic__c Where Opportunity_LineItem_ID__c IN :oppLineItemToDelete AND Training_Event__c IN :trainingEventsIds];
            } 
 
            return true;
            
        }
        
    }

    public Boolean getCanUserEditTopic(){
    	List<Profile> profs = [SELECT Id FROM Profile WHERE Name IN ('Sales Rep','Sales Managers')];
        if(UserInfo.getProfileId()==profs[0].Id || UserInfo.getProfileId()==profs[1].Id){
            return false;
        }
        return true;
    }   
    
    private Topic__c buildTopic(OpportunityLineItem oppItem, Topic__c topic, Id topic_event_id, Decimal numOfDays){
        topic.Topic_Name__c = oppItem.Topic_Name__c;
        if (topic.Topic_Name__c == null){
            topic.Topic_Name__c = oppItem.Product2.Name;
        }
        
        topic.Training_Event__c                 =   topic_event_id;
        topic.Opportunity_LineItem_ID__c        =   oppItem.Id; 
        topic.xEnd_Time__c                      =   oppItem.End_Time__c;
        topic.Commission_Adjustment_Percent__c  =   oppItem.Line_Item_Commission_Percent__c;
        topic.Number_of_Hours__c                =   oppItem.Number_of_hours__c;
        topic.Product_Code__c                   =   oppItem.ProductCode;
        topic.Sales_Price__c                    =   oppItem.UnitPrice;
        topic.Total_Price__c                    =   oppItem.TotalPrice;
        topic.Product_Name__c                   =   oppItem.Product2.Name;
        topic.xTraining_End_Date__c             =   oppItem.End_Date__c;
        topic.Training_Start_Date__c            =   oppItem.Start_Date__c;
        topic.Workbook_Country__c               =   oppItem.Workbook_Country__c;
        topic.Workbook_ID__c                    =   oppItem.Workbook_ID__c;
        topic.Workbook_Location__c              =   oppItem.Workbook_Location__c;
        topic.Workbook_UPC__c                   =   oppItem.Workbook_UPC__c;
        topic.Content_Pack__c                   =   oppItem.Content_Pack__c;
        topic.Modality__c                       =   oppItem.Modality__c;
        topic.Type__c                           =   oppItem.Type__c;
        
        return topic;
        
    }
    
    private String generateTraningEventName(String oppName, Integer dayNumber, String accName){
        String name = oppName;
        if(dayNumber != 0)
            name = accName + ' - ' + name + ' - Event ' + String.valueOf(dayNumber);
        return name;
    }

    private Opportunity getOpportunity() {
        
        String query = 'SELECT ' +
            'Account.Name,' + 
            'AccountID,'+
            'Airport_Drive_time__c,'+
            'Billing_Contact__c,'+
            'Cancellation_Fee__c,'+
            'Webinar_Platform__c,'+
            'Contract_Amount__c,'+
            'Conversion_Rate__c,'+
            'Currency_Conversion__c,'+
            'Decision_Maker__c,'+
            'General_Session_Notes__c,'+
            'Mandatory_Attendance__c,'+
            'Max_Attendees__c,'+
            'name,'+
            'Number_of_Days__c,'+
            'Logistical_Contact__c,'+
            'Product_Quantity__c,'+
            'Type,'+
            'Amount,'+       
            'Description,'+
            'RecordTypeid,'+
            'RecordType.name,'+
            'Projector_Provided__c,'+
            'Recommended_Hotel__c,'+
            'Recommended_Hotel__r.Name,'+
            'Related_Tax_Rate__c,'+
            'Date_Options_Available__c,'+
            'Shipping_Attention_Line__c,'+
            'Shipping_Contact__r.Name,'+
            'Shipping_Contact__c,'+
            'Date_Options__c,'+
            'Tax_Calculation__c,'+
            'Trainer_Requested__c,'+
            'Trainer_Requested__r.Name,'+
            'Trainer_detail__c,'+
            'Training_Location_Contact__c,'+
            'Travel_Notes__c,'+
            'Webinar_Hosting__c,'+
            'End_Time__c,'+
            'Start_Time__c,'+
            'TrainingStartDate__c,'+
            'TotalOpportunityQuantity,'+
            'Opportunity_Converted__c,'+
            'Billing_Currency__c,'+
            'Webinar_Attendees_Per_Session__c,'+
            'Webinar_Evaluation_Link__c,'+
            'Webinar_Notes__c,'+
            'Webinar_Same_Attendees_per_Session__c,'+
            'Webinar_Session_Times__c,'+
            'Webinar_Time_Zone__c,'+
            'Cost_Per_Additional_Attendee__c,'+
            'PO_Number__c,'+
            'Webinar_Recording_Required__c,'+
            'Hard_Expenses_USD__c,'+
            'OwnerId,'+
            'Owner.IsActive,'+
            'Training_of_Days__c,'+
            'Training_Location_Contact__r.Name,'+
            'Training_Location_Contact__r.MailingStreet,'+
            'Training_Location_Contact__r.MailingCity,'+
            'Training_Location_Contact__r.MailingState,'+
            'Training_Location_Contact__r.MailingPostalCode,'+
            'Training_Location_Contact__r.MailingCountry,'+
            'Invoice_Hard_Expenses__c,';
        
        String childQuery = ',Name,Content_Pack__c,';
        
        for(Schema.FieldSetMember f : SObjectType.OpportunityLineItem.FieldSets.Training_Event_Products_Columns.getFields()){
            if(childQuery.indexOf(','+f.getFieldPath()+',')==-1){
                childQuery += f.getFieldPath() + ',';
            } 
        }
        childQuery = '(Select ID' + childQuery.substringBeforeLast(',') + '  FROM OpportunityLineItems)';
        query += 'Id,' + childQuery + ' FROM Opportunity WHERE Id = \''+this.sObjectId+ '\'  LIMIT 1';
        
        return Database.query(query);
        
    }
    
    public PageReference backToOpp (){
        
        return new PageReference('/'+this.opp.Id);
        
    }
    
    public Class InnerOppProduct{
        
        public OpportunityLineItem oppProd {get;set;}
        public Boolean isSelected {get;set;}
        public String quantity {get;set;}
        public String numberOfWorkbooks {get;set;}
        
        public InnerOppProduct(){
            
        }
        
    }
    
    public Class InnerTrainingEvent{
        
        public Training_Event__c tEvent             { get; set; }
        public List<InnerOppProduct> tEventProducts { get; set; }
        
        public InnerTrainingEvent(){
            
        }
        
    }
    
    public class applicationException extends Exception {}
    
}