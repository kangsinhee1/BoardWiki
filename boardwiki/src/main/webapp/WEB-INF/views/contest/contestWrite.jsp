<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 게시판 글쓰기 시작 -->
 <!-- Bootstrap CSS -->
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
<!-- Bootstrap Datepicker CSS -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" rel="stylesheet">
<!-- CKEditor JS -->
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>

<!-- Page top section -->
<section class="page-top-section set-bg" data-setbg="${pageContext.request.contextPath}/img/page-top-bg/4.jpg">
    <div class="page-info">
        <h2>글쓰기</h2>
        <div class="site-breadcrumb">
            <a href="${pageContext.request.contextPath}/home">Home</a>  /
            <span>글쓰기</span>
        </div>
    </div>
</section>
<!-- Page top end-->
<section class="page-main">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <form:form action="${pageContext.request.contextPath}/contestWrite" id="board_register" enctype="multipart/form-data" modelAttribute="contestVO">
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
                        <li>
                             <div class="form-group">
                                <form:label path="con_sdate">대회 모집 시작일:</form:label>
                                <form:input path="con_sdate" id="con_sdate" data-provide="datepicker"/>
                                <form:errors path="con_sdate" cssClass="error-color"/>
                            </div>
                        </li>
                        <li>
                            <div class="form-group">
                                <form:label path="con_edate">대회 모집 종료일:</form:label>
                                <form:input path="con_edate" id="con_edate" data-provide="datepicker"/>
                                <form:errors path="con_edate" cssClass="error-color"/>
                            </div>
                        </li>
                        <li>
                        	<div class="form-group">
                                <label for="con_period">대회 모집 기간:</label>
                                <input type="number" id="con_period" name="con_period" min="1" max="10" required readonly="true"/>
                            </div>
                        </li>
                    </ul>
                    <div class="form-actions">
                        <form:button class="btn btn-primary">전송</form:button>
                        <input type="button" value="목록" class="btn btn-secondary" onclick="location.href='${pageContext.request.contextPath}/list'">
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</section>
<!-- 게시판 글쓰기 끝 -->

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- Bootstrap JS -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<!-- Bootstrap Datepicker JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js"></script>

<script>
var jb = jQuery.noConflict();
jb(function() {
    // 오늘 날짜를 가져옵니다.
    var today = new Date();
    today.setHours(0, 0, 0, 0); // 시간을 0으로 설정하여 날짜만 비교

    // 공통 설정
    var datepickerOptions = {
        format: 'yyyy-mm-dd',
        startDate: today,
        autoclose: true,
        language: 'ko'
    };

    jb('#con_sdate').datepicker(datepickerOptions).on('changeDate', function(e) {
        var startDate = e.date;
        var endDate = new Date(startDate.getTime() + (90 * 24 * 60 * 60 * 1000)); // 90일 후의 날짜 설정
        jb('#con_edate').datepicker('setStartDate', startDate);
        jb('#con_edate').datepicker('setEndDate', endDate);
        calculateEndDate();
    });

    jb('#con_sdate').on('change', function() {
        validateStartDate();
    });

    jb('#con_period').on('input', function() {
        calculateEndDate();
    });

    function calculateEndDate() {
        var startDate = jb('#con_sdate').datepicker('getDate');
        var period = parseInt(jb('#con_period').val(), 10);
        if (startDate && !isNaN(period)) {
            var endDate = new Date(startDate.getTime() + ((period - 1) * 24 * 60 * 60 * 1000)); // 대여 기간만큼의 날짜 계산
            jb('#con_edate').datepicker('setDate', endDate);
        }
    }

    function validateStartDate() {
        var startDate = jb('#con_sdate').datepicker('getDate');
        if (startDate && startDate < today) {
            alert('오늘 날짜 이후의 날짜를 선택해주세요.');
            jb('#con_sdate').val('');
            jb('#con_edate').val('');
            jb('#con_period').val('');
        }
    }

    jb('#con_edate').datepicker(datepickerOptions).on('changeDate', function(e) {
        var startDate = jb('#con_sdate').datepicker('getDate');
        var endDate = e.date;
        var days = Math.floor((endDate - startDate) / (1000 * 60 * 60 * 24)) + 1; // 대여 기간 계산
        jb('#con_period').val(days);
    });

    jb('#con_edate').on('change', function() {
        validateEndDate();
    });

    function validateEndDate() {
        var startDate = jb('#con_sdate').datepicker('getDate');
        var endDate = jb('#con_edate').datepicker('getDate');
        if (startDate && endDate && endDate < startDate) {
            alert('종료일은 시작일 이후의 날짜여야 합니다.');
            jb('#con_edate').val('');
            jb('#con_period').val('');
        }
    }

    // 폼 전송 시 유효성 검사
    jb('#con_register').on('submit', function(event) {
        var startDate = jb('#con_sdate').val();
        var endDate = jb('#con_edate').val();
        var datePattern = /^\d{4}-\d{2}-\d{2}$/;

        if (!datePattern.test(startDate) || !datePattern.test(endDate)) {
            alert('올바른 날짜 형식이 아닙니다.');
            event.preventDefault(); // 폼 전송 막기
        }
    });
});
</script>