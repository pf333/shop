<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<header>
    <nav class="navbar navbar-expand-sm navbar-dark bg-dark">
      <div class="container-fluid">
        <a class="navbar-brand" href="/">Shop</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mynavbar">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="mynavbar">
          <ul class="navbar-nav me-auto">
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
          <form class="d-flex" action="/" method="get">
            <input class="form-control me-2" type="search" name="search" placeholder="Search">
            <button class="btn btn-primary" type="submit">Search</button>
          </form>
        </div>
      </div>
    </nav>
</header>