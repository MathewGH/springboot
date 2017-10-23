/**
 * this file includes all the obj2 related comboboxes that needs to be initialized in editprogram.jsp
 */



//objective2 

function slabTBSwitch(flag){
	
	$('#obj2attainStartPoint').textbox(flag); 
	$('#obj2attainThreshold').textbox(flag); 
	$('#obj2attainUnderPerform').textbox(flag); 
	$('#obj2attainBase').textbox(flag); 
	$('#obj2attainOverPerform').textbox(flag); 
	$('#obj2attainCap').textbox(flag); 
	
	$('#obj2attainUnderPerformCP').textbox(flag); 
	$('#obj2attainBaseCP').textbox(flag); 
	$('#obj2attainOverPerformCP').textbox(flag); 
	
	//$('#obj2rebateThreshold').textbox(flag); 
	$('#obj2rebateUnderPerform').textbox(flag); 
	$('#obj2rebateBase').textbox(flag); 
	$('#obj2rebateOverPerform').textbox(flag); 
	$('#obj2rebateCap').textbox(flag);
	
}

$(function () {
	//选择乘系数时的约束限制
    $('#obj2multipled').combobox({
    	//url: 'combo!getMultipled.action',
        //method: 'get',
        data: AUTO_CALCULATION,
        valueField:'value',
        textField:'text',
        required:true,
    	onSelect: function (rec) {
    		if(rec.value == 'NO'){
    			$('#obj2multiplier').textbox("setValue", "1");
    			$('#obj2multiplier').textbox('disable');
    			
    			slabTBSwitch('enable');
    			bindBlurForObj2();
    		}else{
    			$('#obj2multiplier').textbox('enable');
    			
    			slabTBSwitch('disable');
    		}
    	}
    });

//iscapped约束限制
$('#obj2capped').combobox({
	//url: 'combo!getCap.action',
    //method: 'get',
    data: AUTO_CALCULATION,
    valueField:'value',
    textField:'text',
    required:true,
    onSelect: function(rec){
    	if(rec.value == 'YES') {
			   $('#obj2attainCap').textbox('enable'); 
				$('#obj2attainCap').textbox({
	  					required:true, 
	  					missingMessage:'Please input attain cap!'
	  			 });
	  			
		} else {
			$('#obj2attainCap').textbox('setValue','0'); 
			$('#obj2attainCap').textbox('disable'); 
			$('#obj2attainCap').textbox({
					required:false
			 });
		}
    },
    onChange:function(newValue,oldValue){
    	if(newValue=="NO"){
    		$('#obj2attainCap').textbox('disable'); 
    	}
    }
});

$("#obj2measureBase").combobox({
	//url: 'combo!getMeasureBase.action',
    //method: 'get',
    data: AUTO_MEASURE_BASE,
    valueField:'value',
    textField:'text'
});


$('#obj2productflag').combobox({
	data: PRODUCT_FLAG,
	valueField: 'value',
	textField: 'text',
	onChange:function(newValue,oldValue){
		$("#obj2mtmbutton").linkbutton("enable");
	}
});

});


//product hierachy combobox list
$(function(){
	$('#obj2ph1').combobox({
    	url: '',
        method: 'get',
        valueField:'value',
        textField:'text',
        groupField:'ph',
        multiple:true,
        multiline:true,
        required:true,
        selectOnNavigation:true,
        labelPosition:'left',
        onSelect: function(rec){
            
        },
        onChange: function(newValue, oldValue){
        	$('#obj2ph2').combobox('clear');
        	$('#obj2ph3').combobox('clear');
            $('#obj2ph4').combobox('clear');
            $('#obj2ph5').combobox('clear');
            $('#obj2ph6').combobox('clear');
            $('#obj2mtm').combobox('clear');
            
        	var url = 'combo!getObj2ph.action?phtype=ph2&phcode='+newValue;
            $('#obj2ph2').combobox('reload', url);
        }
    });
	$('#obj2ph2').combobox({
    	url: '',
        method: 'get',
        valueField:'value',
        textField:'text',
        groupField:'ph',
        multiple:true,
        multiline:true,
        selectOnNavigation:true,
        labelPosition:'left',
        onSelect: function(rec){
            
        },
        onChange: function(newValue, oldValue){
        	$('#obj2ph3').combobox('clear');
        	$('#obj2ph4').combobox('clear');
            $('#obj2ph5').combobox('clear');
            $('#obj2ph6').combobox('clear');
            $('#obj2mtm').combobox('clear');
            
        	var url = 'combo!getObj2ph.action?phtype=ph3&phcode='+newValue;
            $('#obj2ph3').combobox('reload', url);
        }
    });
	$('#obj2ph3').combobox({
    	url: '',
        method: 'get',
        valueField:'value',
        textField:'text',
        groupField:'ph',
        multiple:true,
        multiline:true,
        selectOnNavigation:true,
        labelPosition:'left',
        onSelect: function(rec){
            
        },
        onChange: function(newValue, oldValue){
        	$('#obj2ph4').combobox('clear');
        	$('#obj2ph5').combobox('clear');
            $('#obj2ph6').combobox('clear');
            $('#obj2mtm').combobox('clear');
             
        	var url = 'combo!getObj2ph.action?phtype=ph4&phcode='+newValue;
            $('#obj2ph4').combobox('reload', url);
        }
    });
	$('#obj2ph4').combobox({
    	url: '',
        method: 'get',
        valueField:'value',
        textField:'text',
        groupField:'ph',
        multiple:true,
        multiline:true,
        selectOnNavigation:true,
        labelPosition:'left',
        onSelect: function(rec){
            
        },
        onChange: function(newValue, oldValue){
        	$('#obj2ph5').combobox('clear');
        	$('#obj2ph6').combobox('clear');
            $('#obj2mtm').combobox('clear');
            
        	var url = 'combo!getObj2ph.action?phtype=ph5&phcode='+newValue;
            $('#obj2ph5').combobox('reload', url);    
        }
    });
	$('#obj2ph5').combobox({
    	url: '',
        method: 'get',
        valueField:'value',
        textField:'text',
        groupField:'ph',
        multiple:true,
        multiline:true,
        selectOnNavigation:true,
        labelPosition:'left',
        onSelect: function(rec){
            
        },
        onChange: function(newValue, oldValue){
        	$('#obj2ph6').combobox('clear');
        	$('#obj2mtm').combobox('clear');
        	
        	var url = 'combo!getObj2ph.action?phtype=ph6&phcode='+newValue;
            $('#obj2ph6').combobox('reload', url);
        }
    });
	$('#obj2ph6').combobox({
    	url: '',
        method: 'get',
        valueField:'value',
        textField:'text',
        groupField:'ph',
        multiple:true,
        multiline:true,
        selectOnNavigation:true,
        labelPosition:'left',
        onChange: function(newValue, oldValue){
        	$('#obj2mtm').combobox('clear');
        }
    });

	
	
	$('#obj2mtm').combobox({
        multiple:true,
        multiline:true,
        editable:false,
        labelPosition:'left'
    });
});