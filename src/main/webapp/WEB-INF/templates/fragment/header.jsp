<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<header>
    <nav class="navbar navbar-expand-sm navbar-dark bg-dark">
        <button class="navbar-toggler" type="button" data-toggle="collapse"
                data-target="#navbarTogglerDemo03" aria-controls="navbarTogglerDemo03"
                aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <a class="navbar-brand" href="/">Shop</a>

        <div class="collapse navbar-collapse" id="navbarTogglerDemo03">
            <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
                <sec:authorize access="hasRole('ADMIN')">
                    <li class="nav-item">
                        <a class="nav-link" href="/admin/itemForm">상품 등록</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/admin/itemMgt">상품 관리</a>
                    </li>
                </sec:authorize>
                <sec:authorize access="isAuthenticated()">
                    <li class="nav-item">
                        <a class="nav-link" href="/cart">장바구니</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/order">주문 내역</a>
                    </li>
                </sec:authorize>
                <sec:authorize access="isAnonymous()">
                    <li class="nav-item" sec:authorize="()">
                        <a class="nav-link" href="/member/login">로그인</a>
                    </li>
                </sec:authorize>
                <sec:authorize access="isAuthenticated()">
                    <li class="nav-item">
                        <a class="nav-link" href="/member/logout">로그아웃</a>
                    </li>
                </sec:authorize>
            </ul>
            <form class="form-inline my-2 my-lg-0" action="/" method="get">
                <input class="form-control mr-sm-2" type="search" name="searchQuery" placeholder="Search">
                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
            </form>
        </div>
    </nav>
</header>