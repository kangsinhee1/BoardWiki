-- 회원 테이블
CREATE TABLE member (
	mem_num    NUMBER      NOT NULL, -- 회원고유의 번호
	mem_email  VARCHAR2(50)  NOT NULL, -- 회원 이메일(아이디용)
	mem_auth   NUMBER(1)   NOT NULL, -- 회원등급(일반 0, 정지 1, 탈퇴 2, 관리자 9)
	CONSTRAINT mem_num_pk PRIMARY KEY (mem_num)
);

CREATE SEQUENCE member_seq;

-- 출석 테이블
CREATE TABLE attendance (
	att_num     NUMBER      NOT NULL, -- 출석번호
	att_date    DATE        NOT NULL, -- 출석날짜
	att_status  NUMBER      DEFAULT 1 NOT NULL, -- 1:미출석 2:출석
	mem_num     NUMBER      NOT NULL, -- 회원고유의 번호
	CONSTRAINT att_num_pk PRIMARY KEY (att_num),
	CONSTRAINT mem_num_fk FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);

CREATE SEQUENCE attendance_seq;

-- 회원 상세 테이블
CREATE TABLE member_detail (
	mem_name     VARCHAR2(30)  NOT NULL, -- 회원 이름
	mem_nickname VARCHAR2(50)  NULL, -- 회원 별명
	mem_passwd   VARCHAR2(50)  NOT NULL, -- 영문+숫자 4~12
	mem_phone    VARCHAR2(15)  NOT NULL, -- 000-0000-0000 형식
	mem_provider VARCHAR2(10)  NULL, -- 회원 가입 정보 제공자
	mem_rdate    DATE          DEFAULT SYSDATE NOT NULL, -- 회원 가입 날짜
	mem_mdate    DATE          NULL, -- 회원 수정 날짜
	mem_photo    VARCHAR2(400) DEFAULT 'face.png' NULL, -- 회원 프로필 사진
	mem_num      NUMBER        NOT NULL, -- 회원고유의 번호
	CONSTRAINT mem_num_fk1 PRIMARY KEY (mem_num),
	CONSTRAINT mem_num_fk2 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);

CREATE SEQUENCE member_detail_seq;

-- 스트리밍 테이블
CREATE TABLE streaming (
	str_num NUMBER NOT NULL, -- 방송 구별 번호
	mem_num NUMBER NOT NULL, -- 회원고유의 번호
	CONSTRAINT str_num_pk PRIMARY KEY (str_num),
	CONSTRAINT mem_num_fk3 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);

CREATE SEQUENCE streaming_seq;

-- 스트리밍 상세 테이블
CREATE TABLE stream_detail (
	strD_num  NUMBER       NOT NULL, -- 방송 상세 번호
	str_num   NUMBER       NOT NULL, -- 방송 구별 번호
	mem_num   NUMBER       NOT NULL, -- 회원고유의 번호
	strD_title VARCHAR2(300) NOT NULL, -- 방송 제목
	strD_start DATE        DEFAULT SYSDATE NOT NULL, -- 방송 시작 시간
	strD_end   DATE        NULL, -- 방송 종료 시간
	CONSTRAINT strD_num_pk PRIMARY KEY (strD_num),
	CONSTRAINT str_num_fk FOREIGN KEY (str_num) REFERENCES streaming (str_num),
	CONSTRAINT mem_num_fk4 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);

CREATE SEQUENCE stream_detail_seq;

-- 스트리밍 시청 시간 테이블
CREATE TABLE stream_view_time (
	view_id    NUMBER      NOT NULL, -- 시청 번호
	str_num    NUMBER      NOT NULL, -- 방송 구별 번호
	mem_num    NUMBER      NOT NULL, -- 회원고유의 번호
	view_start DATE        NOT NULL, -- 시청 시작 시간
	view_end   DATE        NULL, -- 시청 종료 시간
	CONSTRAINT view_id_pk PRIMARY KEY (view_id),
	CONSTRAINT str_num_fk1 FOREIGN KEY (str_num) REFERENCES streaming (str_num),
	CONSTRAINT mem_num_fk5 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);

CREATE SEQUENCE stream_view_time_seq;

-- 스트리밍 채팅방 테이블
CREATE TABLE streaming_chatroom (
	strC_num NUMBER NOT NULL, -- 채팅방 번호
	str_num  NUMBER NOT NULL, -- 방송 구별 번호
	mem_num  NUMBER NOT NULL, -- 회원고유의 번호
	CONSTRAINT strC_num_pk PRIMARY KEY (strC_num),
	CONSTRAINT str_num_fk2 FOREIGN KEY (str_num) REFERENCES streaming (str_num),
	CONSTRAINT mem_num_fk6 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);

CREATE SEQUENCE streaming_chatroom_seq;

-- 스트리밍 채팅 메시지 테이블
CREATE TABLE streaming_chattage (
	strT_num  NUMBER       NOT NULL, -- 시청 번호
	strC_num  NUMBER       NOT NULL, -- 채팅방 번호
	str_num   NUMBER       NOT NULL, -- 방송 구별 번호
	mem_num   NUMBER       NOT NULL, -- 회원고유의 번호
	strT_chat VARCHAR2(300) NOT NULL, -- 채팅 메시지
	strT_date DATE        DEFAULT SYSDATE NOT NULL, -- 채팅 날짜
	CONSTRAINT strT_num_pk PRIMARY KEY (strT_num),
	CONSTRAINT strC_num_fk FOREIGN KEY (strC_num) REFERENCES streaming_chatroom (strC_num),
	CONSTRAINT str_num_fk3 FOREIGN KEY (str_num) REFERENCES streaming (str_num),
	CONSTRAINT mem_num_fk7 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);

CREATE SEQUENCE streaming_chattage_seq;

-- 알람 테이블
CREATE TABLE alert (
	ale_num     NUMBER        NOT NULL, -- 알람 고유 번호
	mem_num     NUMBER        NOT NULL, -- 회원고유의 번호
	ale_content VARCHAR2(300) NOT NULL, -- 알람 내용
	ale_category NUMBER(1)    NOT NULL, -- 알람 카테고리 (0:출석알림, 1:새댓글 알림, 2:신고처리알림, 3:결제완료 알림)
	ale_time    DATE          DEFAULT SYSDATE NOT NULL, -- 알람 도착일
	ale_check   VARCHAR2(1)   DEFAULT '0' NOT NULL, -- 알람 확인 여부 (0: 확인x, 1: 확인o)
	CONSTRAINT ale_num_pk PRIMARY KEY (ale_num),
	CONSTRAINT mem_num_fk8 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);

CREATE SEQUENCE alert_seq;

-- 채팅 메시지 테이블
CREATE TABLE chat_text (
	chaT_num   NUMBER       NOT NULL, -- 메시지 고유 번호
	chaR_num   NUMBER       NOT NULL, -- 채팅방 고유 번호
	tea_num    NUMBER       NOT NULL, -- 모임 번호
	mem_num    NUMBER       NOT NULL, -- 회원고유의 번호
	chaT_txt   CLOB         NOT NULL, -- 메시지 내용
	chaT_time  DATE         DEFAULT SYSDATE NOT NULL, -- 메시지 전송 시간
	chaT_status NUMBER      NOT NULL, -- 메시지 상태
	CONSTRAINT chaT_num_pk PRIMARY KEY (chaT_num),
	CONSTRAINT chaR_num_fk FOREIGN KEY (chaR_num) REFERENCES chatRoom (chaR_num),
	CONSTRAINT tea_num_fk FOREIGN KEY (tea_num) REFERENCES chatRoom (tea_num),
	CONSTRAINT mem_num_fk9 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);

CREATE SEQUENCE chat_text_seq;

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
	tea_fav    NUMBER        DEFAULT 0 NOT NULL, -- 모임 관심 여부 (기본 0, 관심 1)
	CONSTRAINT tea_num_pk PRIMARY KEY (tea_num),
	CONSTRAINT mem_num_fk10 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);

CREATE SEQUENCE team_seq;

-- 모임 신청 테이블
CREATE TABLE team_apply (
	teaA_num    NUMBER        NOT NULL, -- 모임 신청 번호
	tea_num     NUMBER        NOT NULL, -- 모임 번호
	mem_num     NUMBER        NOT NULL, -- 회원고유의 번호
	teaA_status NUMBER        DEFAULT 0 NOT NULL, -- 모임 신청 상태 (0: 대기, 1: 승인, 2: 거절)
	CONSTRAINT teaA_num_pk PRIMARY KEY (teaA_num),
	CONSTRAINT tea_num_fk1 FOREIGN KEY (tea_num) REFERENCES team (tea_num),
	CONSTRAINT mem_num_fk11 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);

CREATE SEQUENCE team_apply_seq;

-- 모임 게시판 테이블
CREATE TABLE team_board (
	teaB_num    NUMBER        NOT NULL, -- 게시글 번호
	tea_num     NUMBER        NOT NULL, -- 모임 번호
	teaB_title  VARCHAR2(50)  NOT NULL, -- 게시글 제목
	teaB_content CLOB         NOT NULL, -- 게시글 내용
	teaB_rdate  DATE          DEFAULT SYSDATE NOT NULL, -- 게시글 작성 날짜
	teaB_category NUMBER(1)   NOT NULL, -- 게시글 카테고리
	CONSTRAINT teaB_num_pk PRIMARY KEY (teaB_num),
	CONSTRAINT tea_num_fk2 FOREIGN KEY (tea_num) REFERENCES team (tea_num)
);

CREATE SEQUENCE team_board_seq;

-- 모임 댓글 테이블
CREATE TABLE team_reply (
	teaR_num    NUMBER        NOT NULL, -- 댓글 번호
	teaB_num    NUMBER        NOT NULL, -- 게시글 번호
	teaR_content VARCHAR2(3000) NOT NULL, -- 댓글 내용
	teaR_rdate  DATE          DEFAULT SYSDATE NOT NULL, -- 댓글 작성 날짜
	CONSTRAINT teaR_num_pk PRIMARY KEY (teaR_num),
	CONSTRAINT teaB_num_fk FOREIGN KEY (teaB_num) REFERENCES team_board (teaB_num)
);

CREATE SEQUENCE team_reply_seq;

-- 포인트 게임 테이블
CREATE TABLE point_game (
	poiG_num    NUMBER        NOT NULL, -- 게임 번호
	str_num     NUMBER        NOT NULL, -- 방송 구별 번호
	mem_num     NUMBER        NOT NULL, -- 회원고유의 번호
	poiG_content VARCHAR2(500) NOT NULL, -- 게임 내용
	poiG_start  DATE          NOT NULL, -- 게임 시작 시간
	poiG_end    DATE          NULL, -- 게임 종료 시간
	CONSTRAINT poiG_num_pk PRIMARY KEY (poiG_num),
	CONSTRAINT str_num_fk4 FOREIGN KEY (str_num) REFERENCES streaming (str_num),
	CONSTRAINT mem_num_fk12 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);

CREATE SEQUENCE point_game_seq;

-- 포인트 게임 선택지 테이블
CREATE TABLE point_game_option (
	poiO_num     NUMBER       NOT NULL, -- 선택지 번호
	poiG_num     NUMBER       NOT NULL, -- 게임 번호
	optO_content VARCHAR2(500) NOT NULL, -- 선택지 내용
	poiO_no      NUMBER       NULL, -- 선택지 번호
	CONSTRAINT poiO_num_pk PRIMARY KEY (poiO_num),
	CONSTRAINT poiG_num_fk FOREIGN KEY (poiG_num) REFERENCES point_game (poiG_num)
);

CREATE SEQUENCE point_game_option_seq;

-- 포인트 게임 배팅 테이블
CREATE TABLE point_game_betting (
	bet_num    NUMBER        NOT NULL, -- 배팅 번호
	poiG_num   NUMBER        NOT NULL, -- 게임 번호
	poiO_num   NUMBER        NOT NULL, -- 선택지 번호
	bet_point  NUMBER        NOT NULL, -- 배팅 포인트
	bet_date   DATE          DEFAULT SYSDATE NOT NULL, -- 배팅 날짜
	CONSTRAINT bet_num_pk PRIMARY KEY (bet_num),
	CONSTRAINT poiG_num_fk1 FOREIGN KEY (poiG_num) REFERENCES point_game (poiG_num),
	CONSTRAINT poiO_num_fk FOREIGN KEY (poiO_num) REFERENCES point_game_option (poiO_num)
);

CREATE SEQUENCE point_game_betting_seq;

-- 미션 테이블
CREATE TABLE mission (
	mis_num    NUMBER       NOT NULL, -- 미션 번호
	str_num    NUMBER       NOT NULL, -- 방송 구별 번호
	mem_num    NUMBER       NOT NULL, -- 회원고유의 번호
	mis_point  NUMBER       NOT NULL, -- 미션 포인트
	mis_content VARCHAR2(500) NOT NULL, -- 미션 내용
	mis_status NUMBER       NOT NULL, -- 미션 상태 (0: 미수행, 1: 성공, 2: 실패)
	mis_date   DATE         DEFAULT SYSDATE NOT NULL, -- 미션 날짜
	CONSTRAINT mis_num_pk PRIMARY KEY (mis_num),
	CONSTRAINT str_num_fk5 FOREIGN KEY (str_num) REFERENCES streaming (str_num),
	CONSTRAINT mem_num_fk13 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);

CREATE SEQUENCE mission_seq;

-- 후원 테이블
CREATE TABLE donation (
	don_num    NUMBER       NOT NULL, -- 후원 번호
	str_num    NUMBER       NOT NULL, -- 방송 구별 번호
	mem_num    NUMBER       NOT NULL, -- 회원고유의 번호
	don_point  NUMBER       NOT NULL, -- 후원 포인트
	don_content VARCHAR2(500) NOT NULL, -- 후원 메시지
	don_date   DATE         DEFAULT SYSDATE NOT NULL, -- 후원 날짜
	CONSTRAINT don_num_pk PRIMARY KEY (don_num),
	CONSTRAINT str_num_fk6 FOREIGN KEY (str_num) REFERENCES streaming (str_num),
	CONSTRAINT mem_num_fk14 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);

CREATE SEQUENCE donation_seq;

-- 포인트 총계 테이블
CREATE TABLE point_total (
	mem_num    NUMBER       NOT NULL, -- 회원고유의 번호
	point_total VARCHAR2(255) NOT NULL, -- 총 포인트
	CONSTRAINT mem_num_pk1 PRIMARY KEY (mem_num),
	CONSTRAINT mem_num_fk15 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);

-- 포인트 테이블
CREATE TABLE point (
	poi_num    NUMBER       NOT NULL, -- 포인트 번호
	mem_num    NUMBER       NOT NULL, -- 회원고유의 번호
	poi_status NUMBER(1)    NOT NULL, -- 포인트 사용 유형
	poi_use    NUMBER       NOT NULL, -- 사용 포인트
	poi_date   DATE         DEFAULT SYSDATE NOT NULL, -- 사용일
	CONSTRAINT poi_num_pk PRIMARY KEY (poi_num),
	CONSTRAINT mem_num_fk16 FOREIGN KEY (mem_num) REFERENCES point_total (mem_num)
);

CREATE SEQUENCE point_seq;
