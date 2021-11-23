<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<form action="/member/login" method="post">
    <div class="form-group">
      <label for="email">이메일주소</label>
      <input class="form-control" id="email" type="email" name="email" placeholder="이메일을 입력해주세요">
    </div>
    <div class="form-group">
      <label for="password">비밀번호</label>
      <input class="form-control" id="password" type="password" name="password" placeholder="비밀번호 입력">
    </div>
    <c:if test="${!empty loginErrorMsg}">
        <p class="error">${loginErrorMsg}</p>
    </c:if>
    <button class="btn btn-primary">로그인</button>
    <button class="btn btn-primary" type="button" onClick="location.href='/member/memberForm'">회원가입</button>
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
</form>