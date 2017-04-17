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
                    <c:if test="${userRole gt 1}">
                        <%@include file="layout/_headermain.jsp" %>
                    </c:if>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="<s:url action="index"></s:url>">Trang chủ</a> <i class="fa fa-angle-right"></i>Bài tập</li>
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
                                        <input type="button" class="btn-primary btn" onClick="location.href = '<s:url action="insertTask"></s:url>'" value="Thêm mới">
                                    </c:if>
                                </div>
                                <s:form method="post" theme="simple" action="getListTask">
                                    <div class="col-sm-5" >
                                        <s:textfield name="searchString" cssClass="form-control" placeholder="Tìm..." id="searchField"></s:textfield>
                                        </div>
                                        <div class="col-sm-3">
                                        <s:submit value="Tìm kiếm" cssClass="btn btn-primary" ></s:submit>
                                        <input type="button" class="btn-primary btn" onClick="location.href = '<s:url action="getListTask"></s:url>'" value="Reset">
                                        </div>
                                </s:form>

                            </div>

                            <table id="table">
                                <thead>
                                    <tr>
                                        <th>Bài tập</th>
                                        <th>File đính kèm</th>
                                        <th>Điều khiển</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="f" items="${list}">
                                        <tr>
                                            <td>${f.note}</td>
                                            <td>${f.fName}</td>

                                            <td>
                                                <s:url id="fileDownload" namespace="/" action="download" >
                                                    <s:param name="id">${f.fId}</s:param>
                                                </s:url>
                                                <s:a href="%{fileDownload}">Download</s:a>
                                                    &nbsp;&nbsp;&nbsp;
                                                <c:if test="${userRole eq 3}">
                                                    <s:url id="action_delete" action="deleteTask">
                                                        <s:param name="id">${f.fId}</s:param>
                                                    </s:url>
                                                    <s:a href="%{action_delete}" onclick="return confirm('Bạn có muốn xóa bài tập này?')"><i class="fa fa-trash fa-lg" aria-hidden="true"></i></s:a>
                                                        &nbsp;&nbsp;&nbsp;
                                                </c:if>    
                                                <c:if test="${userRole gt 1}">
                                                    <%--<s:token/>--%>
                                                    <s:url id="action_answer" action="answerTask">
                                                        <s:param name="id">${f.fId}</s:param>
                                                    </s:url>
                                                    <s:a href="%{action_answer}">Nộp bài</s:a>
                                                </c:if>
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