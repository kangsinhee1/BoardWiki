CREATE TABLE "member" (
	"mem_num"	number		NOT NULL,  -- 회원고유의 번호
	"mem_email"	varchar2(50)		NOT NULL,  -- 회원 이메일(아이디용)
	"mem_auth"	number(1)		NOT NULL,  -- 회원등급(일반 0 정지 1 탈퇴 2 관리자 9)
	CONSTRAINT "member_pk" PRIMARY KEY ("mem_num")
);

CREATE SEQUENCE member_seq;

CREATE TABLE "attendance" (
	"att_num"	number		NOT NULL,  -- 출석번호
	"att_date"	date		NOT NULL,  -- 출석날짜
	"att_status"	number	DEFAULT 1 NOT NULL,  -- 1:미출석 2:출석
	"mem_num"	number		NOT NULL,  -- 회원고유의 번호
	CONSTRAINT "attendance_pk" PRIMARY KEY ("att_num"),
	CONSTRAINT "attendance_fk" FOREIGN KEY ("mem_num") REFERENCES "member" ("mem_num")
);

CREATE SEQUENCE attendance_seq;

CREATE TABLE "member_detail" (
	"mem_name"	varchar2(30)		NOT NULL,  -- 회원 이름
	"mem_nickname"	varchar2(50)		NULL,  -- UNIQUE
	"mem_passwd"	varchar2(50)		NOT NULL,  -- 영문+숫자4~12
	"mem_phone"	varchar2(15)		NOT NULL,  -- 000-0000-0000형식
	"mem_provider"	varchar2(10)		NULL,  -- 회원의 가입정보를 식별하기 위한정보
	"mem_rdate"	date	DEFAULT SYSDATE	NOT NULL,  -- 회원 가입한 날짜
	"mem_mdate"	date		NULL,  -- 회원 가입한 날짜
	"mem_photo"	varchar2(400)	DEFAULT 'face.png'	NULL,  -- 회원의 프로필 사진
	"mem_num"	number		NOT NULL,  -- 회원고유의 번호
	CONSTRAINT "member_detail_fk" FOREIGN KEY ("mem_num") REFERENCES "member" ("mem_num")
);

CREATE SEQUENCE member_detail_seq;

CREATE TABLE "stream_view_time" (
	"view_id"	number		NOT NULL,  -- 시청번호
	"view_start"	date		NOT NULL,  -- 시청 시작 시간
	"view_end"	date		NULL,  -- 시청 종료 시간
	"str_num"	number		NOT NULL,  -- 방송 구별을 위한 번호
	CONSTRAINT "stream_view_time_pk" PRIMARY KEY ("view_id"),
	CONSTRAINT "stream_view_time_fk" FOREIGN KEY ("str_num") REFERENCES "streaming" ("str_num")
);

CREATE SEQUENCE stream_view_time_seq;

CREATE TABLE "streaming_chatroom" (
	"strC_num"	number		NOT NULL,  -- 채팅방번호
	"str_num"	number		NOT NULL,  -- 방송 구별을 위한 번호
	CONSTRAINT "streaming_chatroom_pk" PRIMARY KEY ("strC_num"),
	CONSTRAINT "streaming_chatroom_fk" FOREIGN KEY ("str_num") REFERENCES "streaming" ("str_num")
);

CREATE SEQUENCE streaming_chatroom_seq;

CREATE TABLE "streaming_chattage" (
	"strT_num"	number		NOT NULL,  -- 시청번호
	"strT_chat"	varchar2(300)		NOT NULL,  -- 채팅메세지
	"strT_date"	date		NOT NULL,  -- 채팅날짜
	"strC_num"	number		NOT NULL,  -- 채팅방번호
	CONSTRAINT "streaming_chattage_pk" PRIMARY KEY ("strT_num"),
	CONSTRAINT "streaming_chattage_fk" FOREIGN KEY ("strC_num") REFERENCES "streaming_chatroom" ("strC_num")
);

CREATE SEQUENCE streaming_chattage_seq;

CREATE TABLE "alert" (
	"ale_num"	number		NOT NULL,  -- 알람고유번호
	"ale_content"	varchar2(300)		NOT NULL,  -- 알람 내용
	"ale_category"	number(1)		NOT NULL,  -- 0:출석알림 1: 새댓글 알림 2:신고처리알림 3:결제완료 알림
	"ale_time"	date	DEFAULT SYSDATE	NOT NULL,  -- 알람 도착일
	"ale_check"	varchar2(255)	DEFAULT '0'	NOT NULL,  -- 0: 확인x 1: 확인 o
	"mem_num"	number		NOT NULL,  -- 회원고유의 번호
	CONSTRAINT "alert_pk" PRIMARY KEY ("ale_num"),
	CONSTRAINT "alert_fk" FOREIGN KEY ("mem_num") REFERENCES "member" ("mem_num")
);

CREATE SEQUENCE alert_seq;

CREATE TABLE "chat_text" (
	"chaT_num"	number		NOT NULL,  -- 메세지고유번호
	"chaT_txt"	clob		NOT NULL,  -- 메세지 내용
	"chaT_time"	date	DEFAULT SYSDATE	NOT NULL,  -- 메세지를 전송한 시간
	"chaT_status"	number		NOT NULL,  -- 신고시비활성화
	"chaR_num"	number		NOT NULL,  -- 채팅방고유번호
	CONSTRAINT "chat_text_pk" PRIMARY KEY ("chaT_num"),
	CONSTRAINT "chat_text_fk" FOREIGN KEY ("chaR_num") REFERENCES "chatRoom" ("chaR_num")
);

CREATE SEQUENCE chat_text_seq;

CREATE TABLE "team" (
	"tea_num"	number		NOT NULL,  -- 모임번호를 식별하는 번호
	"tea_name"	varchar2(40)		NOT NULL,  -- 등록할 모임의 이름
	"tea_content"	clob		NOT NULL,  -- 모임에 대한 설명
	"tea_time"	varchar2(30)		NULL,  -- 모임이 진행되는 날짜
	"tea_location"	varchar2(50)		NOT NULL,  -- 모임을 진행할 장소(지도API)
	"tea_rdate"	date	DEFAULT SYSDATE	NOT NULL,  -- 모임을 등록한 날짜
	"tea_man"	number(2)	DEFAULT 2	NOT NULL,  -- 최대 모집인원 설정 가능(최대 99)
	"tea_hit"	number		NOT NULL,  -- 모임창 클릭 조회수
	"tea_status"	number	DEFAULT 0	NOT NULL,  -- 신고처리시 모임 비활성화(기본0,비활:1)
	"tea_fav"	number	DEFAULT 0	NOT NULL,  -- 관심있는 모임 표현하는 기능(기본:0 선택:1)
	"mem_num"	number		NOT NULL,  -- 회원고유의 번호
	CONSTRAINT "team_pk" PRIMARY KEY ("tea_num"),
	CONSTRAINT "team_fk" FOREIGN KEY ("mem_num") REFERENCES "member" ("mem_num")
);

CREATE SEQUENCE team_seq;

CREATE TABLE "team_Apply" (
	"teaA_num"	number		NOT NULL,  -- 모임 신청을 식별하는 번호
	"teaA_status"	number	DEFAULT 0	NOT NULL,  -- 모임 신청결과 식별(0:승인대기,1:승인2: 거부)
	"teaA_time"	date	DEFAULT SYSDATE	NOT NULL,  -- 신청한 시간을 식별
	"teaA_attend"	number		NOT NULL,  -- 참석여부 신청(참석:1,불참:0)
	"teaA_content"	varchar2(300)		NULL,  -- 신청할때 하고싶은말
	"teaA_auth"	number		NOT NULL,  -- 모임 권한(모임장: 9, 신청자 :0)
	"tea_num"	number		NOT NULL,  -- 모임번호를 식별하는 번호
	CONSTRAINT "team_apply_pk" PRIMARY KEY ("teaA_num"),
	CONSTRAINT "team_apply_fk" FOREIGN KEY ("tea_num") REFERENCES "team" ("tea_num")
);

CREATE SEQUENCE team_apply_seq;

CREATE TABLE "team_board" (
	"teaB_num"	number		NOT NULL,  -- 게시글을 식별 번호
	"teaB_status"	number		NOT NULL,  -- 게시글 공개여부 (0:비공개, 1: 멤버만, 2:모두에게)
	"teaB_title"	varchar2(50)		NOT NULL,  -- 게시글 제목을 저장
	"teaB_content"	clob		NOT NULL,  -- 게시글 내용 저장
	"teaB_rdate"	date	DEFAULT SYSDATE	NOT NULL,  -- 게시글 작성 시간
	"teaB_category"	number(1)		NOT NULL,  -- 게시글 분류(모임 후기, 모임질문, 건의등)
	"teaB_filename"	varchar2(400)		NULL,  -- 게시글 첨부 파일
	"tea_num"	number		NOT NULL,  -- 모임번호를 식별하는 번호
	CONSTRAINT "team_board_pk" PRIMARY KEY ("teaB_num"),
	CONSTRAINT "team_board_fk" FOREIGN KEY ("tea_num") REFERENCES "team" ("tea_num")
);

CREATE SEQUENCE team_board_seq;

CREATE TABLE "team_reply" (
	"teaR_num"	number		NOT NULL,  -- 댓글을 식별하는 번호
	"teaR_content"	varchar2(3000)		NOT NULL,  -- 댓글내용
	"teaR_auth"	number(1)	DEFAULT 0	NOT NULL,  -- 0일반/1신고접수/2정지
	"teaR_rdate"	date	DEFAULT SYSDATE	NOT NULL,  -- 댓글작성날짜
	"teaR_mdate"	date		NULL,  -- 댓글수정날짜
	"teaB_num"	number		NOT NULL,  -- 게시글을 식별 번호
	CONSTRAINT "team_reply_pk" PRIMARY KEY ("teaR_num"),
	CONSTRAINT "team_reply_fk" FOREIGN KEY ("teaB_num") REFERENCES "team_board" ("teaB_num")
);

CREATE SEQUENCE team_reply_seq;

CREATE TABLE "chat_member" (
	"mem_num"	number		NOT NULL,  -- 회원고유의 번호
	"chaR_num"	number		NOT NULL,  -- 채팅방고유번호
	CONSTRAINT "chat_member_fk1" FOREIGN KEY ("mem_num") REFERENCES "member" ("mem_num"),
	CONSTRAINT "chat_member_fk2" FOREIGN KEY ("chaR_num") REFERENCES "chatRoom" ("chaR_num")
);

CREATE SEQUENCE chat_member_seq;

CREATE TABLE "point_game" (
	"poiG_num"	number		NOT NULL,  -- 게임번호
	"poiG_content"	varchar2(500)		NOT NULL,  -- 게임 내용
	"poiG_start"	date		NOT NULL,  -- 게임시작
	"poiG_end"	date		NULL,  -- 게임종료
	"str_num"	number		NOT NULL,  -- 방송 구별을 위한 번호
	CONSTRAINT "point_game_pk" PRIMARY KEY ("poiG_num"),
	CONSTRAINT "point_game_fk" FOREIGN KEY ("str_num") REFERENCES "streaming" ("str_num")
);

CREATE SEQUENCE point_game_seq;

CREATE TABLE "point_game_option" (
	"poiO_num"	number		NOT NULL,  -- 선택지 고유 번호
	"optO_content"	varchar2(500)		NOT NULL,  -- 선택지 내용
	"poiO_no"	number		NULL,  -- 선택지번호
	"poiG_num"	number		NOT NULL,  -- 게임번호
	CONSTRAINT "point_game_option_pk" PRIMARY KEY ("poiO_num"),
	CONSTRAINT "point_game_option_fk" FOREIGN KEY ("poiG_num") REFERENCES "point_game" ("poiG_num")
);

CREATE SEQUENCE point_game_option_seq;

CREATE TABLE "point_game_betting" (
	"bet_num"	number		NOT NULL,  -- 배팅번호
	"bet_point"	number		NOT NULL,  -- 배팅 포인트
	"bet_date"	date	DEFAULT SYSDATE	NOT NULL,  -- 배팅 날짜
	"poiO_num"	number		NOT NULL,  -- 선택지 고유 번호
	CONSTRAINT "point_game_betting_pk" PRIMARY KEY ("bet_num"),
	CONSTRAINT "point_game_betting_fk" FOREIGN KEY ("poiO_num") REFERENCES "point_game_option" ("poiO_num")
);

CREATE SEQUENCE point_game_betting_seq;

CREATE TABLE "mission" (
	"mis_num"	number		NOT NULL,  -- 미션번호
	"mis_point"	number		NOT NULL,  -- 미션포인트
	"mis_content"	varchar2(500)		NOT NULL,  -- 미션내용
	"mis_status"	number		NOT NULL,  -- 0:미수행,1:성공,2:실패
	"mis_date"	date	DEFAULT SYSDATE	NOT NULL,  -- 후원 날짜
	"str_num"	number		NOT NULL,  -- 방송 구별을 위한 번호
	CONSTRAINT "mission_pk" PRIMARY KEY ("mis_num"),
	CONSTRAINT "mission_fk" FOREIGN KEY ("str_num") REFERENCES "streaming" ("str_num")
);

CREATE SEQUENCE mission_seq;

CREATE TABLE "donation" (
	"don_num"	number		NOT NULL,  -- 후원번호
	"don_point"	number		NOT NULL,  -- 후원 포인트
	"don_content"	varchar2(500)		NOT NULL,  -- 후원메세지
	"don_date"	date	DEFAULT SYSDATE	NOT NULL,  -- 후원 날짜
	"str_num"	number		NOT NULL,  -- 방송 구별을 위한 번호
	CONSTRAINT "donation_pk" PRIMARY KEY ("don_num"),
	CONSTRAINT "donation_fk" FOREIGN KEY ("str_num") REFERENCES "streaming" ("str_num")
);

CREATE SEQUENCE donation_seq;

CREATE TABLE "streaming" (
	"str_num"	number		NOT NULL,  -- 방송 구별을 위한 번호
	"mem_num"	number		NOT NULL,  -- 회원고유의 번호
	CONSTRAINT "streaming_pk" PRIMARY KEY ("str_num"),
	CONSTRAINT "streaming_fk" FOREIGN KEY ("mem_num") REFERENCES "member" ("mem_num")
);

CREATE SEQUENCE streaming_seq;

CREATE TABLE "stream_detail" (
	"strD_num"	number		NOT NULL,  -- 방송 구별을 위한 상세 번호
	"strD_title"	varchar2(300)		NOT NULL,  -- 방송제목
	"strD_start"	date	DEFAULT SYSDATE	NOT NULL,  -- 방송 시작 시간
	"strD_end"	date		NULL,  -- 방송 종료 시간
	"str_num"	number		NOT NULL,  -- 방송 구별을 위한 번호
	CONSTRAINT "stream_detail_pk" PRIMARY KEY ("strD_num"),
	CONSTRAINT "stream_detail_fk" FOREIGN KEY ("str_num") REFERENCES "streaming" ("str_num")
);

CREATE SEQUENCE stream_detail_seq;

CREATE TABLE "item" (
	"item_num"	number		NOT NULL,  -- 상품번호
	"item_id"	varchar2(500)		NOT NULL,  -- 상품id
	"item_name"	varchar2(300)		NOT NULL,  -- 상품이름
	"item_price"	number		NOT NULL,  -- 상품가격
	"item_rank"	varchar2(50)		NULL,  -- 상품순위
	"item_average"	varchar2(50)		NULL,  -- 상품평점
	"item_genre"	varchar2(500)		NULL,  -- 상품장르
	"item_image"	varchar2(500)		NULL,  -- 상품 사진
	"item_thumbnail"	varchar2(500)		NULL,  -- 상품썸네일
	"minage"	varchar2(50)		NULL,  -- 최소연령
	"minplayers"	varchar2(50)		NULL,  -- 최소인원
	"maxplayers"	varchar2(50)		NULL,  -- 최대인원
	"description"	clob		NULL,  -- 해설,설명
	"item_year"	varchar2(50)		NOT NULL,  -- 출시연도
	"item_stock"	number(3)		NULL,  -- 재고
	"item_reg_date"	date		NOT NULL,  -- 등록일
	CONSTRAINT "item_pk" PRIMARY KEY ("item_num")
);

CREATE SEQUENCE item_seq;

CREATE TABLE "used_item" (
	"use_num"	number		NOT NULL,  -- 중고번호
	"use_title"	varchar2(150)		NOT NULL,  -- 중고제목
	"use_content"	clob		NOT NULL,  -- 중고글
	"use_photo"	varchar2(400)		NOT NULL,  -- 중고상품사진
	"use_price"	number		NOT NULL,  -- 중고가격
	"use_check"	number(1)	DEFAULT 1	NOT NULL,  -- 1:미판매 2:예약중 3:판매
	"use_rdate"	date	DEFAULT SYSDATE	NOT NULL,  -- 등록일
	"use_mdate"	date		NOT NULL,  -- 수정일
	"use_grade"	number		NULL,  -- 중고거래평점
	"use_comment"	clob		NULL,  -- 중고거래후기
	"item_num"	number		NOT NULL,  -- 상품번호
	"mem_num"	number		NOT NULL,  -- 회원고유의 번호
	CONSTRAINT "used_item_pk" PRIMARY KEY ("use_num"),
	CONSTRAINT "used_item_fk1" FOREIGN KEY ("item_num") REFERENCES "item" ("item_num"),
	CONSTRAINT "used_item_fk2" FOREIGN KEY ("mem_num") REFERENCES "member" ("mem_num")
);

CREATE SEQUENCE used_item_seq;

CREATE TABLE "cart" (
	"item_quantity"	number		NOT NULL,  -- 주문수량
	"item_num"	number		NOT NULL,  -- 상품번호
	"mem_num"	number		NOT NULL,  -- 회원고유의 번호
	CONSTRAINT "cart_fk1" FOREIGN KEY ("item_num") REFERENCES "item" ("item_num"),
	CONSTRAINT "cart_fk2" FOREIGN KEY ("mem_num") REFERENCES "member" ("mem_num")
);

CREATE SEQUENCE cart_seq;

CREATE TABLE "order" (
	"order_num"	number		NOT NULL,  -- 주문번호
	"order_name"	varchar2(500)		NOT NULL,  -- 수령인
	"order_phone"	varchar2(500)		NOT NULL,  -- 수령인 번호
	"order_zipcode"	number		NOT NULL,  -- 우편주소
	"order_address1"	varchar2(500)		NOT NULL,  -- 주소
	"order_address2"	varchar2(500)		NOT NULL,  -- 상세주소
	"order_pay"	number	DEFAULT 1	NOT NULL,  -- 1:계좌이체 2:카드 3:카카오페이
	"order_check"	number(1)	DEFAULT 1	NOT NULL,  -- 1:승인대기 2:배송준비 3:배송 중4:배송완료5:취소
	"order_reg_date"	date	DEFAULT SYSDATE	NOT NULL,  -- 구매일
	"mem_num"	number		NOT NULL,  -- 회원고유의 번호
	CONSTRAINT "order_pk" PRIMARY KEY ("order_num"),
	CONSTRAINT "order_fk" FOREIGN KEY ("mem_num") REFERENCES "member" ("mem_num")
);

CREATE SEQUENCE order_seq;

CREATE TABLE "game_rent" (
	"rent_num"	number		NOT NULL,  -- 게임 대여 목록을 식별하는 번호
	"rent_sdate"	varchar2(30)		NOT NULL,  -- 보드게임 대여 시작일
	"rent_edate"	varchar2(30)		NOT NULL,  -- 보드게임 대여 종료일
	"rent_period"	number(1)		NOT NULL,  -- 보드게임 대여 기간(10일 이내)
	"mem_num"	number		NOT NULL,  -- 회원고유의 번호
	"item_num"	number		NOT NULL,  -- 상품번호
	CONSTRAINT "game_rent_pk" PRIMARY KEY ("rent_num"),
	CONSTRAINT "game_rent_fk1" FOREIGN KEY ("mem_num") REFERENCES "member" ("mem_num"),
	CONSTRAINT "game_rent_fk2" FOREIGN KEY ("item_num") REFERENCES "item" ("item_num")
);

CREATE SEQUENCE game_rent_seq;

CREATE TABLE "board" (
	"boa_num"	number		NOT NULL,  -- 게시글을 식별 번호
	"boa_category"	char(1)		NOT NULL,  -- 1자유게시판/2팁게시판/3후기게시판/4공지사항/5QnA/6모임게시판
	"boa_title"	varchar2(150)		NOT NULL,  -- 게시글 제목
	"boa_content"	clob		NOT NULL,  -- 게시글 내용
	"boa_hit"	number(10)		NOT NULL,  -- 게시글 조회수
	"boa_rdate"	date	DEFAULT SYSDATE	NOT NULL,  -- 게시글 작성 날짜
	"boa_mdate"	date		NULL,  -- 게시글 수정 날짜
	"boa_auth"	number(1)	DEFAULT 0	NOT NULL,  -- 0일반게시글/1신고접수게시글/2정지게시글(Default:0)
	"boa_photo"	varchar2(400)		NULL,  -- 게시글 사진
	"boa_fav"	varchar2(255)		NOT NULL,  -- 게시글 좋아요
	"mem_num"	number		NOT NULL,  -- 회원고유의 번호
	CONSTRAINT "board_pk" PRIMARY KEY ("boa_num"),
	CONSTRAINT "board_fk" FOREIGN KEY ("mem_num") REFERENCES "member" ("mem_num")
);

CREATE SEQUENCE board_seq;

CREATE TABLE "board_reply" (
	"boaR_num"	number		NOT NULL,  -- 댓글을 식별하는 번호
	"mem_num"	number		NOT NULL,  -- 댓글을 작성한 회원 번호
	"boaR_content"	varchar2(1000)		NOT NULL,  -- 댓글내용
	"boaR_auth"	number(1)	DEFAULT 0	NOT NULL,  -- 0일반/1신고접수/2정지
	"boaR_rdate"	date	DEFAULT SYSDATE	NOT NULL,  -- 댓글작성날짜
	"boaR_mdate"	date		NULL,  -- 댓글수정날짜
	"boa_num"	number		NOT NULL,  -- 게시글을 식별 번호
	CONSTRAINT "board_reply_pk" PRIMARY KEY ("boaR_num"),
	CONSTRAINT "board_reply_fk1" FOREIGN KEY ("mem_num") REFERENCES "member" ("mem_num"),
	CONSTRAINT "board_reply_fk2" FOREIGN KEY ("boa_num") REFERENCES "board" ("boa_num")
);

CREATE SEQUENCE board_reply_seq;

CREATE TABLE "board_fav" (
	"mem_num"	number		NOT NULL,  -- 회원고유의 번호
	"boa_num"	number		NOT NULL,  -- 게시글을 식별 번호
	CONSTRAINT "board_fav_fk1" FOREIGN KEY ("mem_num") REFERENCES "member" ("mem_num"),
	CONSTRAINT "board_fav_fk2" FOREIGN KEY ("boa_num") REFERENCES "board" ("boa_num")
);

CREATE SEQUENCE board_fav_seq;

CREATE TABLE "rulebook" (
	"rulB_num"	number		NOT NULL,  -- 게시글을 식별 번호
	"rulB_content"	varchar2(1000)		NOT NULL,  -- 보드게임 내용
	"rulB_filename"	varchar2(400)		NULL,  -- 보드게임 룰 파일
	"rulB_rdate"	date	DEFAULT SYSDATE	NOT NULL,  -- 게시글 작성 날짜
	"rulB_mdate"	date		NULL,  -- 게시글 수정 날짜
	"mem_num"	number		NOT NULL,  -- 회원고유의 번호
	"item_num"	number		NOT NULL,  -- 상품번호
	CONSTRAINT "rulebook_pk" PRIMARY KEY ("rulB_num"),
	CONSTRAINT "rulebook_fk1" FOREIGN KEY ("mem_num") REFERENCES "member" ("mem_num"),
	CONSTRAINT "rulebook_fk2" FOREIGN KEY ("item_num") REFERENCES "item" ("item_num")
);

CREATE SEQUENCE rulebook_seq;

CREATE TABLE "point_Total" (
	"point_Total"	varchar2(255)		NOT NULL,  -- 총포인트
	"mem_num"	number		NOT NULL,  -- 회원고유의 번호
	CONSTRAINT "point_Total_fk" FOREIGN KEY ("mem_num") REFERENCES "member" ("mem_num")
);

CREATE SEQUENCE point_Total_seq;

CREATE TABLE "point" (
	"poi_num"	number		NOT NULL,  -- 포인트번호
	"poi_status"	number	DEFAULT 1	NOT NULL,  -- 포인트사용유형
	"poi_use"	number		NOT NULL,  -- 사용포인트
	"poi_date"	date	DEFAULT SYSDATE	NOT NULL,  -- 사용일
	"mem_num"	number		NOT NULL,  -- 회원고유의 번호
	CONSTRAINT "point_pk" PRIMARY KEY ("poi_num"),
	CONSTRAINT "point_fk" FOREIGN KEY ("mem_num") REFERENCES "member" ("mem_num")
);

CREATE SEQUENCE point_seq;

CREATE TABLE "chatRoom" (
	"chaR_num"	number		NOT NULL,  -- 채팅방고유번호
	"chaR_status"	number(1)	DEFAULT 1	NOT NULL,  -- 0:비활성화 1:활성화
	"chaR_name"	varchar2(100)		NOT NULL,  -- 채팅방 이름
	"chaR_date"	date	DEFAULT SYSDATE	NOT NULL,  -- 채팅방이 만들어진 날짜
	"tea_num"	number		NOT NULL,  -- 모임번호를 식별하는 번호
	CONSTRAINT "chatRoom_pk" PRIMARY KEY ("chaR_num"),
	CONSTRAINT "chatRoom_fk" FOREIGN KEY ("tea_num") REFERENCES "team" ("tea_num")
);

CREATE SEQUENCE chatRoom_seq;

CREATE TABLE "usedChatRoom" (
	"useC_num"	number		NOT NULL,  -- 채팅방 식별 번호
	"useC_status"	number(1)	DEFAULT 1	NOT NULL,  -- 0:비활성화 1:활성화
	"useC_name"	varchar2(100)		NOT NULL,  -- 채팅방 이름
	"useC_date"	date	DEFAULT SYSDATE	NOT NULL,  -- 채팅방이 만들어진 날짜
	"use_num"	number		NOT NULL,  -- 중고번호
	"mem_num"	number		NOT NULL,  -- 회원고유의 번호
	CONSTRAINT "usedChatRoom_pk" PRIMARY KEY ("useC_num"),
	CONSTRAINT "usedChatRoom_fk1" FOREIGN KEY ("use_num") REFERENCES "used_item" ("use_num"),
	CONSTRAINT "usedChatRoom_fk2" FOREIGN KEY ("mem_num") REFERENCES "member" ("mem_num")
);

CREATE SEQUENCE usedChatRoom_seq;

CREATE TABLE "usedChat_text" (
	"chaC_num"	number		NOT NULL,  -- 메세지고유번호
	"chaC_txt"	clob		NOT NULL,  -- 메세지 내용
	"chaC_time"	date	DEFAULT SYSDATE	NOT NULL,  -- 메세지를 전송한 시간
	"chaC_status"	number		NOT NULL,  -- 신고시비활성화
	"chaC_check"	number(1)		NOT NULL,  -- 확인 여부
	"useC_num"	number		NOT NULL,  -- 채팅방 식별 번호
	"mem_num"	number		NOT NULL,  -- 회원고유의 번호
	CONSTRAINT "usedChat_text_pk" PRIMARY KEY ("chaC_num"),
	CONSTRAINT "usedChat_text_fk1" FOREIGN KEY ("useC_num") REFERENCES "usedChatRoom" ("useC_num"),
	CONSTRAINT "usedChat_text_fk2" FOREIGN KEY ("mem_num") REFERENCES "member" ("mem_num")
);

CREATE SEQUENCE usedChat_text_seq;

CREATE TABLE "report" (
	"report_num"	number		NOT NULL,  -- 신고 목록을 식별하는 번호
	"reporter_num"	number		NOT NULL,  -- 신고자를 식별하는 번호
	"report_content"	varchar2(500)		NOT NULL,  -- 신고 처리를 위한 사유
	"report_date"	date	DEFAULT SYSDATE	NOT NULL,  -- 신고 접수일
	"report_type"	number(1)		NOT NULL,  -- 신고 분류를 식별하는 번호
	"report_typeDetail"	number		NOT NULL,  -- 신고당한 게시글, 댓글, 방송, 채팅, 모임을 식별하는 번호
	"mem_num"	number		NOT NULL,  -- 회원고유의 번호
	CONSTRAINT "report_pk" PRIMARY KEY ("report_num"),
	CONSTRAINT "report_fk" FOREIGN KEY ("mem_num") REFERENCES "member" ("mem_num")
);

CREATE SEQUENCE report_seq;

CREATE TABLE "item_rent_Stock" (
	"item_rstock"	number(3)		NULL,  -- 대여상품재고
	"item_restock"	number(3)		NULL,  -- 중고상품재고
	"use_num"	number		NOT NULL,  -- 중고번호
	CONSTRAINT "item_rent_Stock_fk" FOREIGN KEY ("use_num") REFERENCES "used_item" ("use_num")
);

CREATE SEQUENCE item_rent_Stock_seq;
