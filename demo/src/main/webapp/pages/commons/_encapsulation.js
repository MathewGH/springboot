/**
 * 
 */

 function sendAjaxRequest(namespace,actionName,formId,dataGridId){
	   var url=namespace+actionName;
	   $.ajax({
		    url:url
		   ,type:'POST'
		   ,data:$(formId).serialize()
		   ,success:function(data){
			   if(data.success){
				if((dataGridId!=null)&&(dataGridId!='')){
			       $(dataGridId).datagrid('reload');
				}
			    $.messager.show({
				   title: 'Notification',
                   msg:'succeed',
                   style:{
                	    align:'center'
                	    }
			   });
			   }
		   }
		   ,error: function(XMLHttpRequest, textStatus, errorThrown) {
               alert(errorThrown);
           }
		});
   }
 
 
 function removeObj(objectiveNo,url,type){

	 var param;
	 var hint;
	
	
	 
	 var row = $(objectiveNo).datagrid('getSelected');
	  if(type=='program'){
		  param={programID:row.programID}
		  hint='You have successfully removed one record!program code:'+row.programID;
	  } else{
		  param={programID:row.programID,itemNo:row.itemNo}
		  hint='You have successfully removed one record!program code:'+row.programID+',item no. :'+row.itemNo;
	  }
	 
     if (row){
         $.messager.confirm('Confirm','Are you sure you want to remove this record?',function(r){
             if (r){
                 $.post(url,param,function(result){
                     if (result.success){
                    	 $(objectiveNo).datagrid('reload');    // reload the  data
                    	 $.messager.show({
          				   title: 'Notification',
                             msg:hint,
                             style:{
                          	    align:'center'
                          	    }
          			   });
                     } else {
                         $.messager.show({    // show error message
                             title: 'Error',
                             msg:result+ result.errorMsg
                         });
                     }
                 },'json');
             }
         });
     }
 }
 
 
 var DataDeal = {  
		//将从form中通过$('#form').serialize()获取的值转成json  
		           formToJson: function (data) {  
		               data=data.replace(/&/g,"\",\"");  
		               data=data.replace(/=/g,"\":\"");  
		               data="[{\""+data+"\"}]";  
		               return data;  
		            },  
		};  
 
 
 function removeBlankSpace(str){
	 return str.replace(/\s+/g, "");
 }