<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h3>게임</h3>
<div>
<c:if test="${count>0 }">
    <div class="small-name">
    <c:forEach var="item" items="${list}">
        <div class="big-box" style="display:inline-block;vertical-align:top;">
        <div class="image-box" style="display:inline-block;vertical-align:top;">
            <img onclick="location.href='${pageContext.request.contextPath}/item/item_detail?item_num=${item.item_num}'" src="${item.item_image}" width="180" height="180">
        </div>
        <div class="text-box" style="display:inline-block;vertical-align:top;"
             onclick="location.href='${pageContext.request.contextPath}/item/item_detail?item_num=${item.item_num}'">
            <a class="name">${item.item_name}</a><br>
            <a>순위:${item.item_rank}위</a><br>
            <a>평점:${item.item_average}점</a><br>
            <a>출시연도:${item.item_year}년</a>
        </div>
        </div>
    </c:forEach>
    </div>
    <div class="align-center">${page}</div>
	</c:if>
	<c:if test="${count==0 }">
	<h5>검색 결과가 없습니다.</h5>
	</c:if>
</div>
<h3>게시글</h3>
<div>
<c:if test="${count2==0}">
	<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count2 > 0}">
	<table class="striped-table">
		<tr>
			<th>번호</th>
			<th width="400">제목</th>
			<th>작성자</th>
			<th>조회수</th>
			<th>좋아요수</th>
		</tr>
		<c:forEach var="board" items="${list2}">
		<tr>
			<td class="align-center">${board.boa_num}</td>
			<td class="align-left"><a href="detail?boa_num=${board.boa_num}">${board.boa_title}(${board.re_cnt})</a></td>
			<td class="align-center">
				<c:if test="${empty board.mem_nickname}">${board.mem_email}</c:if>
				<c:if test="${!empty board.mem_nickname}">${board.mem_nickname}</c:if>
			</td>
			<td class="align-center">${board.boa_hit}</td>
			<td class="align-center">${board.fav_cnt}</td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page2}</div>
	</c:if>
</div>
<h3>중고게시판</h3>
<div>
<c:if test="${count3 == 0}">
	<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count3 > 0}">
	<table class="striped-table">
		<tr>
			<th>번호</th>
			<th width="400">제목</th>
			<th>작성자</th>
			<th>제품명</th>
			<th>가격</th>
		</tr>
		<c:forEach var="used" items="${list3}">
		<tr>
			<td class="align-center">${used.use_num}</td>
			<td class="align-left">
			<a href="usedDetail?use_num=${used.use_num}">
			<c:if test="${used.use_check==1 }"><b>[판매중] </b></c:if>
			<c:if test="${used.use_check==2 }"><b>[예약중] </b></c:if>
			<c:if test="${used.use_check==3 }"><b>[판매완료] </b></c:if>
			${used.use_title}
			</a></td>
			<td class="align-center">
				<c:if test="${empty mem_nickname}">			
					${used.mem_email}
				</c:if>
				<c:if test="${!empty mem_nickname}">			
					${used.mem_nickname}
				</c:if>
			</td>
			<td class="align-center">${used.item_name}</td>
			<td class="align-center">${used.use_price}</td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page3}</div>
	</c:if>	
	
</div>