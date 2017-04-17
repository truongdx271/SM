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
                        <li class="breadcrumb-item"><a href="<s:url action="index"></s:url>">Trang chủ</a> <i class="fa fa-angle-right"></i><a href="<s:url action="getListTask"></s:url>">Bài tập</a> <i class="fa fa-angle-right"></i>Thêm mới</li>
                        </ol>
                        <div class="grid-form1">
                            <!--<h3 id="forms-horizontal">Thêm người dùng</h3>-->
                            <!--<form class="form-horizontal">-->
                        <c:if test="${alert!=null}">
                            <div class="alert alert-danger" id="alertField">
                                ${alert}
                            </div>
                        </c:if>
                        <s:form method="post" theme="simple" action="insertTaskPr" cssClass="form-horizontal" enctype="multipart/form-data">
                            <%--<s:token/>--%>
                            <div class="form-group">
                                <label for="inputEmail3" class="col-sm-2 control-label hor-form">Nội dung</label>
                                <div class="col-sm-8">
                                    <!--<input type="email" class="form-control" id="inputEmail3" placeholder="Email">-->
                                    <s:textfield name="f.note" cssClass="form-control" placeholder="Nội dung"></s:textfield>
                                    </div>
                                </div>
                                    
                                <div class="form-group">
                                    <label  class="col-sm-2 control-label hor-form">File đính kèm</label>
                                    <div class="col-sm-8">
                                    <%--<s:textfield name="usr.avatar" cssClass="form-control" placeholder=""></s:textfield>--%>
                                    <s:file name="taskFile"></s:file>
                                    </div>

                                </div>

                                <div class="form-group">
                                    <div class="col-sm-offset-2 col-sm-10">
                                        <!--<button type="submit" class="btn btn-default">Sign in</button>-->
                                    <s:submit value="Thêm mới" cssClass="btn btn-primary" ></s:submit>
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
<script type="text/javascript">
    $(document).ready(function () {
        $('#userInsert_usr_username').off('click').on('click', function () {
            $(this).val("");
            $('#alertField').remove();
        });
        $('#userInsert_usr_fullname').off('click').on('click', function () {
            $(this).val("");
            $('#alertField').remove();
        });
        $('#userInsert_usr_email').off('click').on('click', function () {
            $(this).val("");
            $('#alertField').remove();
        });
    });
</script>