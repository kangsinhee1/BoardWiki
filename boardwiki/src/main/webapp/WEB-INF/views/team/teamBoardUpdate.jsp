<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 게시판 글쓰기 시작 -->
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- include ckeditor js -->
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>

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
<div class="">
	<form:form action="teamBoardUpdate" id="team_register"
	           enctype="multipart/form-data"
	                            modelAttribute="teamBoardVO">
		<ul>
	<form:hidden path="mem_num"/>                            
	<form:hidden path="teaB_num"/>                            
			<li>
				<form:label path="teaB_category">분류</form:label>
				<form:select path="teaB_category" >
						<form:option value="1">공지사항</form:option>
						<form:option value="2">잡담</form:option>
						<form:option value="3">후기	</form:option>
				</form:select>
				<form:errors path="teaB_category" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="teaB_title">제목</form:label>
				<form:input path="teaB_title" />
				<form:errors path="teaB_title" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="teaB_content">내용</form:label>
				<form:textarea path="teaB_content"/>
				<form:errors path="teaB_content" cssClass="error-color"/>
				<script>
				 function MyCustomUploadAdapterPlugin(editor) {
					    editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
					        return new UploadAdapter(loader);
					    }
					}
				 
				 ClassicEditor
		            .create( document.querySelector( '#teaB_content' ),{
		            	extraPlugins: [MyCustomUploadAdapterPlugin]
		            })
		            .then( editor => {
						window.editor = editor;
					} )
		            .catch( error => {
		                console.error( error );
		            } );
			    </script> 
			    <li>
				<form:label path="upload">파일업로드</form:label>
				<input type="file" name="upload" id="upload">
				<c:if test="${!empty teamBoardVO.filename}">
				<div id="file_detail">
					(${teamBoardVO.filename})파일이 등록되어 있습니다.
					<input type="button" value="파일 삭제" id="file_del">
				</div>
				<script type="text/javascript">
					$(function(){
						$('#file_del').click(function(){
							const choice = confirm('삭제하시겠습니까?');
							if(choice){
								$.ajax({
									url:'deleteFile',
									data:{teaB_num:${teamBoardVO.teaB_num}},
									type:'post',
									dataType:'json',
									success:function(param){
										if(param.result == 'logout'){
											alert('로그인 후 사용하세요');
										}else if(param.result == 'wrongAccess'){
											alert('잘못된 접속입니다.');
										}else if(param.result == 'success'){
											$('#file_detail').hide();
										}else{
											alert('파일 삭제 오류 발생');
										}
									},
									error:function(){
										alert('네트워크 오류 발생');
									}
								});
							}
						});
					});
				</script>
				</c:if>
			</li>
		</ul> 
		<div class="align-center">
			<form:button class="default-btn">전송</form:button>
			<input type="button" value="목록"
			  class="default-btn"
			  onclick="location.href='teamBoardAdmin?tea_num=${tea_num}'">
		</div>                           
	</form:form>
</div>
</div>
</div>
</div>
</section>


<!-- 게시판 글쓰기 끝 -->









