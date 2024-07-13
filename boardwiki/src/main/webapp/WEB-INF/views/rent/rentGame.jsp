<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script>
$(function() {
    // 오늘 날짜를 가져옵니다.
    var today = new Date();
    today.setHours(0, 0, 0, 0); // 시간을 0으로 설정하여 날짜만 비교

    $("#rent_sdate").datepicker({
        dateFormat: 'yy-mm-dd',
        minDate: today, // 오늘 이후의 날짜만 선택 가능하도록 설정합니다.
        onSelect: function(dateText, inst) {
            var startDate = new Date(dateText);
            var endDate = new Date(startDate.getTime() + (9 * 24 * 60 * 60 * 1000)); // 9일 후의 날짜 설정
            $("#rent_edate").datepicker("option", "minDate", startDate);
            $("#rent_edate").datepicker("option", "maxDate", endDate);
            calculateEndDate();
        }
    });

    $("#rent_sdate").on("change", function() {
        validateStartDate();
    });

    $("#rent_period").on("input", function() {
        calculateEndDate();
    });

    function calculateEndDate() {
        var startDate = $("#rent_sdate").datepicker("getDate");
        var period = parseInt($("#rent_period").val(), 10);
        if (startDate && !isNaN(period)) {
            var endDate = new Date(startDate.getTime() + ((period - 1) * 24 * 60 * 60 * 1000)); // 대여 기간만큼의 날짜 계산
            $("#rent_edate").datepicker("setDate", endDate);
        }
    }

    function validateStartDate() {
        var startDate = $("#rent_sdate").datepicker("getDate");
        if (startDate && startDate < today) {
            alert("오늘 날짜 이후의 날짜를 선택해주세요.");
            $("#rent_sdate").val('');
            $("#rent_edate").val('');
            $("#rent_period").val('');
        }
    }

    $("#rent_edate").datepicker({
        dateFormat: 'yy-mm-dd',
        onSelect: function(dateText, inst) {
            var startDate = $("#rent_sdate").datepicker("getDate");
            var endDate = new Date(dateText);
            var days = Math.floor((endDate - startDate) / (1000 * 60 * 60 * 24)) + 1; // 대여 기간 계산
            $("#rent_period").val(days);
        }
    });

    $("#rent_edate").on("change", function() {
        validateEndDate();
    });

    function validateEndDate() {
        var startDate = $("#rent_sdate").datepicker("getDate");
        var endDate = $("#rent_edate").datepicker("getDate");
        if (startDate && endDate && endDate < startDate) {
            alert("종료일은 시작일 이후의 날짜여야 합니다.");
            $("#rent_edate").val('');
            $("#rent_period").val('');
        }
    }
});
</script>

<div class="page-main">
    <div class="form-container">
        <h2>보드게임 대여</h2>
        <form:form action="rent" id="rent_register" modelAttribute="rentVO">
            <form:hidden path="item_num"/>
            <div class="form-group">
                <form:label path="rent_sdate">대여 시작일:</form:label>
                <form:input path="rent_sdate" id="rent_sdate"/>
                <form:errors path="rent_sdate" cssClass="error-color"/>
            </div>
            <div class="form-group">
                <form:label path="rent_edate">대여 종료일:</form:label>
                <form:input path="rent_edate" id="rent_edate"/>
                <form:errors path="rent_edate" cssClass="error-color"/>
            </div>
            <div class="form-group">
                <label for="rent_period">대여 기간:</label>
                <input type="number" id="rent_period" name="rent_period" min="1" max="10" required/>
            </div>
            <div class="align-center">
                <form:button class="default-btn">전송</form:button>
                <input type="button" value="목록" class="default-btn" onclick="location.href='list'">
            </div>
        </form:form>
    </div>
</div>

<!-- 보드게임 대여 끝 -->
