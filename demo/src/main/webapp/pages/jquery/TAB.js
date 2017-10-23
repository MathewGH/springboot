
$(document).ready(function(){
$("#layout-t span:first").addClass("current");
$("#layout-t .tab-bd-con:gt(0)").hide();
$("#layout-t span").click(function () {//mouseover 改为 click 将变成点击后才显示，mouseover是滑过就显示
$(this).addClass("current").siblings("span").removeClass("current");
$("#layout-t .tab-bd-con:eq(" + $(this).index() + ")").show().siblings(".tab-bd-con").hide().addClass("current");

});

$(".list-tweet >li").mouseover(function(){
	$(this).removeClass("drink-me");
	$(this).addClass("eat-me");
	$(".list-tweet >li:first").removeClass("eat-me");
	$(".list-tweet >li:first").addClass("drink-me");
});
$(".list-tweet >li").mouseout(function(){
	$(this).removeClass("eat-me");
	$(this).addClass("drink-me");
	$(".list-tweet >li:first").addClass("eat-me");
	$(".list-tweet >li:first").removeClass("drink-me");
});
$(".list-tweet >li").mouseover(function(){
	$(this).removeClass("drink-me");
	$(this).addClass("eat-me");
});
});

