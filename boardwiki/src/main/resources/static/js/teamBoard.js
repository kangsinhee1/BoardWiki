$(function(){
	
	/* ========================================================================
	 * 회원 정보 수정
	 * ======================================================================== */
function changeStatus(mem_num,teaA_status) {
	
    $.ajax({
        url: '${pageContext.request.contextPath}/team/changeStatus',
        type: 'post',
        data: {
            mem_num: mem_num,
            new_status: teaA_status
        },
        dataType:'json',
        success: function(param) {
			
            alert('회원 상태가 변경되었습니다.');
            location.reload();
        },
        error: function() {
            alert('회원 상태 변경에 실패했습니다.');
        }
    });
}
  $('#meetingDate').on('change', function() {
        var newDate = $(this).val();
        var tea_num = $(this).attr('data-num');
       
        $.ajax({
            url: 'updateMeetingDate',
            type: 'post',
            data: {tea_time: newDate,tea_num:tea_num},
            dataType: 'json',
            success: function(param) {
				if(param.result == 'logout'){
					alert('로그인 해주세요');
				}else if (param.result == 'success') {
                    alert('모임 일정이 변경되었습니다.');
                    $('#meetingDateDisplay').val('모임 일정 : ' + newDate);
                     location.reload(); // Refresh the page to update attendance status
                } else {
                    alert('모임 일정 변경에 실패했습니다.');
                }
            },
            error: function() {
                alert('모임 일정 변경에 실패했습니다.');
            }
        });
    });

    $('#cancelMeeting').on('click', function() {
		
		
		
		
		 var tea_num = $(this).parent().find('#meetingDateDisplay').attr('data-num');
        $.ajax({
            url: 'deleteMeetingDate',
            type: 'post',
            data: {tea_time: null, tea_num:tea_num},
            dataType: 'json',
            success: function(param) {
				if(param.result == 'logout'){
					alert('로그인 해주세요');
					
				}else if (param.result == 'success') {
                    alert('모임이 취소되었습니다.');
                    
                    $('#meetingDate').val('');
                    $('#meetingDateDisplay').value="모임 일정이 없습니다.";
                     location.reload(); // Refresh the page to update attendance status
                } else {
                    alert('모임 취소에 실패했습니다.');
                }
            },
            error: function() {
                alert('모임 취소에 실패했습니다.');
            }
        });
    });
});




