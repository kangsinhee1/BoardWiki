-- 스트리밍 테이블 
CREATE TABLE streaming (
	str_num NUMBER NOT NULL, -- 방송 구별 번호
	mem_num NUMBER NOT NULL -- 회원고유의 번호
);
ALTER TABLE streaming ADD CONSTRAINT streaming_pk PRIMARY KEY (str_num, mem_num);
CREATE SEQUENCE streaming_seq;

-- 스트리밍 상세 테이블
CREATE TABLE stream_detail (
	strD_num  NUMBER       NOT NULL, -- 방송 상세 번호
	str_num   NUMBER       NOT NULL, -- 방송 구별 번호
	mem_num   NUMBER       NOT NULL, -- 회원고유의 번호
	strD_title VARCHAR2(300) NOT NULL, -- 방송 제목
	strD_start DATE        DEFAULT SYSDATE NOT NULL, -- 방송 시작 시간
	strD_end   DATE        NULL -- 방송 종료 시간
);
ALTER TABLE stream_detail ADD CONSTRAINT stream_detail_pk PRIMARY KEY (strD_num, str_num, mem_num);
ALTER TABLE stream_detail ADD CONSTRAINT stream_detail__fk1 FOREIGN KEY (str_num) REFERENCES streaming (str_num);
ALTER TABLE stream_detail ADD CONSTRAINT stream_detail__fk2 FOREIGN KEY (mem_num) REFERENCES streaming (mem_num);
CREATE SEQUENCE stream_detail_seq;

-- 스트리밍 시청 시간 테이블
CREATE TABLE stream_view_time (
	view_id    NUMBER      NOT NULL, -- 시청 번호
	str_num    NUMBER      NOT NULL, -- 방송 구별 번호
	mem_num    NUMBER      NOT NULL, -- 회원고유의 번호
	view_start DATE        NOT NULL, -- 시청 시작 시간
	view_end   DATE        NULL-- 시청 종료 시간
);
ALTER TABLE stream_view_time ADD CONSTRAINT stream_view_time_pk PRIMARY KEY (view_id, str_num, mem_num);
ALTER TABLE stream_view_time ADD CONSTRAINT stream_view_time__fk1 FOREIGN KEY (str_num) REFERENCES streaming (str_num);
ALTER TABLE stream_view_time ADD CONSTRAINT stream_view_time__fk2 FOREIGN KEY (mem_num) REFERENCES streaming (mem_num);
CREATE SEQUENCE stream_view_time_seq;

-- 스트리밍 채팅방 테이블
CREATE TABLE streaming_chatroom (
	strC_num NUMBER NOT NULL, -- 채팅방 번호
	str_num  NUMBER NOT NULL, -- 방송 구별 번호
	mem_num  NUMBER NOT NULL -- 회원고유의 번호
);
ALTER TABLE streaming_chatroom ADD CONSTRAINT streaming_chatroom_pk PRIMARY KEY (strC_num, str_num, mem_num);
ALTER TABLE streaming_chatroom ADD CONSTRAINT streaming_chatroom__fk1 FOREIGN KEY (str_num) REFERENCES streaming (str_num);
ALTER TABLE streaming_chatroom ADD CONSTRAINT streaming_chatroom__fk2 FOREIGN KEY (mem_num) REFERENCES streaming (mem_num);
CREATE SEQUENCE streaming_chatroom_seq;

-- 스트리밍 채팅 메시지 테이블
CREATE TABLE streaming_chattage (
	strT_num  NUMBER       NOT NULL, -- 시청 번호
	strC_num  NUMBER       NOT NULL, -- 채팅방 번호
	str_num   NUMBER       NOT NULL, -- 방송 구별 번호
	mem_num   NUMBER       NOT NULL, -- 회원고유의 번호
	strT_chat VARCHAR2(300) NOT NULL, -- 채팅 메시지
	strT_date DATE        DEFAULT SYSDATE NOT NULL -- 채팅 날짜
);
ALTER TABLE streaming_chattage ADD CONSTRAINT streaming_chattage_pk PRIMARY KEY (strT_num, strC_num, str_num, mem_num);
ALTER TABLE streaming_chattage ADD CONSTRAINT streaming_chattage__fk1 FOREIGN KEY (strC_num) REFERENCES streaming_chatroom (strC_num);
ALTER TABLE streaming_chattage ADD CONSTRAINT streaming_chattage__fk2 FOREIGN KEY (str_num) REFERENCES streaming_chatroom (str_num);
ALTER TABLE streaming_chattage ADD CONSTRAINT streaming_chattage__fk3 FOREIGN KEY (mem_num) REFERENCES streaming_chatroom (mem_num);
CREATE SEQUENCE streaming_chattage_seq;

-- 포인트 게임 테이블
CREATE TABLE point_game (
	poiG_num    NUMBER       NOT NULL, -- 게임 번호
	str_num     NUMBER       NOT NULL, -- 방송 구별 번호
	mem_num     NUMBER       NOT NULL, -- 회원고유의 번호
	poiG_content VARCHAR2(500) NOT NULL, -- 게임 내용
	poiG_start  DATE         NOT NULL, -- 게임 시작 시간
	poiG_end    DATE         NULL -- 게임 종료 시간
);
ALTER TABLE point_game ADD CONSTRAINT point_game_pk PRIMARY KEY (poiG_num, str_num, mem_num);
ALTER TABLE point_game ADD CONSTRAINT point_game__fk1 FOREIGN KEY (str_num) REFERENCES streaming (str_num);
ALTER TABLE point_game ADD CONSTRAINT point_game__fk2 FOREIGN KEY (mem_num) REFERENCES streaming (mem_num);
CREATE SEQUENCE point_game_seq;

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
CREATE SEQUENCE point_game_option_seq;

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
CREATE SEQUENCE point_game_betting_seq;

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
CREATE SEQUENCE mission_seq;

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
CREATE SEQUENCE donation_seq;

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
	poi_status NUMBER(1)       NOT NULL, -- 포인트 사용 유형
	poi_use    NUMBER       NOT NULL, -- 사용 포인트
	poi_date   DATE         DEFAULT SYSDATE NOT NULL -- 사용일
);
ALTER TABLE point ADD CONSTRAINT point_pk PRIMARY KEY (poi_num, mem_num);
ALTER TABLE point ADD CONSTRAINT point__fk1 FOREIGN KEY (mem_num) REFERENCES point_total (mem_num);
CREATE SEQUENCE point_seq;