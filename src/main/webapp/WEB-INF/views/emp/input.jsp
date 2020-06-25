<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            $("#lastName").change(function () {
                var val = $(this).val();
                val = $.trim(val);
                $(this).val(val);

                // 若修改的lastName和之前的lastName一直,则不发起校验
                var _oldLastName = $("#_oldLastName").val();
                _oldLastName = $.trim(_oldLastName);
                if (_oldLastName != null && _oldLastName !== "" && _oldLastName === val) {
                    $("#msgError").html("用户名可用")
                    return;
                }

                $("#msgError").html("")
                var url = "${pageContext.request.contextPath}/ajaxValidateLastName"
                var args = {"lastName":val,"date":new Date()};
                $.post(url,args,function (data) {
                    if (data == "0") {
                        $("#msgError").html("用户名可用")
                    } else if (data == "1") {
                        $("#msgError").html("用户名不可用")
                    } else {
                        $("#msgError").html("网络请求异常")
                    }
                })
            })
        })
    </script>
</head>
<body>
    <c:set value="${pageContext.request.contextPath}/emp" var="url"></c:set>
    <c:if test="${employee.id != null}">
        <c:set value="${pageContext.request.contextPath}/emp/${employee.id}" var="url"></c:set>
    </c:if>
    <form:form action="${url}" method="post" modelAttribute="employee">

        <c:if test="${employee.id != null}">
            <input type="hidden" id="_oldLastName" value="${employee.lastName}">
            <form:hidden path="id"/>
            <input type="hidden" name="_method" value="PUT">
        </c:if>

        LastName: <form:input path="lastName" id="lastName"/>
        <span id="msgError"></span>
        <br>
        Email: <form:input path="email"/><br>
        Birth: <form:input path="birth"/><br>
        Department:
        <form:select path="department.id">
            <form:options items="${departments}" itemLabel="departmentName" itemValue="id"/>
        </form:select>
        <br/>
        <input type="submit" value="submit">
    </form:form>
</body>
</html>
