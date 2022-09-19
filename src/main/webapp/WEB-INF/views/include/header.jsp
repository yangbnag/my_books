<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- header -->
<header>
    <div id="header-container">
        <div id="inner-header">

            <h1><img src="/img/ibini_logo_4.png" alt=""></h1>

                    <a href="#" class="menu-open">
                        <c:if test="${loginUser.auth == 'COMMON'}">
                            <span class="user-name">${loginUser.userName} 님</span>
                        </c:if>
                        <c:if test="${loginUser.auth == 'ADMIN'}">
                            <span style="text-align: center;">관리자 페이지 입니다.</span>
                            <span class="user-name">[${loginUser.userName}] 님</span>
                        </c:if>
                        <span class="fas fa-bars"></span>
                    </a>

        </div> <!-- // end inner-header -->

        <nav class="gnb">
                            <a href="#" class="menu-close"><span class="far fa-window-close"></span></a>
                            <!-- 일반회원이 보는 헤드 메뉴 -->
                            <c:if test="${loginUser.auth == 'COMMON' || empty loginUser}">
                                <ul>
                                    <li><a href="#">메뉴1</a></li>
                                    <li><a href="/myPage">마이페이지(현정)</a></li>

                                    <li><a href="/list">포스트 전체 목록</a></li>
                                    <li><a href="/post/write">새 포스트 쓰기</a></li>

                                    <c:if test="${loginUser == null}">
                                        <li><a href="/member/sign-in">로그인</a></li>
                                        <li> <a href="/member/sign-up">회원가입</a></li>
                                    </c:if>

                                    <c:if test="${loginUser != null}">
                                        <li> <a href="/member/my-info">내 정보</a></li>
                                        <li><a href="/member/inquiry?userId=${loginUser.userId}">문의하기</a></li>
                                        <li><a href="/member/sign-out">로그아웃</a></li>
                                    </c:if>
                                </ul>
                            </c:if>

                            <!-- 관리자가 보는 헤드 메뉴 -->
                            <c:if test="${loginUser.auth == 'ADMIN'}">
                                <ul>
                                    <li><a href="#">관리자메뉴</a></li>
                                    <li><a href="/member/admin/findall-inquiry">문의하기</a></li>

                                    <c:if test="${loginUser != null}">
                                        <li><a href="/member/sign-out">로그아웃</a></li>
                                    </c:if>
                                </ul>
                            </c:if>

                        </nav> <!-- // end nav -->
            </div> <!-- // end header-container -->
</header> <!-- end header -->