-- 게임 대여 테이블
CREATE TABLE game_rent (
 rent_num number NOT NULL,  			-- 게임 대여 목록을 식별하는 번호
 rent_sdate varchar2(30) NOT NULL,  	-- 보드게임 대여 시작일
 rent_edate varchar2(30) NOT NULL,  	-- 보드게임 대여 종료일
 rent_period number(1) NOT NULL,  		-- 보드게임 대여 기간(10일 이내)
 mem_num number NOT NULL,  				-- 회원고유의 번호
 item_num number NOT NULL,  			-- 상품번호
CONSTRAINT game_rent_pk PRIMARY KEY (rent_num),
CONSTRAINT game_rent_fk1 FOREIGN KEY (mem_num) REFERENCES member (mem_num),
CONSTRAINT game_rent_fk2 FOREIGN KEY (item_num) REFERENCES item (item_num)
);
CREATE SEQUENCE game_rent_seq;

--ALTER TABLE item
--ADD min_time NUMBER;
--
--ALTER TABLE item
--ADD max_time NUMBER;

-- 신고 테이블
CREATE TABLE report (
 report_num number NOT NULL,  					-- 신고 목록을 식별하는 번호
 reporter_num number NOT NULL,  				-- 신고자를 식별하는 번호
 report_content varchar2(500) NOT NULL,  		-- 신고 처리를 위한 사유
 report_date date DEFAULT SYSDATE NOT NULL,	  	-- 신고 접수일
 report_type number(1) NOT NULL,  				-- 신고 분류를 식별하는 번호
 report_typeDetail number NOT NULL,  			-- 신고당한 게시글, 댓글, 방송, 채팅, 모임을 식별하는 번호
 mem_num number NOT NULL,  						-- 회원고유의 번호
CONSTRAINT report_pk PRIMARY KEY (report_num),
CONSTRAINT report_fk FOREIGN KEY (mem_num) REFERENCES member(mem_num)
);

CREATE SEQUENCE report_seq;