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
                    <c:if test="${userRole gt 0}">
                        <%@include file="layout/_headermain.jsp" %>
                    </c:if>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="<s:url action="index"></s:url>">Trang chủ</a> <i class="fa fa-angle-right"></i> Thông tin cá nhân</li>
                        </ol>



                        <div class="agile-grids" style="background: #fff;padding: 2em;margin: 2em 0">

                            <div class="row" style="padding: 1em">
                                <div class="col-md-12">
                                    <div class="col-md-4">
                                        <img src="${pageContext.request.contextPath}/images/${usr.avatar}" alt="" width="200px" height="auto"/>
                                </div>
                                <div class="col-md-8">
                                    <h3>${usr.name}</h3>
                                    <h4>Email: <span>${usr.email}</span></h4>
                                    <h4>Phone: <span>${usr.phone}</span></h4>
                                    <c:if test="${usercode eq id}">
                                        <s:url id="action_edit" action="changeProfile">
                                        </s:url>
                                        <s:a href="%{action_edit}" cssClass="btn btn-success">Thay đổi thông tin cá nhân</s:a>
                                    </c:if>
                                </div>
                            </div>
                        </div>

                        <!--Chat here-->
                        <c:if test="${userRole gt 0}">
                            <c:if test="${usercode ne id}">
                                <div class="container">
                                    <div class="row">
                                        <div class="col-md-2">

                                        </div>
                                        <div class="col-md-6">
                                            <div class="panel panel-primary">
                                                <div class="panel-heading">
                                                    <span class="glyphicon glyphicon-comment"></span> Chat

                                                    <div class="panel-body">
                                                        <ul class="chat">
                                                            <!--chat\\\\ foreach-->

                                                            <c:forEach var="message" items="${listms}">

                                                                <li class="left clearfix"><span class="chat-img pull-left">
                                                                        <img src="${pageContext.request.contextPath}/images/${message.sAvatar}" alt="User Avatar" class="img-circle" width="50px" height="auto"/>
                                                                    </span>
                                                                    <div class="chat-body clearfix">
                                                                        <div class="header">
                                                                            <strong class="primary-font">${message.sName}</strong>

                                                                            <small class="pull-right text-muted"><span class="glyphicon glyphicon-time"></span>${message.time}
                                                                            <c:if test="${message.sentId eq usercode}">
                                                                                <i class="fa fa-pencil-square-o fa-lg" aria-hidden="true" onclick="edifunction(${message.mId})" style="float:left"></i>
                                                                                <!--<input type="hidden" value="" data-id=""/>-->

                                                                                <s:form method="post" action="editMessage" theme="simple" id="editform" enctype="multipart/form-data">
                                                                                    <s:textfield name="content" type="hidden"></s:textfield>
                                                                                    <s:textfield name="messid" type="hidden"></s:textfield>
                                                                                </s:form>
                                                                            </c:if>
                                                                            <s:url id="action_delete" action="deleteMesssage">
                                                                                <s:param name="messid">${message.mId}</s:param>
                                                                            </s:url>
                                                                            <s:a href="%{action_delete}" onclick="return confirm('Bạn có muốn xóa tin nhắn này?')"><i class="fa fa-trash fa-lg" aria-hidden="true" style="float:left"></i></s:a>
                                                                            </small>
                                                                        </div>
                                                                        <p>${message.content}</p>
                                                                        
                                                                            

                                                                        </div>
                                                                    </li>
                                                            </c:forEach>

                                                            <!--chat-->
                                                        </ul>
                                                    </div>
                                                    <div class="panel-footer">
                                                        <div class="input-group">

                                                            <!--form-->
                                                            <s:form method="post" theme="simple" action="sendMessage" cssClass="form-horizontal" enctype="multipart/form-data">
                                                                <!--<input id="btn-input" type="text" class="form-control input-sm" placeholder="Type your message here..." />-->
                                                                <s:textfield name="content" cssClass="form-control input-sm" placeholder="Type your message here..." id="btn-input"></s:textfield>
                                                                    <span class="input-group-btn">
                                                                        <!--<button class="btn btn-warning btn-sm" id="btn-chat">Send</button>-->
                                                                    <s:submit value="Gửi" cssClass="btn btn-primary btn-sm" ></s:submit>
                                                                    </span>
                                                            </s:form>

                                                            <!--/form-->
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:if>
                            <!--Chat End-->
                        </div>


                        <div class="inner-block">
                        </div>
                    </div>
                </div>
                <%@include file="layout/_sidebar.jsp"%>
            </div>


            <script>
                function edifunction(a) {
                    var content = prompt("Nội dung thay đổi");
                    if (content === null)
                    {
                        a = 0;
                    }
                    document.getElementById("editform_content").value = content;
                    document.getElementById("editform_messid").value = a;
                    document.getElementById("editform").submit();
                }
            </script>




    </body>
</html>

<%@include file="layout/_script.jsp" %>