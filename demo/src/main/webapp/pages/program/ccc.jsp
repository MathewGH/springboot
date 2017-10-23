<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>


<html>
<head>

<jsp:include page="../commons/_easyui.jsp"></jsp:include>
<jsp:include page="../commons/_editjslib.jsp"></jsp:include>

  <script type="text/javascript">
  //add a mask before all easyui style were completely loaded.
  //Note: do not change the position of bellow code
  function closes(){
		$("#loadingDiv").fadeOut("normal",function(){
			$(this).remove();
		});
	}
	var pc;
	$.parser.onComplete = function(){
		if(pc) clearTimeout(pc);
		pc = setTimeout(closes, 1000);
	}
	
  //mask end
  var GTN_PURPOSE=[{
	    text: 'Contractual',
		value: 'Contractual',
		selected: true
  }]
  
  var AUTO_CALCULATION=[{
		text: 'YES',
		value: 'YES',
		selected: true
	},{
		text: 'NO',
		value: 'NO'
	}];
  
  var AUTO_MEASURE_BASE=[{
		text: 'SI',
		value: 'SI',
		selected: true
	},{
		text: 'ST',
		value: 'ST'
	},{
		text: 'SO',
		value: 'SO'
	}];
  
  
  var AUTO_DRIVER=[{
		text: 'REV',
		value: 'REV',
		selected: true
	},{
		text: 'CA',
		value: 'CA'
	}];
  
  var OBJECTIVE3_PURPOSE=[{
		text: 'Linearity',
		value: 'Linearity',
		selected: true
	},{
		text: 'MarketDispline',
		value: 'MarketDispline'
	},{
		text: 'DataSubmission',
		value: 'DataSubmission'
	},{
		text: 'AnnualQuotaAttainment',
		value: 'AnnualQuotaAttainment'
	},{
		text: 'AuditScore',
		value: 'AuditScore'
	},{
		text: 'IndiaUpfrontRebate',
		value: 'IndiaUpfrontRebate'
	},{
		text: 'Others',
		value: 'Others'
	}];
  
  var PRODUCT_FLAG=[{
	  text:'Include',
	  value:'I'
  },{
	  text:'Exclude',
	  value:'E'
  }];
  
  function changeLabel(className,newValue){
		$(className).each(function(){
			$(this).html(newValue);
		});
	}  
  function enableOrDisableWidgets(widgetName,flag){
	  $(widgetName).find(".easyui-combobox").each(function(){
		    $(this).combobox(flag);
     });
	   
	     $(widgetName).find(".easyui-textbox").each(function(){
		    $(this).textbox(flag);
    });
	   
 }
		
	$(function(){
		 $('#jpBPCode').textbox({
			  buttonIcon:'icon-search',
			  buttonAlign:'left',
			  editable:false,
			  buttonText:'<spring:message code="btn.getLocalBPCode"/>',
			  onClickButton:function(){
				  getBPCode();
			  }
			  
		 });
		 
		 $('#indiaContactID').textbox({
			  buttonIcon:'icon-search',
			  buttonAlign:'left',
			  editable:false,
			  buttonText:'<spring:message code="btn.getContanctID"/>',
			  onClickButton:function(){
				  getContactID();
			  }
			  
		 });
			//Drive Rebate计算方式
			$("#obj1driver").combobox({
				//url: 'combo!getDriver.action',
		        //method: 'get',
		        required:true,
		        valueField:'value',
		        textField:'text',
		        onChange:function(newValue,oldValue){
		        	if(newValue=='REV'){
		        		changeLabel('.obj1LabelFlag','<spring:message code="obj.pctSymbol" />');
		        
		        	}else{
		        		changeLabel('.obj1LabelFlag','<spring:message code="obj.caSymbol" />');
		        	}
		        }
			});
			
			//Drive Rebate计算方式
			$("#obj2driver").combobox({
				//url: 'combo!getDriver.action',
			    //method: 'get',
			    data: AUTO_DRIVER,
			    valueField:'value',
			    textField:'text',
			    onChange:function(newValue,oldValue){
			    	if(newValue=='REV'){
		        		changeLabel('.obj2LabelFlag','<spring:message code="obj.pctSymbol" />');
		        
		        	}else{
		        		changeLabel('.obj2LabelFlag','<spring:message code="obj.caSymbol" />');
		        	}
			    }
			});
			
			
			
			//make sure this dg was initialized first so that the drive combobox can controll the title name of this dg.
			$('#linearityInfos').datagrid({
					iconCls: 'icon-edit',
					singleSelect: true,
					toolbar: '#linearitytoolbar',
					url: '',
					method: 'get',
					onClickCell: onClickCell,
					idField:'id',
					sortName:'id',
		            sortOrder:'desc',
					pagination:true,
	              pageSize:5,
	              pageList:[5],
	              columns:[[
	                        {field:'id',title:'<spring:message code="obj.id"/>',width:80},
	                        {field:'programID',hidden:true},
	                        {field:'itemNo',hidden:true},
	                        {field:'target',title:'<spring:message code="obj.target"/>',editor:{type:'numberbox',options:{precision:3}},width:100},
	                        {field:'rebate',title:'<spring:message code="obj.rebate"/>',editor:{type:'numberbox',options:{precision:3}},width:100},
	                        {field:'startDate',title:'<spring:message code="obj.startDate"/>',width:100,editor:{type:'datebox',options:{required:true,formatter:myformatter,parser:myparser}}},
	                        {field:'endDate',title:'<spring:message code="obj.endDate"/>',width:100,editor:{type:'datebox',options:{required:true,formatter:myformatter,parser:myparser}}}
	                    ]]
			})
			
			
		 	//Drive Rebate计算方式
		 		$("#obj3driver").combobox({
		 			//url: 'combo!getDriverForObj3.action',
		 	   //method: 'get',
		 	   required:true,
		 	   data: AUTO_DRIVER,
		 	   valueField:'value',
		 	   textField:'text',
		 	   onChange:function(newValue,oldValue){
		 	   	var str = $('#obj3purpose').combobox('getValue');
		 	       	if(newValue=='REV'){
		 	       		
		       	    	$('#linearityInfos').datagrid('getColumnOption', 'rebate').title = "Rebate(%)";
		       	    	$('#linearityInfos').datagrid();
		 	       		if(str != 'Linearity'){
		 	           		$("#obj3fixedAmount").textbox('setValue','0');
		 	           		tbAvailabilityControll('#obj3fixedAmount',true);
		 	           		tbAvailabilityControll('#obj3fixedRebate',false);
		 	       		}else{
		 	           		tbAvailabilityControll('#obj3fixedAmount',true);
		 	           		tbAvailabilityControll('#obj3fixedRebate',true);
		 	       		}
		 	       		
		 	       		changeLabel('.obj3LabelFlag','<spring:message code="obj.pctSymbol" />');
		 	       		
		 	       	
		 	       	}else if(newValue=='CA'){
		       	   	    $('#linearityInfos').datagrid('getColumnOption', 'rebate').title = "Rebate($/unit)";
		       	   	    $('#linearityInfos').datagrid();
		 	       		if(str != 'Linearity'){
		 	       			
		 	           		$("#obj3fixedAmount").textbox('setValue','0');
		 	           		tbAvailabilityControll('#obj3fixedAmount',true);
		 	           		tbAvailabilityControll('#obj3fixedRebate',false);
		 	       		}else{
		 	       			
		 	           		tbAvailabilityControll('#obj3fixedAmount',true);
		 	           		tbAvailabilityControll('#obj3fixedRebate',true);
		 	       		}
		 	       		changeLabel('.obj3LabelFlag','<spring:message code="obj.caSymbol" />');
		 	       	}else{
		 	       		if(str != 'Linearity'){
		 	           		
		 	           		tbAvailabilityControll('#obj3fixedAmount',false);
		 	           		$("#obj3fixedRebate").textbox('setValue','0');
		 	           		tbAvailabilityControll('#obj3fixedRebate',true);
		 	       		}else{
		 	           		tbAvailabilityControll('#obj3fixedAmount',true);
		 	           		tbAvailabilityControll('#obj3fixedRebate',true);
		 	       		}
		 	       	}
		 	       	
		 	       }
		 		});
			
		})

	
  
  function disableWidgets(){
	    $(".easyui-combobox").each(function(){
   		    $(this).combobox('disable')
        }); 
	    
	    $(".easyui-textbox").each(function(){
 		    $(this).textbox('disable')
      	});
  }
  
  function disableBtn(){
	   $(".easyui-linkbutton").each(function(){
		   $(this).linkbutton('disable');
	   });
   }
  
  $(function(){
	  
	  var hintMsg=$('#hintMsg').textbox('getValue');
	  if(hintMsg!=''){
		  $.messager.alert('Warning',hintMsg,'warning'); 
	  }
	  var actionType=$('#actionType').textbox('getValue');
	  
      if(actionType!='addTerms'){
        	disableWidgets();
        }
      if(actionType == 'queryTerms'){
        	disableBtn();
        }
   });
  
	
	 function myformatter(date){
        var y = date.getFullYear();
        var m = date.getMonth()+1;
        var d = date.getDate();
        return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
    }
    function myparser(s){
        if (!s) return new Date();
        var ss = (s.split('-'));
        var y = parseInt(ss[0],10);
        var m = parseInt(ss[1],10);
        var d = parseInt(ss[2],10);
        if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
            return new Date(y,m-1,d);
        } else {
            return new Date();
        }
    }
	
	
	 $.extend($.fn.validatebox.defaults.rules, {
		 capGreaterThan:{
			 validator:function(value,param){
				 var previousSlab=parseFloat($(param[0]).val());
				 var isCapped=$(param[1]).val()=='YES';
				 var currentSlab=parseFloat(value);
				 if(isCapped&&previousSlab>0){
				   return currentSlab>previousSlab;
				 }
				 return true;
			 },
			 message: 'You must input a bigger value than the one in previouse slab!'
		 },
		 normalGreaterThan:{
			 validator:function(value,param){
				 var previousSlab=parseFloat($(param[0]).val());
				 var currentSlab=parseFloat(value);
				 if(previousSlab>0&&currentSlab>0){
				   return currentSlab>previousSlab;
				 }
				 return true;
			 },
			 message: 'You must input a bigger value than the one in previouse slab!'
		 },
         rebate: {// rebate
             validator: function (value) {
                 return (/^(0|[0-9]*)$/.test(value) || /^(0|[0-9]*)\.\d{0,3}$/.test(value));
             },
             message: 'The data format is not right!'
         },
         capValidate: {
             validator: function (value,param) {
            	 var previoseSlab=parseFloat($(param[0]).val());
            	 if(previoseSlab>0){
                    return value<=previoseSlab;
            	 }
            	 return true;
          	   
             },
             message: 'Rebate % for 4th slab should be decelerator, and need be less than the rebate% for 3rd slab!'
         }
	 });
	
   function tbAvailabilityControll(objId,flag){
			$(objId).textbox({
				disabled:flag
			})
		}
	 
	//获取mtm下拉菜单列表
	function getMtmObj(){
		$('#obj2mtm').combobox('enable');
		
		   var str1 = $('#obj2ph1').combobox('getValues');
		   var str2 = $('#obj2ph2').combobox('getValues');
		   var str3 = $('#obj2ph3').combobox('getValues');
		   var str4 = $('#obj2ph4').combobox('getValues');
		   var str5 = $('#obj2ph5').combobox('getValues');
		   var str6 = $('#obj2ph6').combobox('getValues');
		   
		   var url = 'combo!getObj2Mtm.action?phtype=';
		   
		   if(str6 != null && str6.length > 0 && str6[0].length > 0){
			   url = url + 'ph6&phcode=' + str6;
		   }else if(str5 != null && str5.length > 0 && str5[0].length > 0){
			   url = url + 'ph5&phcode=' + str5;
		   }else if(str4 != null && str4.length > 0 && str4[0].length > 0){
			   url = url + 'ph4&phcode=' + str4;
		   }else if(str3 != null && str3.length > 0 && str3[0].length > 0){
			   url = url + 'ph3&phcode=' + str3;
		   }else if(str2 != null && str2.length > 0 && str2[0].length > 0){
			   url = url + 'ph2&phcode=' + str2;
		   }else if(str1 != null && str1.length > 0 && str1[0].length > 0){
			   url = url + 'ph1&phcode=' + str1;
		   }else{
			   $.messager.alert({
					title:'Warning',
					icon:'warning',
					msg:'Please choose the Product Hierachy firstly!',
					showType:'slide',
					style:{
	                   align:'center'
					}
				});
			   return;
		   }
		   
	       $('#obj2mtm').combobox('reload', url);
	   }
	
	 $(function(){
		 $('#uploadFB').filebox({
			 onChange:function(newValue,oldValue){
				 var array=newValue.split('.');
				 var msgContent='';
				 var suffix=array[array.length-1];
				 if((suffix!='xlsx')&&(suffix!='xls')){
					 msgContent='Invalid file type! Only excel is supported,please check!';
				 }
				 if(msgContent!=''){
					 $.messager.alert('File Upload Result',msgContent,'warning');
				 }
			 }
		 })
	 });
	
  </script>
  
  
</head>
	
	
	

<title>ProgramEdit</title>
<body>
    
    <div id='loadingDiv' style="position:absolute;z-index:1000;top:0px;left:0px;width:100%;height:100%;background:#DDDDDB;text-align:center;padding-top: 40%;">
       <img src='pages/images/loading_00.gif'/><br>
       <font>loading...</font>
    </div>  
    
	<div id="mainBody" class="easyui-panel" style="margin-bottom:20px">
		<div title="<spring:message code='programmgt.gtnProgramInfo'/>" class="easyui-panel" data-options="iconCls:'icon-ok',collapsible:true" style="overflow:auto;padding:10px;">
            <div style="float:left;width:30%">
            	<input id="programID" labelPosition="top" label="<spring:message code="programmgt.programID" />" value="<s:property value="program.programID"/>"  class="easyui-textbox" style="width:50%" disabled=true>           
            	<input labelPosition="top"  label=" <spring:message code="programmgt.gtnPoolCode" />" value="<s:property value="program.gtnPoolCode"/>"  class="easyui-textbox"  style="width:50%;" disabled=true>
            	<input id="gtnSegment" labelPosition="top" label="<spring:message code="programmgt.segment" />"  value="<s:property value="program.segment"/>" class="easyui-textbox"   style="width:50%;" disabled=true>
            	<input labelPosition="top" label="<spring:message code="programmgt.startDate" />"  value="<s:property value="program.startDate"/>" class="easyui-textbox"   style="width:50%;" disabled=true>
            	<input id="gtnCurrency" name="program.gtnCurrency" labelPosition="top" label="<spring:message code="programmgt.gtnCurrency" />"  value="<s:property value="program.gtnCurrency"/>" class="easyui-textbox"  disabled=true style="width:50%;">
            	<input id="hintMsg"  class="easyui-textbox"  name="hintMsg" type="hidden" value="<s:property value="hintMsg"/>">
            	<input id="obj1Flag"  class="easyui-textbox"  name="objectiveOneFlag" type="hidden" value="<s:property value="objectiveOneFlag"/>">
            </div>
            <div style="float:left;width:30%">
				<input labelPosition="top" label="<spring:message code="programmgt.programName" />" value="<s:property value="program.programName"/>"  class="easyui-textbox"  style="width:50%" disabled=true>
				<input labelPosition="top" label=" <spring:message code="programmgt.gtnPoolName" />" value="<s:property value="program.gtnPoolName"/>"  class="easyui-textbox"  style="width:50%;" disabled=true>
				<input id="programRegion" labelPosition="top" label="<spring:message code="programmgt.region" />"  value="<s:property value="program.region"/>" class="easyui-textbox"   style="width:50%;" disabled=true>
				<input labelPosition="top" label="<spring:message code="programmgt.endDate" />"  value="<s:property value="program.endDate"/>" class="easyui-textbox"   style="width:50%;" disabled=true>
				<input id="actionType"  class="easyui-textbox"  name="actionType" type="hidden" value="<s:property value="actionType"/>"  style="width:50%;">
			</div>
			 <div style="float:left;width:40%">
				<input labelPosition="top" label="<spring:message code="programmgt.programDesc" />"  value="<s:property value="program.programDesc"/>" class="easyui-textbox"  style="width:50%;" disabled=true>
				<input labelPosition="top" label="<spring:message code="programmgt.gtnType" />"  value="<s:property value="program.gtnType"/>" class="easyui-textbox"   style="width:50%;" disabled=true>
				<input labelPosition="top" label="<spring:message code="programmgt.status" />"  value="<s:property value="program.status"/>" class="easyui-textbox"   style="width:50%;" disabled=true>
            	<input labelPosition="top" label="<spring:message code="programmgt.programValue" />"  value="<s:property value="program.programValue"/>" class="easyui-textbox"   style="width:50%;" disabled=true>
			</div>
        
		</div>
		<div title="<spring:message code='programmgt.programBasicInfo'/>" class="easyui-panel" data-options="iconCls:'icon-ok',collapsible:true" style="padding:10px;">
              	   <div id="basicBtnDiv" style="border:1px solid #ddd;">
                     <a href="javascript:void(0)"  class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editProgram()"><spring:message code='btn.edit'/></a>
                     <a href="javascript:void(0)"  class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveProgram()"><spring:message code='btn.save'/></a>
                     <a href="javascript:void(0)"  class="easyui-linkbutton" iconCls="icon-sum" plain="true" onclick="exportAllBP()"><spring:message code='btn.exportAllBP'/></a>
                   </div>
               <form method="post" id="bsForm">
                  <div id="editArea" style="margin-top:10px">
                  	<div class="easyui-panel" title="Basic Infos:">
                  		<div style="padding:5px;">
                  			<input id="gtnPurpose" name="program.gtnPurpose" value="<s:property value="program.gtnPurpose"/>" class="easyui-combobox" label="<spring:message code="programmgt.gtnPurpose" />" style="width:25%">
                            <input id="autoflag" name="program.autoCalculated" labelWidth=180 value="<s:property value="program.autoCalculated"/>" label="<spring:message code="programmgt.autoFlag" />" labelPosition="left"  class="easyui-combobox"  style="width:25%">
                            <input id="currency" name="program.currency" labelPosition="left" label="<spring:message code="programmgt.currency" />"  value="<s:property value="program.currency"/>" class="easyui-combobox"   style="width:20%;">
                            <input id="productGroup" name="program.productGroup" labelPosition="left" label="<spring:message code="programmgt.productGroup" />"  value="<s:property value="program.productGroup"/>" class="easyui-combobox"   style="width:25%;">
                        </div>
                  	</div>
                  	<div id="bpinfo" class="easyui-panel" title="BP Infos:">
                  		<div style="padding:5px;">
                         	<input id="country" name="program.countries" value="<s:property value="program.countries"/>" class="easyui-combobox" label="<spring:message code="programmgt.country" />" style="width:30%">
                  			<input id="tier" class="easyui-combobox" name="program.tier" value="<s:property value="program.tier"/>"  label="<spring:message code="programmgt.tier" />" style="width:20%"> 
                        	<input id="bptype" class="easyui-combobox" name="program.bpType" value="<s:property value="program.bpType"/>" label=" <spring:message code="programmgt.bpType" />" style="width:30%;">
                  		</div>
                  		<div style="padding:5px;">
                        	<input id="bpCategory" name="program.bpCategory" class="easyui-combobox" value="<s:property value="program.bpCategory"/>" label="<spring:message code="programmgt.bpCategory" />" style="width:30%;">
                  		</div>
                  		<div style="padding:5px;">
                  			<input id="bpflag" name="program.bpFlag" value="<s:property value="program.bpFlag"/>" class="easyui-combobox" label="<spring:message code="programmgt.bpFlag" />" style="width:30%">
                  			<input id="bpName" name="program.bpCode" value="<s:property value="program.bpCode"/>"class="easyui-combobox"  label=" <spring:message code="programmgt.bpName" />"  style="width:60%;">
                  		</div>
                  		<div style="padding:5px;">
                  			<input id="soldToNameFlag" name="program.soldToFlag" value="<s:property value="program.soldToFlag"/>" class="easyui-combobox"  label="<spring:message code="programmgt.soldToNameFlag" />" style="width:30%">
                          	<input id="soldToName"  name="program.soldToName" value="<s:property value="program.soldToName"/>" class="easyui-combobox" label="<spring:message code="programmgt.soldToName" />" style="width:60%">
                  		</div>
                  		<div style="padding:5px;">
                  			<input id="countryregion" name="program.countryRegions" value="<s:property value="program.countryRegions"/>" class="easyui-combobox" label="<spring:message code="programmgt.regions"/>" style="width:30%">
                         	<input id="states" name="program.states"  value="<s:property value="program.states"/>"   class="easyui-combobox" label="<spring:message code="programmgt.states" />" style="width:30%"> 
                  			<input id="cities" name="program.cities" value="<s:property value="program.cities"/>" class="easyui-combobox"  label="<spring:message code="programmgt.cities" />" style="width:30%">
  							<input id="programid" name="program.programID" type="hidden"  value="<s:property value="program.programID"/>" class="easyui-textbox"> 
                  		</div>
                  		<div id="indiaDiv"style="padding:5px">
                        	<input id="subsegment" name="program.subSegment" labelWidth=140 value="<s:property value="program.subSegment"/>" label="<spring:message code="programmgt.subSegment" />" labelPosition="left"  class="easyui-combobox"  editable='false' style="width:30%">
                        	<input id="indiaContactID" name="program.contactID" value="<s:property value="program.contactID"/>"  class="easyui-textbox"  style="width:60%;height:40px">
                  		</div>
                  		
                  		<div id="japanDiv"style="padding:5px">
                  		    <input id="departmentCode" labelWidth=150 name="program.departmentCode" value="<s:property value="program.departmentCode"/>"  class="easyui-combobox"   labelPosition="left" label="<spring:message code="programmgt.departmentCode"/>" style="width:30%">
                        	<input id="jpBPCode" name="program.jpBPCode" value="<s:property value="program.jpBPCode"/>" class="easyui-textbox"  style="width:60%;height:40px">
                  		</div>
                  		
                  	</div>
                  </div>
                </form>
		</div>
		<div id="obj1Panel" title="<spring:message code='programmgt.obj1Title'/>" style="padding:10px;">
                  <div id="obj1toolbar">
                    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="toObj1AddPage()"><spring:message code='btn.add'/></a>
                    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="removeObj1()"><spring:message code='btn.remove'/></a>
                  </div>
                  <table id="objective1" >    
                     <thead>     
                           <tr>  
                               <th field="id"><spring:message code="obj.id"/></th>     
                               <th field="measureBase"><spring:message code="obj.measureBase"/></th>
                               <th field="driver"><spring:message code="obj.driver"/></th>
			                   <th field="quota"><spring:message code="obj.quota"/></th>
							   <th field="capped"><spring:message code="obj.capped"/></th>
<%-- 			                   <th field="attainThreshold"><spring:message code="obj.attainThreshold"/></th> --%>
			                   <th field="attainUnderPerform"><spring:message code="obj.attainUnderPerform"/></th>
			                   <th field="attainBase"><spring:message code="obj.attainBase"/></th>
			                   <th field="attainOverPerform"><spring:message code="obj.attainOverPerform"/></th>
			                   <th field="attainCap"><spring:message code="obj.attainCap"/></th>
			                   <th field="rebateThreshold"><spring:message code="obj.rebateThreshold"/></th>
			                   <th field="rebateUnderPerform"><spring:message code="obj.rebateUnderPerform"/></th>
			                   <th field="rebateBase"><spring:message code="obj.rebateBase"/></th>
			                   <th field="rebateOverPerform"><spring:message code="obj.rebateOverPerform"/></th>
			                   <th field="rebateCap"><spring:message code="obj.rebateCap"/></th>
			                   <!-- hidden column -->
			                   <th field="programID" hidden="true"><spring:message code="programmgt.programID"/></th>
			                   <th field="itemNo" hidden="true"><spring:message code="obj.itemNo"/></th>
                         </tr>      
                    </thead>    
                </table>
		</div>
		<div id="obj2Panel"  title="<spring:message code='programmgt.obj2Title'/>" style="padding:10px;">
                 <div id="obj2toolbar">
                    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="toObj2AddPage()"><spring:message code='btn.add'/></a>
                    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="removeObj2()"><spring:message code='btn.remove'/></a>
                 </div>
                  <table id="objective2" >    
                     <thead>     
                           <tr>  
                               <th field="id"><spring:message code="obj.id"/></th> 
                               <th field="measureBase" ><spring:message code="obj.measureBase"/></th>
                               <th field="driver" ><spring:message code="obj.driver"/></th>
			                   <th field="quota" ><spring:message code="obj.quota"/></th>
							   <th field="capped" ><spring:message code="obj.capped"/></th>
			                   <th field="multipled" ><spring:message code="obj.multipled"/></th>
                               <th field="multiplier" ><spring:message code="obj.multiplier"/></th>    
			                   <th field="attainThreshold" ><spring:message code="obj.attainThreshold"/></th>
			                   <th field="attainUnderPerform" ><spring:message code="obj.attainUnderPerform"/></th>
			                   <th field="attainBase" ><spring:message code="obj.attainBase"/></th>
			                   <th field="attainOverPerform" ><spring:message code="obj.attainOverPerform"/></th>
			                   <th field="attainCap" ><spring:message code="obj.attainCap"/></th>
			                   <th field="rebateThreshold" ><spring:message code="obj.rebateThreshold"/></th>
			                   <th field="rebateUnderPerform" ><spring:message code="obj.rebateUnderPerform"/></th>
			                   <th field="rebateBase" ><spring:message code="obj.rebateBase"/></th>
			                   <th field="rebateOverPerform" ><spring:message code="obj.rebateOverPerform"/></th>
			                   <th field="rebateCap" ><spring:message code="obj.rebateCap"/></th>
			                   <!-- hidden column -->
			                   <th field="ph1"  hidden="true"><spring:message code="obj.ph1"/></th>
			                   <th field="ph2"  hidden="true"><spring:message code="obj.ph2"/></th>
			                   <th field="ph3"  hidden="true"><spring:message code="obj.ph3"/></th>
			                   <th field="ph4"  hidden="true"><spring:message code="obj.ph4"/></th>
			                   <th field="ph5"  hidden="true"><spring:message code="obj.ph5"/></th>
			                   <th field="ph6"  hidden="true"><spring:message code="obj.ph6"/></th>
			                   <th field="mtm"  hidden="true"><spring:message code="obj.mtm"/></th>
			                   <th field="programID" hidden="true"><spring:message code="programmgt.programID"/></th>
			                   <th field="itemNo" hidden="true"><spring:message code="obj.itemNo"/></th>
			                    
                         </tr>      
                    </thead>    
                </table>
                  
		</div>
		<div id="obj3Panel"  title="<spring:message code='programmgt.obj3Title'/>" style="padding:10px;">
                     <div id="obj3toolbar">
                       <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="toObj3AddPage()"><spring:message code='btn.add'/></a>
                       <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="removeObj3()"><spring:message code='btn.remove'/></a>
                     </div>
                 
                  <table id="objective3" >    
                     <thead>     
                           <tr> 
                               <th field="id" width="80"><spring:message code="obj.id"/></th>     
                               <th field="purpose" width="80"><spring:message code="obj.purpose"/></th>
							   <th field="measureBase" width="80"><spring:message code="obj.measureBase"/></th>
			                   <th field="driver" width="80"><spring:message code="obj.driver"/></th>
			                   <th field="fixedRebateDisplay" width="80"><spring:message code="obj.fixedRebate"/></th>
			                   <th field="fixedAmountDisplay" width="80"><spring:message code="obj.fixedAmount"/></th>
			                   
			                    <!-- hidden column -->
			                    <th field="programID" hidden="true"><spring:message code="programmgt.programID"/></th>
			                    <th field="itemNo" hidden="true"><spring:message code="obj.itemNo"/></th>
			                   <th field="fixedRebate" hidden="true"><spring:message code="obj.fixedRebate"/></th>
			                   <th field="fixedAmount" hidden="true"><spring:message code="obj.fixedAmount"/></th>
                          </tr>      
                     </thead>    
                  </table>
		</div>
	</div>
	<div style="margin:0 auto;width:200px;height:100px"> 
      <a href="javascript:void(0)" id="" class="easyui-linkbutton" onclick="nofityGtn()"><spring:message code='btn.submit'/></a>
    </div>
	
    
    <div id="obj1win" title="<spring:message code='programmgt.obj1Title'/>" style="align:center;width:80%;height:40%;padding:10px;" >
      <div title="Objective1 Info" class="easyui-resizable">
                   <div id="obj1BtnArea" style="border:1px solid #ddd">
                    <a href="javascript:void(0)" id="obj1EditBtn" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editObj1()"><spring:message code='btn.edit'/></a>
                     <a href="javascript:void(0)" id="obj1SaveBtn" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveObj1()"><spring:message code='btn.save'/></a>
                     <a href="javascript:void(0)" id="obj1AddBtn" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="addObj1()"><spring:message code='btn.add'/></a>
                   </div>
                <form method="post" id="obj1Form" >
                  <div  id="obj1EditArea" style="margin-top:10px">
                  	<div class="easyui-resizable resizableDiv" data-options="handle:'#obj1basicInfo'" >
                        <div id="obj1basicInfo" style="background:hsla(120,65%,75%,0.3);padding:5px;margin-bottom:10px"><spring:message code='obj.basicInfos'/></div>
                  		<div style="padding:5px;">
                  			<input id="obj1measureBase" name="obj1.measureBase" labelWidth=100 class="easyui-combobox"   labelPosition="left" label="<spring:message code="obj.measureBase" />" style="width:30%">
                        	<input id="obj1driver" name="obj1.driver" class="easyui-combobox"    labelPosition="left" label="<spring:message code="obj.driver" />" style="width:30%"> 
                  		</div>
                  		<div style="padding:5px;">
                  			<input id="obj1capped" name="obj1.capped" class="easyui-combobox" labelWidth=140 labelPosition="left" label="<spring:message code="obj.capped" />" style="width:30%;">
                  			<input id="obj1itemNo" name="obj1.itemNo" class="easyui-textbox" type="hidden">
                        	<input id="obj1programID"  name="obj1.programID" class="easyui-textbox" type="hidden">
                  		</div>
                  	</div>
                  	<div class="easyui-resizable resizableDiv" data-options="handle:'#obj1AttainInfo'" >
                        <div id="obj1AttainInfo" style="background:hsla(120,65%,75%,0.3);padding:5px"><spring:message code='obj.attainInfos'/></div>
                        <div id="obj1SlabDiv" class="easyui-resizable">
                        <table id="obj1SlabTable">
                        <tr class="bgc">
                        <td rowspan="2"></td>
                        <td colspan="2"><spring:message code="slab.attainment"/></td>
                        <td rowspan="2"><spring:message code="slab.rebate"/><label class="obj1LabelFlag"><spring:message code="obj.pctSymbol"/></label></td>
                        </tr>
                        
                        <tr class="bgc">
                        <td width="25%"><spring:message code="slab.from"/></td>
                        <td width="25%"><spring:message code="slab.to"/></td>
                        </tr>
                        
                        <tr class="alt">
                        <td><spring:message code="slab.slab1"/></td>
                        <td><input id="obj1attainThreshold" name="obj1.attainThreshold" data-options="prompt:'Attain Threshold'" class="easyui-textbox"  validtype="rebate"></td>
                        <td><input id="obj1attainUnderPerform" name="obj1.attainUnderPerform" data-options="prompt:'Attain Underperform',validType:'rebate'" class="easyui-textbox"></td>
                        <td><input id="obj1rebateUnderPerform" name="obj1.rebateUnderPerform" data-options="prompt:'Rebate Underperform'" class="easyui-textbox" validtype="rebate"></td>
                        </tr>
                        
                        <tr>
                        <td><spring:message code="slab.slab2"/></td>
                        <td><input id="obj1attainUnderPerformCP" name="obj1.attainUnderPerformCP"  class="easyui-textbox" data-options="prompt:'Attain Underperform'" validtype="rebate"></td>
                        <td><input id="obj1attainBase" name="obj1.attainBase" data-options="prompt:'Attain Base',validType:'rebate'" class="easyui-textbox"></td>
                        <td><input id="obj1rebateBase" name="obj1.rebateBase" data-options="prompt:'Rebate Base'" class="easyui-textbox" validtype="rebate"></td>
                        </tr>
                        
                        <tr class="alt">
                        <td><spring:message code="slab.slab3"/></td>
                        <td><input id="obj1attainBaseCP" class="easyui-textbox" name="obj1.attainBaseCP" data-options="prompt:'Attain Base'" validtype="rebate"></td>
                        <td><input id="obj1attainOverPerform" name="obj1.attainOverPerform" data-options="prompt:'Attain Overperform',validType:'rebate'" class="easyui-textbox"></td>
                        <td><input id="obj1rebateOverPerform" name="obj1.rebateOverPerform" data-options="prompt:'Rebate Overperform'" class="easyui-textbox" validtype="rebate"></td>
                        </tr>
                        
                        <tr>
                        <td><spring:message code="slab.slab4"/></td>
                        <td><input id="obj1attainOverPerformCP" name="obj1.attainOverPerformCP" data-options="prompt:'Attain Overperform'" class="easyui-textbox" validtype="rebate"></td>
                        <td><input id="obj1attainCap" name="obj1.attainCap" data-options="prompt:'Attain Cap',validType:['rebate','capGreaterThan[\'#obj1attainOverPerform\',\'obj1capped\']']" class="easyui-textbox"></td>
                        <td><input id="obj1rebateCap" name="obj1.rebateCap" class="easyui-textbox" data-options="validType:['rebate','capValidate[\'#obj1rebateOverPerform\']'],prompt:'Rebate Cap',required:true, missingMessage:'Please input rebate cap!'"></td>
                        </tr>
                        </table>
                    </div>
                    </div>
                  	<div id="obj1QuotaInfoTB" style="border:1px solid #ddd">
                  <!-- 	<a href="javascript:void(0)" class="easyui-linkbutton" plain="true" onclick="toObj1Upload()"><spring:message code='btn.upload'/></a> --> 
                      <a href="javascript:void(0)" id="obj1Export" class="easyui-linkbutton" plain="true" onclick="exportObj1QuotaInfo()"><spring:message code='btn.export'/></a>
                    </div>
                  	<table id="obj1QuotaInfoDG">
                  	  <thead>     
                           <tr> 
                               <th field="id" width="80"><spring:message code="obj.id"/></th>  
                               <th field="bpName" width="80"><spring:message code="obj.bpName"/></th>
							   <th field="quota" width="80"><spring:message code="obj.quota"/></th>
							   <th field="bpCode"  width="80"><spring:message code="obj.bpCode"/></th>
							  
							   <th field="programID" hidden="true"></th>
			                   <th field="itemNo" hidden="true"></th>
			                   <th field="objType" hidden="true"></th>
						   </tr>
					  </thead>
                  	</table>
                  </div>
                </form>
              </div>
    </div>  
	
	<div id="obj2win" title="<spring:message code='programmgt.obj2Title'/>" style="align:center;width:80%;height:50%;padding:10px;" >
      <div title="Objective2 Info"  class="easyui-resizable">
                   <div style="border:1px solid #ddd">
                    <a href="javascript:void(0)" id="obj2EditBtn" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editObj2()"><spring:message code='btn.edit'/></a>
                     <a href="javascript:void(0)" id="obj2SaveBtn" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveObj2()"><spring:message code='btn.save'/></a>
                     <a href="javascript:void(0)" id="obj2AddBtn" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="addObj2()"><spring:message code='btn.add'/></a>
                   </div>
                <form method="post" id="obj2Form">
                  <div  id="obj2EditArea" style="margin-top:10px;">
                   <div class="easyui-resizable resizableDiv" data-options="handle:'#obj2ProductInfo'" >
                        <div id="obj2ProductInfo" style="background:hsla(120,65%,75%,0.3);padding:5px;margin-bottom:10px;"><spring:message code='obj.productInfos'/></div>
                  		<div style=" padding:5px;">
                  			<select id="obj2ph1" name="obj2.ph1" class="easyui-combobox" label="<spring:message code="obj.ph1"/>" style="width:30%">
    					 	</select>
    					 	<select id="obj2ph2" name="obj2.ph2" class="easyui-combobox" label="<spring:message code="obj.ph2"/>" style="width:30%">
    					 	</select>
    					 	<select id="obj2ph3" name="obj2.ph3" class="easyui-combobox" label="<spring:message code="obj.ph3"/>" style="width:30%">
    					 	</select>    					 	
                  		</div>
                  		<div style="padding:5px;">
                  			<select id="obj2ph4" name="obj2.ph4" class="easyui-combobox" label="<spring:message code="obj.ph4"/>" style="width:30%">
    					 	</select>
                  			<select id="obj2ph5" name="obj2.ph5" class="easyui-combobox" label="<spring:message code="obj.ph5"/>" style="width:30%">
    					 	</select>
    					 	<select id="obj2ph6" name="obj2.ph6" class="easyui-combobox" label="<spring:message code="obj.ph6"/>" style="width:30%">
    					 	</select>    					 	
                  		</div>
                  		<div style=" padding:5px;">
                  			<select id="obj2productflag" labelWidth=120 name="obj2.productFlag" class="easyui-combobox" label="<spring:message code="obj.productFlag"/>" style="width:30%">
                  			</select>
                  			<select id="obj2mtm" name="obj2.mtm" class="easyui-combobox" label="<spring:message code="obj.mtm"/>" style="width:30%">
    					 	</select>
    					 	<a href="javascript:void(0)" id="obj2mtmbutton" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="getMtmObj()"><spring:message code='btn.getmtm'/></a>
                  		</div>
                  		<div id="divObj2Shikiri" style=" padding:5px;">
                  			<input id="obj2shikiricode" labelWidth=120 name="obj2.shikiriCode" class="easyui-textbox" labelPosition="left" label="<spring:message code="obj.shikiriCode" />" style="width:30%">
                  			<input id="obj2itemNo" name="obj2.itemNo" class="easyui-textbox" type="hidden">
                            <input id="obj2programID" name="obj2.programID" class="easyui-textbox" type="hidden">
                  		</div>
                  	</div>
                   <div class="easyui-resizable resizableDiv" data-options="handle:'#obj2BasicTitle'" >
                      <div id="obj2BasicTitle" style="background:hsla(120,65%,75%,0.3);padding:5px;margin-bottom:10px;"><spring:message code='obj.basicInfos'/></div>
                  		<div style="padding:5px;">
                  			<input id="obj2measureBase" name="obj2.measureBase" class="easyui-combobox" data-options='required:true' labelWidth=100 labelPosition="left" label="<spring:message code="obj.measureBase"/>" style="width:30%">
    					 	<input id="obj2driver" name="obj2.driver" class="easyui-combobox" data-options='required:true' labelPosition="left" label="<spring:message code="obj.driver"/>" style="width:30%">
                  		</div>
                  		<div style="padding:5px;">
                  			<input id="obj2capped" name="obj2.capped" labelWidth=140  class="easyui-combobox" labelPosition="left" label="<spring:message code="obj.capped"/>" style="width:30%">
                  			<input id="obj2multipled" name="obj2.multipled" labelWidth=120 class="easyui-combobox" labelPosition="left" label="<spring:message code="obj.multipled"/>" style="width:30%">
    						<input id="obj2multiplier" name="obj2.multiplier" class="easyui-textbox" validtype="rebate" data-options="prompt:'Format:x.xx', required:true, missingMessage:'Please input Multiplier!'" labelPosition="left" label="<spring:message code="obj.multiplier" />" style="width:30%" size="3">
                  		</div>
                  	</div>
                  	<div class="easyui-resizable resizableDiv" data-options="handle:'#obj2AttainInfo'" >
                        <div id="obj2AttainInfo" style="background:hsla(120,65%,75%,0.3);padding:5px"><spring:message code='obj.attainInfos'/></div>
                        <div id="obj2SlabDiv" class="easyui-resizable">
                        <table id="obj2SlabTable">
                        <tr class="bgc">
                        <td rowspan="2"></td>
                        <td colspan="2"><spring:message code="slab.attainment"/></td>
                        <td rowspan="2"><spring:message code="slab.rebate"/><label class="obj2LabelFlag"><spring:message code="obj.pctSymbol"/></label></td>
                        </tr>
                        
                        <tr class="bgc">
                        <td width="25%"><spring:message code="slab.from"/></td>
                        <td width="25%"><spring:message code="slab.to"/></td>
                        </tr>
                        
                        <tr class="alt">
                        <td><spring:message code="slab.slab1"/></td>
                        <td><input id="obj2attainThreshold" name="obj2.attainThreshold" data-options="prompt:'Attain Threshold'" class="easyui-textbox"  validtype="rebate"></td>
                        <td><input id="obj2attainUnderPerform" name="obj2.attainUnderPerform" data-options="prompt:'Attain Underperform',validType:'rebate'" class="easyui-textbox"></td>
                        <td><input id="obj2rebateUnderPerform" name="obj2.rebateUnderPerform" data-options="prompt:'Rebate Underperform'" class="easyui-textbox" validtype="rebate"></td>
                        </tr>
                        
                        <tr>
                        <td><spring:message code="slab.slab2"/></td>
                        <td><input id="obj2attainUnderPerformCP" name="obj2.attainUnderPerformCP" class="easyui-textbox" data-options="prompt:'Attain Underperform'" validtype="rebate"></td>
                        <td><input id="obj2attainBase" name="obj2.attainBase" data-options="prompt:'Attain Base',validType:'rebate'" class="easyui-textbox"></td>
                        <td><input id="obj2rebateBase" name="obj2.rebateBase" data-options="prompt:'Rebate Base'" class="easyui-textbox" validtype="rebate"></td>
                        </tr>
                        
                        <tr class="alt">
                        <td><spring:message code="slab.slab3"/></td>
                        <td><input id="obj2attainBaseCP" name="obj2.attainBaseCP" class="easyui-textbox" data-options="prompt:'Attain Base'" validtype="rebate"></td>
                        <td><input id="obj2attainOverPerform" name="obj2.attainOverPerform" data-options="prompt:'Attain Overperform',validType:'rebate'" class="easyui-textbox"></td>
                        <td><input id="obj2rebateOverPerform" name="obj2.rebateOverPerform" data-options="prompt:'Rebate Overperform'"  class="easyui-textbox" validtype="rebate"></td>
                        </tr>
                        
                        <tr>
                        <td><spring:message code="slab.slab4"/></td>
                        <td><input id="obj2attainOverPerformCP" name="obj2.attainOverPerformCP" data-options="prompt:'Attain Overperform'" class="easyui-textbox" validtype="rebate"></td>
                        <td><input id="obj2attainCap" name="obj2.attainCap" data-options="prompt:'Attain Cap',validType:['rebate','capGreaterThan[\'#obj2attainOverPerform\',\'obj2capped\']']" class="easyui-textbox"></td>
                        <td><input id="obj2rebateCap" name="obj2.rebateCap" class="easyui-textbox" data-options="validType:['rebate','capValidate[\'#obj2rebateOverPerform\']'],prompt:'Rebate Cap',required:true, missingMessage:'Please input rebate cap!'"></td>
                        </tr>
                        </table>
                    </div>
                    </div>
                    <div class="easyui-resizable resizableDiv" ">
                        <div ><spring:message code='slab.announcement'/></div>
                      </div>
                  	<div id="obj2QuotaInfoTB" style="border:1px solid #ddd">
                  	 <!-- <a href="javascript:void(0)" class="easyui-linkbutton" plain="true" onclick="toObj2Upload()"><spring:message code='btn.upload'/></a> --> 
                     <a href="javascript:void(0)" id="obj2Export" class="easyui-linkbutton" plain="true" onclick="exportObj2QuotaInfo()"><spring:message code='btn.export'/></a>
                   </div>
                  	<table id="obj2QuotaInfoDG">
                  	  <thead>     
                           <tr>      
                               <th field="id" width="80"><spring:message code="obj.id"/></th>  
                               <th field="bpName" width="80"><spring:message code="obj.bpName"/></th>
							   <th field="quota" width="80"><spring:message code="obj.quota"/></th>
							    <th field="bpCode"  width="80"><spring:message code="obj.bpCode"/></th>
							   
							   <th field="programID" hidden="true"></th>
			                   <th field="itemNo" hidden="true"></th>
			                   <th field="objType" hidden="true"></th>
						   </tr>
					  </thead>
                  	</table>
                  	
                  </div>
                  </form>
                </div>
    </div>  
    
    
    
   <div id="obj3win" title="<spring:message code='programmgt.obj3Title'/>" style="align:center;width:60%;height:40%;padding:10px;">
      <div title="Objective3 Info"  data-options="fit:true" >
                   <div style="border:1px solid #ddd">
                     <a href="javascript:void(0)" id="obj3EditBtn" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editObj3()"><spring:message code='btn.edit'/></a>
                     <a href="javascript:void(0)" id="obj3SaveBtn" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveObj3()"><spring:message code='btn.save'/></a>
                     <a href="javascript:void(0)" id="obj3AddBtn" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="addObj3()"><spring:message code='btn.add'/></a>
                   </div>
                <form method="post" id="obj3Form" onsubmit="return submitObj3Form();">
                  <div id="obj3EditArea" style="margin-top:10px;" >
                      <div class="easyui-resizable resizableDiv"  data-options="handle:'#obj3BasicTitle'" >
                      	<div id="obj3BasicTitle" style="background:hsla(120,65%,75%,0.3);padding:5px;margin-bottom:10px;"><spring:message code='obj.basicInfos'/></div>
                        <input id="obj3purpose" name="obj3.purpose" class="easyui-combobox" labelPosition="left" label="<spring:message code="obj.purpose"/>" style="width:30%">
                        <input id="obj3measureBase" name="obj3.measureBase" class="easyui-combobox" labelWidth=110 labelPosition="left" label="<spring:message code="obj.measureBase"/>" style="width:30%">
                        <input id="obj3driver" name="obj3.driver" class="easyui-combobox" labelPosition="left" label="<spring:message code="obj.driver"/>" style="width:30%">
                      </div>
                    
                      <div class="easyui-resizable resizableDiv"  data-options="handle:'#obj3Other'">
                        <div id="obj3Other" style="background:hsla(120,65%,75%,0.3);padding:5px;margin-bottom:10px"><spring:message code='obj.otherInfos'/></div>
                      	<input id="obj3fixedAmount" name="obj3.fixedAmount" labelWidth=90 class="easyui-textbox" validtype="rebate" data-options="prompt:'Fixed Amount'" labelPosition="left"  label="<spring:message code="obj.fixedAmount"/>" style="width:30%"><label><spring:message code="obj.dollar" /></label>
                      	<input id="obj3fixedRebate" name="obj3.fixedRebate" class="easyui-textbox" validtype="rebate" data-options="prompt:'Fixed Rebate'" labelPosition="left"  label="<spring:message code="obj.fixedRebate"/>" style="width:30%"><label class="obj3LabelFlag"><spring:message code="obj.pctSymbol" /></label>
                        <input id="obj3itemNo" name="obj3.itemNo" class="easyui-textbox"  type="hidden">
                        <input id="obj3programID" name="obj3.programID" class="easyui-textbox" type="hidden">
                      </div> 
                      <div class="easyui-resizable" data-options="handle:'#obj3Other'">
                        <div id="obj3Other" style="background:hsla(120,65%,75%,0.3);padding:5px;margin-bottom:10px;margin-top:10px;color:#F00;"><spring:message code='obj.notification'/></div>
                      </div>
                   </div>
                 
                   <div class="easyui-resizable resizableDiv" id="obj3LinearityDiv" data-options="handle:'#obj3Linearity'">
                      <div id="obj3Linearity" style="background:hsla(120,65%,75%,0.3);padding:5px;"><spring:message code='obj.linearityInfos'/></div>
                       <div id="linearitytoolbar">
                        <a href="javascript:void(0)" id="obj3AppendBtn" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append()"><spring:message code='btn.append'/></a>
        				<a href="javascript:void(0)"  id="obj3RemoveBtn" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removeit()"><spring:message code='btn.remove'/></a>
                      </div>
                    <table id="linearityInfos">
                    </table>
                   </div>
                      
             </form>         
         </div>
                 
    </div>
    
    
    <div id="obj1UploadWin" class="easyui-window" title="File Uplood" style="width:400px;height:200px;padding:10px">
       <form id="obj1UploadForm" action="objectiveOne!upload.action" enctype="multipart/form-data">  
        <div style="margin-bottom:40px">
            <input id="uploadFB" class="easyui-filebox" name="uploadFile" labelPosition="top" >
        </div>
        <div>
            <a href="#" id="uploadBtn" class="easyui-linkbutton" onclick="doObj1Upload()">Upload</a>
            <input id="obj1uploadItemNo" class="easyui-textbox" type="hidden">
            <input id="obj1uploadProgramID" class="easyui-textbox" type="hidden">
        </div>
        </form>
    </div>
    
      <div id="obj2UploadWin" class="easyui-window" title="File Uplood" style="width:400px;height:200px;padding:10px">
       <form id="obj2UploadForm" action="objectiveTwo!upload.action" enctype="multipart/form-data">  
        <div style="margin-bottom:40px">
            <input id="uploadFB" class="easyui-filebox" name="uploadFile" labelPosition="top" >
        </div>
        <div>
            <a href="#" id="uploadBtn" class="easyui-linkbutton" onclick="doObj2Upload()">Upload</a>
            <input id="obj2uploadItemNo" class="easyui-textbox" type="hidden">
            <input id="obj2uploadProgramID" class="easyui-textbox" type="hidden">
        </div>
        </form>
    </div>

   <script type="text/javascript">
   function exportAllBP(){
	     $("#bsForm").attr("action","program!exportAllBP.action") ;
		 $("#bsForm").submit();
   }
   
   function isBasicInfoValid(){
	   var tierId =  $('#tier').combobox('getValue'); 
       var bpName = $('#bpName').combobox('getValues'); 
       
       if(!bpName){
    	   return false;
       }
       if(!tierId){
    	   return false;
       }
       return true;
   }
   
   function nofityGtn(){
	   if(!isBasicInfoValid()||!isObj1Existing()){
		   $.messager.alert('Error','Please complete your program info first!','error');
		   return;
	   }
	
	   saveProgram();
	   var programID=$('#programID').textbox('getValue');
	   $.ajax({  
		    type:'get',
	        url: "program!notifyGTN.action?programID="+programID,  
	        success: function(data){                    
	            if(data.success){
	               $.messager.alert('Submit result','Success!','info');
	            }
	            if(data.failed){
	            	 $.messager.alert('Error','Error hapended when submiting ,please try later or contact your IT!','info');
	            }
  
	        },
	        error: function(XMLHttpRequest, textStatus, errorThrown){
	           }
	  });
   }
   
   function toObj1Upload(){
	   var itemNo=$('#obj1itemNo').textbox('getValue');
	   var programID=$('#obj1programID').textbox('getValue');
	   $('#obj1uploadItemNo').textbox('setValue',itemNo);
	   $('#obj1uploadProgramID').textbox('setValue',programID);
	   $('#obj1UploadWin').window('open');
	   
   }
   function doObj1Upload(){
	   var itemNo=$('#obj1uploadItemNo').textbox('getValue');
	   var programID=$('#obj1uploadProgramID').textbox('getValue');
	   var formData = new FormData($("#obj1UploadForm")[0]); 
	   formData.append("itemNo", itemNo);
	   formData.append("programID", programID);
	   
	   $.ajax({  
		    type:'post',
	        url: "objectiveOne!upload.action",  
	        data:formData,  
	        processData: false,  
	        contentType: false,  
	        dataType: "json",  
	        success: function(data){                    
	            if(data.success){
	            	 $('#obj1QuotaInfoDG').datagrid('reload');
	            	 $.messager.alert('File Upload Result','File was successfully uploaded!','info');
	            }  
	        },
	        error: function(XMLHttpRequest, textStatus, errorThrown){
	        	$.messager.alert('File Upload Result','File upload failed!','error');
	           }
	  });       
   }
   
   function toObj2Upload(){
	   var itemNo=$('#obj2itemNo').textbox('getValue');
	   var programID=$('#obj2programID').textbox('getValue');
	   $('#obj2uploadItemNo').textbox('setValue',itemNo);
	   $('#obj2uploadProgramID').textbox('setValue',programID);
	   $('#obj2UploadWin').window('open');
	   
   }
   
   function doObj2Upload(){
	   var itemNo=$('#obj2uploadItemNo').textbox('getValue');
	   var programID=$('#obj2uploadProgramID').textbox('getValue');
	   var formData = new FormData($("#obj2UploadForm")[0]); 
	   formData.append("itemNo", itemNo);
	   formData.append("programID", programID);
	   
	   $.ajax({  
		    type:'post',
	        url: "objectiveTwo!upload.action",  
	        data:formData,  
	        processData: false,  
	        contentType: false,  
	        dataType: "json",  
	        success: function(data){                    
	            if(data.success){
	            	 $('#obj2QuotaInfoDG').datagrid('reload');
	            	 $.messager.alert('File Upload Result','File was successfully uploaded!','info');
	            }  
	        },
	        error: function(XMLHttpRequest, textStatus, errorThrown){
	        	$.messager.alert('File Upload Result','File upload failed!','error');
	           }
	  });       
   }
   
   function formValidation(formId){
	   var isValid = $(formId).form('validate'); 
	   if(!isValid){
		   return false;
	   }
	   return true;
   }
   
   
     function editProgram(){
    	 enableOrDisableWidgets('#editArea','enable');
    	 
    	 var flag=$('#bpflag').combobox("getValue");
    	 if(!flag){
    		 $("#bpName").combobox("disable");
    	 }
    	 
     }
     
     function saveProgram(){
    	 if(!formValidation('#bsForm')){
    		 return;
    	 }
    	 enableOrDisableWidgets('#editArea','enable');
	     sendAjaxRequest('program!','updateProgramBaiscInfo.action','#bsForm');
	     enableOrDisableWidgets('#editArea','disable');
   }
     
     function editObj1(){
    	 enableOrDisableWidgets('#obj1EditArea','enable');
    	 if($('#obj1capped').combobox('getValue')=='NO'){
    	  $('#obj1attainCap').textbox('disable'); 
    	 }
    	 bindBlurForObj1();
     }
     
     function editObj2(){
    	 enableOrDisableWidgets('#obj2EditArea','enable');
    	 bindBlurForObj2();
    	 initObj2Status();
     } 
     
     //新增、查看objective2时根据关联关系设置控件使能状态
     function initObj2Status(){
    	 var str = $('#obj2multipled').combobox('getValue');
    	
    	 if(str == 'NO'){
    	 	$('#obj2multiplier').textbox('textbox').attr('disabled',true); 
    	 }else{
    	    $('#obj2attainThreshold').textbox('textbox').attr('disabled',true); 
    	    $('#obj2attainUnderPerform').textbox('textbox').attr('disabled',true); 
    	    $('#obj2attainBase').textbox('textbox').attr('disabled',true); 
    	    $('#obj2attainOverPerform').textbox('textbox').attr('disabled',true); 
    	    $('#obj2attainCap').textbox('textbox').attr('disabled',true); 
    	         			
    	    $('#obj2attainUnderPerformCP').textbox('textbox').attr('disabled',true); 
    	    $('#obj2attainBaseCP').textbox('textbox').attr('disabled',true); 
    	    $('#obj2attainOverPerformCP').textbox('textbox').attr('disabled',true); 
    	    
    	  //  $('#obj2rebateThreshold').textbox('textbox').attr('disabled',true); 
    	    $('#obj2rebateUnderPerform').textbox('textbox').attr('disabled',true); 
    	    $('#obj2rebateBase').textbox('textbox').attr('disabled',true); 
    	    $('#obj2rebateOverPerform').textbox('textbox').attr('disabled',true); 
    	    $('#obj2rebateCap').textbox('textbox').attr('disabled',true); 
    	 }
    	 
    	 
    	 if($('#obj2capped').combobox('getValue')=='NO'){
       	     $('#obj2attainCap').textbox('disable'); 
       	 }
    	 
    	 $('#obj2mtm').combobox('disable');
    	 var flag = $('#obj2productflag').combobox('getValue');
    	 if(flag){
    		 $("#obj2mtmbutton").linkbutton("enable");
    	 }else{
    	 	$("#obj2mtmbutton").linkbutton("disable");
    	 }
     }
     
     function editObj3(){
    	 enableOrDisableWidgets('#obj3EditArea','enable');
    	 
    	 initObj3Status();
     }
     
   	 //新增、查看objective=3时根据关联关系设置控件使能状态
     function initObj3Status(){
    	 var purpose = $('#obj3purpose').combobox('getValue');
    	 var driver = $('#obj3driver').combobox('getValue');
    	 
    	 if(purpose == 'Linearity'){
    			
    			$('#obj3fixedAmount').textbox('textbox').attr('disabled',true);
    			$('#obj3fixedRebate').textbox('textbox').attr('disabled',true);
    		}else{
    			if(driver == 'Others'){
    				$('#obj3fixedRebate').textbox('textbox').attr('disabled',true);
    			}else{
    				$('#obj3fixedAmount').textbox('textbox').attr('disabled',true);
    			}
    		}
     }
     
     function removeObj1(){
  	     removeObj('#objective1','objectiveOne!removeObjective.action','obj');
     }
   
     function removeObj2(){
	     removeObj('#objective2','objectiveTwo!removeObjective.action','obj');
        }
   
   function removeObj3(){
	   removeObj('#objective3','objectiveThree!removeObjective.action','obj');
   } 
  
   function saveObj2(){
	     enableOrDisableWidgets('#obj2EditArea','enable');
	     if(!formValidation('#obj2Form')){
    		 return;
    	 }
	     sendAjaxRequest('objectiveTwo!','updateObjective.action','#obj2Form','#objective2');
		 $('#obj2win').window('close');
   }
   
   function saveObj1(){
	     enableOrDisableWidgets('#obj1EditArea','enable');
	     
	     if(!formValidation('#obj1Form')){
    		 return;
    	 }
	     sendAjaxRequest('objectiveOne!','updateObjective.action','#obj1Form','#objective1');
		 $('#obj1win').window('close');
  }
   
   function saveObj3(){
	   enableOrDisableWidgets('#obj3EditArea','enable');
	   if(!formValidation('#obj3Form')){
  		 return;
  	 }
	   
	   var $dg = $("#linearityInfos");
	   //before saving ,endedit of the data grid
	   var index =  $dg.datagrid('getRows').length-1;
	   $dg.datagrid('endEdit',index);
	   
      var effectRow = new Object();
	   
	   if ($dg.datagrid('getChanges').length) {
           var inserted = $dg.datagrid('getChanges', "inserted");
           var deleted = $dg.datagrid('getChanges', "deleted");
           var updated = $dg.datagrid('getChanges', "updated");
           
           if (inserted.length) {
               effectRow["inserted"] = JSON.stringify(inserted);
           }
           if (deleted.length) {
               effectRow["deleted"] = JSON.stringify(deleted);
           }
           if (updated.length) {
               effectRow["updated"] = JSON.stringify(updated);
           }
           
	   }
	   effectRow["formData"]=DataDeal.formToJson($('#obj3Form').serialize());
	   
	   $.ajax({
           url: 'objectiveThree!updateObjective.action',
           data:effectRow,
           dataType:'json',
           success: function(data){
               if(data.success){
            	   $('#objective3').datagrid('reload');
            	   
            	   $.messager.show({
    				   title: 'Notification',
                       msg:'One Record was successfully updated !',
                       style:{
                    	    align:'center'
                    	    }
    			   });
               }
           },
           error: function(XMLHttpRequest, textStatus, errorThrown){
        	   alert(errorThrown);
               error.apply(this, arguments);
           }
       });
	   
		 $('#obj3win').window('close');
  }
   
   function isObj1Existing(){
	   if($('#obj1Flag').textbox('getValue')=='YES'){
		   return true;
	   }
	   if($('#objective1').datagrid('getRows').length>0){
		   return true;
	   }
	   return false;
   }
   
   function loadDataForCombo(objId){
	   var measureBase='#'+objId+'measureBase';
	   var driver='#'+objId+'driver';
	   $(measureBase).combobox('loadData',AUTO_MEASURE_BASE);
	   $(driver).combobox('loadData',AUTO_DRIVER);
	   
	   if(objId=='obj3'){
		   var purpose='#'+objId+'purpose';
		   $(purpose).combobox('loadData',OBJECTIVE3_PURPOSE);
		   return;
	   }
	   
	    var capped='#'+objId+'capped';
	   $(capped).combobox('loadData',AUTO_CALCULATION);
	   
	   if(objId=='obj2'){
		     var multipled='#'+objId+'multipled';
		     $(multipled).combobox('loadData',AUTO_CALCULATION);
		   }
   }
   
   function toObj3AddPage(){
	   
	   //add the getRows in case that user remove the existing obj1 and then create obj2 or 3
	   if (!isObj1Existing()){
		   $.messager.alert('Error','Please create Objetive 1 first!','error');
		   return;
	   }
	   
	   enableOrDisableWidgets('#obj3EditArea','enable');
	   
	   loadDataForCombo('obj3');
	   
	   //clear the datagrid. otherwise there will be dirty data.
	   $("#linearityInfos").datagrid('loadData', []);
	   
	   initObj3Status();
 
	   $("#obj3EditBtn").hide(); 
	   $("#obj3SaveBtn").hide();
	   $("#obj3AddBtn").show();
  	   
   	 var programID=$('#programID').textbox('getValue');
 	  $('#obj3programID').textbox('setValue',programID);
	   $('#obj3win').window('open');
	   
   }
   
   function toObj2AddPage(){
	   
	   if (!isObj1Existing()){
		   $.messager.alert('Error','Please create Objetive 1 first!','error');
		   return;
	   }
	   
	   enableOrDisableWidgets('#obj2EditArea','enable');
	   
	   loadDataForCombo('obj2');
	   
	   bindBlurForObj2();
	   
	   initObj2Status();
	   
	   //need to manually clear the cache data .otherwise user may see the 
	   //dirty data from last edit page.
	   $('#obj2ph1').combobox('clear');
	   
	   $('#obj2ph1').combobox('reload','combo!getObj2ph.action?phtype=ph1');
	   
	   $("#obj2EditBtn").hide(); 
	   $("#obj2SaveBtn").hide();
	   $("#obj2AddBtn").show();

   	 var programID=$('#programID').textbox('getValue');
 	  $('#obj2programID').textbox('setValue',programID);
 	  
		var text=$('#country').combobox('getText');
		if(text.indexOf('Japan')!=-1){
			$('#divObj2Shikiri').show();
		}else{
			$('#divObj2Shikiri').hide();
		}
  	
	   $('#obj2win').window('open');
	   
   }
   
   function toObj1AddPage(){
	   enableOrDisableWidgets('#obj1EditArea','enable');
	   
	   loadDataForCombo('obj1');
	   
	   bindBlurForObj1();
	   
	   $("#obj1EditBtn").hide(); 
	   $("#obj1SaveBtn").hide();
	   $("#obj1AddBtn").show();
	
  	   var programID=$('#programID').textbox('getValue');
  	   $('#obj1programID').textbox('setValue',programID);
	   $('#obj1win').window('open');
	   
   }
   
   function addObj1(){
	    if(!formValidation('#obj1Form')){
  		     return;
  	    }
	     sendAjaxRequest('objectiveOne!','addObjective.action','#obj1Form','#objective1');
	     $('#obj1win').window('close');
   }
   
   function addObj2(){
	   if(!formValidation('#obj2Form')){
		     return;
	    }
	     sendAjaxRequest('objectiveTwo!','addObjective.action','#obj2Form','#objective2');
	     $('#obj2win').window('close');
   }
   
   
   function addObj3(){
	   if(!formValidation('#obj3Form')){
  		 return;
  	 }
	   
     var effectRow = new Object();
	   
	   var $dg = $("#linearityInfos");
	   //befor saving ,end edit. otherwise ,the data wont be saved.
	   var index =  $dg.datagrid('getRows').length-1;
	   $dg.datagrid('endEdit',index);
	   
	   if ($dg.datagrid('getChanges').length) {
           var inserted = $dg.datagrid('getChanges', "inserted");
           var deleted = $dg.datagrid('getChanges', "deleted");
           var updated = $dg.datagrid('getChanges', "updated");
           
           if (inserted.length) {
               effectRow["inserted"] = JSON.stringify(inserted);
           }
           if (deleted.length) {
               effectRow["deleted"] = JSON.stringify(deleted);
           }
           if (updated.length) {
               effectRow["updated"] = JSON.stringify(updated);
           }
           
	   }
	   effectRow["formData"]=DataDeal.formToJson($('#obj3Form').serialize());
	   
	   $.ajax({
           url: 'objectiveThree!addObjective.action',
           data:effectRow,
           dataType:'json',
           success: function(data){
               if(data.success){
            	   $('#objective3').datagrid('reload');
            	   
            	   $.messager.show({
    				   title: 'Notification',
                       msg:'One Record was successfully created !',
                       style:{
                    	    align:'center'
                    	    }
    			   });
               }
           },
           error: function(XMLHttpRequest, textStatus, errorThrown){
        	   alert(errorThrown);
               error.apply(this, arguments);
           }
       });
	   
	     $('#obj3win').window('close');
   }
   
   
   function exportObj1QuotaInfo(){
	   enableOrDisableWidgets('#obj1EditArea','enable');
	   if(!$('#obj1QuotaInfoDG').datagrid('getRows').length){
		   alert("No data . please confirm");
		   return;
	   }
	   
	   $("#obj1Form").attr("action","objectiveOne!exportQuota.action") ;
	   $("#obj1Form").submit();
	   
	   enableOrDisableWidgets('#obj1EditArea','disable');
   }
   
   function exportObj2QuotaInfo(){
	   enableOrDisableWidgets('#obj2EditArea','enable');
	   
	   $("#obj2Form").attr("action","objectiveTwo!exportQuota.action") ;
	   $("#obj2Form").submit();
	   
	   enableOrDisableWidgets('#obj2EditArea','disable');
   }
   function getBPCode(){
	   var options=$('#bpName').combobox('getValues');
	   if(!options.length){
		   $.messager.alert('Warning','Please select BP name first!','warning');
		   return;
	   }
	   $.ajax({
           url: 'combo!getJapanBPCode.action?bpCodes='+options,
           type: 'get',
           success: function(data){
        	   $('#jpBPCode').textbox('enable');
        	   if(data.userIds){
        	       $('#jpBPCode').textbox('setValue',data.userIds);
        	   }else{
        		   $('#jpBPCode').textbox('setValue','No data found');
        	   }
           },
           error: function(XMLHttpRequest, textStatus, errorThrown){
        	   alert(errorThrown);
               error.apply(this, arguments);
           }
       });
	   
   }
   function getContactID(){
	   var options=$('#bpName').combobox('getValues');
	   if(!options.length){
		   $.messager.alert('Warning','Please select BP name first!','warning');
		   return;
	   }
		   $.ajax({
	           url: 'combo!getContactID.action?bpCodes='+options,
	           type: 'get',
	           success: function(data){
	        	   $('#indiaContactID').textbox('enable');
	        	   if(data.contactIds){
	        	       $('#indiaContactID').textbox('setValue',data.contactIds);
	        	   }else{
	        		   $('#indiaContactID').textbox('setValue','No data found');
	        	   }
	           },
	           error: function(XMLHttpRequest, textStatus, errorThrown){
	        	   alert(errorThrown);
	               error.apply(this, arguments);
	           }
	       });
	 
   }
   
   function bindBlurForObj1(){
  	
  	 $('#obj1attainUnderPerform').textbox('textbox').bind('blur',function(){
			    var perform=$('#obj1attainUnderPerform').textbox('getValue');
			    if(perform&&perform!='0'){
				$('#obj1attainUnderPerformCP').textbox('setValue',perform);
			    }
			});
	 $('#obj1attainUnderPerformCP').textbox('textbox').bind('blur',function(){
		    var perform=$('#obj1attainUnderPerform').textbox('getValue');
		    var performCP=$('#obj1attainUnderPerformCP').textbox('getValue');
		    if(perform&&perform!='0'&&performCP!=perform){
			  $('#obj1attainUnderPerformCP').textbox('setValue',perform);
		    }
		});
  	 
	 $('#obj1attainBase').textbox('textbox').bind('blur',function(){
		    var base=$('#obj1attainBase').textbox('getValue');
		    if(base&&base!='0'){
			   $('#obj1attainBaseCP').textbox('setValue',base);
		    }
		});
	 
	 $('#obj1attainBaseCP').textbox('textbox').bind('blur',function(){
		    var base=$('#obj1attainBase').textbox('getValue');
		    var baseCP=$('#obj1attainBaseCP').textbox('getValue');
		    if(base&&base!='0'&&baseCP!=base){
			  $('#obj1attainBaseCP').textbox('setValue',base);
		    }
		});
	 $('#obj1attainOverPerform').textbox('textbox').bind('blur',function(){
  		 var overPerform=$('#obj1attainOverPerform').textbox('getValue');
  		if(overPerform&&overPerform!='0'){
				$('#obj1attainOverPerformCP').textbox('setValue',overPerform);
  		}
  	 });
	 
  	  $('#obj1attainOverPerformCP').textbox('textbox').bind('blur',function(){
  		 var overPerform=$('#obj1attainOverPerform').textbox('getValue');
  		 var overPerformCP=$('#obj1attainOverPerformCP').textbox('getValue');
  		if(overPerform&&overPerform!='0'&&overPerform!=overPerformCP){
				$('#obj1attainOverPerformCP').textbox('setValue',overPerform);
  		 }
  	  });
   }
   function unbindBlurForObj1(){
  	 $('#obj1attainUnderPerform').textbox('textbox').unbind('blur');
  	 $('#obj1attainBase').textbox('textbox').unbind('blur');
  	 $('#obj1attainOverPerform').textbox('textbox').unbind('blur');
  	 $('#obj1attainUnderPerformCP').textbox('textbox').unbind('blur');
	 $('#obj1attainBaseCP').textbox('textbox').unbind('blur');
  	 $('#obj1attainOverPerformCP').textbox('textbox').unbind('blur');
   }
   
   
   
   function bindBlurForObj2(){
  	 $('#obj2attainUnderPerform').textbox('textbox').bind('blur',function(){
			    var perform=$('#obj2attainUnderPerform').textbox('getValue');
			    var performCP=$('#obj2attainUnderPerformCP').textbox('getValue');
			    if(perform&&perform!='0'){
				  $('#obj2attainUnderPerformCP').textbox('setValue',perform)
			    }
			});
	 $('#obj2attainBase').textbox('textbox').bind('blur',function(){
		    var base=$('#obj2attainBase').textbox('getValue');
		    if(base&&base!='0'){
			 $('#obj2attainBaseCP').textbox('setValue',base)
		    }
		});
	 $('#obj2attainOverPerform').textbox('textbox').bind('blur',function(){
  		 var overPerform=$('#obj2attainOverPerform').textbox('getValue');
  		     if(overPerform&&overPerform!='0'){
				$('#obj2attainOverPerformCP').textbox('setValue',overPerform)
  		     }
  	 });
	 $('#obj2attainUnderPerformCP').textbox('textbox').bind('blur',function(){
		    var perform=$('#obj2attainUnderPerform').textbox('getValue');
		    var performCP=$('#obj2attainUnderPerformCP').textbox('getValue');
		    if(perform&&perform!='0'&&performCP!=perform){
			  $('#obj2attainUnderPerformCP').textbox('setValue',perform);
		    }
		});
	 
	 $('#obj2attainBaseCP').textbox('textbox').bind('blur',function(){
		    var base=$('#obj2attainBase').textbox('getValue');
		    var baseCP=$('#obj2attainBaseCP').textbox('getValue');
		    if(base&&base!='0'&&baseCP!=base){
			  $('#obj2attainBaseCP').textbox('setValue',base);
		    }
		});
	 
	  $('#obj2attainOverPerformCP').textbox('textbox').bind('blur',function(){
	  		 var overPerform=$('#obj2attainOverPerform').textbox('getValue');
	  		 var overPerformCP=$('#obj2attainOverPerformCP').textbox('getValue');
	  		if(overPerform&&overPerform!='0'&&overPerform!=overPerformCP){
					$('#obj2attainOverPerformCP').textbox('setValue',overPerform);
	  		 }
	  	  });
   }
   function unbindBlurForObj2(){
  	 $('#obj2attainUnderPerform').textbox('textbox').unbind('blur');
  	 $('#obj2attainBase').textbox('textbox').unbind('blur');
  	 $('#obj2attainOverPerform').textbox('textbox').unbind('blur');
  	 $('#obj2attainUnderPerformCP').textbox('textbox').unbind('blur');
	 $('#obj2attainBaseCP').textbox('textbox').unbind('blur');
  	 $('#obj2attainOverPerformCP').textbox('textbox').unbind('blur');
   }
   
   
   </script>
   
   <script type="text/javascript">
   //linearity datagrid operations
   var editIndex = undefined;
   var $dg=$('#linearityInfos');
   function endEditing(){
       if (editIndex == undefined){return true}
       if ($dg.datagrid('validateRow', editIndex)){
    	   $dg.datagrid('endEdit', editIndex);
           editIndex = undefined;
           return true;
       } else {
           return false;
       }
   }
   function onClickCell(index, field){
       if (editIndex != index){
           if (endEditing()){
        	   $dg.datagrid('selectRow', index)
                       .datagrid('beginEdit', index);
               var ed = $dg.datagrid('getEditor', {index:index,field:field});
               if (ed){
                   ($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
               }
               editIndex = index;
           } else {
               setTimeout(function(){
            	   $dg.datagrid('selectRow', editIndex);
               },0);
           }
       }
   }
 
   function append(){
       if (endEditing()){
    	   $dg.datagrid('appendRow',{ });
           editIndex = $dg.datagrid('getRows').length-1;
           $dg.datagrid('selectRow', editIndex)
                   .datagrid('beginEdit', editIndex);
       }
   }
   function removeit(){
       if (editIndex == undefined){return}
       $dg.datagrid('cancelEdit', editIndex)
               .datagrid('deleteRow', editIndex);
       editIndex = undefined;
   }
   </script>



    

</body>
</html>