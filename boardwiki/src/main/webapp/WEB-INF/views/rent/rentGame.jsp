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
    $("#rent_sdate").datepicker({
        dateFormat: 'yy-mm-dd',
        onSelect: function(dateText, inst) {
            var startDate = new Date(dateText);
            var endDate = new Date(startDate.getTime() + (9 * 24 * 60 * 60 * 1000)); // 9일 후의 날짜 설정
            $("#rent_edate").datepicker("option", "minDate", startDate);
            $("#rent_edate").datepicker("option", "maxDate", endDate);
            calculateEndDate();
        }
    });

    $("#rent_period").on("input", function() {
        calculateEndDate();
    });

    function calculateEndDate() {
        var startDate = $("#rent_sdate").datepicker("getDate");
        var period = parseInt($("#rent_period").val(), 10);
        if (startDate && !isNaN(period)) {
            var endDate = new Date(startDate.getTime() + ((period - 1) * 24 * 60 * 60 * 1000)); // 대여 기간만큼의 날짜 계산
            $("#rentEdate").datepicker("setDate", endDate);
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
});


</script>

<div class="page-main">
    <h2>보드게임 대여</h2>
    <form:form action="rent" id="rent_register" modelAttribute="rentVO">
        <div class="align-center">
            <form:label path="rent_sdate">대여 시작일:</form:label>
            <form:input path="rent_sdate" id="rent_sdate"/>
            <form:errors path="rent_sdate" cssClass="error-color"/>
        </div>
        <div class="align-center">
            <form:label path="rent_edate">대여 종료일:</form:label>
            <form:input path="rent_edate" id="rent_edate"/>
            <form:errors path="rent_edate" cssClass="error-color"/>
        </div>
        <div class="align-center">
             <label for="rent_period">대여일 수:</label>
    		 <input type="number" id="rent_period" name="rent_period" min="1" max="10" required><br><br>
        </div>
       	
        <div class="align-center">
            <form:button class="default-btn">전송</form:button>
            <input type="button" value="목록" class="default-btn" onclick="location.href='list'">
        </div>
    </form:form>
</div>

<!-- 보드게임 대여 끝 -->  
