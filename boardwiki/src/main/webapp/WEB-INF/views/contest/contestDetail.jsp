<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/videoAdapter.js"></script>

<!-- Page top section -->
<section class="page-top-section set-bg"
	data-setbg="/img/page-top-bg/4.jpg">
	<div class="page-info">
		<h2>대회 신청</h2>
		<div class="site-breadcrumb">
			<a href="/main/main">Home</a> / <span>대회신청</span> /
		</div>
	</div>
</section>
<!-- Page top end-->
<section class="blog-page">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="page-main">
					<h2 class="align-center">${contest.con_name}</h2>
					<ul class="detail-info align-right">

						<li>등록일 : ${contest.con_rdate}</li>

					</ul>
					<hr size="1" width="100%">
					<div class="align-right">
						<input type="button" value="목록"
							onclick="location.href='contestList'">
						<c:if test="${!empty user && user.mem_auth == 9}">
							<input type="button" value="수정"
								onclick="location.href='contestUpdate?con_num=${contest.con_num}'">
							<input type="button" value="삭제" id="delete_btn">
							<script type="text/javascript">
                                const delete_btn = document
                                        .getElementById('delete_btn');
                                delete_btn.onclick = function() {
                                    const choice = confirm('삭제하시겠습니까?');
                                    if (choice) {
                                        location.replace('deleteContest?con_num=${contest.con_num}');
                                    }
                                }
                            </script>
						</c:if>
					</div>
					<div class="detail-content font-white">
						${contest.con_content} 대회 일정 ${contest.con_sdate} ~
						${contest.con_edate}</div>
					<p>
					<h4>참가 현황: ${conManCount} / ${contest.con_maxman}</h4>
				</div>
				<hr>
				<h4>대회 주소: ${contest.con_address1} ${contest.con_address2}</h4>
				<div id="map" style="width: 100%; height: 350px;"></div>

				<br>

				<c:if test="${!empty user}">
					<p class="align-center">
						<c:choose>
							<c:when test="${applied}">
								<input type="button" value="대회 신청 취소" id="cancel_btn">
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${conManCount >= contest.con_maxman}">
										<input type="button" value="대회신청마감" id="apply_btn"
											disabled="disabled">
									</c:when>
									<c:when test="${contest.con_status == 0}">
										<input type="button" value="대회신청" id="apply_btn">
									</c:when>
									<c:when test="${contest.con_status == 1}">
										<input type="button" value="대회진행예정" id="apply_btn" disabled="disabled"> 
									</c:when>
									<c:otherwise>
										<input type="button" value="대회신청종료" id="apply_btn" disabled="disabled">
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
					</p>
				</c:if>
			</div>
		</div>
	</div>
</section>
<script type="text/javascript">
				            document.addEventListener('DOMContentLoaded', function() {
				                const apply_btn = document.getElementById('apply_btn');
				                const cancel_btn = document.getElementById('cancel_btn');

				
				                if (apply_btn) {
				                    apply_btn.onclick = function() {
				                        const choice = confirm('대회 신청하겠습니까?');
				                        if (choice) {
				                            location.replace('contestApply?action=apply&con_num=${contest.con_num}');
				                        }
				                    }
				                }
				                if (cancel_btn) {
				                    cancel_btn.onclick = function() {
				                        const choice = confirm('대회 신청을 취소하시겠습니까?');
				                        if (choice) {
				                            location.replace('contestApply?action=cancel&con_num=${contest.con_num}');
				                        }
				                    }
				                }
				            });
</script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=77c9fa63541b3e967dfb6eb75abb22ff&libraries=services"></script>
<script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level : 3
    // 지도의 확대 레벨
    };

    // 지도를 생성합니다    
    var map = new kakao.maps.Map(mapContainer, mapOption);

    // 주소-좌표 변환 객체를 생성합니다
    var geocoder = new kakao.maps.services.Geocoder();
    var address = "${contest.con_address1}";
    // 주소로 좌표를 검색합니다
    geocoder
            .addressSearch(
                    address,
                    function(result, status) {

                        // 정상적으로 검색이 완료됐으면 
                        if (status === kakao.maps.services.Status.OK) {

                            var coords = new kakao.maps.LatLng(result[0].y,
                                    result[0].x);

                            // 결과값으로 받은 위치를 마커로 표시합니다
                            var marker = new kakao.maps.Marker({
                                map : map,
                                position : coords
                            });

                            // 인포윈도우로 장소에 대한 설명을 표시합니다
                            var infowindow = new kakao.maps.InfoWindow(
                                    {
                                        content : '<div style="width:150px;text-align:center;padding:6px 0;">대회장소</div>'
                                    });
                            infowindow.open(map, marker);

                            // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                            map.setCenter(coords);
                            map.setDraggable(false);
                            map.setZoomable(false);
                        }
                    });
</script>
