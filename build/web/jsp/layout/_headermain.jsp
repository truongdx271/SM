<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="header-main">
    <div class="logo-w3-agile">
        <h1><a href="<s:url action="index"></s:url>">HOME</a></h1>
        </div>
        <div class="w3layouts-left">

            <!--search-box-->
            <div class="w3-search-box">
                <form action="#" method="post">
                    <input type="text" placeholder="Search..." required="">	
                    <input type="submit" value="">					
                </form>
            </div><!--//end-search-box-->
            <div class="clearfix"> </div>
        </div>
        <div class="w3layouts-right">
            <div class="profile_details_left"><!--notifications of menu start -->
                <ul class="nofitications-dropdown">
                    <li class="dropdown head-dpdn">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="fa fa-envelope"></i><span class="badge">3</span></a>
                        <ul class="dropdown-menu">
                            <li>
                                <div class="notification_header">
                                    <h3>You have 3 new messages</h3>
                                </div>
                            </li>
                            <li><a href="#">
                                    <div class="user_img"><img src="${pageContext.request.contextPath}/images/in11.jpg" alt=""></div>
                                <div class="notification_desc">
                                    <p>Lorem ipsum dolor</p>
                                    <p><span>1 hour ago</span></p>
                                </div>
                                <div class="clearfix"></div>	
                            </a></li>
                        <li class="odd"><a href="#">
                                <div class="user_img"><img src="${pageContext.request.contextPath}/images/in10.jpg" alt=""></div>
                                <div class="notification_desc">
                                    <p>Lorem ipsum dolor </p>
                                    <p><span>1 hour ago</span></p>
                                </div>
                                <div class="clearfix"></div>	
                            </a></li>
                        <li><a href="#">
                                <div class="user_img"><img src="${pageContext.request.contextPath}/images/in9.jpg" alt=""></div>
                                <div class="notification_desc">
                                    <p>Lorem ipsum dolor</p>
                                    <p><span>1 hour ago</span></p>
                                </div>
                                <div class="clearfix"></div>	
                            </a></li>
                        <li>
                            <div class="notification_bottom">
                                <a href="#">See all messages</a>
                            </div> 
                        </li>
                    </ul>
                </li>
                <li class="dropdown head-dpdn">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="fa fa-bell"></i><span class="badge blue">3</span></a>
                    <ul class="dropdown-menu">
                        <li>
                            <div class="notification_header">
                                <h3>You have 3 new notification</h3>
                            </div>
                        </li>
                        <li><a href="#">
                                <div class="user_img"><img src="${pageContext.request.contextPath}/images/in8.jpg" alt=""></div>
                                <div class="notification_desc">
                                    <p>Lorem ipsum dolor</p>
                                    <p><span>1 hour ago</span></p>
                                </div>
                                <div class="clearfix"></div>	
                            </a></li>
                        <li class="odd"><a href="#">
                                <div class="user_img"><img src="${pageContext.request.contextPath}/images/in6.jpg" alt=""></div>
                                <div class="notification_desc">
                                    <p>Lorem ipsum dolor</p>
                                    <p><span>1 hour ago</span></p>
                                </div>
                                <div class="clearfix"></div>	
                            </a></li>
                        <li><a href="#">
                                <div class="user_img"><img src="${pageContext.request.contextPath}/images/in7.jpg" alt=""></div>
                                <div class="notification_desc">
                                    <p>Lorem ipsum dolor</p>
                                    <p><span>1 hour ago</span></p>
                                </div>
                                <div class="clearfix"></div>	
                            </a></li>
                        <li>
                            <div class="notification_bottom">
                                <a href="#">See all notifications</a>
                            </div> 
                        </li>
                    </ul>
                </li>	
                <li class="dropdown head-dpdn">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="fa fa-tasks"></i><span class="badge blue1">9</span></a>
                    <ul class="dropdown-menu">
                        <li>
                            <div class="notification_header">
                                <h3>You have 8 pending task</h3>
                            </div>
                        </li>
                        <li><a href="#">
                                <div class="task-info">
                                    <span class="task-desc">Database update</span><span class="percentage">40%</span>
                                    <div class="clearfix"></div>	
                                </div>
                                <div class="progress progress-striped active">
                                    <div class="bar yellow" style="width:40%;"></div>
                                </div>
                            </a></li>
                        <li><a href="#">
                                <div class="task-info">
                                    <span class="task-desc">Dashboard done</span><span class="percentage">90%</span>
                                    <div class="clearfix"></div>	
                                </div>
                                <div class="progress progress-striped active">
                                    <div class="bar green" style="width:90%;"></div>
                                </div>
                            </a></li>
                        <li><a href="#">
                                <div class="task-info">
                                    <span class="task-desc">Mobile App</span><span class="percentage">33%</span>
                                    <div class="clearfix"></div>	
                                </div>
                                <div class="progress progress-striped active">
                                    <div class="bar red" style="width: 33%;"></div>
                                </div>
                            </a></li>
                        <li><a href="#">
                                <div class="task-info">
                                    <span class="task-desc">Issues fixed</span><span class="percentage">80%</span>
                                    <div class="clearfix"></div>	
                                </div>
                                <div class="progress progress-striped active">
                                    <div class="bar  blue" style="width: 80%;"></div>
                                </div>
                            </a></li>
                        <li>
                            <div class="notification_bottom">
                                <a href="#">See all pending tasks</a>
                            </div> 
                        </li>
                    </ul>
                </li>	
                <div class="clearfix"> </div>
            </ul>
            <div class="clearfix"> </div>
        </div>
        <!--notification menu end -->

        <div class="clearfix"> </div>				
    </div>
    <div class="profile_details w3l">		
        <ul>

            <li class="dropdown profile_details_drop">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    <div class="profile_img">	
                        <span class="prfil-img"><img src="${pageContext.request.contextPath}/images/<s:property value="#session.AVATAR"/>" alt=""> </span> 
                        <div class="user-name">
                            <c:if test="${session.USER!=null}">
                                <p><s:property value="#session.USER"/></p>
                                <c:if test="${session.ROLE eq 3}">
                                    <span>Giáo viên</span>
                                </c:if>
                                <c:if test="${session.ROLE eq 2}">
                                    <span>Học sinh</span>
                                </c:if>
                                <c:if test="${session.ROLE eq 1}">
                                    <span>Người dùng</span>
                                </c:if>
                            </c:if>
                        </div>
                        <i class="fa fa-angle-down"></i>
                        <i class="fa fa-angle-up"></i>
                        <div class="clearfix"></div>	
                    </div>	
                </a>

                <ul class="dropdown-menu drp-mnu">
                    <!--<li> <a href="#"><i class="fa fa-cog"></i> Cài đặt</a> </li>--> 
                    <li> <a href="<s:url action="viewProfileAdm"></s:url>"><i class="fa fa-user"></i> Profile</a> </li> 
                    <li> <a href="<s:url action="logout"></s:url>"><i class="fa fa-sign-out"></i> Đăng xuất</a> </li>
                </ul>
            </li>
        </ul>
    </div>

    <div class="clearfix"> </div>	
</div>

<script>
    $(document).ready(function () {
        var navoffeset = $(".header-main").offset().top;
        $(window).scroll(function () {
            var scrollpos = $(window).scrollTop();
            if (scrollpos >= navoffeset) {
                $(".header-main").addClass("fixed");
            } else {
                $(".header-main").removeClass("fixed");
            }
        });

    });
</script>