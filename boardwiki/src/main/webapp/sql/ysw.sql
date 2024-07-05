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