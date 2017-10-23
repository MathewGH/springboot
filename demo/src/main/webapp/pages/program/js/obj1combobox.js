/**
 * this file includes all the ob1 related comboboxes that needs to be initialized in editprogram.jsp
 */


//objective1 combox initial
$(function(){
	//MeasureBase 基准销售数据类型
	$("#obj1measureBase").combobox({
		//url: 'combo!getMeasureBase.action',
        //method: 'get',
        required:true,
        valueField:'value',
        textField:'text'
	});
	
	//ISCapped 是否封顶
	$("#obj1capped").combobox({
		//url: 'combo!getCap.action',
        //method: 'get',
        valueField:'value',
        required:true,
        textField:'text',
  		onSelect: function(rec){
  			if(rec.value == 'YES') {
  				   $('#obj1attainCap').textbox('enable'); 
					$('#obj1attainCap').textbox({
		  					required:true, 
		  					missingMessage:'Please input attain cap!'
		  			 });
  			} else {
  				$('#obj1attainCap').textbox('setValue','0'); 
  				$('#obj1attainCap').textbox('disable'); 
  				$('#obj1attainCap').textbox({
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
	

	$("#obj1quota").textbox({
			required:true, 
			missingMessage:'Please input quota!'
		 });
});




