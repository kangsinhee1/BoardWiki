<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/item.css" type="text/css">
<!-- 상단 시작 -->
<input type="hidden" name="keyfield" id="keyfield" value="1">

<section class="custom-games-section">
<div class="container down-header">
<div id="button-group">
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('') }">selected</c:if>" value="" <c:if test="${param.keyword.equals('') }"> disabled="disabled"</c:if>>ALL</button>
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('격투') }">selected</c:if>" value="격투" <c:if test="${param.keyword.equals('격투') }"> disabled="disabled"</c:if>>격투</button>
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('경제') }">selected</c:if>" value="경제" <c:if test="${param.keyword.equals('경제') }"> disabled="disabled"</c:if>>경제</button>
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('고대') }">selected</c:if>" value="고대" <c:if test="${param.keyword.equals('고대') }"> disabled="disabled"</c:if>>고대</button>
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('도시 건설') }">selected</c:if>" value="도시 건설" <c:if test="${param.keyword.equals('도시 건설') }"> disabled="disabled"</c:if>>도시 건설</button>
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('공포') }">selected</c:if>" value="공포" <c:if test="${param.keyword.equals('공포') }"> disabled="disabled"</c:if>>공포</button>
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('교육') }">selected</c:if>" value="교육" <c:if test="${param.keyword.equals('교육') }"> disabled="disabled"</c:if>>교육</button>
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('동물') }">selected</c:if>" value="동물" <c:if test="${param.keyword.equals('동물') }"> disabled="disabled"</c:if>>동물</button>
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('모험') }">selected</c:if>" value="모험" <c:if test="${param.keyword.equals('모험') }"> disabled="disabled"</c:if>>모험</button>
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('문명') }">selected</c:if>" value="문명" <c:if test="${param.keyword.equals('문명') }"> disabled="disabled"</c:if>>문명</button>
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('미국 서부') }">selected</c:if>" value="미국 서부" <c:if test="${param.keyword.equals('미국 서부') }"> disabled="disabled"</c:if>>미국 서부</button>
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('미니어처') }">selected</c:if>" value="미니어처" <c:if test="${param.keyword.equals('미니어처') }"> disabled="disabled"</c:if>>미니어처</button>
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('산업/제조') }">selected</c:if>" value="산업/제조" <c:if test="${param.keyword.equals('산업/제조') }"> disabled="disabled"</c:if>>산업/제조</button>
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('소설 기반') }">selected</c:if>" value="소설 기반" <c:if test="${param.keyword.equals('소설 기반') }"> disabled="disabled"</c:if>>소설 기반</button>
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('수집품') }">selected</c:if>" value="수집품" <c:if test="${param.keyword.equals('수집품') }"> disabled="disabled"</c:if>>수집품</button>
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('신화') }">selected</c:if>" value="신화" <c:if test="${param.keyword.equals('신화') }"> disabled="disabled"</c:if>>신화</button>
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('여행') }">selected</c:if>" value="여행" <c:if test="${param.keyword.equals('여행') }"> disabled="disabled"</c:if>>여행</button>
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('영토 건설') }">selected</c:if>" value="영토 건설" <c:if test="${param.keyword.equals('영토 건설') }"> disabled="disabled"</c:if>>영토 건설</button>
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('영화') }">selected</c:if>" value="영화" <c:if test="${param.keyword.equals('영화') }"> disabled="disabled"</c:if>>영화</button>
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('우주 탐험') }">selected</c:if>" value="우주 탐험" <c:if test="${param.keyword.equals('우주 탐험') }"> disabled="disabled"</c:if>>우주 탐험</button>
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('운송') }">selected</c:if>" value="운송" <c:if test="${param.keyword.equals('운송') }"> disabled="disabled"</c:if>>운송</button>
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('전쟁 게임') }">selected</c:if>" value="전쟁 게임" <c:if test="${param.keyword.equals('전쟁 게임') }"> disabled="disabled"</c:if>>전쟁 게임</button>
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('정치') }">selected</c:if>" value="정치" <c:if test="${param.keyword.equals('정치') }"> disabled="disabled"</c:if>>정치</button>
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('중세') }">selected</c:if>" value="중세" <c:if test="${param.keyword.equals('중세') }"> disabled="disabled"</c:if>>중세</button>
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('추리') }">selected</c:if>" value="추리" <c:if test="${param.keyword.equals('추리') }"> disabled="disabled"</c:if>>추리</button>
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('카드게임') }">selected</c:if>" value="카드게임" <c:if test="${param.keyword.equals('카드게임') }"> disabled="disabled"</c:if>>카드게임</button>
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('판타지') }">selected</c:if>" value="판타지" <c:if test="${param.keyword.equals('판타지') }"> disabled="disabled"</c:if>>판타지</button>
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('파이터') }">selected</c:if>" value="파이터" <c:if test="${param.keyword.equals('파이터') }"> disabled="disabled"</c:if>>파이터</button>
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('퍼즐') }">selected</c:if>" value="퍼즐" <c:if test="${param.keyword.equals('퍼즐') }"> disabled="disabled"</c:if>>퍼즐</button>
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('항해') }">selected</c:if>" value="항해" <c:if test="${param.keyword.equals('항해') }"> disabled="disabled"</c:if>>항해</button>
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('현대전') }">selected</c:if>" value="현대전" <c:if test="${param.keyword.equals('현대전') }"> disabled="disabled"</c:if>>현대전</button>
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('협상') }">selected</c:if>" value="협상" <c:if test="${param.keyword.equals('협상') }"> disabled="disabled"</c:if>>협상</button>
	<button type="button" class="custom-btn-success <c:if test="${param.keyword.equals('SF') }">selected</c:if>" value="SF" <c:if test="${param.keyword.equals('SF') }"> disabled="disabled"</c:if>>SF</button>
	<select id="order" name="order" style="float:right; margin-right:30px;">
		<option value="1"<c:if test="${param.order == 1}">selected</c:if>>인기순</option>
		<option value="2"<c:if test="${param.order == 2}">selected</c:if>>평점순</option>
		<option value="3"<c:if test="${param.order == 3}">selected</c:if>>신작순</option>
	</select>
	
</div>
</div>

<script type="text/javascript">
	$('.custom-btn-success').click(function(){
		location.href='item_main?keyfield='
				         +$('#keyfield').val()+'&keyword='
				         +$(this).val()+'&order='
				         +$('#order').val();
	});

</script>
</section>
<!-- 상단 끝 -->





