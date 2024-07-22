<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg">
		<div class="page-info">
			<h2>1:1 채팅 목록</h2>
			<div class="site-breadcrumb">
				<a href="">Home</a>  /
				<span>Contact</span>
			</div>
		</div>
	</section>
	<!-- Page top end-->

<script src="${pageContext.request.contextPath}/js/usedChat.js"></script>
<section class="blog-page">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
<div class="page-main">
	<c:if test="${count==0}">
	<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>번호</th>
			<th>채팅방</th>
			<th>개설일</th>
			<th>신고</th>
		</tr>
		<c:forEach var="chat" items="${list}">
		<tr>
			<td class="align-center">${chat.useC_num}</td>
			<td class="align-left"><a href="${pageContext.request.contextPath}useChatSeller?use_num=${chat.use_num}&useC_name=${chat.useC_name}">${chat.useC_name}</a></td>
			<td class="align-center">${chat.useC_date}</td>
			<td class="align-center"><input type="button" value="신고" id="report_btn"></td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
	</c:if>
</div>
</div>
</div>
</div>
</section>


<script type="text/javascript">
    $(document).ready(function() {
        let cnt = 0;
        $(document).on('click', '.report_btn', function() {
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
    });
</script>