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