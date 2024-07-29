<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>대여 목록</title>
</head>
<body>

	<!-- 대여 목록 시작 -->
	<section class="blog-page">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<h2>대여목록</h2>
					<div class="align-center">

						<form action="rent" id="search_form" method="get">
							<input type="hidden" name="item_name" value="${param.item_name}">
							<ul class="rent_search">
								<li><select name="keyfield" id="keyfield"
									class="form-control">
										<option value="1"
											<c:if test="${param.keyfield == 1}">selected</c:if>>게임명</option>
										<option value="2"
											<c:if test="${param.keyfield == 2}">selected</c:if>>날짜</option>
										<option value="3"
											<c:if test="${param.keyfield == 3}">selected</c:if>>내용</option>
										<option value="4"
											<c:if test="${param.keyfield == 4}">selected</c:if>>제목+내용</option>
								</select></li>
								<li id="dateFields" class="date-fields" style="display: flex;">
									<input type="date" name="startDate" id="startDate"
									class="form-control" value="${param.startDate}"> <input
									type="date" name="endDate" id="endDate" class="form-control"
									value="${param.endDate}">
								</li>
								<li><input type="search" name="keyword" id="keyword"
									class="form-control" value="${param.keyword}"></li>
								<li><input type="submit" value="찾기" class="btn btn-primary">
								</li>
							</ul>
							<div class="align-right">
								<select id="order" name="order" class="form-control">
									<option value="1"
										<c:if test="${param.order == 1}">selected</c:if>>이름순</option>
									<option value="2"
										<c:if test="${param.order == 2}">selected</c:if>>대여기간</option>
									<option value="3"
										<c:if test="${param.order == 3}">selected</c:if>>대여상태</option>
								</select>
							</div>
						</form>

						<script type="text/javascript">
                    document.getElementById('order').addEventListener('change', function() {
                        document.getElementById('search_form').submit();
                    });

                    document.getElementById('keyfield').addEventListener('change', function() {
                        var keyfield = this.value;
                        var dateFields = document.getElementById('dateFields');
                        if (keyfield == '2') {
                            dateFields.style.display = 'flex';
                        } else {
                            dateFields.style.display = 'none';
                        }
                    });
                </script>

						<c:if test="${count == 0}">
							<div class="alert alert-info mt-3">표시할 대여 목록이 없습니다.</div>
						</c:if>
						<c:if test="${count > 0}">
							<div class="chart-table">
								<table>
									<thead>
										<tr>
											<th>대여번호</th>
											<th>보드게임명</th>
											<th>대여시작일</th>
											<th>대여종료일</th>
											<th>대여기간</th>
											<th>대출/반납</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="rent" items="${list}">
											<tr>
												<td>${rent.rent_num}</td>
												<td>${rent.item_name}</td>
												<td>${rent.rent_sdate}</td>
												<td>${rent.rent_edate}</td>
												<td>${rent.rent_period}</td>
												<td><c:choose>
														<c:when test="${rent.rent_status == 1}">
															<a
																href="${pageContext.request.contextPath}/rent/return?rent_num=${rent.rent_num}"
																onclick="return confirm('반납하시겠습니까?');">대여중</a>
														</c:when>
														<c:when test="${rent.rent_status == 2}">반납</c:when>
														<c:otherwise>상태 불명</c:otherwise>
													</c:choose></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<div class="align-center">
								<div class="blog-pagination">${page}</div>
							</div>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- 대여 목록 끝 -->
</body>
</html>
