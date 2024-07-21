<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
  <style>
    /* Modal container */
    .modal {
      display: none; /* Hidden by default */
      position: fixed; /* Stay in place */
      z-index: 5; /* Sit on top */
      left: 0;
      top: 50%;
      width: 100%; /* Full width */
      height: 100%; /* Full height */
      overflow: auto; /* Enable scroll if needed */
      background-color: rgb(0,0,0); /* Fallback color */
      background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
      display: flex;
      justify-content: center;
      align-items: center;
    }

    /* Modal content */
    .modal-content {
      background-color: #fefefe;
      margin: auto;
      padding: 20px;
      border: 1px solid #888;
      width: 80%; /* Can be adjusted */
      max-width: 300px; /* Maximum width */
      text-align: center;
      border-radius: 10px; /* Optional: rounded corners */
      box-shadow: 0 5px 15px rgba(0,0,0,0.3); /* Optional: shadow */
    }

    /* Close button */
    .close {
      color: #aaa;
      float: right;
      font-size: 28px;
      font-weight: bold;
    }

    .close:hover,
    .close:focus {
      color: black;
      text-decoration: none;
      cursor: pointer;
    }
  </style>
<!-- 게시판 목록 시작 -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/teamBoard.js"></script>
<section class="blog-page">
<div class="container">
	<div class="row">
		<div class="col-lg-12">
<div class="page-main">
	<h2 class="align-center">(${Team.tea_name})회원 목록</h2>
	<c:if test="${count == 0}">
		<div class="result-display">회원이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
		<table class="chart-table">
		<thead>
			<tr>
				<th>회원 닉네임</th>
				<th>가입 신청 메시지</th>
				<th>신청일</th>
				<th>회원상태</th>
			</tr>
			</thead>
			<c:forEach var="team" items="${list}">
				<tbody>
				<tr>
				<c:if test="${team.teaA_status==2}">
					<td class="align-center">${team.mem_nickname}</td>
					<td  class="align-center"><a href="#" class="content-link" data-content="${team.teaA_content}">${team.teaA_content}</a></td>
					<td class="align-center">${fn:substring(team.teaA_time, 0, 10)}</td>
					 <td class="align-center">
                        <select class="changeStatus2" data-num="${team.teaA_num}">
                            <option class="status2" value="0" ${team.teaA_status == 0 ? 'selected' : ''}>거부/정지 회원</option>
                            <option class="status2" value="1" ${team.teaA_status == 1 ? 'selected' : ''}>수락 대기회원</option>
                            <option class="status2" value="2" ${team.teaA_status == 2 ? 'selected' : ''}>활동 회원</option>
                        </select>
                    </td>
				</c:if>
				</tr>
				</tbody>
			</c:forEach>
		</table>
		<div class="align-center">${page}</div>
	</c:if>
	<h2 class="align-center">(${Team.tea_name})신청 목록</h2>
	<c:if test="${count == 0}">
		<div class="result-display">회원이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
		<table class="chart-table">
			<tr>
				<th>회원 닉네임</th>
				<th>가입 신청 메시지</th>
				<th>신청일</th>
				<th>회원상태</th>
			</tr>
			<c:forEach var="team" items="${list}">
				<tr>
				<c:if test="${team.teaA_status !=2}">
					<td class="align-center">${team.mem_nickname}</td>
					<td  class="align-center"><a href="#" class="content-link" data-content="${team.teaA_content}">${team.teaA_content}</a></td>
					<td class="align-center">${fn:substring(team.teaA_time, 0, 10)}</td>
					 <td class="align-center">
                        <select class="changeStatus2" data-num="${team.teaA_num}">
                            <option class="status2" value="0" ${team.teaA_status == 0 ? 'selected' : ''}>거부/정지 회원</option>
                            <option class="status2" value="1" ${team.teaA_status == 1 ? 'selected' : ''}>신청중</option>
                            <option class="status2" value="2" ${team.teaA_status == 2 ? 'selected' : ''}>활동 회원</option>
                        </select>
                    </td>
				</c:if>
				</tr>
			</c:forEach>
		</table>
		<div class="align-center">${page}</div>
	</c:if>
</div>
<!-- 모달 창 구조 -->
<div id="contentModal" class="modal">
  <div class="modal-content">
    <span class="close">&times;</span>
    <p id="modalContent"></p>
  </div>
</div>
<!-- 게시판 목록 끝 -->
<script>
$(function() {
    $('.changeStatus2').on('change', function() {
        $.ajax({
            url: '${pageContext.request.contextPath}/team/changeStatus',
            type: 'post',
            data: {teaA_num: $(this).attr('data-num'), teaA_status: $(this).val()},
            dataType: 'json',
            success: function(param) {
            	if(param.result =='logout'){
    				alert('로그인 해주세요')
    			}else if(param.result =='wrongAccess'){
    				alert('관리자만 가능합니다.')
    			}else if(param.result =='success'){
    					 alert('회원 상태가 변경되었습니다.');
    			}else{
    				alert('네트워크 오류')
    			}
                location.reload();
            },
            error: function() {
                alert('회원 상태 변경에 실패했습니다.');
            }
        });
    });

    // 모달 창 관련 스크립트
    var modal = document.getElementById("contentModal");
    var span = document.getElementsByClassName("close")[0];

    $('.content-link').on('click', function(event) {
        event.preventDefault();
        var content = "신청 메시지 : " ;
        content += $(this).data('content');
        $('#modalContent').text(content);
        modal.style.display = "block";
    });

    span.onclick = function() {
        modal.style.display = "none";
    };

    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    };
});
</script>

</div>
</div>
</div>
</section>

