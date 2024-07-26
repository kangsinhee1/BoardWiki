<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 게시판 글 수정 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- include ckeditor js -->
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg">
		<div class="page-info">
			<h2>게시글 수정</h2>
		</div>
</section>
<section class="blog-page">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
<div class="page-main">
	<form:form action="tnrboardUpdate" id="tnrboard_modify"
	           enctype="multipart/form-data"
	                            modelAttribute="tnrboardVO">
		<form:hidden path="tnr_num"/>
		<ul>
			<li>
				<form:label path="tnr_category" style="color:white">분류</form:label>
				<form:select path="tnr_category" >
					<form:option value="1">팁게시판</form:option>
					<form:option value="2">후기게시판</form:option>
				</form:select>
				<form:errors path="tnr_category" cssClass="error-color"/>                             
			</li>
			<li>
				<form:input path="tnr_title" placeholder="제목을 입력하세요"/>
				<form:errors path="tnr_title" cssClass="error-color"/>
			</li>
			<li>
				<form:textarea path="tnr_content"/>
				<form:errors path="tnr_content" cssClass="error-color"/>
				<script>
				 function MyCustomUploadAdapterPlugin(editor) {
					    editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
					        return new UploadAdapter(loader);
					    }
					}
				 
				 ClassicEditor
		            .create( document.querySelector( '#tnr_content' ),{
		            	extraPlugins: [MyCustomUploadAdapterPlugin]
		            })
		            .then( editor => {
						window.editor = editor;
					} )
		            .catch( error => {
		                console.error( error );
		            } );
			    </script> 
			</li>
			<li>
				<form:label path="upload" style="color:white">파일업로드</form:label>
				<input type="file" name="upload" id="upload">
				<c:if test="${!empty tnrboardVO.filename}">
				<div id="file_detail">
					(${tnrboardVO.filename})파일이 등록되어 있습니다.
					<input type="button" value="파일 삭제" id="file_del">
				</div>
				<script type="text/javascript">
					$(function(){
						$('#file_del').click(function(){
							const choice = confirm('삭제하시겠습니까?');
							if(choice){
								$.ajax({
									url:'deleteTnrboardFile',
									data:{tnr_num:${tnrboardVO.tnr_num}},
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
			<input type="button" value="목록" class="default-btn" onclick="ListPage()">
		</div>                           
	</form:form>
</div>
</div>
</div>
</div>
</section>
<script type="text/javascript">
    function ListPage() {
        // 현재 선택된 카테고리 가져오기
        var category = document.getElementById("tnr_category").value;
        
        // 각 카테고리에 따라 다른 목록 페이지로 이동
        switch(category) {
            case '1':
            	location.href='tnrboardList?tnr_category=1'; // 팁게시판 목록 페이지 URL
                break;
            case '2':
            	location.href='tnrboardList?tnr_category=2'; // 후기게시판 목록 페이지 URL
                break;
            default:
                location.href = 'tnrboardList'; // 기본적으로 list 페이지로 이동
                break;
        }
    }
</script>
<!-- 게시판 글 수정 끝 -->









