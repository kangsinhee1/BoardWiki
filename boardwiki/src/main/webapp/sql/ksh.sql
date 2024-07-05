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