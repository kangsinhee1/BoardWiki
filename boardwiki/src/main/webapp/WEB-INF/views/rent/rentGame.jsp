<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>보드게임 대여</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Datepicker CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css" type="text/css">
</head>
<body>

<!-- Page top section -->
<section class="page-top-section set-bg" data-setbg="/img/page-top-bg/4.jpg">
    <div class="page-info">
        <h2>게임 대여</h2>
        <div class="site-breadcrumb">
            <a href="">Home</a> /
            <span>Contact</span>
        </div>
    </div>
</section>
<!-- Page top end-->

<section class="blog-page">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="page-main">
                    <div class="form-container">
                        <h2>보드게임 대여</h2>
                        <form:form action="rent" id="rent_register" modelAttribute="rentVO">
                            <form:hidden path="item_num"/>
                            <div class="form-group">
                                <form:label path="rent_sdate">대여 시작일:</form:label>
                                <form:input path="rent_sdate" id="rent_sdate" data-provide="datepicker"/>
                                <form:errors path="rent_sdate" cssClass="error-color"/>
                            </div>
                            <div class="form-group">
                                <form:label path="rent_edate">대여 종료일:</form:label>
                                <form:input path="rent_edate" id="rent_edate" data-provide="datepicker"/>
                                <form:errors path="rent_edate" cssClass="error-color"/>
                            </div>
                            <div class="form-group">
                                <label for="rent_period">대여 기간:</label>
                                <input type="number" id="rent_period" name="rent_period" min="1" max="10" required/>
                            </div>
                            <div class="align-center">
                                <form:button class="rent_btn">전송</form:button>
                                <input type="button" value="목록" class="default-btn" onclick="location.href='${pageContext.request.contextPath}/myPage/rent'">
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

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

    jb('#rent_sdate').datepicker(datepickerOptions).on('changeDate', function(e) {
        var startDate = e.date;
        var endDate = new Date(startDate.getTime() + (9 * 24 * 60 * 60 * 1000)); // 9일 후의 날짜 설정
        jb('#rent_edate').datepicker('setStartDate', startDate);
        jb('#rent_edate').datepicker('setEndDate', endDate);
        calculateEndDate();
    });

    jb('#rent_sdate').on('change', function() {
        validateStartDate();
    });

    jb('#rent_period').on('input', function() {
        calculateEndDate();
    });

    function calculateEndDate() {
        var startDate = jb('#rent_sdate').datepicker('getDate');
        var period = parseInt(jb('#rent_period').val(), 10);
        if (startDate && !isNaN(period)) {
            var endDate = new Date(startDate.getTime() + ((period - 1) * 24 * 60 * 60 * 1000)); // 대여 기간만큼의 날짜 계산
            jb('#rent_edate').datepicker('setDate', endDate);
        }
    }

    function validateStartDate() {
        var startDate = jb('#rent_sdate').datepicker('getDate');
        if (startDate && startDate < today) {
            alert('오늘 날짜 이후의 날짜를 선택해주세요.');
            jb('#rent_sdate').val('');
            jb('#rent_edate').val('');
            jb('#rent_period').val('');
        }
    }

    jb('#rent_edate').datepicker(datepickerOptions).on('changeDate', function(e) {
        var startDate = jb('#rent_sdate').datepicker('getDate');
        var endDate = e.date;
        var days = Math.floor((endDate - startDate) / (1000 * 60 * 60 * 24)) + 1; // 대여 기간 계산
        jb('#rent_period').val(days);
    });

    jb('#rent_edate').on('change', function() {
        validateEndDate();
    });

    function validateEndDate() {
        var startDate = jb('#rent_sdate').datepicker('getDate');
        var endDate = jb('#rent_edate').datepicker('getDate');
        if (startDate && endDate && endDate < startDate) {
            alert('종료일은 시작일 이후의 날짜여야 합니다.');
            jb('#rent_edate').val('');
            jb('#rent_period').val('');
        }
    }

    // 폼 전송 시 유효성 검사
    jb('#rent_register').on('submit', function(event) {
        var startDate = jb('#rent_sdate').val();
        var endDate = jb('#rent_edate').val();
        var datePattern = /^\d{4}-\d{2}-\d{2}$/;

        if (!datePattern.test(startDate) || !datePattern.test(endDate)) {
            alert('올바른 날짜 형식이 아닙니다.');
            event.preventDefault(); // 폼 전송 막기
        }
    });
});


</script>

</body>
</html>
