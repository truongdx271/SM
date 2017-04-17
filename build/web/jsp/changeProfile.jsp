<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <%@include file="layout/_header.jsp" %>
    <body>
        <div class="page-container">
            <div class="left-content">
                <div class="mother-grid-inner">
                    <%@include file="layout/_headermain.jsp" %>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="<s:url action="index"></s:url>">Trang chủ</a> <i class="fa fa-angle-right"></i>Thay đổi thông tin cá nhân</li>
                        </ol>
                        <div class="grid-form1">
                        <c:if test="${alert!=null}">
                            <div class="alert alert-danger" id="alertField">
                                ${alert}
                            </div>
                        </c:if>
                        <s:form method="post" theme="simple" action="changeProfilePr" cssClass="form-horizontal" enctype="multipart/form-data">
                            <%--<s:token/>--%>
                    
                                <div class="form-group">
                                    <label class="col-sm-2 control-label hor-form">Tài khoản</label>
                                    <div class="col-sm-8">
                                    <s:textfield name="usr.username" cssClass="form-control"  readonly="true"></s:textfield>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label hor-form">Họ và tên</label>
                                    <div class="col-sm-8">
                                    <s:textfield name="usr.name" cssClass="form-control" placeholder="Họ và tên"></s:textfield>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label  class="col-sm-2 control-label hor-form">Email</label>
                                    <div class="col-sm-8">
                                    <s:textfield name="usr.email" cssClass="form-control" placeholder="Email"></s:textfield>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label  class="col-sm-2 control-label hor-form">Số điện thoại</label>
                                    <div class="col-sm-8">
                                    <s:textfield name="usr.phone" cssClass="form-control" placeholder="Số điện thoại"></s:textfield>
                                    </div>
                                </div>


                                <div class="form-group">
                                    <label  class="col-sm-2 control-label hor-form">Avatar</label>
                                    <div class="col-sm-8">
                                    <%--<s:textfield name="usr.avatar" cssClass="form-control" placeholder=""></s:textfield>--%>
                                    <img src="${pageContext.request.contextPath}/images/${usr.avatar}" height="60" width="60"/>
                                    <s:hidden name="usr.avatar"></s:hidden>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label  class="col-sm-2 control-label hor-form">Upload</label>
                                    <div class="col-sm-8">
                                    <s:file name="userImage"></s:file>
                                    </div>
                                </div>
                                    <s:hidden name="usr.role"></s:hidden>

                                <div class="form-group">
                                    <div class="col-sm-offset-2 col-sm-8">
                                    <s:submit value="Thay đổi" cssClass="btn btn-primary" ></s:submit>
                                    </div>
                                </div>
                                <!--</form>-->
                        </s:form>
                    </div>






                    <div class="inner-block">
                    </div>

                </div>
            </div>
            <%@include file="layout/_sidebar.jsp"%>
        </div>
    </body>
</html>

<%@include file="layout/_script.jsp" %>