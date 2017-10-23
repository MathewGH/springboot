/**
 * this file includes all the ob3 related comboboxes that needs to be initialized in editprogram.jsp
 */


//objective3 


function reloadComboData(){
	 var AUTO_MEASURE_BASE3=[{
			text: 'SI',
			value: 'SI',
			selected: true
		},{
			text: 'ST',
			value: 'ST'
		},{
			text: 'SO',
			value: 'SO'
		},{
			text: 'Others',
			value: 'Others'
		}];
	 
	  var AUTO_DRIVER3=[{
			text: 'REV',
			value: 'REV',
			selected: true
		},{
			text: 'CA',
			value: 'CA'
		},{
			text: 'Others',
			value: 'Others'
		}];
	  
	  $('#obj3measureBase').combobox('loadData',AUTO_MEASURE_BASE3);
	  $("#obj3driver").combobox('loadData', AUTO_DRIVER3);
	  
}

$(function () {
	
	//purpose约束限制
     $('#obj3purpose').combobox({
    	 /**
    	 url: 'combo!getPurpose.action',
         method: 'get', */
         valueField:'value',
         required:true,
         textField:'text',
       	onChange: function (newVal,oldVal) {
       		var str = $('#obj3driver').combobox('getValue');
       		if(newVal == 'Linearity'){
       			$('#obj3measureBase').combobox('loadData',AUTO_MEASURE_BASE);
       			$("#obj3driver").combobox('loadData', AUTO_DRIVER);
       			
       			$('#obj3LinearityDiv').show();
       			
       			$("#obj3fixedAmount").textbox('setValue','0');
       			$("#obj3fixedRebate").textbox('setValue','0');
       			$('#obj3fixedAmount').textbox('disable');
       			$('#obj3fixedRebate').textbox('disable');
       			
       		}else{
       			reloadComboData();
       			
       			$('#obj3LinearityDiv').hide();
       			
       			if(str == 'Others'){
       				$("#obj3fixedRebate").textbox('setValue','0');
       				$('#obj3fixedAmount').textbox('enable');
	       			$('#obj3fixedRebate').textbox('disable');
       			}else{
       				$("#obj3fixedAmount").textbox('setValue','0');
       				$('#obj3fixedAmount').textbox('disable');
	       			$('#obj3fixedRebate').textbox('enable');
       			}	       			
       			
       		}
       	}
    });
     
   //MeasureBase 基准销售数据类型
 	$("#obj3measureBase").combobox({
 		//url: 'combo!getMeasureBaseForObj3.action',
    //method: 'get',
    data: AUTO_MEASURE_BASE,
    required:true,
    valueField:'value',
    textField:'text'
 	});
 	
});


