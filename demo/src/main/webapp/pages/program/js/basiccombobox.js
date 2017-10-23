/**
 * program basic info
 * this file includes all the bais info related comboboxes that needs to be initialized in editprogram.jsp
 */


//program basic infor

var CURRENCY_LIST=[{text:'AED',value:'AED'},
                   {text:'ARS',value:'ARS'},
                   {text:'AUD',value:'AUD'},
                   {text:'BGN',value:'BGN'},
                   {text:'BRL',value:'BRL'},
                   {text:'CAD',value:'CAD'},
                   {text:'CHF',value:'CHF'},
                   {text:'CLP',value:'CLP'},
                   {text:'COP',value:'COP'},
                   {text:'CZK',value:'CZK'},
                   {text:'DKK',value:'DKK'},
                   {text:'ECS',value:'ECS'},
                   {text:'EGP',value:'EGP'},
                   {text:'EUR',value:'EUR'},
                   {text:'GBP',value:'GBP'},
                   {text:'HKD',value:'HKD'},
                   {text:'HRK',value:'HRK'},
                   {text:'HUF',value:'HUF'},
                   {text:'IDR',value:'IDR'},
                   {text:'ILS',value:'ILS'},
                   {text:'INR',value:'INR'},
                   {text:'JPY',value:'JPY'},
                   {text:'KRW',value:'KRW'},
                   {text:'LKR',value:'LKR'},
                   {text:'MAD',value:'MAD'},
                   {text:'MXN',value:'MXN'},
                   {text:'MYR',value:'MYR'},
                   {text:'NOK',value:'NOK'},
                   {text:'NZD',value:'NZD'},
                   {text:'PEN',value:'PEN'},
                   {text:'PHP',value:'PHP'},
                   {text:'PLN',value:'PLN'},
                   {text:'RMB',value:'RMB'},
                   {text:'RON',value:'RON'},
                   {text:'RUB',value:'RUB'},
                   {text:'SAR',value:'SAR'},
                   {text:'SEK',value:'SEK'},
                   {text:'SGD',value:'SGD'},
                   {text:'SIT',value:'SIT'},
                   {text:'SKK',value:'SKK'},
                   {text:'THB',value:'THB'},
                   {text:'TND',value:'TND'},
                   {text:'TRY',value:'TRY'},
                   {text:'TWD',value:'TWD'},
                   {text:'USD',value:'USD'},
                   {text:'UYU',value:'UYU'},
                   {text:'VEB',value:'VEB'},
                   {text:'VND',value:'VND'},
                   {text:'ZAR',value:'ZAR'}];

var PRODUCT_GROUP=[
                      {text:'All PCSD',value:'All PCSD'},
                      {text:'PC Only',value:'PC Only'},
                      {text:'Tablet Only',value:'Tablet Only'},
                      {text:'Desktop Only',value:'Desktop Only'},
                      {text:'Notebook only',value:'Notebook only'}
                  ];
$(function(){
 $('#country').combobox({
 	 url: 'combo!getComboCountry.action',
     method: 'get',
     valueField:'value',
     textField:'text',
     editable: false,
     multiple:true,
     multiline:true,
     required:true,
     groupField:'bp',
     labelPosition:'left',
     onLoadSuccess:function(){
    	 divVisibilityControl();
     },
     onChange: function(newValue, oldValue){
    	 var options=$('#country').combobox('getValues');
    	 
    	 //clear the value and dropdown list anyway.
    	 $('#countryregion').combobox('clear');
    	 $('#countryregion').combobox('loadData', {});
    	 
         if(options.length){
        	 var url = 'combo!getComboCountryRegion.action?country='+options;
        	 $('#countryregion').combobox('reload', url);
         }
         
         $('#states').combobox('loadData', {});
         $('#cities').combobox('loadData', {});
         
         $('#states').combobox('clear');
         $('#cities').combobox('clear');
         
    	 reloadBPName(true);
    	 
    	 reloadSoldToName(true);
         
    	 divVisibilityControl();
      	
     }
    	 
    });
 
 var countryoptions=$('#country').combobox('getValues');
 if(countryoptions.length){
	 countryoptions='combo!getComboCountryRegion.action?country=' + countryoptions;
 }else{
	 countryoptions='';
 }
 $('#countryregion').combobox({
 	 url: countryoptions,
     method: 'get',
     valueField:'value',
     textField:'text',
     editable: false,
     multiple:true,
     multiline:true,
     labelWidth:50,
     labelPosition:'left',
     selectOnNavigation:true,
     groupField:'bp',
      onChange: function(newValue, oldValue){
     	 
     	 var options=$('#countryregion').combobox('getValues');
     	 
     	 $('#states').combobox('clear');
     	 $('#states').combobox('loadData', {});
     	 
     	 if(options.length){
     		 var url = 'combo!getComboState.action?countryregions='+options;
     		 $('#states').combobox('reload', url);
     	 }
         
         $('#cities').combobox('loadData', {});
         
         $('#cities').combobox('clear');
         
      }
    
 });
 
 var countryregionoptions=$('#countryregion').combobox('getValues');
 if(countryregionoptions.length){
	 countryregionoptions='combo!getComboState.action?countryregions=' + countryregionoptions;
 }else{
	 countryregionoptions='';
 }
 $('#states').combobox({
 	url: countryregionoptions,
     method: 'get',
     valueField:'value',
     textField:'text',
     editable: false,
     groupField:'bp',
     multiple:true,
     labelWidth:120,
     multiline:true,
     labelPosition:'left',
     selectOnNavigation:true,
     onChange: function(newValue, oldValue){
     	
     	var options=$('#states').combobox('getValues');
     	if(options.length){
    		 var url = 'combo!getComboCity.action?states='+options;
    		 $('#cities').combobox('reload', url);
    	 }else{
    		 $('#cities').combobox('loadData', {});
        }
         
     	$('#cities').combobox('clear');
     	
     }
 });
 
 var statesoptions=$('#states').combobox('getValues');
 if(statesoptions.length){
	 statesoptions='combo!getComboCity.action?states=' + statesoptions;
 }else{
	 statesoptions='';
 }
 $('#cities').combobox({
 	url: statesoptions,
     method: 'get',
     valueField:'value',
     textField:'text',
     editable: false,
     multiple:true,
     labelPosition:'left',
     multiline:true,
     selectOnNavigation:true,
     groupField:'bp'
    });
 
 $('#departmentCode').combobox({
 	url: 'combo!getComboDepartment.action',
     method: 'get',
     valueField:'value',
     textField:'text',
     editable: false,
     multiple:true,
     multiline:true,
     selectOnNavigation:true,
     groupField:'bp'
    });
 
 
 $('#autoflag').combobox({
     data: [{
		text: 'YES',
		value: 'YES'
	},{
		text: 'NO',
		value: 'NO'
	}],
     valueField:'value',
     textField:'text',
     editable: false,
     required:true,
     groupField:'bp',
      onLoadSuccess:function(){
        	var a = $('#autoflag').combobox('getValue');
        	if(!a){
        		$('#autoflag').combobox('setValue','YES');
        	}
        }
    });
    
 $('#currency').combobox({
	     data: CURRENCY_LIST,
	     valueField:'value',
	     textField:'text',
	     editable: false,
	     required:true,
	     onLoadSuccess:function(){
	    	 //set GTN currency as the default value
	    	 $('#gtnCurrency').textbox('enable');
	    	 var gtnCurrency=$('#gtnCurrency').textbox('getValue');
	    	 var currency=$('#currency').combobox('getValue');
	    	 if(gtnCurrency&&(!currency)){
	    		 $('#currency').combobox('setValue',gtnCurrency);
	    	 }
	    	 $('#gtnCurrency').textbox('disable');
	    	 }
	    
	    });
 $('#productGroup').combobox({
	 data: PRODUCT_GROUP,
     valueField:'value',
     textField:'text',
     editable: false,
     required:true,
     labelWidth:110,
     onLoadSuccess:function(){
     	var a = $('#productGroup').combobox('getValue');
     	if(!a){
     		$('#productGroup').combobox('setValue','All PCSD');
     	}
     }
 });
 
 $('#subsegment').combobox({
	 data: [{
		  text:'N/A',
		  value:'N/A'
	  },{
		  text:'SB',
		  value:'SB'
	  },{
		  text:'CC',
		  value:'CC'
	  }],
     valueField:'value',
     textField:'text',
     groupField:'group',
     onChange: function(newValue, oldValue){
	    	 if(newValue=='All'){
	    		 $('#subsegment').combobox('clear');
	    	 }
    	 }
    });      
 
 $('#gtnPurpose').combobox({
	 data: GTN_PURPOSE,
     valueField:'value',
     textField:'text',
     labelWidth:110,
     labelPosition:'left',
     editable: false,
     required:true,
     groupField:'bp'
    });
 
 $('#tier').combobox({
 	 url: 'combo!getComboTier.action',
     method: 'get',
     queryParams:{
    	 segment:$('#gtnSegment').textbox('getValue'),
    	 region:$('#programRegion').textbox('getValue')
     },
     valueField:'value',
     textField:'text',
     editable: false,
     required:true,
     labelPosition:'left',
     labelWidth:50,
     groupField:'bp',
     onChange: function(newValue, oldValue){
         $('#bpCategory').combobox('clear');
    	 reloadBPType();
    	 reloadBPName(true);
    	 }
    });
 
 var segmentopt=$('#gtnSegment').textbox('getValue');
 var regionopt=$('#programRegion').textbox('getValue');
 var tieropt=$('#tier').combobox('getValue');
 $('#bptype').combobox({
  	 url: 'combo!getComboBPType.action?segment='+segmentopt+'&region='+regionopt+'&tier='+tieropt,
     method: 'get',
     valueField:'value',
     textField:'text',
     editable: false,
     multiple:true,
     labelPosition:'left',
     multiline:true,
     selectOnNavigation:true,
     required:true,
     groupField:'bp',
     onChange: function(newValue, oldValue){
    	 reloadBPTiering();
    	 reloadBPName(true);
    	 }
    });
 
 var bptypeopt=$('#bptype').combobox('getValue');
 $('#bpCategory').combobox({
 	 url: 'combo!getComboBPCategory.action?segment='+segmentopt+'&region='+regionopt+'&tier='+tieropt+'&bptype='+bptypeopt,
     method: 'get',
     valueField:'value',
     textField:'text',
     editable: false,
     multiple:true,
     labelPosition:'left',
     multiline:true,
     required:true,
     selectOnNavigation:true,
     groupField:'bp', 
     onChange:function(newValue,oldValue){
    	 reloadBPName(true);
     }
    });
 
 $('#bpName').combobox({
     valueField: 'value',
     textField: 'text',
     required:true,
     labelPosition:'left',
     editable:false,
     multiple:true,
     multiline:true,
     icons:[{
         iconCls:'icon-clear',
         handler: function(e){
             var v = $(e.data.target).combobox('clear');
         }
     }],
	 onChange: function(newValue, oldValue){
      }
 
 });
 
 $('#bpflag').combobox({
		valueField: 'value',
		textField: 'text',
		data: PRODUCT_FLAG,
		labelPosition:'left', 
		labelWidth:100,
		editable: false,
		required:true,
		onSelect:function(newValue,oldValue){
			$("#bpName").combobox("enable");
			reloadBPName(false);

		}
	});
 
 $('#soldToName').combobox({
	 multiple:true,
     multiline:true,
     labelWidth:110,
     editable:false,
     labelPosition:'left',
     onSelect:function(newValue,oldValue){
			var soldToFlag=$('#soldToNameFlag').combobox('getValue');
			if(!soldToFlag){
				$.messager.alert('Info','Please select soldto flag first!','info');
			}
		}
 });
 
 $('#soldToNameFlag').combobox({
		valueField: 'value',
		textField: 'text',
		data: PRODUCT_FLAG,
		editable: false,
		labelWidth:90,
		icons:[{
            iconCls:'icon-clear',
            handler: function(e){
                var v = $(e.data.target).combobox('clear');
                $('#soldToName').combobox('clear');
            }
        }],
		labelPosition:'left', 
		onSelect:function(newValue,oldValue){
			reloadSoldToName(false);
		}
	});
 
 });

function reloadBPTiering(){
	 $('#bpCategory').combobox('clear');
	 var segment=$('#gtnSegment').textbox('getValue');
	 var region=$('#programRegion').textbox('getValue');
	 var tier=$('#tier').combobox('getValue');
	 var bptype=$('#bptype').combobox('getValues');
	 //segment&&region will always be true.skip the judgement
	 if(tier&&bptype.length){
	          var url = 'combo!getComboBPCategory.action?segment='+segment+'&region='+region+'&tier='+tier+'&bptype='+bptype;
	          $('#bpCategory').combobox('reload', url);
	 }
}

function reloadSoldToName(clearFlag){
	 
	 if(clearFlag){
		 $('#soldToName').combobox('clear');
		 $('#soldToName').combobox('loadData', {});
	 }
	 var countries=$('#country').combobox('getValues');
	 var segment=$('#gtnSegment').textbox('getValue');
	 //segment will always be true. skip 
	 if(countries.length){
	    var url='combo!getSoldToNameList.action?countries='+countries+'&gtnSegment='+segment;
	    $('#soldToName').combobox('reload',url);
	 }
}

function reloadBPName(clearFlag){
	if(clearFlag){
	   //clear the value box 
       $('#bpName').combobox('clear');
       //clear the dropdown list
       $('#bpName').combobox('loadData', {});
	}
	$('#segment').textbox('enable'); 
	var segment =  $('#gtnSegment').textbox('getValue'); 
	$('#segment').textbox('disable'); 
    var tierId =  $('#tier').combobox('getValue'); 
    var bptypeId = $('#bptype').combobox('getValues');
    var categoryIds = $('#bpCategory').combobox('getValues'); 
    var countryIds = $('#country').combobox('getValues'); 
    
    if(tierId&&bptypeId.length&&categoryIds.length&&countryIds.length){
    	var url='combo!fuzzySearchBPName.action?tier='+tierId+'&bptype='+bptypeId+'&bpcategory='+categoryIds+'&country='+countryIds+'&segment='+segment;
    	$('#bpName').combobox('reload',url);
    }
}

function divVisibilityControl(){
	var text=$('#country').combobox('getText');
  	if(text.indexOf('Japan')!=-1){
  		$('#japanDiv').show();
  		$('#indiaDiv').hide();
  		
  	}else if(text.indexOf('India')!=-1){
  		$('#japanDiv').hide();
  		$('#indiaDiv').show();
  	}else{
  		$('#japanDiv').hide();
  		$('#indiaDiv').hide();
  	}
}

function reloadBPType(){

     $('#bptype').combobox('clear');
	 var segment=$('#gtnSegment').textbox('getValue');
	 var region=$('#programRegion').textbox('getValue');
	 var tier=$('#tier').combobox('getValue');
	 if(tier){
	     var url = 'combo!getComboBPType.action?segment='+segment+'&region='+region+'&tier='+tier;
	     $('#bptype').combobox('reload', url);
	 }
}


	
