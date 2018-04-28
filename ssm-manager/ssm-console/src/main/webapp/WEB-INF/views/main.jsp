<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="head.jsp"/>
<jsp:include page="modal.jsp"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>员工列表</title>
</head>


<body>
<div class="container">

    <!--标题  -->
    <div class="row">
        <div class="col-md-12">
            <blockquote>
                <%--<code style="font-size: larger">王gay博分页很难</code>--%>
                <h1><b>增删改查</b></h1>
                <footer>简单的增删改查</footer>
            </blockquote>
        </div>
    </div>


    <!--按钮 -->
    <div class="row">
        <div class="col-md-2 col-md-offset-10">
            <button type="button" class="btn btn-primary" id="emps_add_btn">新增</button>
            <button type="button" class="btn btn-danger" id="emps_deleteAll_btn" data-toggle="modal" data-target="#deleteMsgModal">删除</button>
        </div>
    </div>
    <br/>


    <!--显示表格数据  -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" class="hidden" id="check_all"/>
                    </th>
                    <th>编号</th>
                    <th>姓名</th>
                    <th>性别</th>
                    <th>邮箱</th>
                    <th>部门</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>

    <!--显示分页信息  -->
    <div class="row">
        <div class="col-md-6" id="page_info_area">

        </div>
        <!--分页条信息 -->
        <div class="col-md-6" id="page_info_nav">

        </div>
    </div>
</div>


<script type="text/javascript">

    var totalRecord, currentPage;

    //1.页面加载完以后,直接发送一个ajax请求,取到分页的数据
    $(function () {
        //去首页
        to_page(1);

    })

    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
                //console.log(result);
                //1.解析并显示员工数据
                build_emps_table(result);
                //2.解析并显示分页信息
                build_page_area(result);
                //3.解析显示分页条数据
                build_page_nav(result);

                $("table td").each(function(i,dom){
                        $(dom).on("click",function(){
                            if ( $(this).parent().hasClass("active") ){
                                $(this).parent().removeClass("active")
                                    .find('.check_item').prop("checked", false);
                            }else {
                                $(this).parent().addClass("active")
                                    .find('.check_item').prop("checked", true);
                            }

                        })

                })
            }
        })
    }

    //构建页面表单数据
    function build_emps_table(result) {
        $("#emps_table tbody").empty();

        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var checkBox = $('<td><input type="checkbox"  class="check_item hidden"></input></td>');
            var empId = $('<td></td>').append(item.empId);
            var empName = $('<td></td>').append(item.empName);
            var gender = $('<td></td>').append(item.gender == 'M' ? '男' : '女');
            var email = $('<td></td>').append(item.email);
            var deptName = $('<td></td>').append(item.department.deptName);

            var editorButton = $('<button></button>')
                .addClass('btn btn-info btn-sm edit_btn')
                .append($("<span></span>")).addClass('glyphicon glyphicon-pencil')
                .append('编辑');

            //为编辑按钮添加一个自定义的属性,来表示当前员工id
            editorButton.attr("edit-id", item.empId);

            var deleteButton = $('<button></button>')
                .addClass('btn btn-danger btn-sm delete-btn')
                .append($("<span></span>")).addClass('glyphicon glyphicon-trash')
                .append('删除');

            //为删除按钮添加一个自定义的属性来表示当前员工id
            deleteButton.attr("del-id", item.empId);
            var editor = $('<td></td>').append(editorButton).append(deleteButton);


            $('<tr></tr>')
                .append(checkBox)
                .append(empId)
                .append(empName)
                .append(gender)
                .append(email)
                .append(deptName)
                .append(editor)
                .appendTo('#emps_table tbody');
        })
    }


    //构建页面分页
    function build_page_area(result) {
        $("#page_info_area").empty();

        var pageInfo = result.extend.pageInfo;

        $("#page_info_area").append(
            '当前' + pageInfo.pageNum + '页,共' + pageInfo.pages + '页' + ',共' + pageInfo.total + '条记录'
        )
        totalRecord = pageInfo.total;
        currentPage = pageInfo.pageNum;
    }

    function build_page_nav(result) {

        $("#page_info_nav").empty();

        var pageInfo = result.extend.pageInfo;
        var ul = $("<ul></ul>").addClass("pagination");

        var firstPage = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePage = $("<li></li>").append($("<a></a>").css("cursor", "pointer").append("&laquo;"));

        if (pageInfo.hasPreviousPage == false) {
            firstPage.addClass("disabled");
            prePage.addClass("disabled");
        }

        firstPage.click(function () {
            to_page(1);
        })

        prePage.click(function () {
            to_page(pageInfo.pageNum - 1);
        })

        var nextPage = $("<li></li>").append($("<a></a>").css("cursor", "pointer").append("&raquo;"));
        var lastPage = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));

        lastPage.click(function () {
            to_page(pageInfo.pages);
        })

        nextPage.click(function () {
            to_page(pageInfo.pageNum + 1);
        })

        if (pageInfo.hasNextPage == false) {
            nextPage.addClass("disabled");
            lastPage.addClass("disabled");
        }

        ul.append(firstPage).append(prePage);

        $.each(pageInfo.navigatepageNums, function (index, item) {
            var pageNum = $("<li></li>").append($("<a></a>").attr("href", "#").append(item));
            if (item == pageInfo.pageNum) {
                pageNum.addClass("active");
            }
            pageNum.click(function () {
                to_page(item);
            });
            ul.append(pageNum);
        })

        ul.append(nextPage).append(lastPage);
        var nav = $("<nav></nav>").append(ul);
        nav.appendTo("#page_info_nav");

    }

    //清空表单样式及内容
    function reset_form(ele) {
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }


    //点击新增按钮弹出模态框
    $("#emps_add_btn").click(function () {
        //清除表单数据(表单完整重置,表单的数据,表单的样式)
        reset_form("#empAddModal form");

        //发送ajax请求查出部门信息,显示在下拉列表中
        var depts = getDepts("#empAddModal select");
        $.each(depts, function (index, item) {

            $("<option></option>").append(item.deptName).appendTo("#dId");
        })

        //弹出模态框
        $("#empAddModal").modal({
            backdrop: "static"
        })
    })


    //查处所有部门信息并显示在下拉列表中
    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (result) {
                //console.log(result);
                $.each(result.extend.depts, function (index, item) {
                    var optionEle = $("<option></option>").append(item.deptName).attr("value", item.deptId);
                    optionEle.appendTo(ele)
                })
            }
        })
    }


    //点击保存按钮进行验证
    function validate_add_form() {
        //1.拿到需要校验的数据,进行正则表达式验证
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/
        if (!regName.test(empName)) {
            //alert("用户名必须是2-5位中文或6-16位英文字母的组合!");
            show_validate_msg("#empName_add_input", "error", "用户名错误!");
            return false;
        } else {
            show_validate_msg("#empName_add_input", "success", "");
        }
        ;

        //2.检验邮箱信息
        var email = $("#email_add_input").val();
        var regName = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regName.test(email)) {
            show_validate_msg("#email_add_input", "error", "邮箱格式错误!");
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "");
        }
        ;
        return true;
    }

    //校验
    function show_validate_msg(ele, status, msg) {
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        //清除当前元素的校验状态
        if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        } else if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }
    }


    //保存按钮
    $("#emp_save_btn").click(function () {
        //模态框数据提交服务器进行处理
        //1.先对数据库的数据进行校验
        //表单数据进行校验
        if (!validate_add_form()) {
            return false;
        }
        //2.判断之前的ajax用户名是否校验成功
        if ($(this).attr("ajax-va") == "error") {
            return false;
        }

        //2.发送ajax请求保存员工
        $.ajax({
            url: "${APP_PATH}/empAdd",
            type: "POST",
            data: $("#empAddModal form").serialize(),
            success: function (result) {
                //alert(result.msg);
                if (result.code == 100) {
                    //员工保存成功
                    //1.关闭模态框
                    $("#empAddModal").modal('hide');
                    //2.来到最后一页,显示刚才保存的数据
                    //发送ajax请求显示最后一页数据即可
                    to_page(totalRecord);
                } else {
                    //后台请求验证失败
                    //console().log(result);
                    if (undefined != result.extend.errorFields.email) {
                        //显示邮箱错误信息
                        show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                    }
                    if (undefined != result.extend.errorFields.empName) {
                        //显示员工名字的错误
                        show_validate_msg("#email_add_input", "error", result.extend.errorFields.empName);
                    }

                }

            }
        })
    })

    //验证用户名是否重复
    $("#empName_add_input").change(function () {
        var empName = this.value;

        //1.
        //2.ajax提交数据
        $.ajax({
            url: "${APP_PATH}/checkUser",
            data: "empName=" + empName,
            type: "POST",
            success: function (result) {
                if (result.code == 100) {
                    show_validate_msg("#empName_add_input", "success", result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va", "success");
                } else {
                    show_validate_msg("#empName_add_input", "error", result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va", "error")
                }
            }
        })
    })

    //点击修改按钮弹出模态框
    //按钮创建之前就绑定了cilick,所以绑定无效
    //解决方法:1.在按钮创建时进行绑定 2.绑定点击事件
    $(document).on("click", ".edit_btn", function () {
        //1.查出员工信息.并显示员工信息
        getEmployee($(this).attr("edit-id"));
        //2.查出部门信息,并显示部门列表
        var depts = getDepts("#empUpdateModal select");
        //3.把员工id传递给模态框的更新按钮
        $("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));

        $.each(depts, function (index, item) {

            $("<option></option>").append(item.deptName).appendTo("#dId");
        })

        //弹出模态框
        $("#empUpdateModal").modal({
            backdrop: "static"
        })
    })

    //给修改按钮弹出的模态框赋值
    function getEmployee(id) {
        $.ajax({
            url: "${APP_PATH}/emp/" + id,
            type: "GET",
            success: function (result) {
                // console.log(result);
                var empData = result.extend.emp;
                $("#emp_update_input").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.dId]);
            }

        })
    }

    //更新,更新员工信息
    $("#emp_update_btn").click(function () {
        //1.验证邮箱是否合法
        var email = $("#email_update_input").val();
        var regName = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regName.test(email)) {
            show_validate_msg("#email_update_input", "error", "邮箱格式错误!");
            return false;
        } else {
            show_validate_msg("#email_update_input", "success", "");
        }
        ;

        //2.发送ajax请求保存更新的员工数据
        $.ajax({
            url: "${APP_PATH}/emp/" + $(this).attr("edit-id"),
            type: "PUT",
            data: $("#empUpdateModal form").serialize(),
            success: function (result) {
                //alert(result.msg);
                //1.关闭对话框
                $("#empUpdateModal").modal("hide");
                //2.回到本页面
                to_page(currentPage);
            }
        })
    })

    //单条数据删除
    $(document).on("click", ".delete-btn", function () {
        //1.弹出是否确认删除对话框
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).attr("del-id");

        cleanDelModal();
        $("#trouble").text("单条删除");
        $("#delete_msg").text("确认删除 " + empName + "君 吗?");
        $("#delete_true_btn").attr("value", empId);


        //弹出模态框
        $("#deleteMsgModal").modal({
            backdrop: "static"
        })

    })

    /**
     * 清空模态框中的数据
     */
    function cleanDelModal() {
        $("#trouble").text("");
        $("#delete_msg").text("");
        $("#delete_true_btn").attr("value", "");
        $("#delete_true_btn").removeClass("disabled");
    }

    //模态框删除数据
    $("#delete_true_btn").click(function(){
        var  empId = $("#delete_true_btn").val();
        //确认,发送ajax请求即可
        $.ajax({
            url: "${APP_PATH}/emp/" + empId,
            type: "DELETE",
            success: function (result) {
                // alert(result.msg);
                $("#deleteMsgModal").modal("hide")
                to_page(currentPage);
                cleanDelModal();
            }
        })
    })


    //完成全选,全不选功能
    $("#check_all").click(function () {
        //attr获取checked是undefined;
        //attr用来获取自定义属性的值,获取属性值最好使用dom原生方法
        //prop修改和读取dom原生属性的值,
        //将check_item的checked属性的值变为$(this).prop("checked"),也就是全选那个复选框的属性值
        $(".check_item").prop("checked", $(this).prop("checked"));
    })

    //check_item
    $(document).on("click", ".check_item", function () {
        //判断当前选中的元素是否为五个, 是五个就把全选的复选框checked,不是就不勾
        //alert($(".check_item:checked").length);
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked", flag);
    })

    //点击全部删除,就批量删除
    $("#emps_deleteAll_btn").click(function () {

        var empNames = "";
        var del_ids = "";


        $.each($(".check_item:checked"), function () {
            empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
            del_ids += $(this).parents("tr").find("td:eq(1)").text() + "-";
        });

        //去除empNames结尾多余的逗号和del_idstr多余的-号
        empNames = empNames.substring(0, empNames.length - 1);
        del_ids = del_ids.substring(0, del_ids.length - 1);


        if('' == empNames){
            cleanDelModal();
            $("#trouble").text("批量删除");
            $("#delete_msg").text("未选中数据,如何删除?");
            $("#delete_true_btn").addClass("disabled");
            return;
        }else{
            cleanDelModal();
            $("#trouble").text("批量删除");
            $("#delete_msg").text("确认删除 " + empNames + "君 吗?");
            $("#delete_true_btn").attr("value", del_ids);
            $("#delete_true_btn").attr("data-dismiss","modal");
            return;
        }
            //弹出模态框
            $("#deleteMsgModal").modal({
                backdrop: "static"
            })
    });




    /*
    $("td").click(function(){
        $(this).addClass("active");
        a.data.success();

    })*/

</script>
</body>
</html>