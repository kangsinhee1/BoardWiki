<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!-- 게시판 글상세 시작 -->
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/videoAdapter.js"></script>
<script src="${pageContext.request.contextPath}/js/tnrboard.fav.js"></script>
<script src="${pageContext.request.contextPath}/js/tnrboard.reply.js"></script>
<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg">
		<div class="page-info">
			<c:choose>
        	<c:when test="${tnrboard.tnr_category == 1}">
        		<h2>팁</h2>
           		 <div class="site-breadcrumb">
				<a href="tnrboardList?tnr_category=1">Home</a>  /
				<span>Tip</span>
			</div>
       		 </c:when>
        	<c:when test="${tnrboard.tnr_category == 2}">
        	    <h2>후기</h2>
           		<div class="site-breadcrumb">
				<a href="tnrboardList?tnr_category=2">Home</a>  /
				<span>Review</span>
			</div>
       		 </c:when>
    		</c:choose>
		</div>
	</section>
<section class="blog-page">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
<div class="page-main">
	<h2 style="text-align:center;">${tnrboard.tnr_title}</h2><br>
	<ul class="detail-info">
		<li>
			<c:if test="${empty tnrboard.mem_nickname}">작성자 : ${tnrboard.mem_email}</c:if>
			<c:if test="${!empty tnrboard.mem_nickname}">작성자 : ${tnrboard.mem_nickname}</c:if>
			<br>
			제품명 : ${tnrboard.item_name}<br>
			<c:if test="${empty tnrboard.tnr_mdate}">
			작성일 : ${tnrboard.tnr_rdate} /
			</c:if>
			<c:if test="${!empty tnrboard.tnr_mdate}">
			최근 수정일 : ${tnrboard.tnr_mdate} /
			</c:if>
			조회 : ${tnrboard.tnr_hit}
		</li>
		
	</ul>
	<c:if test="${!empty tnrboard.filename}">
	<ul>
		<li>첨부파일 : <a href="file?tnr_num=${tnrboard.tnr_num}">${tnrboard.filename}</a></li>
	</ul>
	</c:if>
	<div class="detail-content">
	<br>
		${tnrboard.tnr_content}
	</div>
	<div>
		<%-- 좋아요 --%>
		<img id="output_fav" data-num="${tnrboard.tnr_num}"
		    src="${pageContext.request.contextPath}/images/heart2.png">
		<span id="output_fcount"></span>    
		<%-- 댓글수 --%>
		<span id="output_rcount"></span>
	</div>
	<hr size="1" width="100%">
	<div class="align-right">
		<c:if test="${!empty user && user.mem_num == tnrboard.mem_num || user.mem_auth == 9}">
		<input type="button" value="수정"
		   onclick="location.href='tnrboardUpdate?tnr_num=${tnrboard.tnr_num}'">
		<c:choose>
			<c:when test="${tnrboard.tnr_category == 1}">
				<input type="button" value="삭제" id="delete_btn">
		<script>
			const delete_btn = document.getElementById('delete_btn');
			delete_btn.onclick=function(){
				const choice = confirm('삭제하시겠습니까?');
				if(choice){
					location.replace('tnrboardDelete?tnr_num=${tnrboard.tnr_num}');
				}
			};
		</script>   
		  </c:when>
		   <c:when test="${tnrboard.tnr_category == 2}">
		    	<input type="button" value="삭제" id="delete_btn">
		<script>
			const delete_btn = document.getElementById('delete_btn');
			delete_btn.onclick=function(){
				const choice = confirm('삭제하시겠습니까?');
				if(choice){
					location.replace('tnrboardDelete2?tnr_num=${tnrboard.tnr_num}');
				}
			};
		</script>
		</c:when>  
		</c:choose>
		</c:if>
		<c:choose>
			<c:when test="${tnrboard.tnr_category == 1}">
				<input type="button" value="신고" id="report_btn"> 
				<input type="button" value="목록" onclick="location.href='tnrboardList?tnr_category=1'">
		  	</c:when>
		    <c:when test="${tnrboard.tnr_category == 2}">  
		    	<input type="button" value="신고" id="report_btn"> 
				<input type="button" value="목록" onclick="location.href='tnrboardList?tnr_category=2'">
		   	</c:when>
		</c:choose>
	</div>
	<hr size="1" width="100%">
	<!-- 댓글 UI 시작 -->
	<!-- 댓글 목록 출력 -->
	<div id="output"></div>
	<div id="loading" style="display:none;">
		<img src="${pageContext.request.contextPath}/images/loading.gif" width="30" height="30">
	</div>
	<div class="paging-button" style="display:none;">
		<input type="button" value="더보기">
	</div>
	<!-- 댓글 목록 끝 -->
	<div id="reply_div">
		<span class="re-title" style="color:white">댓글 달기</span>
		<form id="re_form">
			<input type="hidden" name="tnr_num"
			          value="${tnrboard.tnr_num}" id="tnr_num">
			<textarea rows="3" cols="50" name="tnrR_content"
			      id="tnrR_content" class="rep-content"
			      <c:if test="${empty user}">disabled="disabled"</c:if>
			><c:if test="${empty user}">로그인해야 작성할 수 있습니다.</c:if></textarea>          
			<c:if test="${!empty user}">
			<div id="re_first">
				<span class="letter-count">300/300</span>
			</div><br>
			<a href="writeReply" id="submit-link" class="writeReply" style="color:white">댓글달기</a>
			</c:if>
		</form>
	</div>
	<!-- 댓글 UI 끝 -->
</div>
</div>
</div>
</div>
</section>
<!-- 게시판 글상세 끝 -->

<div class="modal-bg">
	<div class="modal2">
		<form id="reportForm">
			<h3 style="color:black;">※신고하기※</h3><br>
			<input type="hidden" id="report_type" name="report_type" value="7">
			<input type="hidden" id="report_typeDetail" name="report_typeDetail"
				value="${tnrboard.tnr_num }">
			<textarea rows="10" cols="30" id="report_content"
				name="report_content" placeholder="신고 사유를 적어주세요"></textarea>
			<h6 style="color:black;"><b>신고 사유</b></h6>
			<div>
				<input type="radio" name="report_category" value="1" checked />욕설/혐오/차별표현<br>
				<input type="radio" name="report_category" value="2" />부적절한 게시물<br>
				<input type="radio" name="report_category" value="3" />불법정보를 포함<br>
				<input type="radio" name="report_category" value="4" />도배/스팸
			</div>
			<br>
			<div>
				<input type="submit" id="sbm_btn" value="완료"> <input
					type="button" value="취소" id="cancel">
			</div>
		</form>
	</div>
</div>

<script type="text/javascript">
    $(document).ready(function() {
        let cnt = 0;
        $('#report_btn').click(function() {
            if (cnt === 0) {
                $('.modal').show();
                $('.modal-bg').show();
                cnt = 1;
            } else {
                $('.modal').hide();
                $('.modal-bg').hide();
                cnt = 0;    
            }
        });
        $('#cancel').click(function() {
            $('.modal').hide();
            $('.modal-bg').hide();
            cnt = 0;
        });
        function initForm(){
    		$('textarea').val('');
    	}
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
                        $('.modal-bg').hide();
                        cnt = 0;
                        initForm();
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
        $('#submit-link').click(function(event) {
            event.preventDefault(); // 기본 링크 동작 방지
            $('#re_form').submit(); // 폼 제출
        });
    });
</script>











