--출석
CREATE TABLE  attendance  (
	 att_num 	number		NOT NULL,  -- 출석번호
	 att_date 	date		NOT NULL,  -- 출석날짜
	 att_status 	number	DEFAULT 1 NOT NULL,  -- 1:미출석 2:출석
	 mem_num 	number		NOT NULL,  -- 회원고유의 번호
	CONSTRAINT  attendance_pk  PRIMARY KEY ( att_num ),
	CONSTRAINT  attendance_fk  FOREIGN KEY ( mem_num ) REFERENCES  member  ( mem_num )
);
--시청시간
CREATE TABLE  stream_view_time  (
	 view_id 	number		NOT NULL,  -- 시청번호
	 view_start 	date		NOT NULL,  -- 시청 시작 시간
	 view_end 	date		NULL,  -- 시청 종료 시간
	 str_num 	number		NOT NULL,  -- 방송 구별을 위한 번호
	CONSTRAINT  stream_view_time_pk  PRIMARY KEY ( view_id ),
	CONSTRAINT  stream_view_time_fk  FOREIGN KEY ( str_num ) REFERENCES  streaming  ( str_num )
);

CREATE SEQUENCE stream_view_time_seq;
--채팅방
CREATE TABLE  streaming_chatroom  (
	 strC_num 	number		NOT NULL,  -- 채팅방번호
	 str_num 	number		NOT NULL,  -- 방송 구별을 위한 번호
	CONSTRAINT  streaming_chatroom_pk  PRIMARY KEY ( strC_num ),
	CONSTRAINT  streaming_chatroom_fk  FOREIGN KEY ( str_num ) REFERENCES  streaming  ( str_num )
);

CREATE SEQUENCE streaming_chatroom_seq;
--채팅 메세지
CREATE TABLE  streaming_chattage  (
	 strT_num 	number		NOT NULL,  -- 시청번호
	 strT_chat 	varchar2(300)		NOT NULL,  -- 채팅메세지
	 strT_date 	date		NOT NULL,  -- 채팅날짜
	 strC_num 	number		NOT NULL,  -- 채팅방번호
	CONSTRAINT  streaming_chattage_pk  PRIMARY KEY ( strT_num ),
	CONSTRAINT  streaming_chattage_fk  FOREIGN KEY ( strC_num ) REFERENCES  streaming_chatroom  ( strC_num )
);

CREATE SEQUENCE streaming_chattage_seq;
--포인트 게임
CREATE TABLE  point_game  (
	 poiG_num 	number		NOT NULL,  -- 게임번호
	 poiG_content 	varchar2(500)		NOT NULL,  -- 게임 내용
	 poiG_start 	date		NOT NULL,  -- 게임시작
	 poiG_end 	date		NULL,  -- 게임종료
	 str_num 	number		NOT NULL,  -- 방송 구별을 위한 번호
	CONSTRAINT  point_game_pk  PRIMARY KEY ( poiG_num ),
	CONSTRAINT  point_game_fk  FOREIGN KEY ( str_num ) REFERENCES  streaming  ( str_num )
);

CREATE SEQUENCE point_game_seq;
--포인트 게임 선택지
CREATE TABLE  point_game_option  (
	 poiO_num 	number		NOT NULL,  -- 선택지 고유 번호
	 optO_content 	varchar2(500)		NOT NULL,  -- 선택지 내용
	 poiO_no 	number		NULL,  -- 선택지번호
	 poiG_num 	number		NOT NULL,  -- 게임번호
	CONSTRAINT  point_game_option_pk  PRIMARY KEY ( poiO_num ),
	CONSTRAINT  point_game_option_fk  FOREIGN KEY ( poiG_num ) REFERENCES  point_game  ( poiG_num )
);

CREATE SEQUENCE point_game_option_seq;
--포인트 게임 배팅
CREATE TABLE  point_game_betting  (
	 bet_num 	number		NOT NULL,  -- 배팅번호
	 bet_point 	number		NOT NULL,  -- 배팅 포인트
	 bet_date 	date	DEFAULT SYSDATE	NOT NULL,  -- 배팅 날짜
	 poiO_num 	number		NOT NULL,  -- 선택지 고유 번호
	CONSTRAINT  point_game_betting_pk  PRIMARY KEY ( bet_num ),
	CONSTRAINT  point_game_betting_fk  FOREIGN KEY ( poiO_num ) REFERENCES  point_game_option  ( poiO_num )
);

CREATE SEQUENCE point_game_betting_seq;
--미션
CREATE TABLE  mission  (
	 mis_num 	number		NOT NULL,  -- 미션번호
	 mis_point 	number		NOT NULL,  -- 미션포인트
	 mis_content 	varchar2(500)		NOT NULL,  -- 미션내용
	 mis_status 	number		NOT NULL,  -- 0:미수행,1:성공,2:실패
	 mis_date 	date	DEFAULT SYSDATE	NOT NULL,  -- 후원 날짜
	 str_num 	number		NOT NULL,  -- 방송 구별을 위한 번호
	CONSTRAINT  mission_pk  PRIMARY KEY ( mis_num ),
	CONSTRAINT  mission_fk  FOREIGN KEY ( str_num ) REFERENCES  streaming  ( str_num )
);

CREATE SEQUENCE mission_seq;
--후원
CREATE TABLE  donation  (
	 don_num 	number		NOT NULL,  -- 후원번호
	 don_point 	number		NOT NULL,  -- 후원 포인트
	 don_content 	varchar2(500)		NOT NULL,  -- 후원메세지
	 don_date 	date	DEFAULT SYSDATE	NOT NULL,  -- 후원 날짜
	 str_num 	number		NOT NULL,  -- 방송 구별을 위한 번호
	CONSTRAINT  donation_pk  PRIMARY KEY ( don_num ),
	CONSTRAINT  donation_fk  FOREIGN KEY ( str_num ) REFERENCES  streaming  ( str_num )
);

CREATE SEQUENCE donation_seq;
--방송
CREATE TABLE  streaming  (
	 str_num 	number		NOT NULL,  -- 방송 구별을 위한 번호
	 mem_num 	number		NOT NULL,  -- 회원고유의 번호
	CONSTRAINT  streaming_pk  PRIMARY KEY ( str_num ),
	CONSTRAINT  streaming_fk  FOREIGN KEY ( mem_num ) REFERENCES  member  ( mem_num )
);

CREATE SEQUENCE streaming_seq;
--방송 디테일
CREATE TABLE  stream_detail  (
	 strD_num 	number		NOT NULL,  -- 방송 구별을 위한 상세 번호
	 strD_title 	varchar2(300)		NOT NULL,  -- 방송제목
	 strD_start 	date	DEFAULT SYSDATE	NOT NULL,  -- 방송 시작 시간
	 strD_end 	date		NULL,  -- 방송 종료 시간
	 str_num 	number		NOT NULL,  -- 방송 구별을 위한 번호
	CONSTRAINT  stream_detail_pk  PRIMARY KEY ( strD_num ),
	CONSTRAINT  stream_detail_fk  FOREIGN KEY ( str_num ) REFERENCES  streaming  ( str_num )
);

CREATE SEQUENCE stream_detail_seq;
--총 포인트
CREATE TABLE  point_Total  (
	 point_Total 	varchar2(255)		NOT NULL,  -- 총포인트
	 mem_num 	number		NOT NULL,  -- 회원고유의 번호
	CONSTRAINT  point_Total_fk  FOREIGN KEY ( mem_num ) REFERENCES  member  ( mem_num )
);

CREATE SEQUENCE point_Total_seq;
--포인트
CREATE TABLE  point  (
	 poi_num 	number		NOT NULL,  -- 포인트번호
	 poi_status 	number	DEFAULT 1	NOT NULL,  -- 포인트사용유형
	 poi_use 	number		NOT NULL,  -- 사용포인트
	 poi_date 	date	DEFAULT SYSDATE	NOT NULL,  -- 사용일
	 mem_num 	number		NOT NULL,  -- 회원고유의 번호
	 poi_increase number not null, -- 1:감소,2:증가 
	CONSTRAINT  point_pk  PRIMARY KEY ( poi_num ),
	CONSTRAINT  point_fk  FOREIGN KEY ( mem_num ) REFERENCES  member  ( mem_num )
);

CREATE SEQUENCE point_seq;