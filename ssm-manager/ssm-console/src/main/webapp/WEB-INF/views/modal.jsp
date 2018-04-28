<%--
  Created by IntelliJ IDEA.
  User: dingZiYuan
  Date: 2018-04-27
  Time: 11:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="head.jsp"/>
<!-- 修改模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">修改页面</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal">

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">empName:</label>
                        <div class="col-sm-10" id="empNameDiv">
                            <p class="form-control-static" id="emp_update_input"></p>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">email:</label>
                        <div class="col-sm-10" id="emailDiv">
                            <input type="email" name="email" class="form-control" id="email_update_input" placeholder="Email">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">gender:</label>
                        <div class="col-sm-10" id="genderDiv">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M">男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F">女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">department:</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_update_select"></select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id = "emp_update_btn">修改</button>
            </div>
        </div>
    </div>
</div>




<!-- 新增模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">新增页面</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal">

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">员工姓名:</label>
                        <div class="col-sm-10" id="empNameDiv">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="姓名">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">邮箱:</label>
                        <div class="col-sm-10" id="emailDiv">
                            <input type="email" name="email" class="form-control" id="email_add_input" placeholder="邮箱">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">性别:</label>
                        <div class="col-sm-10" id="genderDiv">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M">男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F">女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">部门:</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_add_select"></select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id = "emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>


<%-- msg返回信息模态框 --%>
<div class="modal fade" id="deleteMsgModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="trouble"></h4>
            </div>
            <div class="modal-body">
                <h2 id="delete_msg"></h2>
            </div>


            <div class="modal-footer">

                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary"  id = "delete_true_btn">确定</button>
            </div>


        </div>
    </div>
</div>


