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
                        <li class="breadcrumb-item"><a href="<s:url action="index"></s:url>">Trang chủ</a> <i class="fa fa-angle-right"></i>Người dùng</li>
                        </ol>

                        <div class="agile-tables">
                        <c:if test="${alert != null}">
                            <div class="alert alert-success" id="alertField">
                                ${alert}
                            </div>
                        </c:if>
                        <div class="w3l-table-info">
                            <!--<button class="btn-primary btn">Thêm mới</button>-->
                            <div class="row">
                                <div class="col-sm-4">
                                    <c:if test="${userRole eq 3}">
                                        <input type="button" class="btn-primary btn" onClick="location.href = '<s:url action="insertUsr"></s:url>'" value="Thêm mới">
                                    </c:if>
                                </div>
                                <s:form method="post" theme="simple" action="userListPaging">
                                    <div class="col-sm-5" >
                                        <s:textfield name="searchString" cssClass="form-control" placeholder="Tìm..." id="searchField"></s:textfield>
                                        </div>
                                        <div class="col-sm-3">
                                        <s:submit value="Tìm kiếm" cssClass="btn btn-primary" ></s:submit>
                                        <input type="button" class="btn-primary btn" onClick="location.href = '<s:url action="userListPaging"></s:url>'" value="Reset">
                                        </div>
                                </s:form>

                            </div>

                            <table id="table">
                                <thead>
                                    <tr>
                                        <th>Họ và tên</th>
                                        <th>Email</th>
                                        <th>Điện thoại</th>
                                        <th>Avatar</th>
                                            <c:if test="${userRole eq 3}">
                                            <th>Tài khoản</th>
                                            <th>Trạng thái</th>
                                            <th>Loại tài khoản</th>
                                            </c:if>
                                        <th>Điều khiển</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="user" items="${list}">
                                        <tr>
                                            <td>${user.name}</td>
                                            <td>${user.email}</td>
                                            <td>${user.phone}</td>
                                            <td><img src="${pageContext.request.contextPath}/images/${user.avatar}" height="60" width="auto" /></td>

                                            <c:if test="${userRole eq 3}">
                                                <td>${user.username}</td>

                                                <c:if test="${user.status eq true}">
                                                    <td><button class="btn disabled btn-sm btn-block col-15">Kích hoạt</button></td>
                                                </c:if>
                                                <c:if test="${user.status eq false}">
                                                    <td><button class="btn disabled btn-sm btn-block col-2">Khóa</button></td>
                                                </c:if>

                                                <c:if test="${user.role eq 1}">
                                                    <td><button class="btn disabled btn-sm btn-block col-2">Người dùng</button></td>
                                                </c:if>
                                                <c:if test="${user.role eq 2}">
                                                    <td><button class="btn disabled btn-sm btn-block col-15">Học sinh</button></td>
                                                </c:if>
                                                <c:if test="${user.role eq 3}">
                                                    <td><button class="btn disabled btn-sm btn-block col-7">Giáo viên</button></td>
                                                </c:if>

                                            </c:if>
                                            <td>
                                                <c:if test="${userRole eq 3}">
                                                    <s:url id="action_edit" action="editUsr">
                                                        <s:param name="id">${user.uId}</s:param>
                                                    </s:url>
                                                    <s:a href="%{action_edit}"><i class="fa fa-pencil-square-o fa-lg" aria-hidden="true"></i></s:a>
                                                        &nbsp;&nbsp;&nbsp;

                                                    <s:url id="action_delete" action="deleteUsr">
                                                        <s:param name="id">${user.uId}</s:param>
                                                    </s:url>
                                                    <s:a href="%{action_delete}" onclick="return confirm('Bạn có muốn xóa người dùng này?')"><i class="fa fa-trash fa-lg" aria-hidden="true"></i></s:a>
                                                        &nbsp;&nbsp;&nbsp;
                                                </c:if>    

                                                <%--<s:token/>--%>
                                                <s:url id="action_view" action="profile">
                                                    <s:param name="id">${user.uId}</s:param>
                                                </s:url>
                                                <s:a href="%{action_view}"><i class="fa fa-user fa-lg" aria-hidden="true"></i></s:a>
                                                </td>

                                            </tr>
                                    </c:forEach>    
                                </tbody>

                            </table>



                            <div class="text-center">
                                <c:if test="${noOfRecords gt 0}">
                                    <ul class="pagination pagination-lg" max-size="4">
                                        <!--previous-->

                                        <c:if test="${currentPage gt 1}">
                                            <s:url id="action_previous" action="userListPaging">
                                                <s:param name="page">${currentPage-1}</s:param>
                                                <c:if test="${not empty searchString}">
                                                    <s:param name="searchString">${searchString}</s:param>
                                                </c:if>
                                            </s:url>
                                            <li><s:a href="%{action_previous}">❮</s:a></li>
                                            </c:if>
                                            <s:url id="action_first" action="userListPaging">
                                                <s:param name="page">${1}</s:param>
                                                <c:if test="${not empty searchString}">
                                                    <s:param name="searchString">${searchString}</s:param>
                                                </c:if>
                                            </s:url>
                                            <c:if test="${currentPage eq 1}">
                                            <li class="active"><s:a href="#">1</s:a></li>
                                            </c:if>
                                            <c:if test="${currentPage gt 1}">
                                            <li><s:a href="%{action_first}">1</s:a></li>
                                            </c:if>
                                        <!--Page-->
                                        <c:if test="${noOfPages lt 9}">
                                            <c:forEach begin="2" end="${noOfPages-1}" var="i">
                                                <c:choose>
                                                    <c:when test="${currentPage eq i}">
                                                        <li class="active"><a href="#">${i}</a></li>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <s:url id="action_page" action="userListPaging">
                                                                <s:param name="page">${i}</s:param>
                                                                <c:if test="${not empty searchString}">
                                                                    <s:param name="searchString">${searchString}</s:param>
                                                                </c:if>
                                                            </s:url>
                                                        <li><s:a href="%{action_page}">${i}</s:a></li>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:forEach>
                                            </c:if>
                                            <c:if test="${noOfPages ge 9}">
                                                <c:if test="${currentPage ge 5 && currentPage le (noOfPages-4)}">
                                                    <c:forEach begin="${currentPage-3}" end="${currentPage + 3}" var="i">
                                                        <c:choose>
                                                            <c:when test="${currentPage eq i}">
                                                            <li class="active"><a href="#">${i}</a></li>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <s:url id="action_page" action="userListPaging">
                                                                    <s:param name="page">${i}</s:param>
                                                                    <c:if test="${not empty searchString}">
                                                                        <s:param name="searchString">${searchString}</s:param>
                                                                    </c:if>
                                                                </s:url>
                                                            <li><s:a href="%{action_page}">${i}</s:a></li>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                </c:if>
                                                <c:if test="${currentPage lt 5}">
                                                    <c:forEach begin="2" end="8" var="i">
                                                        <c:choose>
                                                            <c:when test="${currentPage eq i}">
                                                            <li class="active"><a href="#">${i}</a></li>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <s:url id="action_page" action="userListPaging">
                                                                    <s:param name="page">${i}</s:param>
                                                                    <c:if test="${not empty searchString}">
                                                                        <s:param name="searchString">${searchString}</s:param>
                                                                    </c:if>
                                                                </s:url>
                                                            <li><s:a href="%{action_page}">${i}</s:a></li>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                </c:if>
                                                <c:if test="${currentPage gt (noOfPages-4)}">
                                                    <c:forEach begin="${noOfPages-7}" end="${noOfPages-1}" var="i">
                                                        <c:choose>
                                                            <c:when test="${currentPage eq i}">
                                                            <li class="active"><a href="#">${i}</a></li>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <s:url id="action_page" action="userListPaging">
                                                                    <s:param name="page">${i}</s:param>
                                                                    <c:if test="${not empty searchString}">
                                                                        <s:param name="searchString">${searchString}</s:param>
                                                                    </c:if>
                                                                </s:url>
                                                            <li><s:a href="%{action_page}">${i}</s:a></li>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                </c:if>
                                            </c:if>
                                        <!--Next-->
                                        <s:url id="action_last" action="userListPaging">
                                            <s:param name="page">${noOfPages}</s:param>
                                            <c:if test="${not empty searchString}">
                                                <s:param name="searchString">${searchString}</s:param>
                                            </c:if>
                                        </s:url>
                                        <c:if test="${noOfPages gt 1}">
                                            <c:if test="${currentPage eq noOfPages}">
                                                <li class="active"><s:a href="#">${noOfPages}</s:a></li>
                                                </c:if>
                                                <c:if test="${currentPage lt noOfPages}">
                                                <li><s:a href="%{action_last}">${noOfPages}</s:a></li>
                                                </c:if>
                                            </c:if>

                                        <c:if test="${currentPage lt noOfPages}">
                                            <s:url id="action_next" action="userListPaging">
                                                <s:param name="page">${currentPage + 1}</s:param>
                                                <c:if test="${not empty searchString}">
                                                    <s:param name="searchString">${searchString}</s:param>
                                                </c:if>
                                            </s:url>
                                            <li><s:a href="%{action_next}">❯</s:a></li>
                                            </c:if>
                                    </ul>
                                </c:if>
                            </div>



                        </div>
                    </div>


                    <div class="inner-block">
                    </div>
                </div>
            </div>
            <%@include file="layout/_sidebar.jsp"%>
        </div>


    </body>
</html>

<script>
    $('#table').basictable();
    $(document).ready(function () {
        $('#table').basictable();

        $('#table-breakpoint').basictable({
            breakpoint: 768
        });

        $('#table-swap-axis').basictable({
            swapAxis: true
        });

        $('#table-force-off').basictable({
            forceResponsive: false
        });

        $('#table-no-resize').basictable({
            noResize: true
        });

        $('#table-two-axis').basictable();

        $('#table-max-height').basictable({
            tableWrapper: true
        });
    });
</script>

<%@include file="layout/_script.jsp" %>

<script>
    function removeAlert() {
        $('#alertField').fadeOut('slow');
    }

    $(document).ready(function () {
        setTimeout(removeAlert, 3000);

    });
</script>