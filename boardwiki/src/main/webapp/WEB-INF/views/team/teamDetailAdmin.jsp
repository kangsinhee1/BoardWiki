<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/videoAdapter.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/teamFav.js"></script>

	<!-- Page top section -->
<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg">
	<div class="page-info">
		<h2>모임 신청</h2>
		<div class="site-breadcrumb">
			<a href="">Home</a>  /
			<span>모임신청</span> /
			<span><a href="myTeam2"> 내 모임 보기(관리자)</a></span>
		</div>
	</div>
</section>
<!-- Page top end-->
<section class="blog-page">
<div class="container">
	<div class="row">
		<div class="col-lg-12">
<div class="page-main">
	<h2 class="align-center">${team.tea_name}</h2>
		<div class="align-right">
	<ul class="detail-info">
		<li>작성자 : ${team.mem_nickname}</li>
		<li>등록일 : ${team.tea_rdate} </li>
		<li>조회수 : ${team.tea_hit}</li>
	</ul>
	</div>
	<hr size="1" width="100%">
	<div class="align-right">
	<input type="button" value="목록" onclick="location.href='teamListAdmin'">
	
	<input type="button" value="게시판" onclick="location.href='teamBoardAdmin?tea_num=${team.tea_num}'">
			<input type="button" value="삭제" id="delete_btn" class="default_btn2">
			<script type="text/javascript">
	 			const delete_btn = document.getElementById('delete_btn');
	 			delete_btn.onclick=function(){
	 				const choice = confirm('삭제하시겠습니까?');
	 				if(choice){
	 					location.replace('teamDelete?tea_num=${team.tea_num}');
	 				}
	 			}
	 		</script>
		</div>
		<div class="detail-content">${team.tea_content}</div>
		<hr>
<div class="mapsize">
<h4>모임 주소: ${team.tea_address1} ${team.tea_address2}</h4>
<div id="map" style="width:100%;height:350px;"></div>
</div>

<br>

</div>
</div>
</div>
</div>
</section>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=77c9fa63541b3e967dfb6eb75abb22ff&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();
var address = "${team.tea_address1}";
// 주소로 좌표를 검색합니다
geocoder.addressSearch(address, function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">모임위치</div>'
        });
        infowindow.open(map, marker);	

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
        map.setDraggable(false); 
        map.setZoomable(false); 
    } 
});    
</script>

