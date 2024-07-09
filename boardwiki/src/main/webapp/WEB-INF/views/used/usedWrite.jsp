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
	<h2>모임 글쓰기</h2>
	<form:form action="usedWrite" id="used_write"
	           enctype="multipart/form-data"
	                            modelAttribute="usedItemVO">
				<form:hidden path="mem_num" />
		<ul>
			<li>
				<form:label path="use_title">제목</form:label>
				<form:input path="use_title" />
				<form:errors path="use_title" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="item_num">제품명</form:label>
				<form:input type="number" path="item_num"  min="2" max="99" defaultValue="2"/>
				<form:errors path="item_num" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="use_content">홍보 내용</form:label>
				<form:textarea path="use_content"/>
				<form:errors path="use_content" cssClass="error-color"/>
				<script>
				 function MyCustomUploadAdapterPlugin(editor) {
					    editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
					        return new UploadAdapter(loader);
					    }
					}
				 
				 ClassicEditor
		            .create( document.querySelector( '#use_content' ),{
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
				<form:label path="use_price">가격</form:label>
				<form:input type="number" path="use_price" min="0" max="999999999"/>
			</li>
			<li>
				<form:label path="use_check">제품상태</form:label>
				<form:select path="use_check">
					<form:option value="0" disabled="disabled">제품상태를 선택해주세요</form:option>
					<form:option value="1">A</form:option>
					<form:option value="2">B</form:option>
					<form:option value="3">C</form:option>
				</form:select>
				<form:errors path="use_check" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="use_photo">제품 사진</form:label>
				<input type="file" name="upload" id="upload">
			</li>
		</ul> 
		<div class="align-center">
			<form:button class="default-btn">글쓰기</form:button>
			<input type="button" value="목록"
			  class="default-btn"
			  onclick="location.href='usedList'">
		</div>                           
	</form:form>
</div>







