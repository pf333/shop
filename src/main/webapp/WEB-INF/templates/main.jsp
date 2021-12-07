<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="carouselControls" class="carousel slide margin" data-ride="carousel">
    <div class="carousel-inner">
        <div class="carousel-item active item">
            <img class="d-block w-100 banner" src="https://cdn.shopify.com/s/files/1/1421/5698/files/CR7_7091b4c7-8f57-434d-8ffb-caa52f746aed_1400x.jpg?v=1616079366" alt="First slide">
        </div>
    </div>
</div>

<input type="hidden" name="searchQuery" value="${itemSearchDto.searchQuery}">
<c:if test="${!empty itemSearchDto.searchQuery}">
    <div class="center">
        <p class="h3 font-weight-bold">${itemSearchDto.searchQuery} 검색 결과</p>
    </div>
</c:if>

<div class="row">
    <c:forEach var="item" items="${items.getContent()}">
        <div class="col-md-4 margin">
            <div class="card">
                <a class="text-dark" href="/item/${item.id}">
                    <img class="card-img-top" src="${item.imgUrl}" alt="${item.itemNm}" height="400">
                    <div class="card-body">
                        <h4 class="card-title">${item.itemNm}</h4>
                        <p class="card-text">${item.itemDetail}</p>
                        <h3 class="card-title text-danger">${item.price}원</h3>
                    </div>
                </a>
            </div>
        </div>
    </c:forEach>
</div>

<c:set var="start" value="${(items.number/maxPage)*maxPage + 1}"/>
<c:set var="end" value="${(items.totalPages == 0) ? 1 : (start + (maxPage - 1) < items.totalPages ? start + (maxPage - 1) : items.totalPages)}"/>
<ul class="pagination justify-content-center">

    <li class="${items.number eq 0 ? 'page-item disabled' : 'page-item'}">
        <a class="page-link" href="/?searchQuery=${itemSearchDto.searchQuery}&page=${items.number-1}">Previous</a>
    </li>

    <c:forEach var="page" begin="${start}" end="${end}">
        <li class="${items.number eq page-1 ? 'page-item active' : 'page-item'}">
            <a class="page-link" href="/?searchQuery=${itemSearchDto.searchQuery}&page=${page-1}" inline="text">${page}</a>
        </li>
    </c:forEach>

    <li class="${items.number+1 ge items.totalPages ? 'page-item disabled' : 'page-item'}">
        <a class="page-link" href="/?searchQuery=${itemSearchDto.searchQuery}&page=${items.number+1}">Next</a>
    </li>

</ul>