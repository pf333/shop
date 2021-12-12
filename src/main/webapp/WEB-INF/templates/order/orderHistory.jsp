<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="content-mg">

    <h2 class="mb-4">
        주문 내역
    </h2>

    <c:forEach var="order" items="${orders.getContent()}">

        <div class="d-flex mb-3 align-self-center">
            <h4>${order.orderDate} 주문</h4>
            <div class="ml-3">
                <c:choose>
                    <c:when test="${order.orderStatus eq 'ORDER'}">
                        <button class="btn btn-outline-secondary" type="button" value="${order.orderId}" onclick="cancelOrder(this.value)">주문 취소</button>
                    </c:when>
                    <c:otherwise>
                        <h4>(취소 완료)</h4>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <div class="card d-flex">
            <c:forEach var="orderItem" items="${order.orderItemDtoList}">
                <div class="d-flex mb-3">
                    <div class="repImgDiv">
                        <img class = "rounded repImg" src="${orderItem.imgUrl}" alt="${orderItem.itemNm}">
                    </div>
                    <div class="align-self-center w-75">
                        <span class="fs24 font-weight-bold">${orderItem.itemNm}</span>
                        <hr/>
                        <div class="fs18 font-weight-light">
                            <span>주문 금액: ${orderItem.orderPrice}원 * ${orderItem.count}개 = ${orderItem.orderPrice * orderItem.count}원</span>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

    </c:forEach>

    <c:set var="start" value="${(orders.number/maxPage)*maxPage + 1}"/>
    <c:set var="end" value="${(orders.totalPages == 0) ? 1 : (start + (maxPage - 1) < orders.totalPages ? start + (maxPage - 1) : orders.totalPages)}"/>
    <ul class="pagination justify-content-center">

        <li class="${orders.number eq 0 ? 'page-item disabled' : 'page-item'}">
            <a class="page-link" href="/order/${orders.number-1}">Previous</a>
        </li>

        <c:forEach var="page" begin="${start}" end="${end}">
            <li class="${orders.number eq page - 1 ? 'page-item active' : 'page-item'}">
                <a class="page-link" href="/order/${page - 1}" inline="text">${page}</a>
            </li>
        </c:forEach>

        <li class="${orders.number+1 ge orders.totalPages ? 'page-item disabled' : 'page-item'}">
            <a class="page-link" href="/order/${orders.number + 1}">Next</a>
        </li>

    </ul>

</div>
<script>
    function cancelOrder(orderId) {
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");

        var url = '/order/' + orderId + '/cancel';
        var paramData = {
            orderId : orderId,
        };

        var param = JSON.stringify(paramData);

        $.ajax({
            url      : url,
            type     : 'POST',
            contentType : 'application/json',
            data     : param,
            beforeSend : function(xhr){
                /* 데이터를 전송하기 전에 헤더에 csrf값을 설정 */
                xhr.setRequestHeader(header, token);
            },
            dataType : 'json',
            cache   : false,
            success  : function(result, status){
                alert('주문이 취소 되었습니다.');
                location.href='/order/' + '${page}';
            },
            error : function(jqXHR, status, error){
                if(jqXHR.status == '401'){
                    alert('로그인 후 이용해주세요.');
                    location.href='/member/login';
                } else{
                    alert(jqXHR.responseText);
                }
            }
        });
    }
</script>