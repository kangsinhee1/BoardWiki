<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="page-main">

<h2>신고목록(관리자)</h2>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<section class="blog-page">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="page-main">
					<c:if test="${count==0}">
						<div class="result-display">표시할 신고가 없습니다.</div>
					</c:if>
					<c:if test="${count > 0}">
						<div class="chart-table">
							<table>
								<tr>
									<th>번호</th>
									<th>신고내용</th>
									<th>신고자</th>
									<th>신고발생지</th>
									<th>신고유형</th>
								</tr>
								<c:forEach var="report" items="${list}">
									<tr>
										<td class="align-center">${report.report_num}</td>
										<td class="align-left"><a
											href="${pageContext.request.contextPath}/adminPage/reportDetail?report_type=${report.report_type}&report_typeDetail=${report.report_typeDetail}&report_num=${report.report_num}">${report.report_content}</a>
										</td>
										<td class="align-center">${report.mem_nickName}</td>
										<td class="align-center"><c:if
												test="${report.report_type==1}">자유게시판</c:if> <c:if
												test="${report.report_type==5}">중고게시판</c:if> <c:if
												test="${report.report_type==6}">모임게시판</c:if> <c:if
												test="${report.report_type==7}">팁/후기게시판</c:if></td>
										<td class="align-center"><c:if
												test="${report.report_category == 1}">욕설/혐오/차별표현</c:if> <c:if
												test="${report.report_category == 2}">부적절한 게시물</c:if> <c:if
												test="${report.report_category == 3}">불법정보를 포함</c:if> <c:if
												test="${report.report_category == 4}">도배/스팸</c:if></td>
									</tr>
								</c:forEach>
							</table>
						</div>
						<div class="align-center">${page}</div>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</section>
</div>