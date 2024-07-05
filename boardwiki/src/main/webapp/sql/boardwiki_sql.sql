-- 회원 테이블
CREATE TABLE member (
	mem_num    NUMBER      NOT NULL, -- 회원고유의 번호
	mem_email  VARCHAR2(50)  NOT NULL, -- 회원 이메일(아이디용)
	mem_auth   NUMBER(1)   NOT NULL -- 회원등급(일반 0, 정지 1, 탈퇴 2, 관리자 9)
);
ALTER TABLE member ADD CONSTRAINT member_pk PRIMARY KEY (mem_num);
CREATE SEQUENCE member_mem_num_seq;

-- 회원 상세 테이블
CREATE TABLE member_detail (
	mem_num      NUMBER        NOT NULL, -- 회원고유의 번호
	mem_name     VARCHAR2(30)  NOT NULL, -- 회원 이름
	mem_nickname VARCHAR2(50)  NULL, -- 회원 별명
	mem_passwd   VARCHAR2(50)  NOT NULL, -- 회원 비밀번호 (영문+숫자 4~12)
	mem_phone    VARCHAR2(15)  NOT NULL, -- 회원 전화번호 (000-0000-0000 형식)
	mem_provider VARCHAR2(10)  NULL, -- 회원 가입 정보 제공자
	mem_rdate    DATE          DEFAULT SYSDATE NOT NULL, -- 회원 가입 날짜
	mem_mdate    DATE          NULL, -- 회원 수정 날짜
	mem_photo    VARCHAR2(400) DEFAULT 'face.png' NULL -- 회원 프로필 사진
);
ALTER TABLE member_detail ADD CONSTRAINT member_detail_pk PRIMARY KEY (mem_num);
ALTER TABLE member_detail ADD CONSTRAINT member_detail__fk1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
CREATE SEQUENCE member_detail_mem_num_seq;

-- 출석 테이블
CREATE TABLE attendance (
	att_num     NUMBER      NOT NULL, -- 출석번호
	mem_num     NUMBER      NOT NULL, -- 회원고유의 번호
	att_date    DATE        NOT NULL, -- 출석날짜
	att_status  NUMBER      DEFAULT 1 NOT NULL -- 1:미출석 2:출석
);
ALTER TABLE attendance ADD CONSTRAINT attendance_pk PRIMARY KEY (att_num, mem_num);
ALTER TABLE attendance ADD CONSTRAINT attendance__fk1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
CREATE SEQUENCE attendance_att_num_seq;

-- 스트리밍 테이블 
CREATE TABLE streaming (
	str_num NUMBER NOT NULL, -- 방송 구별 번호
	mem_num NUMBER NOT NULL -- 회원고유의 번호
);
ALTER TABLE streaming ADD CONSTRAINT streaming_pk PRIMARY KEY (str_num, mem_num);
CREATE SEQUENCE streaming_str_num_seq;

-- 스트리밍 시청 시간 테이블
CREATE TABLE stream_view_time (
	view_id    NUMBER      NOT NULL, -- 시청 번호
	str_num    NUMBER      NOT NULL, -- 방송 구별 번호
	mem_num    NUMBER      NOT NULL, -- 회원고유의 번호
	view_start DATE        NOT NULL, -- 시청 시작 시간
	view_end   DATE        NOT NULL -- 시청 종료 시간
);
ALTER TABLE stream_view_time ADD CONSTRAINT stream_view_time_pk PRIMARY KEY (view_id, str_num, mem_num);
ALTER TABLE stream_view_time ADD CONSTRAINT stream_view_time__fk1 FOREIGN KEY (str_num) REFERENCES streaming (str_num);
ALTER TABLE stream_view_time ADD CONSTRAINT stream_view_time__fk2 FOREIGN KEY (mem_num) REFERENCES streaming (mem_num);
CREATE SEQUENCE stream_view_time_view_id_seq;

-- 스트리밍 채팅방 테이블
CREATE TABLE streaming_chatroom (
	strC_num NUMBER NOT NULL, -- 채팅방 번호
	str_num  NUMBER NOT NULL, -- 방송 구별 번호
	mem_num  NUMBER NOT NULL -- 회원고유의 번호
);
ALTER TABLE streaming_chatroom ADD CONSTRAINT streaming_chatroom_pk PRIMARY KEY (strC_num, str_num, mem_num);
ALTER TABLE streaming_chatroom ADD CONSTRAINT streaming_chatroom__fk1 FOREIGN KEY (str_num) REFERENCES streaming (str_num);
ALTER TABLE streaming_chatroom ADD CONSTRAINT streaming_chatroom__fk2 FOREIGN KEY (mem_num) REFERENCES streaming (mem_num);
CREATE SEQUENCE streaming_chatroom_strC_num_seq;

-- 스트리밍 채팅 메시지 테이블
CREATE TABLE streaming_chattage (
	strT_num  NUMBER       NOT NULL, -- 시청 번호
	strC_num  NUMBER       NOT NULL, -- 채팅방 번호
	str_num   NUMBER       NOT NULL, -- 방송 구별 번호
	mem_num   NUMBER       NOT NULL, -- 회원고유의 번호
	strT_chat VARCHAR2(300) NOT NULL, -- 채팅 메시지
	strT_date DATE         NOT NULL -- 채팅 날짜
);
ALTER TABLE streaming_chattage ADD CONSTRAINT streaming_chattage_pk PRIMARY KEY (strT_num, strC_num, str_num, mem_num);
ALTER TABLE streaming_chattage ADD CONSTRAINT streaming_chattage__fk1 FOREIGN KEY (strC_num) REFERENCES streaming_chatroom (strC_num);
ALTER TABLE streaming_chattage ADD CONSTRAINT streaming_chattage__fk2 FOREIGN KEY (str_num) REFERENCES streaming_chatroom (str_num);
ALTER TABLE streaming_chattage ADD CONSTRAINT streaming_chattage__fk3 FOREIGN KEY (mem_num) REFERENCES streaming_chatroom (mem_num);
CREATE SEQUENCE streaming_chattage_strT_num_seq;

-- 알람 테이블
CREATE TABLE alert (
	ale_num     NUMBER        NOT NULL, -- 알람 고유 번호
	mem_num     NUMBER        NOT NULL, -- 회원고유의 번호
	ale_content VARCHAR2(300) NOT NULL, -- 알람 내용
	ale_category NUMBER(1)    NOT NULL, -- 알람 카테고리 (0:출석알림, 1:새댓글 알림, 2:신고처리알림, 3:결제완료 알림)
	ale_time    DATE          DEFAULT SYSDATE NOT NULL, -- 알람 도착일
	ale_check   VARCHAR2(1)   DEFAULT '0' NOT NULL -- 알람 확인 여부 (0: 확인x, 1: 확인o)
);
ALTER TABLE alert ADD CONSTRAINT alert_pk PRIMARY KEY (ale_num, mem_num);
ALTER TABLE alert ADD CONSTRAINT alert__fk1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
CREATE SEQUENCE alert_ale_num_seq;

-- 채팅 메시지 테이블
CREATE TABLE chat_text (
	chaT_num   NUMBER       NOT NULL, -- 메시지 고유 번호
	chaR_num   NUMBER       NOT NULL, -- 채팅방 고유 번호
	tea_num    NUMBER       NOT NULL, -- 모임 번호
	mem_num    NUMBER       NOT NULL, -- 회원고유의 번호
	chaT_txt   CLOB         NOT NULL, -- 메시지 내용
	chaT_time  DATE         DEFAULT SYSDATE NOT NULL, -- 메시지 전송 시간
	chaT_status NUMBER      NOT NULL -- 메시지 상태
);
ALTER TABLE chat_text ADD CONSTRAINT chat_text_pk PRIMARY KEY (chaT_num, chaR_num, tea_num, mem_num);
ALTER TABLE chat_text ADD CONSTRAINT chat_text__fk1 FOREIGN KEY (chaR_num) REFERENCES chatRoom (chaR_num);
ALTER TABLE chat_text ADD CONSTRAINT chat_text__fk2 FOREIGN KEY (tea_num) REFERENCES chatRoom (tea_num);
ALTER TABLE chat_text ADD CONSTRAINT chat_text__fk3 FOREIGN KEY (mem_num) REFERENCES chatRoom (mem_num);
CREATE SEQUENCE chat_text_chaT_num_seq;

-- 모임 테이블
CREATE TABLE team (
	tea_num    NUMBER        NOT NULL, -- 모임 번호
	mem_num    NUMBER        NOT NULL, -- 모임 주최자 번호
	tea_name   VARCHAR2(40)  NOT NULL, -- 모임 이름
	tea_content CLOB         NOT NULL, -- 모임 설명
	tea_time   VARCHAR2(30)  NULL, -- 모임 진행 날짜
	tea_location VARCHAR2(50) NOT NULL, -- 모임 장소 (지도 API)
	tea_rdate  DATE          DEFAULT SYSDATE NOT NULL, -- 모임 등록 날짜
	tea_man    NUMBER(2)     DEFAULT 2 NOT NULL, -- 최대 모집 인원
	tea_hit    NUMBER        NOT NULL, -- 모임 조회수
	tea_status NUMBER        DEFAULT 0 NOT NULL, -- 모임 상태 (기본 0, 비활성화 1)
	tea_fav    NUMBER        DEFAULT 0 NOT NULL -- 모임 관심 여부 (기본 0, 관심 1)
);
ALTER TABLE team ADD CONSTRAINT team_pk PRIMARY KEY (tea_num, mem_num);
ALTER TABLE team ADD CONSTRAINT team__fk1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
CREATE SEQUENCE team_tea_num_seq;

-- 모임 신청 테이블
CREATE TABLE team_apply (
	teaA_num    NUMBER        NOT NULL, -- 모임 신청 번호
	tea_num     NUMBER        NOT NULL, -- 모임 번호
	mem_num     NUMBER        NOT NULL, -- 회원고유의 번호
	teaA_status NUMBER        DEFAULT 0 NOT NULL, -- 모임 신청 상태 (0: 승인대기, 1: 승인, 2: 거부)
	teaA_time   DATE          DEFAULT SYSDATE NOT NULL, -- 신청 시간
	teaA_attend NUMBER        NOT NULL, -- 참석 여부 (1: 참석, 0: 불참)
	teaA_content VARCHAR2(300) NULL, -- 신청 시 메시지
	teaA_auth   NUMBER        NOT NULL -- 모임 권한 (모임장 9, 신청자 0)
);
ALTER TABLE team_apply ADD CONSTRAINT team_apply_pk PRIMARY KEY (teaA_num, tea_num, mem_num);
ALTER TABLE team_apply ADD CONSTRAINT team_apply__fk1 FOREIGN KEY (tea_num) REFERENCES team (tea_num);
ALTER TABLE team_apply ADD CONSTRAINT team_apply__fk2 FOREIGN KEY (mem_num) REFERENCES team (mem_num);
CREATE SEQUENCE team_apply_teaA_num_seq;

-- 모임 게시판 테이블
CREATE TABLE team_board (
	teaB_num    NUMBER       NOT NULL, -- 게시글 번호
	tea_num     NUMBER       NOT NULL, -- 모임 번호
	mem_num     NUMBER       NOT NULL, -- 회원고유의 번호
	teaB_status NUMBER       NOT NULL, -- 게시글 공개 여부 (0: 비공개, 1: 멤버만, 2: 모두에게 공개)
	teaB_title  VARCHAR2(50) NOT NULL, -- 게시글 제목
	teaB_content CLOB        NOT NULL, -- 게시글 내용
	teaB_rdate  DATE         DEFAULT SYSDATE NOT NULL, -- 게시글 작성 날짜
	teaB_category NUMBER(1)  NOT NULL, -- 게시글 분류
	teaB_filename VARCHAR2(400) NULL -- 게시글 첨부 파일
);
ALTER TABLE team_board ADD CONSTRAINT team_board_pk PRIMARY KEY (teaB_num, tea_num, mem_num);
ALTER TABLE team_board ADD CONSTRAINT team_board__fk1 FOREIGN KEY (tea_num) REFERENCES team (tea_num);
ALTER TABLE team_board ADD CONSTRAINT team_board__fk2 FOREIGN KEY (mem_num) REFERENCES team (mem_num);
CREATE SEQUENCE team_board_teaB_num_seq;

-- 모임 댓글 테이블
CREATE TABLE team_reply (
	teaR_num    NUMBER        NOT NULL, -- 댓글 번호
	teaB_num    NUMBER        NOT NULL, -- 게시글 번호
	tea_num     NUMBER        NOT NULL, -- 모임 번호
	mem_num     NUMBER        NOT NULL, -- 회원고유의 번호
	teaR_content VARCHAR2(3000) NOT NULL, -- 댓글 내용
	teaR_auth   NUMBER(1)     DEFAULT 0 NOT NULL, -- 댓글 권한 (0: 일반, 1: 신고 접수, 2: 정지)
	teaR_rdate  DATE          DEFAULT SYSDATE NOT NULL, -- 댓글 작성 날짜
	teaR_mdate  DATE          NULL -- 댓글 수정 날짜
);
ALTER TABLE team_reply ADD CONSTRAINT team_reply_pk PRIMARY KEY (teaR_num, teaB_num, tea_num, mem_num);
ALTER TABLE team_reply ADD CONSTRAINT team_reply__fk1 FOREIGN KEY (teaB_num) REFERENCES team_board (teaB_num);
ALTER TABLE team_reply ADD CONSTRAINT team_reply__fk2 FOREIGN KEY (tea_num) REFERENCES team_board (tea_num);
ALTER TABLE team_reply ADD CONSTRAINT team_reply__fk3 FOREIGN KEY (mem_num) REFERENCES team_board (mem_num);
CREATE SEQUENCE team_reply_teaR_num_seq;

-- 채팅 멤버 테이블
CREATE TABLE chat_member (
	mem_num  NUMBER NOT NULL, -- 회원고유의 번호
	chaR_num NUMBER NOT NULL -- 채팅방 고유 번호
);
ALTER TABLE chat_member ADD CONSTRAINT chat_member_pk PRIMARY KEY (mem_num, chaR_num);
ALTER TABLE chat_member ADD CONSTRAINT chat_member__fk1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
ALTER TABLE chat_member ADD CONSTRAINT chat_member__fk2 FOREIGN KEY (chaR_num) REFERENCES chatRoom (chaR_num);

-- 포인트 게임 테이블
CREATE TABLE point_game (
	poiG_num    NUMBER       NOT NULL, -- 게임 번호
	str_num     NUMBER       NOT NULL, -- 방송 구별 번호
	mem_num     NUMBER       NOT NULL, -- 회원고유의 번호
	poiG_content VARCHAR2(500) NOT NULL, -- 게임 내용
	poiG_start  DATE         NOT NULL, -- 게임 시작 시간
	poiG_end    DATE         NOT NULL -- 게임 종료 시간
);
ALTER TABLE point_game ADD CONSTRAINT point_game_pk PRIMARY KEY (poiG_num, str_num, mem_num);
ALTER TABLE point_game ADD CONSTRAINT point_game__fk1 FOREIGN KEY (str_num) REFERENCES streaming (str_num);
ALTER TABLE point_game ADD CONSTRAINT point_game__fk2 FOREIGN KEY (mem_num) REFERENCES streaming (mem_num);
CREATE SEQUENCE point_game_poiG_num_seq;

-- 포인트 게임 선택지 테이블
CREATE TABLE point_game_option (
	poiO_num     NUMBER       NOT NULL, -- 선택지 번호
	poiG_num     NUMBER       NOT NULL, -- 게임 번호
	str_num      NUMBER       NOT NULL, -- 방송 구별 번호
	mem_num     NUMBER       NOT NULL, -- 회원고유의 번호
	optO_content VARCHAR2(500) NOT NULL, -- 선택지 내용
	poiO_no      NUMBER       NULL -- 선택지 번호
);
ALTER TABLE point_game_option ADD CONSTRAINT point_game_option_pk PRIMARY KEY (poiO_num, poiG_num, str_num, mem_num);
ALTER TABLE point_game_option ADD CONSTRAINT point_game_option__fk1 FOREIGN KEY (poiG_num) REFERENCES point_game (poiG_num);
ALTER TABLE point_game_option ADD CONSTRAINT point_game_option__fk2 FOREIGN KEY (str_num) REFERENCES point_game (str_num);
ALTER TABLE point_game_option ADD CONSTRAINT point_game_option__fk3 FOREIGN KEY (mem_num) REFERENCES point_game (mem_num);
CREATE SEQUENCE point_game_option_poiO_num_seq;

-- 포인트 게임 배팅 테이블
CREATE TABLE point_game_betting (
	bet_num    NUMBER       NOT NULL, -- 배팅 번호
	poiG_num   NUMBER       NOT NULL, -- 게임 번호
	str_num    NUMBER       NOT NULL, -- 방송 구별 번호
	mem_num    NUMBER       NOT NULL, -- 회원고유의 번호
	poiO_num   NUMBER       NOT NULL, -- 선택지 번호
	bet_point  NUMBER       NOT NULL, -- 배팅 포인트
	bet_date   DATE         DEFAULT SYSDATE NOT NULL -- 배팅 날짜
);
ALTER TABLE point_game_betting ADD CONSTRAINT point_game_betting_pk PRIMARY KEY (bet_num, poiG_num, str_num, mem_num, poiO_num);
ALTER TABLE point_game_betting ADD CONSTRAINT point_game_betting__fk1 FOREIGN KEY (poiG_num) REFERENCES point_game_option (poiG_num);
ALTER TABLE point_game_betting ADD CONSTRAINT point_game_betting__fk2 FOREIGN KEY (str_num) REFERENCES point_game_option (str_num);
ALTER TABLE point_game_betting ADD CONSTRAINT point_game_betting__fk3 FOREIGN KEY (mem_num) REFERENCES point_game_option (mem_num);
ALTER TABLE point_game_betting ADD CONSTRAINT point_game_betting__fk4 FOREIGN KEY (poiO_num) REFERENCES point_game_option (poiO_num);
CREATE SEQUENCE point_game_betting_bet_num_seq;

-- 미션 테이블
CREATE TABLE mission (
	mis_num     NUMBER       NOT NULL, -- 미션 번호
	str_num     NUMBER       NOT NULL, -- 방송 구별 번호
	mem_num     NUMBER       NOT NULL, -- 회원고유의 번호
	mis_point   NUMBER       NOT NULL, -- 미션 포인트
	mis_content VARCHAR2(500) NOT NULL, -- 미션 내용
	mis_status  NUMBER       NOT NULL, -- 미션 상태 (0: 미수행, 1: 성공, 2: 실패)
	mis_date    DATE         DEFAULT SYSDATE NOT NULL -- 미션 날짜
);
ALTER TABLE mission ADD CONSTRAINT mission_pk PRIMARY KEY (mis_num, str_num, mem_num);
ALTER TABLE mission ADD CONSTRAINT mission__fk1 FOREIGN KEY (str_num) REFERENCES streaming (str_num);
ALTER TABLE mission ADD CONSTRAINT mission__fk2 FOREIGN KEY (mem_num) REFERENCES streaming (mem_num);
CREATE SEQUENCE mission_mis_num_seq;

-- 후원 테이블
CREATE TABLE donation (
	don_num     NUMBER       NOT NULL, -- 후원 번호
	str_num     NUMBER       NOT NULL, -- 방송 구별 번호
	mem_num     NUMBER       NOT NULL, -- 회원고유의 번호
	don_point   NUMBER       NOT NULL, -- 후원 포인트
	don_content VARCHAR2(500) NOT NULL, -- 후원 메시지
	don_date    DATE         DEFAULT SYSDATE NOT NULL -- 후원 날짜
);
ALTER TABLE donation ADD CONSTRAINT donation_pk PRIMARY KEY (don_num, str_num, mem_num);
ALTER TABLE donation ADD CONSTRAINT donation__fk1 FOREIGN KEY (str_num) REFERENCES streaming (str_num);
ALTER TABLE donation ADD CONSTRAINT donation__fk2 FOREIGN KEY (mem_num) REFERENCES streaming (mem_num);
CREATE SEQUENCE donation_don_num_seq;

-- 스트리밍 상세 테이블
CREATE TABLE stream_detail (
	strD_num  NUMBER       NOT NULL, -- 방송 상세 번호
	str_num   NUMBER       NOT NULL, -- 방송 구별 번호
	mem_num   NUMBER       NOT NULL, -- 회원고유의 번호
	strD_title VARCHAR2(300) NOT NULL, -- 방송 제목
	strD_start DATE        DEFAULT SYSDATE NOT NULL, -- 방송 시작 시간
	strD_end   DATE        NOT NULL -- 방송 종료 시간
);
ALTER TABLE stream_detail ADD CONSTRAINT stream_detail_pk PRIMARY KEY (strD_num, str_num, mem_num);
ALTER TABLE stream_detail ADD CONSTRAINT stream_detail__fk1 FOREIGN KEY (str_num) REFERENCES streaming (str_num);
ALTER TABLE stream_detail ADD CONSTRAINT stream_detail__fk2 FOREIGN KEY (mem_num) REFERENCES streaming (mem_num);
CREATE SEQUENCE stream_detail_strD_num_seq;

-- 상품 테이블
CREATE TABLE item (
	item_num      NUMBER        NOT NULL, -- 상품 번호
	item_id       VARCHAR2(500) NOT NULL, -- 상품 ID
	item_name     VARCHAR2(300) NOT NULL, -- 상품 이름
	item_price    NUMBER        NOT NULL, -- 상품 가격
	item_rank     VARCHAR2(50)  NULL, -- 상품 순위
	item_average  VARCHAR2(50)  NULL, -- 상품 평점
	item_genre    VARCHAR2(500) NULL, -- 상품 장르
	item_image    VARCHAR2(500) NULL, -- 상품 이미지
	item_thumbnail VARCHAR2(500) NULL, -- 상품 썸네일
	minage        VARCHAR2(50)  NULL, -- 최소 연령
	minplayers    VARCHAR2(50)  NULL, -- 최소 인원
	maxplayers    VARCHAR2(50)  NULL, -- 최대 인원
	description   CLOB          NULL, -- 설명
	item_year     VARCHAR2(50)  NOT NULL, -- 출시 연도
	item_stock    NUMBER(3)     NULL, -- 재고
	item_reg_date DATE          NOT NULL -- 등록일
);
ALTER TABLE item ADD CONSTRAINT item_pk PRIMARY KEY (item_num);
CREATE SEQUENCE item_item_num_seq;

-- 중고 상품 테이블
CREATE TABLE used_item (
	use_num    NUMBER        NOT NULL, -- 중고 번호
	mem_num    NUMBER        NOT NULL, -- 회원고유의 번호
	item_num   NUMBER        NOT NULL, -- 상품 번호
	use_title  VARCHAR2(150) NOT NULL, -- 중고 제목
	use_content CLOB         NOT NULL, -- 중고 내용
	use_photo  VARCHAR2(400) NOT NULL, -- 중고 상품 사진
	use_price  NUMBER(10)    NOT NULL, -- 중고 가격
	use_check  NUMBER(1)     DEFAULT 1 NOT NULL, -- 상태 (1:미판매, 2:예약중, 3:판매)
	use_rdate  DATE          DEFAULT SYSDATE NOT NULL, -- 등록일
	use_mdate  DATE          NOT NULL, -- 수정일
	use_grade  NUMBER        NULL, -- 중고 거래 평점
	use_comment CLOB         NULL -- 중고 거래 후기
);
ALTER TABLE used_item ADD CONSTRAINT used_item_pk PRIMARY KEY (use_num, mem_num, item_num);
ALTER TABLE used_item ADD CONSTRAINT used_item__fk1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
ALTER TABLE used_item ADD CONSTRAINT used_item__fk2 FOREIGN KEY (item_num) REFERENCES item (item_num);
CREATE SEQUENCE used_item_use_num_seq;

-- 장바구니 테이블
CREATE TABLE cart (
	mem_num      NUMBER NOT NULL, -- 회원고유의 번호
	item_num     NUMBER NOT NULL, -- 상품 번호
	item_quantity NUMBER NOT NULL -- 주문 수량
);
ALTER TABLE cart ADD CONSTRAINT cart_pk PRIMARY KEY (mem_num, item_num);
ALTER TABLE cart ADD CONSTRAINT cart__fk1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
ALTER TABLE cart ADD CONSTRAINT cart__fk2 FOREIGN KEY (item_num) REFERENCES item (item_num);

-- 주문 테이블
CREATE TABLE orders (
	order_num     NUMBER         NOT NULL, -- 주문 번호
	mem_num       NUMBER         NOT NULL, -- 회원고유의 번호
	item_num      NUMBER         NOT NULL, -- 상품 번호
	order_name    VARCHAR2(500)  NOT NULL, -- 수령인
	order_phone   VARCHAR2(500)  NOT NULL, -- 수령인 전화번호
	order_zipcode NUMBER         NOT NULL, -- 우편번호
	order_address1 VARCHAR2(500) NOT NULL, -- 주소
	order_address2 VARCHAR2(500) NOT NULL, -- 상세주소
	order_pay     NUMBER(1)      DEFAULT 1 NOT NULL, -- 결제 방식 (1:계좌이체, 2:카드, 3:카카오페이)
	order_check   NUMBER(1)      DEFAULT 1 NOT NULL, -- 주문 상태 (1:승인대기, 2:배송준비, 3:배송 중, 4:배송완료, 5:취소)
	order_reg_date DATE          DEFAULT SYSDATE NOT NULL -- 구매일
);
ALTER TABLE orders ADD CONSTRAINT orders_pk PRIMARY KEY (order_num, mem_num, item_num);
ALTER TABLE orders ADD CONSTRAINT orders__fk1 FOREIGN KEY (mem_num) REFERENCES cart (mem_num);
ALTER TABLE orders ADD CONSTRAINT orders__fk2 FOREIGN KEY (item_num) REFERENCES cart (item_num);
CREATE SEQUENCE orders_order_num_seq;

-- 게임 대여 테이블
CREATE TABLE game_rent (
	rent_num   NUMBER        NOT NULL, -- 게임 대여 번호
	item_num   NUMBER        NOT NULL, -- 상품 번호
	mem_num    NUMBER        NOT NULL, -- 회원고유의 번호
	rent_sdate VARCHAR2(30)  NOT NULL, -- 대여 시작일
	rent_edate VARCHAR2(30)  NOT NULL, -- 대여 종료일
	rent_period NUMBER(1)    NOT NULL -- 대여 기간 (10일 이내)
);
ALTER TABLE game_rent ADD CONSTRAINT game_rent_pk PRIMARY KEY (rent_num, item_num, mem_num);
ALTER TABLE game_rent ADD CONSTRAINT game_rent__fk1 FOREIGN KEY (item_num) REFERENCES item (item_num);
ALTER TABLE game_rent ADD CONSTRAINT game_rent__fk2 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
CREATE SEQUENCE game_rent_rent_num_seq;

-- 게시판 테이블
CREATE TABLE board (
	boa_num    NUMBER       NOT NULL, -- 게시글 번호
	mem_num    NUMBER       NOT NULL, -- 회원고유의 번호
	game_num   CHAR(1)      NOT NULL, -- 게시판 구분 (1:자유게시판, 2:팁게시판, 3:후기게시판, 4:공지사항, 5:QnA, 6:모임게시판)
	boa_title  VARCHAR2(150) NOT NULL, -- 게시글 제목
	boa_content CLOB        NOT NULL, -- 게시글 내용
	boa_hit    NUMBER(10)   NOT NULL, -- 게시글 조회수
	boa_rdate  DATE         DEFAULT SYSDATE NOT NULL, -- 게시글 작성 날짜
	boa_mdate  DATE         NULL, -- 게시글 수정 날짜
	boa_auth   NUMBER(1)    NOT NULL, -- 게시글 권한 (0: 일반, 1: 신고 접수, 2: 정지)
	boa_photo  VARCHAR2(400) NULL, -- 게시글 사진
	boa_fav    VARCHAR2(1)  NOT NULL -- 게시글 좋아요
);
ALTER TABLE board ADD CONSTRAINT board_pk PRIMARY KEY (boa_num, mem_num);
CREATE SEQUENCE board_boa_num_seq;

-- 게시판 댓글 테이블
CREATE TABLE board_reply (
	boaR_num    NUMBER        NOT NULL, -- 댓글 번호
	boa_num     NUMBER        NOT NULL, -- 게시글 번호
	mem_num    NUMBER        NOT NULL, -- 회원고유의 번호
	mem_num     NUMBER        NOT NULL, -- 댓글 작성자 번호
	boaR_content VARCHAR2(1000) NOT NULL, -- 댓글 내용
	boaR_auth   NUMBER(1)     NOT NULL, -- 댓글 권한 (0: 일반, 1: 신고 접수, 2: 정지)
	boaR_rdate  DATE          NOT NULL, -- 댓글 작성 날짜 (기본: SYSDATE)
	boaR_mdate  DATE          NULL -- 댓글 수정 날짜
);
ALTER TABLE board_reply ADD CONSTRAINT board_reply_pk PRIMARY KEY (boaR_num, boa_num, mem_num);
ALTER TABLE board_reply ADD CONSTRAINT board_reply__fk1 FOREIGN KEY (boa_num) REFERENCES board (boa_num);
ALTER TABLE board_reply ADD CONSTRAINT board_reply__fk2 FOREIGN KEY (mem_num) REFERENCES board (mem_num);
CREATE SEQUENCE board_reply_boaR_num_seq;

-- 게시글 좋아요 테이블
CREATE TABLE board_fav (
	boa_num  NUMBER NOT NULL, -- 게시글 번호
	mem_num NUMBER NOT NULL -- 회원고유의 번호
);
ALTER TABLE board_fav ADD CONSTRAINT board_fav_pk PRIMARY KEY (boa_num, mem_num);
ALTER TABLE board_fav ADD CONSTRAINT board_fav__fk1 FOREIGN KEY (boa_num) REFERENCES board (boa_num);
ALTER TABLE board_fav ADD CONSTRAINT board_fav__fk2 FOREIGN KEY (mem_num) REFERENCES member (mem_num);

-- 룰북 테이블
CREATE TABLE rulebook (
	rulB_num    NUMBER       NOT NULL, -- 게시글 번호
	item_num    NUMBER       NOT NULL, -- 상품 번호
	mem_num     NUMBER       NOT NULL, -- 회원고유의 번호
	rulB_content VARCHAR2(1000) NOT NULL, -- 룰북 내용
	rulB_filename VARCHAR2(400) NULL, -- 룰북 파일명
	rulB_rdate  DATE         DEFAULT SYSDATE NOT NULL, -- 작성 날짜
	rulB_mdate  DATE         NULL -- 수정 날짜
);
ALTER TABLE rulebook ADD CONSTRAINT rulebook_pk PRIMARY KEY (rulB_num, item_num, mem_num);
ALTER TABLE rulebook ADD CONSTRAINT rulebook__fk1 FOREIGN KEY (item_num) REFERENCES item (item_num);
ALTER TABLE rulebook ADD CONSTRAINT rulebook__fk2 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
CREATE SEQUENCE rulebook_rulB_num_seq;

-- 포인트 총계 테이블
CREATE TABLE point_total (
	mem_num    NUMBER       NOT NULL, -- 회원고유의 번호
	point_total VARCHAR2(255) NOT NULL -- 총 포인트
);
ALTER TABLE point_total ADD CONSTRAINT point_total_pk PRIMARY KEY (mem_num);
ALTER TABLE point_total ADD CONSTRAINT point_total__fk1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);

-- 포인트 테이블
CREATE TABLE point (
	poi_num    NUMBER       NOT NULL, -- 포인트 번호
	mem_num    NUMBER       NOT NULL, -- 회원고유의 번호
	poi_status NUMBER       DEFAULT 1 NOT NULL, -- 포인트 사용 유형
	poi_use    NUMBER       NOT NULL, -- 사용 포인트
	poi_date   DATE         DEFAULT SYSDATE NOT NULL -- 사용일
);
ALTER TABLE point ADD CONSTRAINT point_pk PRIMARY KEY (poi_num, mem_num);
ALTER TABLE point ADD CONSTRAINT point__fk1 FOREIGN KEY (mem_num) REFERENCES point_total (mem_num);
CREATE SEQUENCE point_poi_num_seq;

-- 채팅방 테이블
CREATE TABLE chatroom (
	chaR_num    NUMBER       NOT NULL, -- 채팅방 고유 번호
	tea_num     NUMBER       NOT NULL, -- 모임 번호
	mem_num     NUMBER       NOT NULL, -- 회원고유의 번호
	chaR_status NUMBER(1)    DEFAULT 1 NOT NULL, -- 상태 (0: 비활성화, 1: 활성화)
	chaR_name   VARCHAR2(100) NOT NULL, -- 채팅방 이름
	chaR_date   DATE         DEFAULT SYSDATE NOT NULL -- 생성 날짜
);
ALTER TABLE chatroom ADD CONSTRAINT chatroom_pk PRIMARY KEY (chaR_num, tea_num, mem_num);
ALTER TABLE chatroom ADD CONSTRAINT chatroom__fk1 FOREIGN KEY (tea_num) REFERENCES team (tea_num);
ALTER TABLE chatroom ADD CONSTRAINT chatroom__fk2 FOREIGN KEY (mem_num) REFERENCES team (mem_num);
CREATE SEQUENCE chatroom_chaR_num_seq;

-- 중고 거래 채팅방 테이블
CREATE TABLE usedChatRoom (
	useC_num   NUMBER       NOT NULL, -- 채팅방 고유 번호
	mem_num    NUMBER       NOT NULL, -- 구매자
	use_num    NUMBER       NOT NULL, -- 중고 번호
	item_num   NUMBER       NOT NULL, -- 상품 번호
	useC_status NUMBER(1)   DEFAULT 1 NOT NULL, -- 상태 (0: 비활성화, 1: 활성화)
	useC_name  VARCHAR2(100) NOT NULL, -- 채팅방 이름
	useC_date  DATE         DEFAULT SYSDATE NOT NULL -- 생성 날짜
);
ALTER TABLE usedChatRoom ADD CONSTRAINT usedChatRoom_pk PRIMARY KEY (useC_num, mem_num, use_num, item_num);
ALTER TABLE usedChatRoom ADD CONSTRAINT usedChatRoom__fk1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
ALTER TABLE usedChatRoom ADD CONSTRAINT usedChatRoom__fk2 FOREIGN KEY (use_num) REFERENCES used_item (use_num);
ALTER TABLE usedChatRoom ADD CONSTRAINT usedChatRoom__fk3 FOREIGN KEY (item_num) REFERENCES used_item (item_num);
CREATE SEQUENCE usedChatRoom_useC_num_seq;

-- 중고 거래 채팅 메시지 테이블
CREATE TABLE usedChat_text (
	chaC_num   NUMBER       NOT NULL, -- 메시지 고유 번호
	useC_num   NUMBER       NOT NULL, -- 채팅방 고유 번호
	mem_num    NUMBER       NOT NULL, -- 구매자
	item_num   NUMBER       NOT NULL, -- 상품 번호
	chaC_txt   CLOB         NOT NULL, -- 메시지 내용
	chaC_time  DATE         DEFAULT SYSDATE NOT NULL, -- 메시지 전송 시간
	chaC_status NUMBER      NOT NULL, -- 메시지 상태
	chaC_check NUMBER(1)    NOT NULL -- 확인 상태 (0: 확인x, 1: 확인o)
);
ALTER TABLE usedChat_text ADD CONSTRAINT usedChat_text_pk PRIMARY KEY (chaC_num, useC_num, mem_num, item_num);
ALTER TABLE usedChat_text ADD CONSTRAINT usedChat_text__fk1 FOREIGN KEY (useC_num) REFERENCES usedChatRoom (useC_num);
ALTER TABLE usedChat_text ADD CONSTRAINT usedChat_text__fk2 FOREIGN KEY (mem_num) REFERENCES usedChatRoom (mem_num);
ALTER TABLE usedChat_text ADD CONSTRAINT usedChat_text__fk3 FOREIGN KEY (item_num) REFERENCES usedChatRoom (item_num);
CREATE SEQUENCE usedChat_text_chaC_num_seq;

-- 신고 테이블
CREATE TABLE report (
	report_num       NUMBER       NOT NULL, -- 신고 번호
	mem_num          NUMBER       NOT NULL, -- 피신고자 번호
	reporter_num     NUMBER       NOT NULL, -- 신고자 번호
	report_content   VARCHAR2(500) NOT NULL, -- 신고 내용
	report_date      DATE         DEFAULT SYSDATE NOT NULL, -- 신고 접수일
	report_type      NUMBER(1)    NOT NULL, -- 신고 유형
	report_typeDetail NUMBER      NOT NULL -- 신고 대상 식별 번호
);
ALTER TABLE report ADD CONSTRAINT report_pk PRIMARY KEY (report_num, mem_num);
ALTER TABLE report ADD CONSTRAINT report__fk1 FOREIGN KEY (mem_num) REFERENCES member (mem_num);
CREATE SEQUENCE report_report_num_seq;

-- 상품 대여 재고 테이블
CREATE TABLE item_rent_stock (
	use_num      NUMBER        NOT NULL, -- 중고 번호
	mem_num      NUMBER        NOT NULL, -- 회원고유의 번호
	item_num     NUMBER        NOT NULL, -- 상품 번호
	item_rstock  NUMBER(3)     NULL, -- 대여 상품 재고
	item_restock NUMBER(3)     NULL -- 중고 상품 재고
);
ALTER TABLE item_rent_stock ADD CONSTRAINT item_rent_stock_pk PRIMARY KEY (use_num, mem_num, item_num);
ALTER TABLE item_rent_stock ADD CONSTRAINT item_rent_stock__fk1 FOREIGN KEY (use_num) REFERENCES used_item (use_num);
ALTER TABLE item_rent_stock ADD CONSTRAINT item_rent_stock__fk2 FOREIGN KEY (mem_num) REFERENCES used_item (mem_num);
ALTER TABLE item_rent_stock ADD CONSTRAINT item_rent_stock__fk3 FOREIGN KEY (item_num) REFERENCES used_item (item_num);
CREATE SEQUENCE item_rent_stock_use_num_seq;
