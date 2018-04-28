<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="head.jsp"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
</head>

	<div class="container">
		<!--标题  -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!--按钮 -->
		<div class="row">
			<div class="col-md-2 col-md-offset-10">
				<button type="button" class="btn btn-primary">新增</button>
				<button type="button" class="btn btn-danger">删除</button>
			</div>
		</div>
		<br/>
		<!--显示表格数据  -->
		<div class="row">
			<div class="col-md-12"> 
				<table class="table table-striped table-hover">
					<tr>
						<th>#</th>
						<th>姓名</th>
						<th>邮箱</th>
						<th>性别</th>
						<th>部门</th>
						<th>操作</th>
					</tr>
		<c:forEach items="${pageInfo.list }" var="emp">
			<tr>
						<th>${emp.empId }</th>
						<th>${emp.empName }</th>
						<th>${emp.email }</th>
						<th>${emp.gender eq "M"?"男":"女" }</th>
						<th>${emp.department.deptName }</th>
						<th>
							<button type="button" class="btn btn-info btn-sm">
								<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
							编辑
							</button>
							<button type="button" class="btn btn-danger btn-sm">
							<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
					 		删除
							</button>
						</th>
					</tr>
		</c:forEach>
					
				</table>
			</div>
		</div>
		<!--显示分页信息  -->
		<div class="row">
			<div class="col-md-6">
				第${pageInfo.pageNum }页,共${pageInfo.pages }页,共${pageInfo.total }条记录
			</div>
			<!--分页条信息 -->
			<div class="col-md-6">
			
			
				<nav aria-label="Page navigation">
				  <ul class="pagination">
				     <li class="next"><a href="${APP_PATH }/emps?pn=1">首页</a></li>
				 
				   	<c:if test="${pageInfo.pageNum != 1 }">
					   	 <li class="next"> 
					      <a href="${APP_PATH }/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
					    </li>
				   	</c:if> 
				   	
				    <c:forEach items="${pageInfo.navigatepageNums }" var="page_Num">
					   	 <c:if test="${page_Num == pageInfo.pageNum}">
					    	<li class="active"><a href="${APP_PATH }/emps?pn=${page_Num}">${page_Num }</a></li>
					   	 </c:if>
				   	 	<c:if test="${page_Num != pageInfo.pageNum}">
				   	 		<li class="next"><a href="${APP_PATH }/emps?pn=${page_Num}">${page_Num }</a></li>
				   	 	</c:if>
				    </c:forEach>
				    
				    <c:if test="${pageInfo.pageNum != pageInfo.pages }">
				    <li class="next">
				      <a href="${APP_PATH }/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
				        <span aria-hidden="true">&raquo;</span>
				      </a>
				    </li>
				    </c:if>
				    <li class="next"><a href="${APP_PATH }/emps?pn=${pageInfo.pages}">末页</a></li>
				  </ul>
				</nav>
		
		
		
			</div>
		</div>
	</div>
</body>
</html>