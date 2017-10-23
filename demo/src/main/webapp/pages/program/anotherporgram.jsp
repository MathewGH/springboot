<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>


<html>
<head>

	<link rel="stylesheet" type="text/css" href="jquery/themes/bootstrap/easyui.css">
	<link rel="stylesheet" type="text/css" href="jquery/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="jquery/themes/color.css">
	<link rel="stylesheet" type="text/css" href="jquery/demo.css">
	
	
	<script type="text/javascript" src="jquery/jquery.min.js"></script>
	<script type="text/javascript" src="jquery/jquery.easyui.min.js"></script>
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
  
  </script>
  
  
</head>
	
	
	

<title>ProgramEdit</title>
<body>
    <div id='loadingDiv' style="position:absolute;z-index:1000;top:0px;left:0px;width:100%;height:100%;background:#DDDDDB;text-align:center;padding-top: 20%;">
       <img src='pages/jquery/images/loading_00.gif'/><br>
       <font>loading...</font>
    </div>  
    ${message} <br>
    Locale: ${pageContext.response.locale}
    
	<div id="mainBody"  title="haha" class="easyui-panel" style="margin-bottom:20px">
		<div title='<spring:message code="test.msg"/>' class="easyui-panel" data-options="iconCls:'icon-ok',collapsible:true" style="overflow:auto;padding:10px;">
            <div style="float:left;width:30%">
            	<input id="programID" labelPosition="top" label="" value=""  class="easyui-textbox" style="width:50%" disabled=true>           
            	<input labelPosition="top"  label=" " value=""  class="easyui-textbox"  style="width:50%;" disabled=true>
            	<input id="gtnSegment" labelPosition="top" label=""  value="" class="easyui-textbox"   style="width:50%;" disabled=true>
            	<input labelPosition="top" label=""  value="" class="easyui-textbox"   style="width:50%;" disabled=true>
            	<input id="gtnCurrency" name="program.gtnCurrency" labelPosition="top" label=""  value="" class="easyui-textbox"  disabled=true style="width:50%;">
            	<input id="hintMsg"  class="easyui-textbox"  name="hintMsg" type="hidden" value="">
            	<input id="obj1Flag"  class="easyui-textbox"  name="objectiveOneFlag" type="hidden" value="">
            </div>
            <div style="float:left;width:30%">
				<input labelPosition="top" label="" value=""  class="easyui-textbox"  style="width:50%" disabled=true>
				<input labelPosition="top" label=" " value=""  class="easyui-textbox"  style="width:50%;" disabled=true>
				<input id="programRegion" labelPosition="top" label=""  value="" class="easyui-textbox"   style="width:50%;" disabled=true>
				<input labelPosition="top" label=""  value="" class="easyui-textbox"   style="width:50%;" disabled=true>
				<input id="actionType"  class="easyui-textbox"  name="actionType" type="hidden" value=""  style="width:50%;">
			</div>
			 <div style="float:left;width:40%">
				<input labelPosition="top" label=""  value="" class="easyui-textbox"  style="width:50%;" disabled=true>
				<input labelPosition="top" label=""  value="" class="easyui-textbox"   style="width:50%;" disabled=true>
				<input labelPosition="top" label=""  value="" class="easyui-textbox"   style="width:50%;" disabled=true>
            	<input labelPosition="top" label=""  value="" class="easyui-textbox"   style="width:50%;" disabled=true>
			</div>
        
		</div>
		



    

</body>
</html>