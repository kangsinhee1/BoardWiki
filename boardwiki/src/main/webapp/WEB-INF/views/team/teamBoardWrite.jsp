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
		<h2>모임</h2>
		<div class="site-breadcrumb">
			<a href="">Home</a>  /
			<span>Team Request</span> /
			<span><a href="myTeam2">My Team</a></span>
		</div>
	</div>
</section>
<!-- Page top end-->
<section class="blog-page">
<div class="container">
	<div class="row">
		<div class="col-lg-12">
<div class="">
	<form:form action="teamBoardWrite" id="team_register"
	           enctype="multipart/form-data"
	                            modelAttribute="teamBoardVO">
		<ul>
			
			<li>
			<form:hidden path="tea_num"/>
				<form:label class="font-white" path="teaB_category">분류</form:label>
				<form:select path="teaB_category" >
				<c:if test="${admin}">
						<form:option value="1">공지사항</form:option>
				</c:if>
						<form:option value="2">잡담</form:option>
						<form:option value="3">후기	</form:option>
				</form:select>
				<form:errors path="teaB_category" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="teaB_title" class="font-white">제목</form:label>
				<form:input path="teaB_title" />
				<form:errors path="teaB_title" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="teaB_content" class="font-white">내용</form:label>
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
				<form:label path="upload" class="font-white">파일 업로드</form:label>
				<input type="file" name="upload" id="upload" class="font-white">
			</li>
		</ul> 
		<div class="align-center" style="text-align:center;">
			<form:button class="default-btn">전송</form:button>
		<c:if test="${admin}">
		<input type="button" value="목록" onclick="location.href='teamBoardAdmin?tea_num=${tea_num}'">
		</c:if>
		<c:if test="${!admin}">
		<input type="button" value="목록" onclick="location.href='teamBoardUser?tea_num=${tea_num}'">
		</c:if>
		</div>                           
	</form:form>
</div>
</div>
</div>
</div>
</section>

<!-- 게시판 글쓰기 끝 -->









