<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!-- 게시판 글상세 시작 -->
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/videoAdapter.js"></script>
<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg">
		<div class="page-info">
			<h2>${used.use_title}</h2>
			<div class="site-breadcrumb">
				<a href="">Home</a>  /
				<span>Contact</span>
			</div>
		</div>
	</section>
	<!-- Page top end-->

<section class="blog-page">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
<div class="page-main">
  <input type="hidden" name="useC_name" value="${used.use_title} 중고거래채팅">
	<h2>${used.use_title}</h2>
	<ul class="detail-info">
		<li>
		작성자:
			<c:if test="${empty used.mem_nickname}">${used.mem_email}</c:if>
			<c:if test="${!empty used.mem_nickname}">${used.mem_nickname}</c:if>
			<br>
			<c:if test="${empty used.use_mdate}">
			작성일 : ${used.use_rdate}
			</c:if>  
			<c:if test="${!empty used.use_mdate}">
			최근 수정일 : ${used.use_mdate}
			</c:if>
		</li>
		<li>
			제품 : ${used.item_name}
		</li>
		<li>
			가격 : ${used.use_price }
		</li>
	</ul>
	<c:if test="${!empty used.use_photo}">
		<!-- 사진 넣어야함 -->	
	</c:if>
	<div class="align-right">
		<input type="button" value="신고" id="report_btn"> 
	<c:if test="${used.use_check !=3 }">
		<input type="button" value=<c:if test="${user.mem_num == used.mem_num}">"채팅 목록"</c:if><c:if test="${user.mem_num != used.mem_num}">"1:1채팅하기"</c:if> onclick="location.href='useChat?mem_num=${used.mem_num}&use_num=${used.use_num }'">	
	</c:if>
	</div>
	<div class="detail-content">
		${used.use_content}
	</div>
	<hr size="1" width="100%">
	<div class="align-right">
		<c:if test="${!empty user && user.mem_num == used.mem_num}">
		<c:if test="${used.use_check!=3 }">
		<input type="button" value="수정"
		   onclick="location.href='usedUpdate?use_num=${used.use_num}'">
		</c:if>
		<input type="button" value="삭제" id="delete_btn">
		<input type="button" value="목록" class="default-btn" onclick="location.href='usedList'">
		<script>
			const delete_btn = document.getElementById('delete_btn');
			delete_btn.onclick=function(){
				const choice = confirm('삭제하시겠습니까?');
				if(choice){
					location.replace('usedDelete?use_num=${used.use_num}');
				}
			};
		</script>   
		</c:if>
	</div>
</div>
</div>
</div>
</div>
</section>
<!-- 게시판 글상세 끝 -->
<!-- 신고 모달창 -->
<div class="modal" style="">
	<form id="reportForm">
		<h4>신고하기</h4>
			<input type="hidden" id="report_type" name="report_type" value="5">
			<input type="hidden" id="report_typeDetail" name="report_typeDetail" value="${used.use_num }">
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











