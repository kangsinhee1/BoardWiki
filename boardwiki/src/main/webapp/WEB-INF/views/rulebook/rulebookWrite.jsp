<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- include ckeditor js -->
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<div class="page-main">
<section class="page-top-section set-bg"
	data-setbg="/img/page-top-bg/4.jpg">
	<div class="page-info">
		<h2>룰북 작성</h2>
		<div class="site-breadcrumb">
			<a href="">Home</a> / <span>룰북 작성</span>
		</div>
	</div>
</section>
	<form:form action="rulebookWrite" id="rulebook_register"
	           enctype="multipart/form-data"
	                            modelAttribute="rulebookVO">
		<ul>
			 <li>
                제품명
                <form:input type="hidden" path="item_num" id="item_num"/>
                <form:errors path="item_num" cssClass="error-color"/>
                <input type="text" name="item_name" placeholder="제품을 선택해주세요" id="item_name" maxlength="10" readonly="readonly">
                <input type="button" id="item_numbtn" value="제품선택" class="button2">
                     
            </li>
			<li>
				<form:textarea path="rulB_content"/>
				<form:errors path="rulB_content" cssClass="error-color"/>
				<script>
				 function MyCustomUploadAdapterPlugin(editor) {
					    editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
					        return new UploadAdapter(loader);
					    }
					}
				 
				 ClassicEditor
		            .create( document.querySelector( '#rulB_content' ),{
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
				<form:label path="upload">파일업로드</form:label>
				<input type="file" name="upload" id="upload">
			</li>
		</ul> 
		<div class="align-center">
			<form:button class="default-btn">전송</form:button>
			<input type="button" value="목록"
			  class="default-btn"
			  onclick="location.href='rulebookList'">
		</div>                           
	</form:form>
</div>
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
			        let data_form ="";
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
			        	data_form = $('#search').val();
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
			                    keyword: data_form,
			                    pageNum: currentNum,
			                    rowCount: rowCount
			                },
			                type: 'get',
			                dataType: 'json',
			                success: function(param) {
			                    $('#add').empty();
			                    if (param.result === 'none') {
			                        $('#add').append('찾으시는 보드게임이 없습니다.');
			                    } else if (param.result === 'success') {
			                        let output = '';
			                        count = param.count;
			                        $('#item_num').val('');
			                        $(param.list).each(function(index, item) {
				                        $('#item_num').val(item.item_num);
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









