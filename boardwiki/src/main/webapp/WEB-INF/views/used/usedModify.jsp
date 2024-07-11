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
    <h2>중고 글수정</h2>
    <form:form action="usedUpdate" id="used_modify"
               enctype="multipart/form-data"
               modelAttribute="usedItemVO" method="post">
        <form:hidden path="use_num" value="${used.use_num }"/>
        <ul>
            <li>
                제목
                <form:input path="use_title" id="use_title"/>
                <form:errors path="use_title" cssClass="error-color"/>
            </li>
            <li>
                제품명
                <form:input type="hidden" path="item_num" id="item_num"/>
                <form:errors path="item_num" cssClass="error-color"/>
                <input type="text" value="${used.item_name}"name="item_name" id="item_name" maxlength="10" readonly="readonly">
            </li>
            <li>
                <form:label path="use_content">내용</form:label>
                <form:textarea path="use_content" id="use_content"/>
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
                <form:input type="number" path="use_price" id="use_price" min="0" max="999999999"/>
                <form:errors path="use_price" cssClass="error-color"/>
            </li>
            <li>
                <form:label path="use_check">제품상태</form:label>
                <form:select path="use_check" id="use_check">
                    <form:option value="0" disabled="disabled">제품상태를 선택해주세요</form:option>
                    <form:option value="1">A</form:option>
                    <form:option value="2">B</form:option>
                    <form:option value="3">C</form:option>
                </form:select>
                <form:errors path="use_check" cssClass="error-color"/>
            </li>
            <li>
                <form:label path="use_upload">제품 사진</form:label>
                <input type="file" name="use_upload" id="use_upload">
            </li>
        </ul> 
        <div class="align-center">
            <button type="submit" class="default-btn">글수정하기</button>
            <input type="button" value="목록" class="default-btn" onclick="location.href='usedList'">
        </div>                           
    </form:form>
</div>

