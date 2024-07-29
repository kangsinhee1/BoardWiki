<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- 게시판 글쓰기 시작 -->
<!-- Bootstrap CSS -->
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Bootstrap Datepicker CSS -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css"
	rel="stylesheet">
<!-- CKEditor JS -->
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>

<!-- Page top section -->
<section class="page-top-section set-bg"
	data-setbg="${pageContext.request.contextPath}/img/page-top-bg/4.jpg">
	<div class="page-info">
		<h2>글수정</h2>
		<div class="site-breadcrumb">
			<a href="${pageContext.request.contextPath}/home">Home</a> / <span>글수정</span>
		</div>
	</div>
</section>
<!-- Page top end-->
<section class="blog-page">
	<div class="container">
		<div class="row">
			<div class="page-main">
				<form:form action="contestUpdate" id="team_register"
					enctype="multipart/form-data" modelAttribute="contestVO">
					<ul class="form-list">
						<form:hidden path="con_num"/>
						<li><form:input path="con_name" placeholder="제목을 입력하세요"
								class="form-control" /> <form:errors path="con_name"
								cssClass="error-color" /></li>
						<li><form:textarea path="con_content" id="content"
								class="form-control" /> <form:errors path="con_content"
								cssClass="error-color" /> <script>
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
                            </script></li>
						<li>
							<div class="form-group">
								<form:label path="con_sdate">대회 모집 시작일:</form:label>
								<form:input path="con_sdate" id="con_sdate"
									data-provide="datepicker" autocomplete="off"/>
								<form:errors path="con_sdate" cssClass="error-color" />
							</div>
							
						</li>
						<li>
							<div class="form-group">
								<form:label path="con_edate" style="margin:5px">대회 모집 종료일:</form:label>
								<form:input path="con_edate" id="con_edate"
									data-provide="datepicker" autocomplete="off"/>
								<form:errors path="con_edate" cssClass="error-color" />
							</div>
						</li>
						<li>
							<div class="form-group">
								<label for="con_period">대회 모집 기간:</label> <input type="number"
									id="con_period" name="con_period" min="1" max="10" required
									readonly="true"/>
							</div>
							<div class="form-group">
								<label for="con_maxman">대회 참가 인원 설정:</label> <input type="number"
									id="con_maxman" name="con_maxman" min="0" max="99" required/>
							</div>
						</li>

						<form:label class="label2" path="con_zipcode">모임 진행 장소</form:label>
						<li><form:input type="hidden" path="con_zipcode" /> <input
							type="button" onclick="execDaumPostcode()" value="주소 찾기"
							class="default-btn"></li>
						<li><form:input path="con_address1" placeholder="주소"
								readonly="readonly" /> <form:errors path="con_address1"
								cssClass="error-color" /></li>
						<li><form:input path="con_address2" placeholder="상세주소" /> <form:errors
								path="con_address2" cssClass="error-color" /></li>
					</ul>
					<div class="align-center">
						<form:button class="default-btn">전송</form:button>
						<input type="button" value="목록" class="default-btn"
							onclick="location.href='teamList'">
					</div>
				</form:form>
				<!-- 우편번호 시작 -->
				<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
				<div id="layer"
					style="display: none; position: fixed; overflow: hidden; z-index: 1; -webkit-overflow-scrolling: touch;">
					<img src="//t1.daumcdn.net/postcode/resource/images/close.png"
						id="btnCloseLayer"
						style="cursor: pointer; position: absolute; right: -3px; top: -3px; z-index: 1"
						onclick="closeDaumPostcode()" alt="닫기 버튼">
				</div>
			</div>
		</div>
	</div>
</section>
<!-- 게시판 글쓰기 끝 -->

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- Bootstrap JS -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<!-- Bootstrap Datepicker JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js"></script>

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

<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    //(주의)address1에 참고항목이 보여지도록 수정
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    //(수정) document.getElementById("address2").value = extraAddr;
                
                } 
                //(수정) else {
                //(수정)    document.getElementById("address2").value = '';
                //(수정) }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('con_zipcode').value = data.zonecode;
                //(수정) + extraAddr를 추가해서 address1에 참고항목이 보여지도록 수정
                document.getElementById("con_address1").value = addr + extraAddr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("con_address2").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
</script>