<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<form:form method="post" enctype="multipart/form-data" modelAttribute="itemFormDto">

    <p class="h2">
        상품 등록
    </p>

    <form:input type="hidden" path="id"/>

    <div class="form-group">
        <form:select class="custom-select" path="itemSellStatus">
            <form:option value="SELL">판매중</form:option>
            <form:option value="SOLD_OUT">품절</form:option>
        </form:select>
    </div>

    <div class="input-group">
        <div class="input-group-prepend">
            <span class="input-group-text">상품명</span>
        </div>
        <form:input class="form-control" type="text" path="itemNm" placeholder="상품명을 입력해주세요"/>
    </div>
    <form:errors class="fieldError" path="itemNm"/>

    <div class="input-group">
        <div class="input-group-prepend">
            <span class="input-group-text">가격</span>
        </div>
        <form:input class="form-control" type="number" path="price" placeholder="상품의 가격을 입력해주세요"/>
    </div>
    <form:errors class="fieldError" path="price"/>

    <div class="input-group">
        <div class="input-group-prepend">
            <span class="input-group-text">재고</span>
        </div>
        <form:input class="form-control" type="number" path="stockNumber" placeholder="상품의 재고를 입력해주세요"/>
    </div>
    <form:errors class="fieldError" path="stockNumber"/>

    <div class="input-group">
        <div class="input-group-prepend">
            <span class="input-group-text">상품 상세 내용</span>
        </div>
        <form:textarea class="form-control" path="itemDetail"/>
    </div>
    <form:errors class="fieldError" path="itemDetail"/>

    <c:if test="${empty itemFormDto.itemImgDtoList}">
        <c:forTokens var="num" items="1,2,3,4,5" delims=",">
            <div class="form-group">
                <div class="custom-file img-div">
                    <input class="custom-file-input" type="file" name="itemImgFile">
                    <label class="custom-file-label">상품이미지 ${num}</label>
                </div>
            </div>
        </c:forTokens>
    </c:if>

    <c:if test="${!empty itemFormDto.itemImgDtoList}">
        <c:forEach var="itemImgDto" items="${itemFormDto.itemImgDtoList}" varStatus="status">
            <div class="form-group">
                <div class="custom-file img-div">
                    <input class="custom-file-input" type="file" name="itemImgFile">
                    <input type="hidden" name="itemImgIds" value="${itemImgDto.id}">
                    <label class="custom-file-label">
                        <c:choose>
                            <c:when test="${!empty itemImgDto.oriImgName}">
                                ${itemImgDto.oriImgName}
                            </c:when>
                            <c:otherwise>
                                상품이미지 ${status.index+1}
                            </c:otherwise>
                        </c:choose>
                    </label>
                </div>
            </div>
        </c:forEach>
    </c:if>

    <c:choose>
        <c:when test="${empty itemFormDto.id}">
            <div style="text-align: center">
                <button formaction="/admin/itemForm" class="btn btn-primary" type="submit">저장</button>
            </div>
        </c:when>
        <c:otherwise>
            <div style="text-align: center">
                <button formaction="/admin/itemForm/${itemFormDto.id}" class="btn btn-primary" type="submit">수정</button>
            </div>
        </c:otherwise>
    </c:choose>
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

</form:form>
<script>
    $(document).ready(function(){
        var errorMessage = '${errorMessage}';
        if(errorMessage != ''){
            alert(errorMessage);
        }

        bindDomEvent();

    });

    function bindDomEvent(){
        $(".custom-file-input").on("change", function() {
            var fileName = $(this).val().split("\\").pop();  //이미지 파일명
            var fileExt = fileName.substring(fileName.lastIndexOf(".")+1); // 확장자 추출
            fileExt = fileExt.toLowerCase(); //소문자 변환

            if(fileExt != "jpg" && fileExt != "jpeg" && fileExt != "gif" && fileExt != "png" && fileExt != "bmp"){
                alert("이미지 파일만 등록이 가능합니다.");
                return;
            }

            $(this).siblings(".custom-file-label").html(fileName);
        });
    }
</script>