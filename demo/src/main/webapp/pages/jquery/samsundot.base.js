var __isInitValidate = false;
$(document).ready(function () {

    //将客户端浏览器的时区，写入Cookie
    __setCookie('TimeZone', new Date().getTimezoneOffset() / 60 * -1);

    //表单提交时 默认显示遮罩
    if (this.forms.length > 0) { if (window["__defaultBlock"] == undefined || window["__defaultBlock"]) { this.forms[0].onsubmit = function () { __block(); }; } }

    //Ajax交互时 默认不显示遮罩
    $(document).ajaxSend(function (e, s, d) { if ((d.url + d.data).toLowerCase().indexOf("block=true") > 0) { __block(); } }).ajaxStop(function () { __unblock(); });

    //Asp.Net 局部刷新完成之后 执行的函数：GTN项目禁止使用 微软Ajax
    if (window["Sys"] && Sys.WebForms != undefined) { Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () { alert("微软Ajax 会破坏页面 Dom结构，GTN项目禁止使用 微软Ajax！"); }); }

    //初始话页面验证对象:表单在 任何时候的 submit 都会触发验证
    InitValidate();

    //文本框的class='Datapicker' 则将它设置成日历控件
    InitAllDatepicker();

    //初始化前端权限设置
    //InitFunctionAuth();

    //初始化界面Css样式
    InitCssStyle();

    //处理键盘事件 
    document.onkeydown = __keyDown;
    //主窗体 添加 删除 节点
    window.append = function (element) { return $(element).appendTo(window.document.body); };
    window.remove = function (element) { return $(element).remove(); };
    window.refresh = function (element) { __refreshPage(); };


});





//浏览器型号 版本
function __ie() { return $.browser.msie; }
function __ie6() { return $.browser.msie && $.browser.version == '6.0'; }
function __ie7() { return $.browser.msie && $.browser.version == '7.0'; }
function __ie8() { return $.browser.msie && $.browser.version == '8.0'; }
function __ie9() { return $.browser.msie && $.browser.version == '9.0'; }
function __ie10() { return $.browser.msie && $.browser.version == '10.0'; }
function __firefox() { return $.browser.mozilla; }
function __chrome() { return $.browser.chrome; }




//当前语言状态
function __isEnglish() { return __getSetting("IsEnglish", true) ? true : false; }

//获取一个唯一编码
function __soleId(prefix) { return prefix + "_" + Math.random().toString().replace(".", ""); }

//当前页面的 Form 对象
function __currentDomForm() { if (document.getElementById("form1")) { return document.getElementById("form1"); } else if (document.getElementsByTagName("form")) { return document.getElementsByTagName("form"); } else if (document.forms && document.forms.length > 0) { return document.forms[0]; } return null; }
function __currentJQForm() { return $(__currentDomForm()); }


//从 __PageSetting 页面参数中 取属性值
function __getSetting(key, defaultValue) { try { if (window["__PageSetting"] && __PageSetting["key"]) { return __PageSetting["key"]; } } catch (exp) { } return defaultValue; }

//获取 Select 控件 的 选中项 文本
function __getSelectText($selectCtrl) { if (!$selectCtrl || $selectCtrl.length <= 0) return ""; var domSelectCtrl = $selectCtrl.length >= 1 ? $selectCtrl[0] : null; if (domSelectCtrl) { var selectIndex = domSelectCtrl.selectedIndex; var selectText = domSelectCtrl.options[selectIndex].text; return selectText; } return ""; }
////设置 Select 控件 的 值 或者 文本
//function __setSelectValue($selectCtrl, value) { if (!$selectCtrl || $selectCtrl.length <= 0) return; value = value || ""; var domSelectCtrl = $selectCtrl.length >= 1 ? $selectCtrl[0] : null; if (domSelectCtrl) { $selectCtrl.val(value); if ($selectCtrl.val() != value) { /*没有找到有效的 Value项*/ for (var index = 0; index < domSelectCtrl.options.length; index++) { if ($.trim((domSelectCtrl.options[index].text || "").toUpperCase()) == $.trim(value.toUpperCase())) { domSelectCtrl.selectedIndex = index; break; } } } } }

//将一个日期 从 String格式( "/Date(1369211788390)/"  "2013-06-05" "2013/06/05") 转换成 Date格式 或者 返回 format 格式的时间字符串
function __parseDate(dateStr, format) { if (!dateStr) { return ""; } var date; if (dateStr instanceof Date) { date = dateStr; } else { var format1 = new RegExp("\\/Date\\([^\\)]+\\)\\/", "g"); /*"/Date(1369211788390)/"*/var format2 = new RegExp("\\d{2,4}\\-\\d{1,2}\\-\\d{1,2}", "g"); /*"2013-06-05"*/if (format1.test(dateStr)) { date = eval('new ' + (dateStr.replace(/\//g, ''))); } else if (format2.test(dateStr)) { date = new Date(Date.parse(dateStr.replace(/\-/g, "\/"))); } else { try { date = new Date(Date.parse(dateStr)); } catch (exp) { date = ""; } } } return (date && format) ? date.format(format) : date; }
//在一个 时间或者时间字符串 基础上 增加 指定天数, 返回 format 格式的字符串 或者 Date对象
function __addDays(dateStr, days, format) { days = days | 0; var date = dateStr instanceof Date ? dateStr : __parseDate(dateStr); if (date && days) { date.setDate(date.getDate() + parseInt(days + "x")); } return (date && format) ? date.format(format) : date; }
//在一个 时间或者时间字符串 基础上 增加 指定月份, 返回 format 格式的字符串 或者 Date对象
function __addMonths(dateStr, months, format) { months = months | 0; var date = dateStr instanceof Date ? dateStr : __parseDate(dateStr); if (date && months) { date.setMonth(date.getMonth() + parseInt(months + "x")); } return (date && format) ? date.format(format) : date; }
//在一个 时间或者时间字符串 基础上 增加 指定年份, 返回 format 格式的字符串 或者 Date对象
function __addYears(dateStr, years, format) { years = years | 0; var date = dateStr instanceof Date ? dateStr : __parseDate(dateStr); if (date && years) { date.setYear(date.getFullYear() + parseInt(years + "x")); } return (date && format) ? date.format(format) : date; }


//设置指定的 文本框 为 日历控件
function SetDatepicker(textboxId, __configCustomer) { if (!textboxId) return; var isEnglish = __isEnglish() ? true : false; var dayNameArr = isEnglish ? ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'] : ['日', '一', '二', '三', '四', '五', '六']; var currentDayText = isEnglish ? 'Today' : '今天'; var closeWindowText = isEnglish ? 'Close' : '关闭'; var clearWindowText = isEnglish ? 'Clear' : '清除'; var __config = { changeMonth: true, changeYear: true, dateFormat: "yy-mm-dd", currentText: currentDayText, closeText: closeWindowText, clearText: clearWindowText, showButtonPanel: true, showClearInButtonPanel: true, monthNamesShort: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"], dayNamesMin: dayNameArr }; if (__configCustomer) { for (var __name in __configCustomer) { __config[__name] = __configCustomer[__name]; } } var $textBox = typeof textboxId == "string" ? $('#' + textboxId) : textboxId; $textBox.datepicker(__config); $textBox.attr("readonly", "true"); /*设置文本框只读*/ }

//设置指定的 文本框 为 日历时间控件
function SetDatetimepicker(textboxId, __configCustomer) { if (!textboxId) return; var isEnglish = __isEnglish() ? true : false; var dayNameArr = isEnglish ? ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'] : ['日', '一', '二', '三', '四', '五', '六']; var currentDayText = isEnglish ? 'Today' : '今天'; var closeWindowText = isEnglish ? 'Close' : '关闭'; var clearWindowText = isEnglish ? 'Clear' : '清除'; var __timeText = isEnglish ? 'Time' : '时间'; var __hourText = isEnglish ? 'Hour' : '时'; var __minuteText = isEnglish ? 'Minute' : '分'; var __config = { changeMonth: true, changeYear: true, dateFormat: "yy-mm-dd", timeFormat: "HH:mm", currentText: currentDayText, closeText: closeWindowText, clearText: clearWindowText, timeText: __timeText, hourText: __hourText, minuteText: __minuteText, showButtonPanel: true, showClearInButtonPanel: true, monthNamesShort: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"], dayNamesMin: dayNameArr }; if (__configCustomer) { for (var __name in __configCustomer) { __config[__name] = __configCustomer[__name]; } } var $textBox = typeof textboxId == "string" ? $('#' + textboxId) : textboxId; $textBox.datetimepicker(__config); $textBox.attr("readonly", "true"); /*设置文本框只读*/ }

//初始化所有 日历时间 控件样式
function InitAllDatepicker() { $('input[type="text"].Datapicker').each(function (index, elem) { try { SetDatepicker(elem.id); } catch (exp) { } }); $('input[type="text"].Datatimepicker').each(function (index, elem) { try { SetDatetimepicker(elem.id); } catch (exp) { } }); }

//初始化验证
function InitValidate() { if ($.validator && !__isInitValidate) { /*添加上【非空校验的红星】$(".editorForm .required").each(function (i, e) { if ($(e).hasClass("NoRedStar") == false) $("<em" + (e.tagName == "SELECT" ? " style='margin-left:3px;'" : "") + ">*</em>").appendTo($(e).parent()); }); __createRedStar();*/$.validator.addMethod("minlengthcn", function (value, element, param) { value = $.trim(value); return value.replace(/[^\x00-\xff]/g, 'xx').length >= param || this.optional(element); }, $.validator.format(__isEnglish() ? "Please enter at least {0} ncharacters." : "请输入一个长度最少是 {0} 的字符串(一个汉字是双字节长度)")); $.validator.addMethod("maxlengthcn", function (value, element, param) { value = $.trim(value); return value.replace(/[^\x00-\xff]/g, 'xx').length <= param || this.optional(element); }, $.validator.format(__isEnglish() ? "Please enter no more than {0} ncharacters." : "请输入一个长度最多是 {0} 的字符串(一个汉字是双字节长度)")); var pageForm = __currentJQForm(); if (pageForm && pageForm.length > 0) { pageForm.validate({ invalidHandler: function (form, validator) { for (var c in validator.errorList) { var el = validator.errorList[c]; $(el.element).addClass("inputError").attr("title", el.message).tooltip({ position: { my: "center bottom-10", at: "center top", using: function (position, feedback) { $(this).css(position); $("<div>").addClass("ui-tooltip-arrow").addClass(feedback.vertical).addClass(feedback.horizontal).appendTo(this); } } }); } if (validator.errorList.length != 0) { if (__isEnglish()) { alert('You have missed ' + validator.errorList.length + ' fields. Please refer to the highlighted fields'); } else { alert('有' + validator.errorList.length + '个字段不符合校验规则，请参见高亮显示的字段'); } } }, success: function (lable) { /*具有及时性*/var soruceId = lable.attr("for"); $("#" + soruceId).removeClass("inputError").removeAttr("title"); lable.remove(); }, errorPlacement: function (error, element) { } /*阻止默认显示错误方式*/ }); } if (!__isEnglish()) { jQuery.extend(jQuery.validator.messages, { required: "必须输入内容", remote: "请修正该字段", email: "请输入正确格式的电子邮件", url: "请输入正确格式的网址", date: "请输入合法的日期", dateISO: "请输入合法的日期 (ISO).", number: "请输入合法的数字", digits: "只能输入整数", creditcard: "请输入合法的信用卡号", equalTo: "请再次输入相同的值", accept: "请输入拥有合法后缀名的字符串", maxlength: jQuery.validator.format("请输入一个长度最多是 {0} 的字符串"), minlength: jQuery.validator.format("请输入一个长度最少是 {0} 的字符串"), rangelength: jQuery.validator.format("请输入一个长度介于 {0} 和 {1} 之间的字符串"), range: jQuery.validator.format("请输入一个介于 {0} 和 {1} 之间的值"), max: jQuery.validator.format("请输入一个最大为 {0} 的值"), min: jQuery.validator.format("请输入一个最小为 {0} 的值") }); } __isInitValidate = true; } };

//初始化 前端验证，将没有权限的 按钮隐藏掉
//GTN项目没有此特性function InitFunctionAuth() { if (window["__FunctionAuth"] && __FunctionAuth != undefined && __FunctionAuth.length > 0) { $("a").each(function (index) { var $a = $(this); var c = $a.attr('CommandName'); if (!c) return; if ($.inArray(c, __FunctionAuth) < 0) { $a.hide(); /* .attr('disabled', 'disabled').die('click');*/ /*if ($a.attr('role') == 'button') $a.button("disable");*/ } }); } }

//初始化 界面CSS样式
function InitCssStyle() {
    //设置【按钮行】的宽度展位span，用于兼容ie浏览器（因为ie6、ie7下会根据td中的文本重新划分列宽）
    $("table.editorForm tr.trButtons td:empty").each(function (idx, el) { $(el).append("<span class='whitespan'>########</span>"); });
    $("table.grid>tbody>tr:even").addClass('a');
    $("table.grid>tbody>tr:odd").addClass('b');
    $("table.grid>tbody>tr a").hover(function (e) { $(this).addClass('c').parents('.scrollXdiv').height(0).height('auto'); }, function (e) { $(this).removeClass('c').parents('.scrollXdiv').height(0).height('auto'); });
    //防止有滚动条的情况页面闪动问题
    //$("table.grid>tbody>tr").bind('keydown keyup keypress mouseout mouseup mousemove mouseover mousedown mouseenter mouseleave', function () { $(this).parents('.scrollXdiv').height($('.scrollXdiv').height()); });
    $("table.grid>tbody>tr>td.e").tooltip().each(function (idx, el) { $(el).attr('title', $(el).text()); });
    $(".wrapper .icon").click(function () { $(this).toggleClass('icon-on icon-off').parents('.wrapper').children('.w_center').toggle(); });
}

//键盘输入检测及转译：回车和Backspace
function __keyDown() {
    var keycode = event.keyCode; /*var keyChar = String.fromCharCode(keycode);*/ /*textarea 的键盘事件，超过指定长度则拦截*/
    if (event.srcElement.type == 'textarea') { var $element = $(event.srcElement); var maxLength = $element.attr("maxlength") > $element.attr("lengthmax") ? $element.attr("maxlength") : $element.attr("lengthmax"); maxLength = maxLength > 0 ? maxLength : 2000; if ($element.val().length > maxLength) { $element.val($element.val().substring(0, maxLength)); return false; } }
    if (keycode == 8) { if (event.srcElement.type == 'textarea') { if (event.srcElement.readOnly || event.srcElement.disabled == true) event.keyCode = 0; } else if (event.srcElement.type == 'text') { if (event.srcElement.readOnly || event.srcElement.disabled == true) event.keyCode = 0; } else { event.keyCode = 0; } }
    if (keycode == 13) { if (event.srcElement.type == 'textarea') { if (event.srcElement.readOnly || event.srcElement.disabled == true) event.keyCode = 0; } else if (event.srcElement.type == 'text') { event.keyCode = 9; } else { event.keyCode = 9; } }
    return true;
}




//对CheckBoxList做非空校验
function __validCheckBoxList(obj) { var allChecked = true; obj.each(function (index, el) { var $chkList = $(el); if ($chkList.hasClass("required")) { if ($chkList.find("input:checked").length == 0) { $chkList.addClass("inputError"); allChecked = false; } else { $chkList.removeClass("inputError"); } } }); return allChecked; }

//下载文件，参数是文件的 URL地址
function __downLoad(fileUrl, fileName) { $("<form style='display:none' method='post' action='download?p=" + fileUrl + "&n=" + fileName + " ' ></form>").appendTo($('body')).submit().remove(); }

//刷新当前页面
function __refreshPage(refreshCtrlId) { try { if (!refreshCtrlId) { refreshCtrlId = "ctl00$ContentPlaceHolder1$pager"; } if (this['__doPostBack'] != undefined) __doPostBack(refreshCtrlId); } catch (exp) { alert("Page Refresh Failed!"); window.location.href = window.location.href; } }

//表单校验
function __checkInput() { var pageForm = __currentJQForm(); return pageForm && pageForm.length > 0 && !__firefox() ? /*火狐浏览器 的 验证会抛出异常*/pageForm.valid() : true; }

//读取Cookie
function __getCookie(Name) { var search = Name + "="; if (document.cookie.length > 0) { var offset = document.cookie.indexOf(search); if (offset != -1) { offset += search.length; var end = document.cookie.indexOf(";", offset); if (end == -1) end = document.cookie.length; return unescape(document.cookie.substring(offset, end)); } else return ""; } return ""; }
//设置Cookie
function __setCookie(name, value) { var argv = __setCookie.arguments; var argc = __setCookie.arguments.length; var expires = (argc > 2) ? argv[2] : null; var LargeExpDate = new Date(); if (expires != null) { LargeExpDate.setTime(LargeExpDate.getTime() + (expires * 1000 * 3600 * 24)); } document.cookie = name + "=" + escape(value) + ((expires == null) ? "" : ("; expires=" + LargeExpDate.toGMTString())) + "; path=" + "/"; }

//document 弹出遮罩
function __block(msg) { if ($.blockUI != undefined) { $.blockUI({ message: ('<h1 style="padding: 15px 0px 15px 0px;"><img src="/FrameworkFiles/images/loading.gif" />' + (msg || ((window["__PageSetting"] && __PageSetting.IsEnglish) ? "Loading..." : "数据加载中...")) + '</h1>'), fadeIn: false }); } }
//document 关闭遮罩
function __unblock() { if ($.unblockUI != undefined) { $.unblockUI({ fadeOut: false }); } }
//具体元素 弹出遮罩
function __elemBlock(elem, msg) { if (elem == undefined) __block(msg); else if (elem.block != undefined) { elem.block({ message: ('<h1 style="padding: 15px 0px 15px 0px;"><img src="/FrameworkFiles/images/loading.gif" />' + (msg || (__isEnglish() ? "Loading..." : "数据加载中...")) + '</h1>'), fadeIn: false }); } }
//具体元素 关闭遮罩
function __elemUnblock(elem) { if (elem == undefined) __unblock(); else if (elem.block != undefined) elem.unblock({ fadeOut: false }); }




//静态下拉列表级联 - 初始化
function cascade_init(controls, hiddenField, data, defaultValue) {
    if (!defaultValue) {
        defaultValue = __isEnglish() ? "Please Select" : "请选择";
    }
    var cfg = { ctrl: $(controls[0]), hidden: hiddenField.length < 1 ? undefined : $(hiddenField[0]), next: { ctrl: $(controls[1]), hidden: hiddenField.length < 2 ? undefined : $(hiddenField[1]), next: controls.length < 3 ? undefined : { ctrl: $(controls[2]), hidden: hiddenField.length < 3 ? undefined : $(hiddenField[2]), next: controls.length < 4 ? undefined : { ctrl: $(controls[3]), hidden: hiddenField.length < 4 ? undefined : $(hiddenField[3])}}} };
    /*初始化*/
    var cascade_prepare = function (cfg, data, defaultValue) {
        cfg.defaultValue = defaultValue;
        cfg.lv = cfg.parent == undefined ? 1 : cfg.parent.lv + 1;
        if (cfg.kField == undefined) cfg.kField = "K" + cfg.lv;
        if (cfg.vField == undefined) cfg.vField = "V" + cfg.lv; /*填充数据*/
        cascade_filldata(cfg, data); /*递归初始化所有控件*/
        if (cfg.next) {
            cfg.next.parent = cfg;
            cascade_prepare(cfg.next, data, defaultValue);
        } /*注册触发事件*/
        cfg.ctrl.change(function () {
            if (cfg.hidden) {
                var oldValue = cfg.hidden.val();
                cfg.hidden.attr("old", oldValue);
                cfg.hidden.val(cfg.ctrl.val());
                if (oldValue != cfg.hidden.val()) {
                    setTimeout(function () { cfg.hidden.trigger("change", oldValue); }, 1);
                }
            }
            if (cfg.next) { cascade_filldata(cfg.next, data); }
        });
    };
    /*填充数据*/
    var cascade_filldata = function (cfg, data) {
        cfg.ctrl.html("");
        if (cfg.defaultValue) {
            cfg.ctrl.append($("<option></option>").val('').html(cfg.defaultValue));
        }
        var arr = new Array();
        for (var i in data) {
            var item = data[i];
            var v = item[cfg.kField], t = item[cfg.vField];
            if (v && $.inArray(v, arr) == -1 && cascade_match(cfg, item)) {
                cfg.ctrl.append($("<option></option>").val(v).html(t));
                arr.push(v);
            }
        }
        if (cfg.hidden) {
            try { if ((cfg.defaultValue && cfg.ctrl.find("option").length <= 1) || (!cfg.defaultValue && cfg.ctrl.find("option").length <= 0)) cfg.hidden.val(''); } catch (expValue) { }
            /* 初始化 隐藏域 给 下拉列表赋值 */
            if (__ie6()) { setTimeout(function () { try { cfg.ctrl.val(cfg.hidden.val()); if (cfg.ctrl.val()) { cfg.hidden.val(cfg.ctrl.val()); /*冗余代码, 不要删除*/ } cfg.ctrl.trigger('change'); cfg.hidden.trigger("change"); } catch (exp) { } }, 1); }
            else { cfg.ctrl.val(cfg.hidden.val()); if (cfg.ctrl.val()) { cfg.hidden.val(cfg.ctrl.val()); /*冗余代码,不要删除*/cfg.ctrl.trigger('change'); cfg.hidden.trigger("change"); } }
        }
    };
    /*判断是否满足联动的 数据关系条件*/
    var cascade_match = function (cfg, item) {
        if (cfg.parent == undefined) return true;
        if (item[cfg.parent.kField] != cfg.parent.ctrl.val()) return false;
        return cascade_match(cfg.parent, item);
    };
    cascade_prepare(cfg, data, defaultValue);
}


//动态下拉列表级联；（警告：各下拉列表之间 请不要出现 循环依赖）
function RefreshLinkage(ddlCtrl) {
    var curId = !ddlCtrl ? "" : ddlCtrl.id;
    if (curId && ddlCtrl) {
        var hfValueCtrlId = $(ddlCtrl).attr("valueCtrlId");
        if (!hfValueCtrlId) hfValueCtrlId = "hf_" + curId;
        var $hfValueCtrl = $("#" + hfValueCtrlId);
        if ($hfValueCtrl.val() != $(ddlCtrl).val()) {
            var oldValue = $hfValueCtrl.val();
            $hfValueCtrl.attr("old", oldValue);
            $hfValueCtrl.val($(ddlCtrl).val());
            if (oldValue != $hfValueCtrl.val()) { setTimeout(function () { $hfValueCtrl.trigger("change", oldValue); }, 1); }
        }
    }
    $("select").each(function (index, elem) { if (!curId || elem.id != curId) { /*全部刷新 或者 不联动自己*/var parentId = $(elem).attr("parentId"); if (parentId != undefined && ("" + parentId).replace(" ", "").length > 0) { var parentIds = parentId.split(','); /*分割父级Id*/if (!parentIds.indexOf) { Array.prototype.indexOf = function (e) { for (var i = 0; i < this.length; i++) { if (this[i] == e) { return i; } } return -1; }; } if (!curId || parentIds.indexOf(curId) >= 0) { /*如果某个控件被当前控件联动*/ /*操作 联动子控件*/refreshOptions(elem); } } } });
    /*刷新 指定的下拉列表*/

    function refreshOptions(elem) {
        if (!elem || !elem.id) return;
        var parentId = $(elem).attr("parentId");
        var parentKey = $(elem).attr("parentKey");
        if (!parentId || !parentKey) return;
        var parentIds = parentId.split(',');
        var parentKeys = parentKey.split(',');
        if (parentKeys.length != parentIds.length) throw new Error("Linkage Select \"" + elem.id + "\": 'ParentKey' And 'ParentId' Length Is Not Same!");
        var elemValueId = $(ddlCtrl).attr("valueCtrlId");
        if (!elemValueId) elemValueId = "hf_" + elem.id;
        var $valueCtrl = $("#" + elemValueId);
        /*清空下拉列表*/
        if ($(elem).find("option").length > 0) {
            if ($valueCtrl && $valueCtrl.length > 0) {
                var oldValue2 = $valueCtrl.val();
                $valueCtrl.attr("old", oldValue2);
                $valueCtrl.val('');
                if (oldValue2 != $valueCtrl.val()) { setTimeout(function () { $valueCtrl.trigger("change", oldValue2); }, 1); }
            }
        }
        $(elem).find("option").remove();
        /*创建默认行*/
        var withEmpty = $(elem).attr("withEmpty") != "false";
        var emptyValue = ($(elem).attr("emptyValue") || '');
        var emptyText = ($(elem).attr("emptyText") || (__isEnglish() ? "Please Select" : "请选择"));
        if (withEmpty) { $(elem).append("<option value='{V}'>{T}</option>".replace("{V}", emptyValue).replace("{T}", emptyText)); }
        /*需要的数据*/
        var parentIsEmpty = true;
        var jsonStr = "{ \"__Action\":\"RefreshSelect\", \"__SelectCtrl\":\"" + elem.id + "\", ";
        for (var j = 0; j < parentKeys.length; j++) { var parentValue = ($("#" + parentIds[j]).val() || ''); jsonStr = jsonStr + "\"" + parentKeys[j] + "\":\"" + parentValue + "\"" + (j == parentKeys.length - 1 ? "" : ", "); if (parentValue && parentValue != emptyValue) parentIsEmpty = false; } jsonStr = jsonStr + "}";
        /*如果所有父级都没有数据 则 不进行 Ajax*/
        if (parentIsEmpty) return;
        /*Ajax提交*/
        var jsonData = JSON.parse(jsonStr); var postUrl = ($(elem).attr("postUrl") || (window.location.href)); /*没有指定 Post地址，则 指向 自身页面*/
        postUrl = postUrl + (postUrl.indexOf("?") >= 0 ? ("&_rd=" + Math.random()) : ("?_rd=" + Math.random())); /*防止缓存*/
        $.post(postUrl, jsonData, function (data, status) {
            if (data != undefined && data.length > 0) {
                /*动态获取的行*/
                var optionTemp = ($(elem).attr("optionTemp") || "<option value='{V}'>{T}</option>");
                $.each(data, function (itemIndex, itemElem) {
                    var html = perfectExpres(optionTemp, itemElem);
                    $(elem).append(html);
                });
                /* 初始化 隐藏域 给 下拉列表赋值 */
                if ($valueCtrl && $valueCtrl.length > 0) {
                    try { if ((withEmpty && $(elem).find("option").length <= 1) || (!withEmpty && $(elem).find("option").length <= 0)) $valueCtrl.val(''); } catch (expValue) { }
                    /*__setSelectValue($(elem), $valueCtrl.val());*/
                    var valueTemp = $valueCtrl.val();
                    if (__ie6()) { setTimeout(function () { try { $(elem).val(valueTemp); if ($(elem).val()) { $valueCtrl.val($(elem).val()); /*冗余代码,不要删除*/RefreshLinkage(elem); $valueCtrl.trigger("change", oldValue); } } catch (exp) { } }, 1); }
                    else { $(elem).val(valueTemp); if ($(elem).val()) { $valueCtrl.val($(elem).val()); /*冗余代码,不要删除*/RefreshLinkage(elem); $valueCtrl.trigger("change", oldValue); } }
                }

            }
        }, "json");
    }

    /*循环 object 中的所有属性，替换 expres 中，对应的部分；*/
    function perfectExpres(expres, object) {
        for (var key in object) {
            expres = expres.replace("{" + key + "}", (object[key] || ''));
        }
        return expres;
    }
}


//关闭弹出层
function __closeWindow(data) { JQueryUIDialog({ op: "close", data: data }); }
//传递弹出层数据
function __changeWindow(data) { JQueryUIDialog({ op: "change", data: data }); }
////获取当前 Frame 页面的 上一级弹窗
//function __getPreWindow() {
//    if ($(window.document).find(".ui-dialog").length > 0) { return window; } else if (window.parent && $(window.parent.document).find(".ui-dialog").length > 0) { return $(window.parent.document).find(".ui-dialog"); } else { return $(__firstWindow().document).find(".ui-dialog"); }
//}

function __firstWindow() {
    var w = window;
    while (w.parent && w.parent != w && w.lv != -1 /*&& (w.parent.document.domain+"").toLowerCase() == (w.document.domain+"").toLowerCase()*/ /*判断域相同,FireFox Chrome 和最终发布下有BUG*/ && (w.parent.location.host + "").toLowerCase() == (w.location.host + "").toLowerCase() /*判断域相同,加上端口号*/) {
        w = w.parent;
    }
    return w;
}


//弹出交互 URL 或者 DIV 窗体
function JQueryUIDialog(popObj) {
    var isUrlWindow = (popObj.url) ? true : false; /*当前弹出的是一个 Url-Frame 否则就是一个 DIV*/
    var isTopWindow = popObj.topWindow == true;  /*当前弹出的是 顶级弹窗（全部遮罩） */
    if (isUrlWindow) { popObj.url = (popObj.url.indexOf("?") >= 0) ? popObj.url + "&_=" + Math.random() : popObj.url + "?_=" + Math.random(); }
    var firstWin = isTopWindow ? __firstWindow() : window;
    function getSoleClass() { return ".Dg_" + Math.random().toString().replace(".", ""); }
    function getWindowWidth(_w) { if (__firefox()) { return $(_w).width() - 7; } else if (__chrome()) { return $(_w).width() - 7; } else if (__ie6() || __ie7() || __ie8()) { return $(_w).width() - 5; } else if (__ie9() || __ie10()) { return $(_w).width() - 7; } return $(_w).width(); }
    function getWindowHeight(_w) { if (__firefox()) { return $(_w).height() - 5; } else if (__chrome()) { return $(_w).height() - 5; } else if (__ie6() || __ie7() || __ie8()) { return $(_w).height() - 5; } else if (__ie9() || __ie10()) { return $(_w).height() - 5; } return $(_w).height(); }
    function fillResultData(_data, $content) { if (_data) { var inputs = $content.find("input"); inputs.each(function (index, elem) { try { _data[elem.name] = $(elem).val(); } catch (exp) { } }); var selects = $content.find("select"); selects.each(function (index, elem) { try { _data[elem.name] = $(elem).val(); } catch (exp) { } }); var textareas = $content.find("textarea"); textareas.each(function (index, elem) { try { _data[elem.name] = $(elem).val(); } catch (exp) { } }); } }
    //function getBackBlock() { var $backBlock = $(firstWin.document); return $backBlock.find(".ui-widget-overlay"); }
    function closePopPage(_data, $removeDialogContent) { /*关闭弹出层*/
        var $removeDialog = null;
        if (!$removeDialogContent) {
            var $dialogs = getDialogs();
            $removeDialogContent = $dialogs.find(".ui-dialog-content").first();
            if (!$dialogs || $dialogs.length <= 0) return;
            $removeDialog = $dialogs.last();
        } else { $removeDialog = $removeDialogContent.parent(); }
        if ($removeDialog && $removeDialog.length > 0 && $removeDialogContent && $removeDialogContent.length > 0 && !$removeDialog[0].closed) {
            if (!$removeDialog[0].isUrlWindow && _data) { /*如果不给定 _data 即认为 不返回 当前已经录入的值*/fillResultData(_data, $removeDialogContent); }
            var e = { cancel: false }; if ($removeDialog[0].beforeClose) { cancel = $removeDialog[0].beforeClose(_data, e); }
            if (!e.cancel) { $removeDialog[0].closed = true; /*禁止多次触发*/if ($removeDialog[0].callback) { $removeDialog[0].callback(_data || { success: false }); } if ($removeDialog[0].dialogTarget) $removeDialog[0].dialogTarget.dialog("close"); /*ie9下会报错$removeDialog.remove();*/ }
        }
        /*清理垃圾*/function deleteElement() { if (window["CollectGarbage"] && CollectGarbage) { CollectGarbage(); /*IE 特有 释放内存*/ } /*ie9下会报错$(".ui-dialog:hidden").remove();*/ }
        setTimeout(deleteElement, 10); /*解决兼容问题*/
    }

    function changePopPage(_data, $changeDialogContent) { /*在弹出层不允许关闭的时候执行传递值*/
        var $changeDialog = null;
        if (!$changeDialogContent) { var $dialogs = getDialogs(); $changeDialogContent = $dialogs.find(".ui-dialog-content").first(); if (!$dialogs || $dialogs.length <= 0) return; $changeDialog = $dialogs.last(); } else { $changeDialog = $changeDialogContent.parent(); }
        if ($changeDialog && $changeDialog.length > 0 && $changeDialogContent && $changeDialogContent.length > 0) { if ($changeDialog[0].changed) { if (!$changeDialog[0].isUrlWindow && _data) { /*如果不给定 _data 即认为 不返回 当前已经录入的值*/var inputs = $changeDialogContent.find("input"); inputs.each(function (index, elem) { try { _data[elem.name] = $(elem).val(); } catch (exp) { } }); } $changeDialog[0].changed(_data || { success: false }); } }
    }

    function getDialogs() { if ($(window.document).find(".ui-dialog").length > 0) { return $(window.document).find(".ui-dialog"); } else if (window.parent && $(window.parent.document).find(".ui-dialog").length > 0) { return $(window.parent.document).find(".ui-dialog"); } else { return $(__firstWindow().document).find(".ui-dialog"); } }

    if (popObj.op == "close") { function close() { closePopPage(popObj.data); } setTimeout(close, 10); /*解决一些浏览器的兼容问题*/ }
    else if (popObj.op == "change") { function change() { changePopPage(popObj.data); } setTimeout(change, 10); /*解决一些浏览器的兼容问题*/ }
    else {
        /*设置默认属性*/popObj.title = popObj.title == undefined ? "No&nbsp;Title" : popObj.title.replace(/\s+/g, "&nbsp;"); popObj.modal = popObj.modal == undefined ? true : popObj.modal; popObj.resizable = popObj.resizable == undefined ? false : popObj.resizable;
        var url = popObj.url; var width = popObj.width > 0 ? popObj.width : getWindowWidth(firstWin); var height = popObj.height > 0 ? popObj.height : getWindowHeight(firstWin);
        var templpate = isUrlWindow ? ('<div title=' + popObj.title + '><iframe width=' + (width - 0) + 'px height=' + (height - 48) + 'px frameborder=\'0\' src=\'about:blank\'></iframe><div>') : popObj.divHtml;
        var $dialogContent = firstWin.append(templpate);
        var dialogParams = { title: popObj.title, height: height, width: width, modal: popObj.modal, autoOpen: false, bgiframe: true, resizable: popObj.resizable, close: function (e, ui) { closePopPage(null, $dialogContent); }, resize: function (e, ui) { if (isUrlWindow) { $dialogContent.find('iframe').attr({ width: ui.size.width - 0, height: ui.size.height - 48 }); } }, dragStart: function (e, ui) { if (isUrlWindow) { $dialogContent.find('iframe').hide(); } }, dragStop: function (e, ui) { if (isUrlWindow) { $dialogContent.find('iframe').show(); } }, create: function () { if (isUrlWindow && __ie6()) { function _create() { var $backBlock = $(firstWin).find(".ui-widget-overlay").attr("overflow", "hidden"); $('<iframe style="top:0;left:0;width:100%;height:100%;filter:alpha(opacity=0);"></iframe>').appendTo($backBlock); } setTimeout(_create, 50); /*解决兼容问题*/ } }, open: function (event, ui) { if (isUrlWindow) { $dialogContent.find('iframe').attr("src", url); } } };
        if (!isUrlWindow) { $dialogContent.html($dialogContent.html() + (popObj.divScript || "")); }
        $dialogContent.dialog(dialogParams); $dialogContent.dialog("open");

        var $dialog = $dialogContent.parent(); var soleClass = getSoleClass(); $dialog.addClass(soleClass); $dialog.attr("soleClass", soleClass);
        if ($dialog && $dialog.length > 0) { $dialog[0].isUrlWindow = isUrlWindow, $dialog[0].dependWindow = firstWin; /*当前弹窗 依附 的 Window 对象*/$dialog[0].preWindow = width;       /*当前弹窗 的 前一个 Window 对象*/$dialog[0].dialogTarget = $dialogContent; $dialog[0].beforeClose = function (data, e) { if (popObj.beforeClose) popObj.beforeClose(data, e); }; $dialog[0].callback = function (data) { if (popObj.onClose) popObj.onClose(data); }; $dialog[0].changed = function (data) { if (popObj.onChange) popObj.onChange(data); }; }
        /*把弹出窗口右上角的X按钮隐藏*/if (popObj.hasClose != undefined && popObj.hasClose == false) { $dialog.parent().find(".ui-dialog-titlebar-close").hide(); }
    }
}

function SpeedyEntry(/*快速输入*/$e, values, c) {
    ///<signature>
    ///     <summary>快读完成</summary>
    ///     <param name="$e" type="$.fn">指定dom元素</param>
    ///     <param name="values" type="Array<String>[]">选择列表值</param>
    ///</signature>
    ///<signature>
    ///     <summary>快读完成</summary>
    ///     <param name="$e" type="$.fn">指定dom元素</param>
    ///     <param name="values" type="Array<String>[]">选择列表值</param>
    ///     <param name="c" type="function">内容更变的回调函数</param>
    ///</signature>
    function split(val) {
        return val.split(/,\s*/);
    }
    function extractLast(term) {
        return split(term).pop();
    }
    $e.bind("keydown", function (event) {
        if (event.keyCode === $.ui.keyCode.TAB &&
						    $(this).data("autocomplete").menu.active) {
            event.preventDefault();
        }
    }).autocomplete({
        minLength: 0,
        source: function (request, response) {
            // delegate back to autocomplete, but extract the last term
            response($.ui.autocomplete.filter(
						    values, extractLast(request.term)));
        },
        focus: function () {
            // prevent value inserted on focus
            return false;
        },
        select: function (event, ui) {
            var terms = split(this.value);
            // remove the current input
            terms.pop();
            // add the selected item
            terms.push(ui.item.value);
            // add placeholder to get the comma-and-space at the end
            terms.push("");
            this.value = terms.join(", ");
            return false;
        }, change: function (event, ui) {
            if (c) {
                c($e.val(), ui);
            }
        }
    });
}