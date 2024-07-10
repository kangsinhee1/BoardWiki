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
    <form:input type="number" path="item_num" min="0" max="999999" defaultValue=""/>
    <input type="text" name="item_name" placeholder="제품을 선택해주세요" id="item_name" maxlength="10" readonly="readonly">
    <input type="button" id="item_numbtn" value="제품선택" class="button2">
    
    <div class="modal">
        <form id="searchform">
            <h4>제품 검색</h4>
            <input type="text" name="search" class="inputcheck input-style2" id="search" maxlength="30" placeholder="제목을 입력하세요">
            <input id="itembtn" type="button" value="검색" class="button2">
            <input id="itembtn2" type="button" value="취소" class="button2">
            <div id="add"></div>
            <input type="button" class="button2 paging2" style="display:none;" value="이전">
            <input type="button" class="button2 paging" style="display:none;" value="다음">
        </form>
    </div>
    
    <script type="text/javascript">
    $(document).ready(function() {
        let currentNum;
        let count;
        let rowCount = 10;
        let cnt = 0;
		let data_form = $('#search').val();
		
        $('#item_numbtn').click(function() {
            if (cnt === 0) {
                $('.modal').show();
                cnt = 1;
            } else {
                $('.modal').hide();
                cnt = 0;	
            }
        });

        $('#itembtn2').click(function() {
            $('.modal').hide();
            cnt = 0;
        });

        $('#itembtn').on('click',function(event) {
            event.preventDefault();
            selList(1);
        });

        function selList(pageNum) {
            currentNum = pageNum;
            if (currentNum === 0) {
                currentNum = 1;
            }
            $.ajax({
                url: 'searchItem',
                data: {
                    item_name: data_form,
                    pageNum: currentNum
                },
                type: 'post',
                dataType: 'json',
                success: function(param) {
                    $('#add').empty();
                    if (param.result === 'none') {
                        $('#add').append('찾으시는 보드게임이 없습니다.');
                    } else if (param.result === 'success') {
                        let output = '';
                        count = param.count;
                        $(param.list).each(function(index, item) {
                            output += '<input type="text" value="' + item.item_name + '" readonly="readonly" class="itemsh" id="' + item.item_num + '">';
                            output += '<br>';
                        });
                        $('#add').append(output);
                        if (currentNum >= Math.ceil(count / rowCount)) {
                            // 다음 페이지가 없음
                            $('.paging').hide();
                        } else {
                            // 다음 페이지가 존재
                            $('.paging').show();
                        }
                        if (currentNum <= 1) {
                            $('.paging2').hide();
                        } else {
                            $('.paging2').show();
                        }
                    } else {
                        alert('보드게임찾기오류');
                    }
                },
                error: function() {
                    alert('네트워크오류');
                }
            });
        }

        $(document).on('click', '.itemsh', function() {
            $('#item_name').val(this.value);
            $('#item_num').val(this.id);
            $('.modal').hide();
        });

        $('.paging').click(function() {
            selList(currentNum + 1);
        });

        $('.paging2').click(function() {
            selList(currentNum - 1);
        });
    });
    </script>
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
			<input type="button" value="목록"class="default-btn" onclick="location.href='usedList'">
		</div>                           
	</form:form>
</div>







