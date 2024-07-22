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
			<span><a href="myTeam2"> 내 모임 보기</a></span>
		</div>
	</div>
</section>
<!-- Page top end-->
<section class="blog-page">
<div class="container">
	<div class="row">
		<div class="col-lg-12">
<div class="page-main">
	<h2 class="">${team.tea_name}</h2>
	<ul class="detail-info">
		<li>작성자 : ${team.mem_nickname}</li>
		<li>등록일 : ${team.tea_rdate} </li>
		<li>조회수 : ${team.tea_hit}</li>
	</ul>
		<%--좋아요 --%>
	<div>
		<img id="output_fav" data-num="${team.tea_num}" src="${pageContext.request.contextPath}/images/fav01.gif">
		<span id="output_fcount"></span>
	</div>
	<hr size="1" width="100%">
	<div class="align-right">
	<input type="button" value="신고" id="report_btn">
	<input type="button" value="목록" onclick="location.href='teamList'">
		<c:if test="${!empty user &&user.mem_num == team.mem_num}">
			<input type="button" value="수정"
				onclick="location.href='teamUpdate?tea_num=${team.tea_num}'">
			<input type="button" value="삭제" id="delete_btn">
			<script type="text/javascript">
	 			const delete_btn = document.getElementById('delete_btn');
	 			delete_btn.onclick=function(){
	 				const choice = confirm('삭제하시겠습니까?');
	 				if(choice){
	 					location.replace('teamDelete?tea_num=${team.tea_num}');
	 				}
	 			}
	 		</script>
 		</c:if> 
		</div>
		<div class="detail-content">${team.tea_content}</div>
		<hr>
<div>모임 주소: ${team.tea_address1} ${team.tea_address2}</>
<div id="map" style="width:100%;height:350px;"></div>

<br>
<c:if test="${team.mem_num != user.mem_num }">
<p class="align-center">
		<input type="button" value="가입하기"
			  class="default-btn"
			  onclick="location.href='teamApply?tea_num=${team.tea_num}'">	
	</p>
</c:if>
</div>
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
<div class="modal" style="">
	<form id="reportForm">
		<h4>신고하기</h4>
			<input type="hidden" id="report_type" name="report_type" value="6">
			<input type="hidden" id="report_typeDetail" name="report_typeDetail" value="${team.tea_num }">
			<textarea rows="10" cols="30" id="report_content" name="report_content" placeholder="신고 사유를 적어주세요"></textarea>
		<h6>신고 사유</h6>
		<div>
			<input type="radio" name="report_category" value="1" checked />욕설/혐오/차별표현<br>
			<input type="radio" name="report_category" value="2" />부적절한 게시물<br>
			<input type="radio" name="report_category" value="3" />불법정보를 포함<br>
			<input type="radio" name="report_category" value="4" />도배/스팸
		</div>
		<div>
			<input type="submit" id="sbm_btn" value="완료"> 
			<input type="button" value="취소" id="cancel">
		</div>
	</form>
</div>

<script type="text/javascript">
    $(document).ready(function() {
        let cnt = 0;
        $('#report_btn').click(function() {
            if (cnt === 0) {
                $('.modal').show();
                cnt = 1;
            } else {
                $('.modal').hide();
                cnt = 0;    
            }
        });
        $('#cancel').click(function() {
            $('.modal').hide();
            cnt = 0;
        });
        $('#reportForm').submit(function(event){
            if($('#report_content').val().trim()==''){
                alert('내용을 입력하세요');
                $('#report_content').val('').focus();
                return false;
            }
            
            let form_data = $(this).serialize();
            console.log(form_data);
            
            //서버와 통신
            $.ajax({
                url: 'insertReport',
                type: 'post',
                data: form_data,
                dataType: 'json',
                success: function(param){
                    if(param.result === 'logout'){
                        alert('로그인해야 작성할 수 있습니다.');
                    } else if(param.result === 'success'){
                        alert('신고 완료');
                        $('.modal').hide();
                        cnt = 0;
                    } else {
                        alert('신고 접수 오류 발생');
                    }
                },
                error: function(){
                    alert('네트워크 오류 발생');
                }
            });
            
            //기본 이벤트 제거
            event.preventDefault();
        });
    });
</script>
