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
<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg">
	<div class="page-info">
		<h2>모임 신청</h2>
		<div class="site-breadcrumb">
			<a href="">Home</a>  /
			<span></span> /
			<span><a > </a></span>
		</div>
	</div>
</section>
<section class="blog-page">
<div class="container">
	<div class="row">
		<div class="col-lg-12">
<div class="page-main">
    <h2>중고 글수정</h2>
    <form:form action="usedUpdate" id="used_modify"
               enctype="multipart/form-data"
               modelAttribute="used">
        <form:hidden path="use_num" value="${used.use_num}"/>
        <ul>
            <li>
                <form:label path="use_title">제목</form:label>
                <form:input path="use_title" />
                <form:errors path="use_title" cssClass="error-color"/>
            </li>
            <li>
                <form:label  path="item_num" >제품명</form:label>
                <form:input type="hidden" path="item_num"/>
                <form:errors path="item_num" cssClass="error-color"/>
                <input type="text" value="${used.item_name}"name="item_name" id="item_name" maxlength="10" readonly="readonly">
            </li>
            <li>
                <form:label path="use_content">내용</form:label>
                <form:textarea path="use_content"/>
                <form:errors path="use_content" cssClass="error-color"/>
                <script>
                 function MyCustomUploadAdapterPlugin(editor) {
                        editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
                            return new UploadAdapter(loader);
                        }
                    }
                 
                 ClassicEditor
                    .create(document.querySelector('#use_content'), {
                        extraPlugins: [MyCustomUploadAdapterPlugin]
                    })
                    .then(editor => {
                        window.editor = editor;
                    })
                    .catch(error => {
                        console.error(error);
                    });
                </script>  
            </li>
            <li>
                <form:label path="use_price">가격</form:label>
                <form:input type="number" path="use_price"  min="0" max="999999999"/>
                <form:errors path="use_price" cssClass="error-color"/>
            </li>
            <li>
                <form:label path="use_check">판매상태</form:label>
                <form:select path="use_check" >
                    <form:option value="0" disabled="disabled">제품상태를 선택해주세요</form:option>
                    <form:option value="1">판매중</form:option>
                    <form:option value="2">예약중</form:option>
                    <form:option value="3">판매완료</form:option>
                </form:select>
                <form:errors path="use_check" cssClass="error-color"/>
            </li>
        </ul> 
        <div class="align-center">
            <button type="submit" class="default-btn">수정하기</button>
            <input type="button" value="목록" class="default-btn" onclick="location.href='usedList'">
        </div>                           
    </form:form>
</div>
</div>
</div>
</div>
</section>


