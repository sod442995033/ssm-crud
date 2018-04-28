

<%
    pageContext.setAttribute("APP_PATH",request.getContextPath());
%>

<!--web路径:
不以/开头的相对路径,找资源以当前资源的路径为基准,部署在服务器上有可能路径出错.
以/开头的相对路径,找资源以服务器的路径为标准(http://localhost:3306);可以再加上项目名
-->
<script type="text/javascript" src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
<link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>