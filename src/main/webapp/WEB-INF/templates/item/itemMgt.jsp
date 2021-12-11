<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<form:form action="/admin/items/${items.number}" method="get" modelAttribute="itemSearchDto">
    <table class="table">
        <thead>
        <tr>
            <td>상품아이디</td>
            <td>상품명</td>
            <td>상태</td>
            <td>등록자</td>
            <td>등록일</td>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${items.getContent()}">
            <tr>
                <td>${item.id}</td>
                <td>
                    <a href="/admin/itemForm/${item.id}">${item.itemNm}</a>
                </td>
                <td>${item.itemSellStatus eq 'SELL' ? '판매중' : '품절'}</td>
                <td>${item.createdBy}</td>
                <td>${item.regTime}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <c:set var="start" value="${(items.number/maxPage)*maxPage + 1}"/>
    <c:set var="end" value="${(items.totalPages == 0) ? 1 : (start + (maxPage - 1) < items.totalPages ? start + (maxPage - 1) : items.totalPages)}"/>
    <ul class="pagination justify-content-center">

        <li class="${items.first ? 'page-item disabled' : 'page-item'}">
            <a class="page-link" onclick="page(${items.number - 1})">Previous</a>
        </li>

        <c:forEach var="page" begin="${start}" end="${end}">
            <li class="${items.number eq page-1 ? 'page-item active' : 'page-item'}">
                <a class="page-link" onclick="page(${page - 1})" inline="text">${page}</a>
            </li>
        </c:forEach>

        <li class="${items.last ? 'page-item disabled' : 'page-item'}">
            <a class="page-link" onclick="page(${items.number + 1})">Next</a>
        </li>

    </ul>

    <div class="form-inline justify-content-center">
        <form:select class="form-control" style="width:auto;" path="searchDateType">
            <form:option value="all">전체기간</form:option>
            <form:option value="1d">1일</form:option>
            <form:option value="1w">1주</form:option>
            <form:option value="1m">1개월</form:option>
            <form:option value="6m">6개월</form:option>
        </form:select>
        <form:select class="form-control" style="width:auto;" path="searchSellStatus">
            <form:option value="">판매상태(전체)</form:option>
            <form:option value="SELL">판매</form:option>
            <form:option value="SOLD_OUT">품절</form:option>
        </form:select>
        <form:select class="form-control" style="width:auto;" path="searchBy">
            <form:option value="itemNm">상품명</form:option>
            <form:option value="createdBy">등록자</form:option>
        </form:select>
        <form:input class="form-control" type="text" path="searchQuery" placeholder="검색어를 입력해주세요"/>
        <button id="searchBtn" class="btn btn-primary" type="submit">검색</button>
    </div>
</form:form>
<script>
    $(document).ready(function(){
        $("#searchBtn").on("click",function(e) {
            e.preventDefault();
            page(0);
        });
    });

    function page(page){
        var searchDateType = $("#searchDateType").val();
        var searchSellStatus = $("#searchSellStatus").val();
        var searchBy = $("#searchBy").val();
        var searchQuery = $("#searchQuery").val();

        location.href='/admin/itemMgt/' + page + '?searchDateType=' + searchDateType
        + '&searchSellStatus=' + searchSellStatus
        + '&searchBy=' + searchBy
        + '&searchQuery=' + searchQuery;
    }
</script>