<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/item.css" type="text/css">
<!-- 상단 시작 -->
<input type="hidden" name="keyfield" id="keyfield" value="1">

<section class="custom-games-section">
<div class="container down-header">
<div id="button-group">
	<button type="button" class="custom-btn-success" value="">ALL</button>
	<button type="button" class="custom-btn-success" value="격투">격투</button>
	<button type="button" class="custom-btn-success" value="경제">경제</button>
	<button type="button" class="custom-btn-success" value="고대">고대</button>
	<button type="button" class="custom-btn-success" value="도시 건설">도시 건설</button>
	<button type="button" class="custom-btn-success" value="공포">공포</button>
	<button type="button" class="custom-btn-success" value="교육">교육</button>
	<button type="button" class="custom-btn-success" value="동물">동물</button>
	<button type="button" class="custom-btn-success" value="모험">모험</button>
	<button type="button" class="custom-btn-success" value="문명">문명</button>
	<button type="button" class="custom-btn-success" value="미국 서부">미국 서부</button>
	<button type="button" class="custom-btn-success" value="미니어처">미니어처</button>
	<button type="button" class="custom-btn-success" value="산업/제조">산업/제조</button>
	<button type="button" class="custom-btn-success" value="소설 기반">소설 기반</button>
	<button type="button" class="custom-btn-success" value="수집품">수집품</button>
	<button type="button" class="custom-btn-success" value="신화">신화</button>
	<button type="button" class="custom-btn-success" value="여행">여행</button>
	<button type="button" class="custom-btn-success" value="영토 건설">영토 건설</button>
	<button type="button" class="custom-btn-success" value="영화">영화</button>
	<button type="button" class="custom-btn-success" value="우주 탐험">우주 탐험</button>
	<button type="button" class="custom-btn-success" value="운송">운송</button>
	<button type="button" class="custom-btn-success" value="전쟁 게임">전쟁 게임</button>
	<button type="button" class="custom-btn-success" value="정치">정치</button>
	<button type="button" class="custom-btn-success" value="중세">중세</button>
	<button type="button" class="custom-btn-success" value="추리">추리</button>
	<button type="button" class="custom-btn-success" value="카드게임">카드게임</button>
	<button type="button" class="custom-btn-success" value="판타지">판타지</button>
	<button type="button" class="custom-btn-success" value="파이터">파이터</button>
	<button type="button" class="custom-btn-success" value="퍼즐">퍼즐</button>
	<button type="button" class="custom-btn-success" value="항해">항해</button>
	<button type="button" class="custom-btn-success" value="현대전">현대전</button>
	<button type="button" class="custom-btn-success" value="협상">협상</button>
	<button type="button" class="custom-btn-success" value="SF">SF</button>
	<button type="button" class="custom-btn-success" value="없을떄">없을떄</button>
	
</div>
<select id="order" name="order">
	<option value="1"<c:if test="${param.order == 1}">selected</c:if>>인기순</option>
	<option value="2"<c:if test="${param.order == 2}">selected</c:if>>평점순</option>
	<option value="3"<c:if test="${param.order == 3}">selected</c:if>>신작순</option>
</select>
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





