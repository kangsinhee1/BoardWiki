<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>글 작성</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Datepicker CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" rel="stylesheet">
    <!-- CKEditor CSS -->
    <link rel="stylesheet" href="https://cdn.ckeditor.com/4.16.2/standard/ckeditor.js">
</head>
<body>
<div class="container">
    <h2 class="mt-5">글 작성</h2>
    <form:form method="post" modelAttribute="contestVO" action="${pageContext.request.contextPath}/contest/write" class="mt-4">
        <div class="form-group">
            <label for="con_name">제목</label>
            <form:input path="con_name" id="con_name" class="form-control" />
            <form:errors path="con_name" cssClass="text-danger" />
        </div>
        <div class="form-group">
            <label for="con_content">내용</label>
            <form:textarea path="con_content" id="con_content" class="form-control" rows="5"></form:textarea>
            <form:errors path="con_content" cssClass="text-danger" />
        </div>
        <div class="form-group">
            <label for="con_location">위치</label>
            <form:input path="con_location" id="con_location" class="form-control" />
            <form:errors path="con_location" cssClass="text-danger" />
        </div>
        <div class="form-group">
            <label for="con_sdate">시작 날짜</label>
            <form:input path="con_sdate" id="con_sdate" class="form-control datepicker" />
            <form:errors path="con_sdate" cssClass="text-danger" />
        </div>
        <div class="form-group">
            <label for="con_edate">종료 날짜</label>
            <form:input path="con_edate" id="con_edate" class="form-control datepicker" />
            <form:errors path="con_edate" cssClass="text-danger" />
        </div>
        <button type="submit" class="btn btn-primary">등록</button>
    </form:form>
</div>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- Bootstrap JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
<!-- Bootstrap Datepicker JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<!-- CKEditor -->
<script src="https://cdn.ckeditor.com/4.16.2/standard/ckeditor.js"></script>
<script>
    $(document).ready(function(){
        $('.datepicker').datepicker({
            format: 'yyyy-mm-dd',
            autoclose: true,
            todayHighlight: true
        });

        // Initialize CKEditor
        CKEDITOR.replace('con_content');
    });
</script>
</body>
</html>
