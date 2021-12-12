<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div style="margin-left:25%;margin-right:25%">

    <input type="hidden" id="itemId" value="${item.id}">

    <div class="d-flex">
        <div class="repImgDiv">
            <img class = "rounded repImg" src="${item.itemImgDtoList[0].imgUrl}" alt="${item.itemNm}">
        </div>
        <div class="wd50">
            <c:choose>
                <c:when test="${item.itemSellStatus eq 'SELL'}">
                    <span class="badge badge-primary mgb-15">
                        판매중
                    </span>
                </c:when>
                <c:otherwise>
                    <span class="badge btn-danger mgb-15">
                        품절
                    </span>
                </c:otherwise>
            </c:choose>
            <div class="h4">${item.itemNm}</div>
            <hr class="my-4">

            <div class="text-right">
                <div class="h4 text-danger text-left">
                    <input id="price" type="hidden" name="price" value="${item.price}">
                    <span>${item.price}원</span>
                </div>
                <div class="input-group w-50">
                    <div class="input-group-prepend">
                        <span class="input-group-text">수량</span>
                    </div>
                    <input id="count" class="form-control" type="number" name="count" value="1" min="1">
                </div>
            </div>
            <hr class="my-4">

            <div class="text-right mgt-50">
                <h5>결제 금액</h5>
                <h3 id="totalPrice" class="font-weight-bold" name="totalPrice"></h3>
            </div>
            <c:choose>
                <c:when test="${item.itemSellStatus eq 'SELL'}">
                    <div class="text-right">
                        <button class="btn btn-light border border-primary btn-lg" type="button" onclick="addCart()">장바구니 담기</button>
                        <button class="btn btn-primary btn-lg" type="button" onclick="order()">주문하기</button>
                    </div>
                </c:when>
                <c:otherwise>
                <div class="text-right">
                    <button class="btn btn-danger btn-lg" type="button">품절</button>
                </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="jumbotron jumbotron-fluid mgt-30">
        <div class="container">
            <h4 class="display-5">상품 상세 설명</h4>
            <hr class="my-4">
            <p class="lead">${item.itemDetail}</p>
        </div>
    </div>

    <c:forEach var="itemImg" items="${item.itemImgDtoList}">
        <div class="text-center">
            <c:if test="${!empty itemImg.imgUrl}">
                <img class="rounded mgb-15" src="${itemImg.imgUrl}" width="800">
            </c:if>
        </div>
    </c:forEach>

</div>
<script>
    $(document).ready(function(){

        calculateTotalPrice();

        $("#count").change(function(){
            calculateTotalPrice();
        });
    });

    function calculateTotalPrice(){
        var count = $("#count").val();
        var price = $("#price").val();
        var totalPrice = price * count;
        $("#totalPrice").html(totalPrice + '원');
    }

    function order(){
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");

        var url = '/order';
        var paramData = {
            itemId : $("#itemId").val(),
            count : $("#count").val()
        };

        var param = JSON.stringify(paramData);

        $.ajax({
            url : url,
            type : 'POST',
            contentType : 'application/json',
            data : param,
            beforeSend : function(xhr){
                /* 데이터를 전송하기 전에 헤더에 csrf 값을 설정 */
                xhr.setRequestHeader(header, token);
            },
            dataType : 'json',
            cache : false,
            success : function(result, status){
                alert('주문이 완료 되었습니다.');
                location.href='/';
            },
            error : function(jqXHR/*Fake xhr*/, status, error){
                if(jqXHR.status == '401'){
                    alert('로그인 후 이용해주세요.');
                    location.href='/member/login';
                } else{
                    alert(jqXHR.responseText);
                }
            }
        });
    }

    function addCart(){
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");

        var url = '/cart';
        var paramData = {
            itemId : $("#itemId").val(),
            count : $("#count").val()
        };

        var param = JSON.stringify(paramData);

        $.ajax({
            url : url,
            type : 'POST',
            contentType : 'application/json',
            data : param,
            beforeSend : function(xhr){
                /* 데이터를 전송하기 전에 헤더에 csrf 값을 설정 */
                xhr.setRequestHeader(header, token);
            },
            dataType : 'json',
            cache   : false,
            success  : function(result, status){
                alert('상품을 장바구니에 담았습니다.');
                location.href='/';
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