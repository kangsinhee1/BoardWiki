<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 게시판 글쓰기 시작 -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- include ckeditor js -->
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<!-- Page top section -->
<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg">
    <div class="page-info">
        <h2>글쓰기</h2>
        <div class="site-breadcrumb">
            <a href="">Home</a>  /
            <span>글쓰기</span>
        </div>
    </div>
</section>
<!-- Page top end-->
<section class="page-main">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <form:form action="contestWrite" id="board_register" enctype="multipart/form-data" modelAttribute="contestVO">
                    <ul class="form-list">
                        <li>
                            <form:input path="con_name" placeholder="제목을 입력하세요" class="form-control"/>
                            <form:errors path="con_name" cssClass="error-color"/>
                        </li>
                        <li>
                            <form:textarea path="con_content" id="content" class="form-control"/>
                            <form:errors path="con_content" cssClass="error-color"/>
                            <script>
                                function MyCustomUploadAdapterPlugin(editor) {
                                    editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
                                        return new UploadAdapter(loader);
                                    }
                                }

                                ClassicEditor
                                    .create(document.querySelector('#content'), {
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
                    </ul>
                    <div class="form-actions">
                        <form:button class="btn btn-primary">전송</form:button>
                        <input type="button" value="목록" class="btn btn-secondary" onclick="location.href='list'">
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</section>
<!-- 게시판 글쓰기 끝 -->
