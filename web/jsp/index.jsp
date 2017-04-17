<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>

    <%--<s:if test="#session.USER != null">--%>
        <%@include file="layout/_header.jsp" %>
    <%--</s:if>--%>
    <body>
        <div class="page-container">
            <div class="left-content">
                <div class="mother-grid-inner">
                    <s:if test="#session.USER != null">
                    <%@include file="layout/_headermain.jsp" %>
                    </s:if>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="<s:url action="index"></s:url>">Trang chủ</a> <i class="fa fa-angle-right"></i></li>
                        </ol>
                    <s:if test="#session.USER != null">
                        <h1>Welcome <s:property value="#session.USER"/></h1>
                    </s:if>
                    <s:if test="#session.USER == null">
                        <h1><a href="<s:url action="login"></s:url> ">Đăng nhập</a></h1>
                    </s:if>
                    <div class="inner-block">
                    </div>
                </div>
            </div>
            <%@include file="layout/_sidebar.jsp"%>
        </div>
    </body>
</html>

<%@include file="layout/_script.jsp" %>


<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <%@include file="layout/_header.jsp" %>
    <body>
        <div class="page-container">
            <div class="left-content">
                <div class="mother-grid-inner">
                    <%@include file="layout/_headermain.jsp" %>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="<s:url action="adminIndex"></s:url>">Trang chủ</a> <i class="fa fa-angle-right"></i></li>
                    </ol>
                    <s:if test="#session.USER != null">
                        <h1>Welcome <s:property value="#session.USER"/></h1>
                    </s:if>
                        <h2>Trở về <s:a action="index">trang người dùng</s:a> </h2>

                    <div class="inner-block">
                    </div>
                </div>
            </div>
            <%@include file="layout/_sidebar.jsp"%>
        </div>


    </body>
</html>

<%@include file="layout/_script.jsp" %>--%>