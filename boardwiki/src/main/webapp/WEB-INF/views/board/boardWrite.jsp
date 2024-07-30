<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- 게시판 글쓰기 시작 -->
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- include ckeditor js -->
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<section class="page-top-section set-bg"
	data-setbg="/img/page-top-bg/4.jpg">
	<div class="page-info">
		<h2>자유게시판 작성</h2>
		<div class="site-breadcrumb">
			<a href="list?boa_category=1">Home</a> / <span>자유게시판 작성</span>
		</div>
	</div>
</section>
<section class="blog-page">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="page-main">
					<form:form action="write" id="board_register"
						enctype="multipart/form-data" modelAttribute="boardVO">
						<ul>
							<li><input type="hidden" name="boa_category" value="1">
							</li>
							<li><form:label path="boa_title" style="color:white;">제목</form:label>
								<form:input path="boa_title" placeholder="제목을 입력하세요"
									style="color:black;" /> <form:errors path="boa_title"
									cssClass="error-color" /></li>
							<li><form:textarea path="boa_content" /> <form:errors
									path="boa_content" cssClass="error-color" /> <script>
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
			    </script></li>
							<li><form:label path="upload" style="color:white;">파일업로드</form:label>
								<input type="file" name="upload" id="upload" class="font-white">
							</li>
						</ul>
						<div class="align-center">
							<form:button class="default-btn">전송</form:button>
							<input type="button" value="목록" class="default-btn"
								onclick="location.href='list?boa_category=1'">
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- 게시판 글쓰기 끝 -->

<script>
$(document).ready(function() {
    // textarea의 id를 정확히 지정하여 해당 textarea를 모니터링합니다.
    const textarea = document.getElementById('boa_content');

    // textarea의 입력을 모니터링하는 이벤트 핸들러를 추가합니다.
    textarea.addEventListener('input', function() {
        const text = textarea.value;
        const maxLength = 20;

        let formattedText = '';
        for (let i = 0; i < text.length; i++) {
            formattedText += text[i];
            if ((i + 1) % maxLength === 0) {
                formattedText += '\n';
            }
        }

        textarea.value = formattedText;
    });
});
</script>







