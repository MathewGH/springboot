/**
 * this file includes all the divs that needs to be initialized in editprogram.jsp
 */



  $(function(){
	  $('#obj1Panel').panel({
		  iconCls:'icon-ok',
		  collapsible:true,
		  collapsed:true,
		  onExpand:function(){
		   var programID=$("#programID").textbox('getValue');
		    $('#objective1').datagrid('reload','objectiveOne!getObjective1List.action?programID='+programID);
			  
		  }
	  })
  })
  
	
		
	 $(function(){
	  $('#obj2Panel').panel({
		  iconCls:'icon-ok',
		  collapsible:true,
		  collapsed:true,
		  onExpand:function(){
		   var programID=$("#programID").textbox('getValue');
		    $('#objective2').datagrid('reload','objectiveTwo!getObjective2List.action?programID='+programID);
			  
		  }
	  })
  })	
	
	
 	 
 	 $(function(){
 		  $('#obj3Panel').panel({
 			  iconCls:'icon-ok',
 			  collapsible:true,
 			  collapsed:true,
 			  onExpand:function(){
 			   var programID=$("#programID").textbox('getValue');
 			    $('#objective3').datagrid('reload','objectiveThree!getObjective3List.action?programID='+programID);
 				  
 			  }
 		  })
 	  })
 	  