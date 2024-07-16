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
	<h2>게시판 작성</h2>
	<form:form action="write2" id="board_register"
	           enctype="multipart/form-data"
	                            modelAttribute="boardVO">
		<ul>
			<li>
				<form:label path="boa_category">분류</form:label>
				<form:select path="boa_category" id="boa_category">
					<option disabled="disabled" selected>선택하세요</option>
					<c:if test="${user.mem_auth==9}">
					<form:option value="4">공지사항</form:option>
					</c:if>
					<form:option value="5">QnA</form:option>
				</form:select>
				<form:errors path="boa_category" cssClass="error-color"/>                             
			</li>
			<li>
				<form:input path="boa_title" placeholder="제목을 입력하세요"/>
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
				<form:label path="upload">파일업로드</form:label>
				<input type="file" name="upload" id="upload">
			</li>
		</ul> 
		<div class="align-center">
			<form:button class="default-btn">전송</form:button>
			<input type="button" value="목록"
			  class="default-btn"
			  onclick="location.href='list'">
		</div>                           
	</form:form>
</div>
<script>
    $(document).ready(function() {
        $('#board_register').submit(function(e) {
            e.preventDefault(); // 폼 기본 제출 방지

            // 폼 데이터를 비동기로 전송
            $.ajax({
                type: 'POST',
                url: $(this).attr('action'),
                data: new FormData(this),
                contentType: false,
                cache: false,
                processData: false,
                success: function(response) {
                    // 전송 성공 후 카테고리에 따라 페이지 이동
                    var boa_category = $('#boa_category').val();
                    switch (boa_category) {
                        case '1':
                            window.location.href = 'list?boa_category=1';
                            break;
                        case '2':
                            window.location.href = 'list?boa_category=2';
                            break;
                        case '3':
                            window.location.href = 'list?boa_category=3';
                            break;
                        case '4':
                            window.location.href = 'list?boa_category=4';
                            break;
                        case '5':
                            window.location.href = 'list?boa_category=5';
                            break;
                        default:
                            window.location.href = 'list'; // 기본적으로 전체 목록으로 이동
                            break;
                    }
                },
                error: function(xhr, status, error) {
                    console.error(xhr.responseText);
                }
            });
        });
        
    });
</script>
<!-- 게시판 글쓰기 끝 -->


  






