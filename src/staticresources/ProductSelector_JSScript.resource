
$.aljsInit({
    assetsLocation: assetsLocation,
    scoped: true
});

var productFilteringOptions = {'ByNameOrCode':'','ByField':'','Comparator':'','Text':'','fieldType':''};

$(document).ready(function() {

	$("form").submit(function() { return false; });

	$('.ar-column-field').digits();

    if(window.location.hash!=''){ 
    	$('[data-aljs="tabs"]').tabs({
		        defaultTabId: window.location.hash.substring(1)
		    }
		  );
    }else{
    	$('[data-aljs="tabs"]').tabs();
    }

    $('[data-aljs="modal"]').modal();
    $('[data-aljs="picklistByField"]').picklist({ 

    	onChange: function(obj) { 

    		var previosType = productFilteringOptions.fieldType;
    		var previosField = productFilteringOptions.fieldType;

    		if(obj.valueId!='none-none'){
    			productFilteringOptions.ByField = obj.valueId.split('-')[0];
    			productFilteringOptions.fieldType = obj.valueId.split('-')[1];
    		}else{
    			productFilteringOptions.ByField = '';
    			productFilteringOptions.fieldType = '';
    		}
    		

    		if((previosField!='' || productFilteringOptions.fieldType.toUpperCase()=="BOOLEAN") && previosType!=productFilteringOptions.fieldType){
	    		if(productFilteringOptions.fieldType.toUpperCase()=="BOOLEAN"){
	    			$('#comparatorPicklist').css('display','none');
	    			$('#comparatorPicklistForBoolean').css('display','block');
	    			$('#searchText').attr('disabled','true');
	    		}else{
	    			$('#comparatorPicklist').css('display','block');
	    			$('#comparatorPicklistForBoolean').css('display','none');
	    			$('#searchText').removeAttr('disabled');
	    		}
	    	}

    	} 

    });


	$('[data-aljs="picklistComparator"]').picklist({ 
		onChange: function(obj) { 
			productFilteringOptions.Comparator = obj.valueId;
			
		} 
	});

	$('#byNameOrCode,#searchText').keyup(function(e) {
	    var enterKey = 13;
	    if (e.which == enterKey){
	        filter();
	     }
	 });

	animateAmount();

	$('[name=requestedDueDate]').datepicker({
	        numYearsBefore: 0,
	        numYearsAfter: 15,
	        format: 'MM/DD/YYYY',
	        initDate: moment(),
	        dayLabels: [{full: 'Sunday',abbv: 'S'},
	            {full: 'Monday',abbv: 'M'},
	            {full: 'Tuesday',abbv: 'T'},
	            {full: 'Wednesday',abbv: 'W'},
	            {full: 'Thursday',abbv: 'T'},
	            {full: 'Friday',abbv: 'F'},
	            {full: 'Saturday',abbv: 'S'}]
	    });

	// To center the calendar inside the div
	$('[name=requestedDueDate], [name=requestedDueDateSVG]').click(function(e){
		$('.slds-datepicker').css({
			left:"calc(50% - 141px)", 
			top: "calc(50% - 140px)",
			position: "fixed"
		});
		
	});

	$('[name=edit-requestedDueDate]').datepicker({
	        numYearsBefore: 0,
	        numYearsAfter: 15,
	        format: 'MM/DD/YYYY',
	        initDate: moment(),
	        dayLabels: [{full: 'Sunday',abbv: 'S'},
	            {full: 'Monday',abbv: 'M'},
	            {full: 'Tuesday',abbv: 'T'},
	            {full: 'Wednesday',abbv: 'W'},
	            {full: 'Thursday',abbv: 'T'},
	            {full: 'Friday',abbv: 'F'},
	            {full: 'Saturday',abbv: 'S'}]
	    });

	// To center the calendar inside the div
	$('[name=edit-requestedDueDate], [name=edit-requestedDueDateSVG]').click(function(e){
		$('.slds-datepicker').css({
			left:"calc(50% - 141px)", 
			top: "calc(50% - 140px)",
			position: "fixed"
		});
		
	});

});

function animateAmount(){
	var decimal_places = 2;
	var decimal_factor = decimal_places === 0 ? 1 : Math.pow(10, decimal_places);
		$('#totalAmount').animateNumber({ 
										number: $('#oppAmount').val() * decimal_factor,
										easing:'easeInQuad',
										numberStep: function(now, tween) {
										        var floored_number = Math.floor(now) / decimal_factor,
										            target = $(tween.elem);

										        if (decimal_places > 0) {
										          // force decimal places even if they are 0
										          floored_number = floored_number.toFixed(decimal_places);
										        }

										        target.text(floored_number.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
										      }
										 }, 3000);
}

function returnToOpp(){
	location.href = '/' + getParameterByName('id');
}

function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)", 'i'),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}

function showHideProdActDropdown(isShow,id){

		if(isShow){
			$('#pDropDown-' + id).css('display','block');
		}else{
			$('#pDropDown-' + id).css('display','none');
		}

}

function toggleRequestDueDate(elem,isEdit){

	var editTag = '';
	if(isEdit){
		editTag = 'edit-';
	}

	if(elem.checked){
		$('#'+editTag+'requestedDueDate'+elem.getAttribute('id').replace(/\bedit-/g,'')).removeAttr('disabled');
		$('#'+editTag+'requestedDueDateSVG'+elem.getAttribute('id').replace(/\bedit-/g,'')).css('display','block');
	}else{
		$('#'+editTag+'requestedDueDate'+elem.getAttribute('id').replace(/\bedit-/g,'')).attr('disabled','true');
		$('#'+editTag+'requestedDueDate'+elem.getAttribute('id').replace(/\bedit-/g,'')).val('');
		$('#'+editTag+'requestedDueDateSVG'+elem.getAttribute('id').replace(/\bedit-/g,'')).css('display','none');
	}
	

}

function showModal(type, id, name, price){

		$('#prod-modal').modal('show');
		$('#modal-prodId').val(id);
		$('#modal-prodName').val(name);

		if(price==4200){
			switch(type) {
			    case 'Standard':
			        price=4200;
			        break;
			    case 'Custom Lite':
			        price=4500;
			        break;
			    case 'Custom':
			        price=4800;
			        break;
			}
			price = price.toFixed(2);
		}

		$('#modal-prodPrice').val(price.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
		$('#modal-prodType').html(type);
		$('#modal-prodLineName').val('');
		$('#modal-prodLineDesc').val('');
		$('#modal-prodQuantity').val('');
		$('#modal-prodModality').prop('selectedIndex', 0);

		refreshModal(false,type);

}

function showEditModal(type, id, name, price, lineName, lineDesc, cpId, quantity, modality){
		
		$('#edit-modal-prodId').val(id);
		$('#edit-modal-prodName').val(unescapeHtml(name));
		$('#edit-modal-prodPrice').val(price.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
		$('#edit-modal-prodType').html(type);
		$('#edit-modal-prodLineName').val(unescapeHtml(lineName));
		$('#edit-modal-prodLineDesc').val(unescapeHtml(lineDesc));
		$('#edit-modal-prodQuantity').val(quantity);
		$('#edit-modal-prodModality').val(modality);

		refreshModal(true,type);
 
		var ci = new myContentItem.Content_Item__c();
		ci.retrieve({where: {Content_Pack__c: {eq: cpId },Removed_from_Product_Selector__c: {eq: false }}}, function(err, records) {
															if(records!=null && records.length>0){
																for(i=0;i<records.length;i++){
																	$('#edit-'+records[i].get('Item_Type__c').replace(/\s/g,'_')).prop('checked','true');
																	if(records[i].get('Requested_Due_Date__c')!=undefined){
																		$('#edit-requestedDueDate'+records[i].get('Item_Type__c').replace(/\s/g,'_')).val(records[i].get('Requested_Due_Date__c').toLocaleDateString());
																	}
																	$('#edit-requestedDueDate'+records[i].get('Item_Type__c').replace(/\s/g,'_')).removeAttr('disabled');
																	$('#edit-requestedDueDateSVG'+records[i].get('Item_Type__c').replace(/\s/g,'_')).css('display','block');
																}
															}
															$('#edit-prod-modal').modal('show');
														});
}

function refreshModal(isEdit,type){
	
	var editTag = '';

	if(isEdit){
		editTag = 'edit-';
	}

	$('[name='+editTag+'contentItemType-check]').prop('checked', false);
	$('[name='+editTag+'requestedDueDate]').val('');
	$('[name='+editTag+'requestedDueDate]').attr('disabled','true');
	$('[name='+editTag+'requestedDueDateSVG]').css('display','none');

	$('#'+editTag+'prod-modal-container').css('display','block');
	$('#delete-prod-modal-container').css('display','none');

	$('#'+editTag+'modal-prodPriceDiv').removeClass('slds-has-error');
	$('#'+editTag+'modal-prodPriceError').html('');
	$('#'+editTag+'modal-prodQuantityDiv').removeClass('slds-has-error');
	$('#'+editTag+'modal-prodQuantityError').html('');
	$('#'+editTag+'modal-prodCustomContentError').html('');

	$('[name='+editTag+'requestedDueDate]').parent('div').removeClass('slds-has-error');

	switch(type) {
	    case 'Standard':
	        $('#'+editTag+'modal-prodLineName-row').css('display','none');
	        $('#'+editTag+'modal-reqCustomContent').css('display','none');
	        $('#'+editTag+'modal-prodLineDesc-row').css('display','none');
	        break;
	    case 'Custom Lite':
	        $('#'+editTag+'modal-prodLineName-row').css('display','block');
	        $('#'+editTag+'modal-reqCustomContent').css('display','block');
	        $('#'+editTag+'modal-prodLineDesc-row').css('display','block');
	        break;
	    case 'Custom':
	        $('#'+editTag+'modal-prodLineName-row').css('display','block');
	        $('#'+editTag+'modal-reqCustomContent').css('display','block');
	        $('#'+editTag+'modal-prodLineDesc-row').css('display','block');
	        break;
	}

}

function showDeleteModal(id,name,price){
	$('#delete-modal-prodId').val(id);
	$('#delete-modal-prodName').val(unescapeHtml(name));
	$('#delete-modal-prodPrice').val(price);
	$('#edit-prod-modal-container').css('display','none');
	$('#delete-prod-modal-container').css('display','block');
	$('#edit-modal-prodPriceDiv').removeClass('slds-has-error');
	$('#edit-modal-prodPriceError').html('');
	$('#edit-modal-prodCustomContentError').html('');
	$('#edit-prod-modal').modal('show');
}

function validateProd(isEdit){

	var editTag = '';
	if(isEdit){
		editTag = 'edit-';
	}

	$('#'+editTag+'modal-prodPriceDiv').removeClass('slds-has-error');
	$('#'+editTag+'modal-prodPriceError').html('');
	$('#'+editTag+'modal-prodQuantityDiv').removeClass('slds-has-error');
	$('#'+editTag+'modal-prodQuantityError').html('');
	$('#'+editTag+'modal-prodLineNameDiv').removeClass('slds-has-error'); //added this
	$('#'+editTag+'modal-prodLineNameError').html(''); //added this
	$('#'+editTag+'modal-prodCustomContentError').html('');

	if( $('#'+editTag+'modal-prodPrice').val().trim()== ''){

		$('#'+editTag+'modal-prodPriceDiv').addClass('slds-has-error');
		$('#'+editTag+'modal-prodPriceError').html('This field cannot be empty.');
		$('#'+editTag+'modal-prodPrice').focus();

	}else if( !$.isNumeric($('#'+editTag+'modal-prodPrice').val().replace(new RegExp(',', 'g'),'')) ){

		$('#'+editTag+'modal-prodPriceDiv').addClass('slds-has-error');
		$('#'+editTag+'modal-prodPriceError').html('This field must be a number.');
		$('#'+editTag+'modal-prodPrice').focus();

	}else if( !$.isNumeric($('#'+editTag+'modal-prodQuantity').val()) ){

		$('#'+editTag+'modal-prodQuantityDiv').addClass('slds-has-error');
		$('#'+editTag+'modal-prodQuantityError').html('This field must be a number.');
		$('#'+editTag+'modal-prodQuantity').focus();

		// created this else if
	}else if( ($('#'+editTag+'modal-prodType').text() == 'Custom' || $('#'+editTag+'modal-prodType').text() == 'Custom Lite') && $('#'+editTag+'modal-prodLineName').val() == '' ){

		$('#'+editTag+'modal-prodLineNameDiv').addClass('slds-has-error');
		$('#'+editTag+'modal-prodLineNameError').html('This field must be populated for Custom and Custom Lite products.');
		$('#'+editTag+'modal-prodLineName').focus();

	}else if( $('#'+editTag+'modal-prodType').text()=='Custom' && !$('[name='+editTag+'contentItemType-check]').is(':checked') ){

		$('#'+editTag+'modal-prodCustomContentError').html('You must to check at least one checkbox.');

	}else{
		return true;
	}

	return false;
}

function addProductScript(){

		if(validateProd(false)){
			var pInfo = { 'Id' : $('#modal-prodId').val() , 'LineDescription': $('#modal-prodLineDesc').val() , 
							'SalesPrice': $('#modal-prodPrice').val().replace(new RegExp(',', 'g'),'') , 'Type': $('#modal-prodType').text(), 
							'LineName': $('#modal-prodLineName').val(), 'Modality': $('#modal-prodModality').val(),
							'Quantity': $('#modal-prodQuantity').val()
						 };

			var checkboxes = $('[name=contentItemType-check]');
			var element;
			pInfo["itemTypes"]=[];
			for(i=0;i<checkboxes.length;i++){
				element = new Object();
				element.id = $($('[name=contentItemType-check]').get(i)).attr('id').replace(/_/g,' ');
				element.value = $($('[name=contentItemType-check]').get(i)).is(':checked');
				element.requestedDueDate = $('#requestedDueDate' + $($('[name=contentItemType-check]').get(i)).attr('id')).val();
				pInfo["itemTypes"][i] = element;
			}
			
			addProd(JSON.stringify(pInfo));
			$('#prod-modal').modal('dismiss');

		}
}

function saveProductScript(){

		if(validateProd(true)){

			var error = false;		

			var pInfo = { 'Id' : $('#edit-modal-prodId').val() , 'LineDescription': $('#edit-modal-prodLineDesc').val() , 
							'SalesPrice': $('#edit-modal-prodPrice').val().replace(new RegExp(',', 'g'),'') , 'Type': $('#edit-modal-prodType').text(), 
							'LineName': $('#edit-modal-prodLineName').val(), 'Modality': $('#edit-modal-prodModality').val(),
							'Quantity': $('#edit-modal-prodQuantity').val()
						 };

			var checkboxes = $('[name=edit-contentItemType-check]');
			var element;
			pInfo["itemTypes"]=[];
			for(i=0;i<checkboxes.length;i++){
				element = new Object();
				element.id = $($('[name=edit-contentItemType-check]').get(i)).attr('id').replace(/\bedit-/g,'').replace(/_/g,' ');
				element.value = $($('[name=edit-contentItemType-check]').get(i)).is(':checked');
				element.requestedDueDate = $('#edit-requestedDueDate' + $($('[name=edit-contentItemType-check]').get(i)).attr('id').replace(/\bedit-/g,'')).val();
				pInfo["itemTypes"][i] = element;
			}

			if(!error){

				saveProd(JSON.stringify(pInfo));

				$('#edit-prod-modal').modal('dismiss');

			}

		}
}

function productSuccessfullyAdded(isEdit,isDelete){
		if(isEdit){
			text = 'Product successfully saved.';
			idText = 'edit-txtSuccessMsg';
			idDiv = 'edit-divSuccessMsg';
		}else if(isDelete){
			text = 'Product successfully deleted.';
			idText = 'edit-txtSuccessMsg';
			idDiv = 'edit-divSuccessMsg';
		}
		else{
			animateAmount();
			text = 'Product successfully added';
			idText = 'txtSuccessMsg';
			idDiv = 'divSuccessMsg';
		}
		if( ($('[id$="errorMsgs"]').html().trim()=='' && !isEdit && !isDelete) || ($('[id$="edit-errorMsgs"]').html().trim()=='' && isEdit || isDelete) ){
			$('#' + idText).html(text);
			$('#' + idDiv).show('slow');
		}
}

function filter(){

	$('#ByFieldPicklist').find('button').css('border-color','');
	$('#comparatorPicklist').find('button').css('border-color','');
	$('#comparatorPicklistForBoolean').find('button').css('border-color','');
	$('#searchText').css('border-color','');

	var isError = false;

	if(productFilteringOptions.Comparator=='true'||productFilteringOptions.Comparator=='false'){
		if(productFilteringOptions.ByField==''){
			isError = true;
		}else{
			isError = false;
		}
	}else{
		isError = false;
	}

	if(!isError){
		$('#divMsg').hide();
		filterProds(JSON.stringify(productFilteringOptions));
	}else{
		$('#txtMsg').html('Fields missing');
		$('#divMsg').show();
		//missing filtering fields
		if(productFilteringOptions.ByField==''){
			$('#ByFieldPicklist').find('button').css('border-color','#c23934');
		}
		if(productFilteringOptions.Comparator==''){
			$('#comparatorPicklist').find('button').css('border-color','#c23934');
			$('#comparatorPicklistForBoolean').find('button').css('border-color','#c23934');
		}
		if(productFilteringOptions.Text=='' && productFilteringOptions.fieldType!='BOOLEAN'){
			$('#searchText').css('border-color','#c23934');
		}
	}
}
function unescapeHtml(escapedStr) {
    var div = document.createElement('div');
    div.innerHTML = escapedStr;
    var child = div.childNodes[0];
    return child ? child.nodeValue : '';
};
$.fn.digits = function(){ 
    return this.each(function(){ 
        $(this).text( $(this).text().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") ); 
    })
}