<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Page top section -->
<section class="page-top-section set-bg"
	data-setbg="/img/page-top-bg/1.jpg">
	<div class="page-info">
		<h2>Games</h2>
		<div class="site-breadcrumb">
			<a href="">Home</a> / <span>Games</span>
		</div>
	</div>
</section>
<!-- Page top end-->
<section class="games-section">
	<div class="container">

		<div class="game-main">
			<h2>Game</h2>
			<b class="hr"></b>
			<c:if test="${count > 0}">
				<div class="col-xl-12 col-lg-12 col-md-12">
					<div class="row">
						<c:forEach var="item" items="${list}" varStatus="status">
							<div class="col-lg-2 col-md-4">
								<div class="game-item">
									<img
										onclick="location.href='${pageContext.request.contextPath}/item/item_detail?item_num=${item.item_num}'"
										src="${item.item_image}" class="card-img-top" alt="#">
									<div class="card-body">
										<h5 class="card-title">${item.item_name}</h5>
										<p class="card-text">
											순위: ${item.item_rank}위<br> 평점: ${item.item_average}점<br>
											출시연도: ${item.item_year}년
										</p>
										<a
											href="${pageContext.request.contextPath}/item/item_detail?item_num=${item.item_num}"
											class="btn btn-primary">상세보기</a>
									</div>
								</div>
							</div>
							<c:if test="${status.index % 6 == 5 && !status.last}">
					</div>
					<div class="row">
			</c:if>
			</c:forEach>
		</div>
		<div class="align-center" style="text-align: center">${page}</div>
		</c:if>

		<c:if test="${count == 0}">
			<h5>검색 결과가 없습니다.</h5>
			<hr size="1" noshade="noshade" width="100%">
		</c:if>
	</div>
</section>

<section class="games-section">
	<div class="container">
		<h2>게시글</h2>
			<b class="hr"></b>
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
							<td class="align-left"><a
								href="${pageContext.request.contextPath}/board/detail?boa_num=${board.boa_num}">${board.boa_title}(${board.re_cnt})</a></td>
							<td class="align-center"><c:if
									test="${empty board.mem_nickname}">${board.mem_email}</c:if> <c:if
									test="${!empty board.mem_nickname}">${board.mem_nickname}</c:if>
							</td>
							<td class="align-center">${board.boa_hit}</td>
							<td class="align-center">${board.fav_cnt}</td>
						</tr>
					</c:forEach>
				</table>
				<div class="align-center" style="text-align: center;">${page2}</div>
			</c:if>
		</div>
	</div>
</section>
<section class="games-section">
	<div class="container">
		<h2>중고게시판</h2>
		<b class="hr"></b>
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
							<td class="align-left"><a
								href="${pageContext.request.contextPath}/used/usedDetail?use_num=${used.use_num}">
									<c:if test="${used.use_check==1 }">
										<b>[판매중] </b>
									</c:if> <c:if test="${used.use_check==2 }">
										<b>[예약중] </b>
									</c:if> <c:if test="${used.use_check==3 }">
										<b>[판매완료] </b>
									</c:if> ${used.use_title}
							</a></td>
							<td class="align-center"><c:if test="${empty mem_nickname}">			
					${used.mem_email}
				</c:if> <c:if test="${!empty mem_nickname}">			
					${used.mem_nickname}
				</c:if></td>
							<td class="align-center">${used.item_name}</td>
							<td class="align-center">${used.use_price}</td>
						</tr>
					</c:forEach>
				</table>
				<div class="align-center" style="text-align: center;">${page3}</div>
			</c:if>
		</div>
	</div>
</section>