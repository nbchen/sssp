<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 2020/6/25
  Time: 16:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/scripts/jquery-1.9.1.min.js"></script>
    <script>
        $(function () {
            $(".delete").click(function () {
               var label = $(this).next(":hidden").val();
               var flag = confirm("确定要删除" + label + "吗？");
               if (flag) {
                    var url = $(this).attr("href");
                    $("#_form").attr("action",url);
                    $("#_method").val("DELETE");
                    $("#_form").submit();
               }
               return false;
            })
        })
    </script>
</head>
<body>

    <form action="" method="post" id="_form">
        <input type="hidden" name="_method" id="_method">
    </form>


    <c:if test="${page == null || page.numberOfElements == 0}">
        没有任何记录
    </c:if>
    <c:if test="${page != null && page.numberOfElements > 0}">
        <table border="1" cellpadding="10" cellspacing="0">
            <tr>
                <th>ID</th>
                <th>LastName</th>
                <th>Email</th>
                <th>Birth</th>
                <th>CreateTime</th>
                <th>Department</th>
                <th>Edit</th>
                <th>Delete</th>
            </tr>
            <c:forEach items="${page.content}" var="emp">
                <tr>
                    <td>${emp.id}</td>
                    <td>${emp.lastName}</td>
                    <td>${emp.email}</td>
                    <td>
                        <fmt:formatDate value="${emp.birth}" pattern="yyyy-MM-dd"/>
                    </td>
                    <td>
                        <fmt:formatDate value="${emp.createTime}" pattern="yyyy-MM-dd hh:mm:ss"/>
                    </td>
                    <td>${emp.department.departmentName}</td>
                    <td><a href="${pageContext.request.contextPath}/emp/${emp.id}">Edit</a></td>
                    <td>
                        <a class="delete" href="${pageContext.request.contextPath}/emp/${emp.id}">Delete</a>
                        <input type="hidden" value="${emp.lastName}">
                    </td>
                </tr>
            </c:forEach>
            <tr>
                <td colspan="8">
                    共 ${page.totalElements} 条记录
                    共 ${page.totalPages} 页
                    当前 ${page.number + 1} 页
                    <a href="?pageNo=${page.number + 1 - 1}">上一页</a>
                    <a href="?pageNo=${page.number + 1 + 1}">下一页</a>
                </td>
            </tr>
        </table>
    </c:if>
</body>
</html>
