-- 게시판 테이블
CREATE TABLE board (
	boa_num    NUMBER       NOT NULL, -- 게시글 번호
	mem_num    NUMBER       NOT NULL, -- 회원고유의 번호
	boa_category CHAR(1)      NOT NULL, -- 게시판 구분 (1:자유게시판, 2:팁게시판, 3:후기게시판, 4:공지사항, 5:QnA, 6:모임게시판)
	boa_title  VARCHAR2(150) NOT NULL, -- 게시글 제목
	boa_content CLOB        NOT NULL, -- 게시글 내용
	boa_hit    NUMBER(10)   NOT NULL, -- 게시글 조회수
	boa_rdate  DATE         DEFAULT SYSDATE NOT NULL, -- 게시글 작성 날짜
	boa_mdate  DATE         NULL, -- 게시글 수정 날짜
	boa_auth   NUMBER(1)  DEFAULT '0'  NOT NULL, -- 게시글 권한 (0: 일반, 1: 신고 접수, 2: 정지)
	boa_photo  VARCHAR2(400) NULL -- 게시글 사진
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
	boaR_auth   NUMBER(1)  DEFAULT '0'   NOT NULL, -- 댓글 권한 (0: 일반, 1: 신고 접수, 2: 정지)
	boaR_rdate  DATE  DEFAULT SYSDATE  NOT NULL, -- 댓글 작성 날짜 (기본: SYSDATE)
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
