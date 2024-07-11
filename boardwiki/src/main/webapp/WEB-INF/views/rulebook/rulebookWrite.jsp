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
<div class="page-main">
	<h2>룰북 작성</h2>
	<form:form action="rulebookWrite" id="rulebook_register"
	           enctype="multipart/form-data"
	                            modelAttribute="rulebookVO">
		<ul>
			
			<li>
				<form:textarea path="rulB_content"/>
				<form:errors path="rulB_content" cssClass="error-color"/>
				<script>
				 function MyCustomUploadAdapterPlugin(editor) {
					    editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
					        return new UploadAdapter(loader);
					    }
					}
				 
				 ClassicEditor
		            .create( document.querySelector( '#rulB_content' ),{
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
				<form:label path="rulB_upload">파일업로드</form:label>
				<input type="file" name="rulB_upload" id="rulB_upload">
			</li>
		</ul> 
		<div class="align-center">
			<form:button class="default-btn">전송</form:button>
			<input type="button" value="목록"
			  class="default-btn"
			  onclick="location.href='rulebookList'">
		</div>                           
	</form:form>
</div>
<!-- 게시판 글쓰기 끝 -->









