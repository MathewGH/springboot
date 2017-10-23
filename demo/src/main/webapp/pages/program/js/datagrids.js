/**
 * this file includes all the datagrids that needs to be initialized in editprogram.jsp
 */


  $(function(){
      $('#objective1').datagrid({      
             nowrap: false,
             striped: true,
             pagination: true,
             border: true,      
             toolbar:'#obj1toolbar', 
             fitColumns:true,
             url:'',
             remoteSort:false,    
             resizable:true,
             idField:'id',
             align:'left',
             singleSelect:true,
             onDblClickRow:function(rowIndex,rowData){
            	 loadDataForCombo('obj1');
            	 
            	 var row= $('#objective1').datagrid('getSelected');
            	 $("#obj1itemNo").textbox('setValue',row.itemNo);
            	 $("#obj1programID").textbox('setValue',row.programID);
            	 $("#obj1measureBase").combobox('setValue',row.measureBase);
            	 $("#obj1capped").combobox('setValue',row.capped);
            	 $("#obj1driver").combobox('setValue',row.driver);
            	 
            	 $("#obj1attainThreshold").textbox('setValue',row.attainThreshold);
            	 $("#obj1attainUnderPerform").textbox('setValue',row.attainUnderPerform);
            	 $("#obj1attainBase").textbox('setValue',row.attainBase);
            	 $("#obj1attainOverPerform").textbox('setValue',row.attainOverPerform);
            	 $("#obj1attainCap").textbox('setValue',row.attainCap);
            	 $("#obj1rebateThreshold").textbox('setValue',row.rebateThreshold);
            	 $("#obj1rebateUnderPerform").textbox('setValue',row.rebateUnderPerform);
            	 $("#obj1rebateBase").textbox('setValue',row.rebateBase);
            	 $("#obj1rebateOverPerform").textbox('setValue',row.rebateOverPerform);
            	 $("#obj1rebateCap").textbox('setValue',row.rebateCap);
            	 
            	 $("#obj1attainUnderPerformCP").textbox('setValue',row.attainUnderPerformCP);
            	 $("#obj1attainBaseCP").textbox('setValue',row.attainBaseCP);
            	 $("#obj1attainOverPerformCP").textbox('setValue',row.attainOverPerformCP);
            	 
            	 enableOrDisableWidgets('#obj1EditArea','disable');
            	 
            	 $('#obj1QuotaInfoDG').datagrid('reload','quotaInfo!getQuotaList.action?programID='+row.programID+'&itemNo='+row.itemNo+'&objType=1');
            	 
            	 $('#obj1win').window('open');
          	     $("#obj1EditBtn").show(); 
        	     $("#obj1SaveBtn").show();
            	 $("#obj1AddBtn").hide(); 
             }
         });    
          
    });


$(function(){    
    $('#objective2').datagrid({      
             nowrap: false,
             striped: true,
             pagination: true,
             border: true,      
             toolbar:'#obj2toolbar' , 
             fitColumns:true,
             url:'',      
             remoteSort:false,    
             resizable:true,
             idField:'id',
             align:'left',
             singleSelect:true,
             onDblClickRow:function(rowIndex,rowData){
            	 
            	 loadDataForCombo('obj2');
                 var row= $('#objective2').datagrid('getSelected');
                 $("#obj2itemNo").textbox('setValue',row.itemNo);
             	 $("#obj2programID").textbox('setValue',row.programID);
                 $("#obj2multipled").combobox('setValue',(row.multipled==null)?"":row.multipled);
                 $("#obj2multiplier").textbox('setValue',(row.multiplier==null)?"":row.multiplier);
                 $("#obj2ph1").combobox('setValues',row.ph1.toString().replace(/\s/g, "").split(","));
                 $("#obj2ph2").combobox('setValues',row.ph2.toString().replace(/\s/g, "").split(","));
                 $("#obj2ph3").combobox('setValues',row.ph3.toString().replace(/\s/g, "").split(","));
                 $("#obj2ph4").combobox('setValues',row.ph4.toString().replace(/\s/g, "").split(","));
                 $("#obj2ph5").combobox('setValues',row.ph5.toString().replace(/\s/g, "").split(","));
                 $("#obj2ph6").combobox('setValues',row.ph6.toString().replace(/\s/g, "").split(","));
                 $("#obj2productflag").combobox('setValue',row.productFlag.toString().replace(/\s/g, "").split(","));
                 $("#obj2mtm").combobox('setValues',row.mtm.toString().replace(/\s/g, "").split(","));
                 $("#obj2shikiricode").textbox('setValue',row.shikiriCode.toString());
              	 $("#obj2measureBase").combobox('setValue',row.measureBase);
              	 $("#obj2capped").combobox('setValue',row.capped);
              	 $("#obj2driver").combobox('setValue',row.driver);
              	 
              	 $("#obj2attainThreshold").textbox('setValue',row.attainThreshold);
              	 $("#obj2attainUnderPerform").textbox('setValue',row.attainUnderPerform);
              	 $("#obj2attainBase").textbox('setValue',row.attainBase);
              	 $("#obj2attainOverPerform").textbox('setValue',row.attainOverPerform);
              	 $("#obj2attainCap").textbox('setValue',row.attainCap);
              //	 $("#obj2rebateThreshold").textbox('setValue',row.rebateThreshold);
              	 $("#obj2rebateUnderPerform").textbox('setValue',row.rebateUnderPerform);
              	 $("#obj2rebateBase").textbox('setValue',row.rebateBase);
              	 $("#obj2rebateOverPerform").textbox('setValue',row.rebateOverPerform);
              	 $("#obj2rebateCap").textbox('setValue',row.rebateCap);
              	 
          	     $("#obj2attainUnderPerformCP").textbox('setValue',row.attainUnderPerformCP);
          	     $("#obj2attainBaseCP").textbox('setValue',row.attainBaseCP);
          	     $("#obj2attainOverPerformCP").textbox('setValue',row.attainOverPerformCP);
              	 
              	 enableOrDisableWidgets('#obj2EditArea','disable');
              	 $("#obj2mtmbutton").linkbutton("disable");
              	 
              	 $('#obj2ph1').combobox('reload','combo!getObj2ph.action?phtype=ph1');
              	 $('#obj2QuotaInfoDG').datagrid('reload','quotaInfo!getQuotaList.action?programID='+row.programID+'&itemNo='+row.itemNo+'&objType=2');
              	 
              	 $('#obj2win').window('open');
              	 $("#obj2EditBtn").show(); 
        	     $("#obj2SaveBtn").show();
            	 $("#obj2AddBtn").hide(); 
             }
         });    
          
    });
	
$(function(){    
    $('#objective3').datagrid({      
             title:'',      
             nowrap: false,
             striped: true,
             pagination: true,
             border: true,      
             toolbar:'#obj3toolbar' , 
             fitColumns:true,
             url:'',      
             remoteSort:false,    
             resizable:true,
             idField:'id',
             align:'left',
             singleSelect:true,
             onDblClickRow:function(rowIndex,rowData){
            	 loadDataForCombo('obj3');
            	 var row= $('#objective3').datagrid('getSelected');
            	 $("#obj3itemNo").textbox('setValue',row.itemNo);
            	 $("#obj3programID").textbox('setValue',row.programID);
            	 $("#obj3purpose").combobox('setValue',row.purpose);
            	 $("#obj3measureBase").combobox('setValue',row.measureBase);
            	 $("#obj3driver").combobox('setValue',row.driver);
            	 $("#obj3fixedRebate").textbox('setValue',row.fixedRebate);
            	 $("#obj3fixedAmount").textbox('setValue',row.fixedAmount);
            	 
            	 enableOrDisableWidgets('#obj3EditArea','disable');
            	 
            	 $('#linearityInfos').datagrid('reload','linearityInfo!getLinearityList.action?programID='+row.programID+'&itemNo='+row.itemNo);
            	 $('#linearityInfos').datagrid({url:''});
            	 
            	 $('#obj3win').window('open');
            	 $("#obj3EditBtn").show(); 
        	     $("#obj3SaveBtn").show();
            	 $("#obj3AddBtn").hide(); 
             }
         });    
          
    });


$(function(){
	$('#obj1QuotaInfoDG').datagrid({
           height: 330, 
           border: true,
           fit:true,
           toolbar:'#obj1QuotaInfoTB',
           url:'',
           singleSelect:false
	});
	
	$('#obj2QuotaInfoDG').datagrid({
        height: 330, 
        border: true, 
        toolbar:'#obj2QuotaInfoTB',
        url:'',
        fit:true,
        singleSelect:false,
        rownumbers:true
	});
	
})


		
