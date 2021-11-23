<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<form:form action="/member/memberForm" method="post" modelAttribute="memberFormDto">
    <div class="form-group">
        <label for="name">이름</label>
        <form:input class="form-control" type="text" path="name" placeholder="이름을 입력해주세요"/>
        <form:errors class="fieldError" path="name"/>
    </div>
    <div class="form-group">
        <label for="email">이메일주소</label>
        <form:input class="form-control" type="email" path="email" placeholder="이메일을 입력해주세요"/>
        <form:errors class="fieldError" path="email"/>
    </div>
    <div class="form-group">
        <label for="password">비밀번호</label>
        <form:input class="form-control" type="password" path="password" placeholder="비밀번호 입력"/>
        <form:errors class="fieldError" path="password"/>
    </div>
    <div class="form-group">
        <label for="address">주소</label>
        <form:input class="form-control" type="text" path="address" placeholder="주소를 입력해주세요"/>
        <form:errors class="fieldError" path="address"/>
    </div>
    <div style="text-align: center">
        <button class="btn btn-primary" type="submit" style="">Submit</button>
    </div>
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
</form:form>
<script>
    $(document).ready(function(){
        var errorMessage = '${errorMessage}';
        if(errorMessage != null){
            alert(errorMessage);
        }
    });
</script>