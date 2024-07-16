CREATE TABLE  team  (
	 tea_num 	number		NOT NULL,  -- 모임번호를 식별하는 번호
	 tea_name 	varchar2(40)		NOT NULL,  -- 등록할 모임의 이름
	 tea_content 	clob		NOT NULL,  -- 모임에 대한 설명
	 tea_time 	varchar2(30)		NULL,  -- 모임이 진행되는 날짜
	 tea_zipcode number(5) not null,
	 tea_address1 varchar2(90) not null,
	 tea_address2 varchar2(90) not null,
	 tea_rdate 	date	DEFAULT SYSDATE	NOT NULL,  -- 모임을 등록한 날짜
	 tea_man 	number(2)	DEFAULT 2	NOT NULL,  -- 최대 모집인원 설정 가능(최대 99)
	 tea_hit 	number		DEFAULT 0 NOT NULL,  -- 모임창 클릭 조회수
	 tea_status 	number	DEFAULT 1	NOT NULL,  -- 신고처리시 모임 비활성화(기본1,비활:0)
	 mem_num 	number		NOT NULL,  -- 회원고유의 번호
	CONSTRAINT  team_pk  PRIMARY KEY ( tea_num ),
	CONSTRAINT  team_fk  FOREIGN KEY ( mem_num ) REFERENCES  member  ( mem_num )
);
CREATE SEQUENCE team_seq;

CREATE TABLE  team_fav  (
	 mem_num 	number		NOT NULL,  -- 회원고유의 번호
	 tea_num 	number		NOT NULL,  -- 모임의 식별 번호
	CONSTRAINT   team_fav_fk1  FOREIGN KEY ( mem_num ) REFERENCES  member  ( mem_num ),
	CONSTRAINT  team_fav_fk2  FOREIGN KEY ( tea_num ) REFERENCES  team  ( tea_num )
);

CREATE TABLE  team_Apply  (
	 teaA_num 	number		NOT NULL,  -- 모임 신청을 식별하는 번호
	 teaA_status 	number	DEFAULT 1	NOT NULL,  -- 모임 신청결과 식별(1:승인대기,  2:승인   0: 거부 관리자:9)
	 teaA_time 	date	DEFAULT SYSDATE	NOT NULL,  -- 신청한 시간을 식별
	 teaA_attend 	number	 DeFAULT 0	NOT NULL,  -- 참석여부 신청(참석:1,불참:0)
	 teaA_content 	varchar2(300)		NULL,  -- 신청할때 하고싶은말
	 teaA_auth 	number DEFAULT 2 NOT NULL,  -- 모임 권한(모임장: 9, 신청자 :2)
	 tea_num 	number		NOT NULL,  -- 모임번호를 식별하는 번호
	 mem_num number not null,  -- 신청 회원 번호
	CONSTRAINT  team_apply_pk  PRIMARY KEY ( teaA_num ),
	CONSTRAINT  team_apply_fk1 FOREIGN KEY ( tea_num ) REFERENCES  team  ( tea_num ),
	CONSTRAINT  team_apply_fk2  FOREIGN KEY ( mem_num ) REFERENCES  member  ( mem_num )
);

CREATE SEQUENCE team_apply_seq;

CREATE TABLE  team_board  (
	 teaB_num 	number		NOT NULL,  -- 게시글을 식별 번호
	 teaB_status 	number(1)		NOT NULL,  -- 게시글 공개여부 (0:비공개, 1: 멤버만, 2:모두에게)
	 teaB_title 	varchar2(50)		NOT NULL,  -- 게시글 제목을 저장
	 teaB_content 	clob		NOT NULL,  -- 게시글 내용 저장
	 teaB_rdate 	date	DEFAULT SYSDATE	NOT NULL,  -- 게시글 작성 시간
	 teaB_category 	number(1)		NOT NULL,  -- 게시글 분류(모임 후기, 모임질문, 건의등)
	 teaB_filename 	varchar2(400)		NULL,  -- 게시글 첨부 파일
	 tea_num 	number		NOT NULL,  -- 모임번호를 식별하는 번호
	CONSTRAINT  team_board_pk  PRIMARY KEY ( teaB_num ),
	CONSTRAINT  team_board_fk  FOREIGN KEY ( tea_num ) REFERENCES  team  ( tea_num )
);

CREATE SEQUENCE team_board_seq;

CREATE TABLE  team_reply  (
	 teaR_num 	number		NOT NULL,  -- 댓글을 식별하는 번호
	 teaR_content 	varchar2(3000)		NOT NULL,  -- 댓글내용
	 teaR_status 	number(1)	DEFAULT 0	NOT NULL,  -- 0일반/1신고접수/2정지
	 teaR_rdate 	date	DEFAULT SYSDATE	NOT NULL,  -- 댓글작성날짜
	 teaR_mdate 	date		NULL,  -- 댓글수정날짜
	 teaB_num 	number		NOT NULL,  -- 게시글을 식별 번호
	 teaB_hit	number DEFAULT 0 not null,
	CONSTRAINT  team_reply_pk  PRIMARY KEY ( teaR_num ),
	CONSTRAINT  team_reply_fk  FOREIGN KEY ( teaB_num ) REFERENCES  team_board  ( teaB_num )
);

CREATE SEQUENCE team_reply_seq;
-- chat_room 테이블 생성
CREATE TABLE chat_room (
    chaR_num number NOT NULL,  -- 채팅방 고유번호
    chaR_status number(1) DEFAULT 1 NOT NULL,  -- 0:활성화 1:비활성화
    chaR_name varchar2(900) NOT NULL,  -- 채팅방 이름
    chaR_date date DEFAULT SYSDATE NOT NULL,  -- 채팅방이 만들어진 날짜
    tea_num number NOT NULL,  -- 모임번호를 식별하는 번호
    CONSTRAINT chatRoom_pk PRIMARY KEY (chaR_num),
    CONSTRAINT chatRoom_fk FOREIGN KEY (tea_num) REFERENCES team (tea_num)
);

-- chat_room 시퀀스 생성
CREATE SEQUENCE chat_room_seq;

-- chat_member 테이블 생성
CREATE TABLE chat_member (
    mem_num number NOT NULL,  -- 회원 고유 번호
    chaR_num number NOT NULL,  -- 채팅방 고유번호
    basic_chat varchar2(900) NOT NULL, -- 채팅멤버 추가시 기본 채팅방 이름을 멤버 이름으로 처리
    member_date date default sysdate not null, 
    CONSTRAINT chat_member_fk1 FOREIGN KEY (mem_num) REFERENCES member (mem_num),
    CONSTRAINT chat_member_fk2 FOREIGN KEY (chaR_num) REFERENCES chat_room (chaR_num)
);

-- chat_member 시퀀스 생성
CREATE SEQUENCE chat_member_seq;

-- chat_text 테이블 생성
CREATE TABLE chat_text (
    chaT_num number NOT NULL,  -- 메시지 고유번호
    chaT_txt clob NOT NULL,  -- 메시지 내용
    chaT_time date DEFAULT SYSDATE NOT NULL,  -- 메시지를 전송한 시간
    chaT_status number DEFAULT 1 NOT NULL,  -- 신고 시 비활성화
    chaR_num number NOT NULL,  -- 채팅방 고유번호
    mem_num number NOT NULL,  -- 회원 고유 번호
    CONSTRAINT chat_text_pk PRIMARY KEY (chaT_num),
    CONSTRAINT chat_text_fk1 FOREIGN KEY (chaR_num) REFERENCES chat_room (chaR_num),
    CONSTRAINT chat_text_fk2 FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);

-- chat_text 시퀀스 생성
CREATE SEQUENCE chat_text_seq;

-- chat_read 테이블 생성
CREATE TABLE chat_read (
    chaR_num number NOT NULL,  -- 채팅방 고유번호
    chaT_num number NOT NULL,  -- 메시지 고유번호
    mem_num number NOT NULL,  -- 회원 고유 번호
    CONSTRAINT chat_read_fk1 FOREIGN KEY (chaR_num) REFERENCES chat_room (chaR_num),
    CONSTRAINT chat_read_fk2 FOREIGN KEY (mem_num) REFERENCES member (mem_num),
    CONSTRAINT chat_read_fk3 FOREIGN KEY (chaT_num) REFERENCES chat_text (chaT_num)
);
