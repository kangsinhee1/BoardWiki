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
<section class="page-top-section set-bg"
	data-setbg="/img/page-top-bg/4.jpg">
	<div class="page-info">
		<c:choose>
        	<c:when test="${param.boa_category == 4}">
           	<div class="site-breadcrumb">
           		<h2>공지 작성</h2>
				<a href="list2?boa_category=4">Home</a>  /
				<span>Notice</span>
			</div>
       		 </c:when>
        	<c:when test="${param.boa_category == 5}">
           		<div class="site-breadcrumb">
           		<h2>QnA 작성</h2>
				<a href="list2?boa_category=5">Home</a>  /
				<span>QnA</span>
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
	<form:form action="write2" id="board_register"
	           enctype="multipart/form-data"
	                            modelAttribute="boardVO">
		<ul>
			<li>
				<c:if test="${user.mem_auth==9}">
					<input type="hidden" name="boa_category" value="4" >
				</c:if>
				<c:if test="${user.mem_auth!=9}">
				<input type="hidden" name="boa_category" value="5">
				</c:if>
			</li>
			<li>
				<form:label path="boa_title" style="color:white;">제목</form:label>
				<form:input path="boa_title" placeholder="제목을 입력하세요" style="color:black;"/>
				<form:errors path="boa_title" cssClass="error-color"/>
			</li>
			<li>
				<form:textarea path="boa_content"/>
				<form:errors path="boa_content" cssClass="error-color"/>
				<script>
				 function MyCustomUploadAdapterPlugin(editor) {
					    editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
					        return new UploadAdapter(loader);
					    }
					}
				 
				 ClassicEditor
		            .create( document.querySelector( '#boa_content' ),{
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
				<form:label path="upload" style="color:white;">파일업로드</form:label>
				<input type="file" name="upload" id="upload">
			</li>
		</ul> 
		<div class="align-center">
			<form:button class="default-btn">전송</form:button>
			<c:choose>
	    		<c:when test="${param.boa_category == 4}">
					<input type="button" value="목록" class="default-btn"
			 			 onclick="location.href='list2?boa_category=4'">
	   			</c:when>   
	   			<c:when test="${param.boa_category == 5}">
						<input type="button" value="목록" class="default-btn"
			 			 onclick="location.href='list2?boa_category=5'">
	  			</c:when> 
	  			
			</c:choose>   
		</div>       
		                 
	</form:form>
</div>
</div>
</div>
</div>
</section>
<!-- 게시판 글쓰기 끝 -->


  






