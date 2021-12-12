<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="content-mg">

    <h2 class="mb-4">
        장바구니 목록
    </h2>

    <div>

        <table class="table">
            <colgroup>
                <col width="20%"/>
                <col width="55%"/>
                <col width="15%"/>
                <col width="10%"/>
            </colgroup>
            <thead>
            <tr class="text-center">
                <td>
                    <input id="checkall" type="checkbox" onclick="checkAll()">전체선택
                </td>
                <td>상품정보</td>
                <td>상품금액</td>
                <td>삭제</td>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="cartItem" items="${cartItems}">
                <tr>
                    <td class="text-center align-middle">
                        <input type="checkbox" name="cartChkBox" value="${cartItem.cartItemId}">
                    </td>
                    <td class="d-flex">
                        <div class="repImgDiv align-self-center">
                            <img class = "rounded repImg" src="${cartItem.imgUrl}" alt="${cartItem.itemNm}">
                        </div>
                        <div class="align-self-center">
                            <span class="fs24 font-weight-bold">${cartItem.itemNm}</span>
                            <hr/>
                            <div class="fs18 font-weight-light">
                                <span class="input-group mt-2">
                                    <span id="price_${cartItem.cartItemId}" class="align-self-center mr-2" data-price="${cartItem.price}">
                                        ${cartItem.price}원
                                    </span>
                                    <span class="input-group w-50">
                                        <input id="count_${cartItem.cartItemId}" class="form-control" type="number" name="count" value="${cartItem.count}" min="1" onchange="changeCount(this)">
                                        <span class="input-group-prepend">
                                            <span class="input-group-text">개</span>
                                        </span>
                                    </span>
                                </span>
                            </div>
                        </div>
                    </td>
                    <td class="text-center align-middle">
                        <span id="totalPrice_${cartItem.cartItemId}" name="totalPrice">
                            ${cartItem.price * cartItem.count}원
                        </span>
                    </td>
                    <td class="text-center align-middle">
                        <button class="close" type="button">
                            <span data-id="${cartItem.cartItemId}" onclick="deleteCartItem(this)">&times;</span>
                        </button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <h2 class="text-center">
            총 주문 금액 : <span id="orderTotalPrice" class="text-danger">0원</span>
        </h2>

        <div class="text-center mt-3">
            <button type="button" class="btn btn-primary btn-lg" onclick="orders()">주문하기</button>
        </div>

    </div>

</div>
<script>
    $(document).ready(function(){
        $("input[name=cartChkBox]").change(function(){
            getOrderTotalPrice();
        });
    });

    function getOrderTotalPrice(){
        var orderTotalPrice = 0;
        $("input[name=cartChkBox]:checked").each(function() {
            var cartItemId = $(this).val();
            var price = $("#price_" + cartItemId).attr("data-price");
            var count = $("#count_" + cartItemId).val();
            orderTotalPrice += price * count;
        });

        $("#orderTotalPrice").html(orderTotalPrice + '원');
    }

    function changeCount(obj){
        var count = obj.value;
        var cartItemId = obj.id.split('_')[1];
        var price = $("#price_" + cartItemId).data("price");
        var totalPrice = count * price;
        $("#totalPrice_" + cartItemId).html(totalPrice + '원');
        getOrderTotalPrice();
        updateCartItemCount(cartItemId, count);
    }

    function checkAll(){
        if($("#checkall").prop("checked")){
            $("input[name=cartChkBox]").prop("checked",true);
        }else{
            $("input[name=cartChkBox]").prop("checked",false);
        }
        getOrderTotalPrice();
    }

    function updateCartItemCount(cartItemId, count){
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");

        var url = '/cartItem/' + cartItemId+ '?count=' + count;

        $.ajax({
            url : url,
            type : 'PATCH',
            beforeSend : function(xhr){
                /* 데이터를 전송하기 전에 헤더에 csrf 값을 설정 */
                xhr.setRequestHeader(header, token);
            },
            dataType : 'json',
            cache : false,
            success : function(result, status){
                console.log('cartItem count update success');
            },
            error : function(jqXHR, status, error){

                if(jqXHR.status == '401'){
                    alert('로그인 후 이용해주세요.');
                    location.href='/member/login';
                } else{
                    alert(jqXHR.responseJSON.message);
                }

            }
        });
    }

    function deleteCartItem(obj){
        var cartItemId = obj.dataset.id;
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");

        var url = '/cartItem/' + cartItemId;

        $.ajax({
            url : url,
            type : 'DELETE',
            beforeSend : function(xhr){
                /* 데이터를 전송하기 전에 헤더에 csrf 값을 설정 */
                xhr.setRequestHeader(header, token);
            },
            dataType : 'json',
            cache : false,
            success : function(result, status){
                location.href='/cart';
            },
            error : function(jqXHR, status, error){

                if(jqXHR.status == '401'){
                    alert('로그인 후 이용해주세요.');
                    location.href='/member/login';
                } else{
                    alert(jqXHR.responseJSON.message);
                }

            }
        });
    }

    function orders(){
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");

        var url = '/cart/order';

        var dataList = new Array();
        var paramData = new Object();

        $("input[name=cartChkBox]:checked").each(function() {
            var cartItemId = $(this).val();
            var data = new Object();
            data['cartItemId'] = cartItemId;
            dataList.push(data);
        });

        paramData['cartOrderDtoList'] = dataList;

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
                location.href='/order';
            },
            error : function(jqXHR, status, error){

                if(jqXHR.status == '401'){
                    alert('로그인 후 이용해주세요.');
                    location.href='/member/login';
                } else{
                    alert(jqXHR.responseJSON.message);
                }

            }
        });
    }
</script>