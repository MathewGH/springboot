/**
 * this file includes all the windows that needs to be initialized in editprogram.jsp
 */


$(function () {
    $('#obj1UploadWin').window({
             closed:true,
             height:200,
             collapsible:true,
             onOpen:function(){
              $('#obj1UploadWin').window('move',{
                  left:(document.body.clientWidth)/2-$('#obj1UploadWin').width()/2,
                  top:(document.body.clientHeight-$('#obj1UploadWin').height())/2+document.body.scrollTop
              })
             }
    });
    
    $('#obj2UploadWin').window({
        closed:true,
        height:200,
        collapsible:true,
        onOpen:function(){
         $('#obj2UploadWin').window('move',{
             left:(document.body.clientWidth)/2-$('#obj1UploadWin').width()/2,
             top:(document.body.clientHeight-$('#obj1UploadWin').height())/2+document.body.scrollTop
         })
        }
});
});

	$(function () {
        $('#obj3win').window({
                 closed:true,
                 height:500,
                 collapsible:true,
                 iconCls:'icon-save',
                 onOpen:function(){
                  $('#obj3win').window('move',{
                      left:(document.body.clientWidth)/2-$('#obj3win').width()/2,
                      top:(document.body.clientHeight-$('#obj3win').height())/2+document.body.scrollTop
                  })
                 },
            onBeforeClose: function () {
             $("Input[id^='obj3']").textbox('clear');
             $('#obj3EditArea').find("input").each(function(){
       		    $(this).attr("editable",false);
       	   });;
            }

        });
    });
	
	$(function () {
        $('#obj2win').window({
                closed:true,
                modal:true,
                collapsible:true,
                iconCls:'icon-save',
                onOpen:function(){
                 $('#obj2win').window('move',{
                     left:(document.body.clientWidth)/2-$('#obj2win').width()/2,
                     top:(document.body.clientHeight-$('#obj2win').height())/2+document.body.scrollTop
                 })
                },
            onBeforeClose: function () {
            	unbindBlurForObj2();
             $("Input[id^='obj2']").textbox('clear');
             $('#obj2EditArea').find("input").each(function(){
       		    $(this).attr("editable",false);
       	   });;
            }

        });
    });
	
	$(function () {
        $('#obj1win').window({
                closed:true,
                height:500,
                modal:true,
                collapsible:true,
                iconCls:'icon-save',
                onOpen:function(){
                 $('#obj1win').window('move',{
                     left:(document.body.clientWidth)/2-$('#obj1win').width()/2,
                     top:(document.body.clientHeight-$('#obj1win').height())/2+document.body.scrollTop
                 })
                },
            onBeforeClose: function () {
            	unbindBlurForObj1();
             $("Input[id^='obj1']").textbox('clear');
             $('#obj1EditArea').find("input").each(function(){
       		    $(this).attr("editable",false);
       	   });;
            }

        });
    });

