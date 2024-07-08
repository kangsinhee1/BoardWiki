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
	item_year     VARCHAR2(50)  NULL, -- 출시 연도
	item_stock    NUMBER(3)     NOT NULL, -- 재고
	item_reg_date DATE DEFAULT SYSDATE NOT NULL, -- 등록일
	CONSTRAINT item_pk PRIMARY KEY (item_num)
);
CREATE SEQUENCE item_seq;

-- 중고 상품 테이블
CREATE TABLE used_item (
	use_num    NUMBER        NOT NULL, -- 중고 번호
	mem_num    NUMBER        NOT NULL, -- 회원고유의 번호
	item_num   NUMBER        NOT NULL, -- 상품 번호
	use_title  VARCHAR2(150) NOT NULL, -- 중고 제목
	use_content CLOB         NOT NULL, -- 중고 내용
	use_comment CLOB         NULL, -- 중고 거래 후기
	use_grade  NUMBER        NULL, -- 중고 거래 평점	
	use_photo  VARCHAR2(400) NOT NULL, -- 중고 상품 사진
	use_price  NUMBER(10)    NOT NULL, -- 중고 가격
	use_check  NUMBER(1)     DEFAULT 1 NOT NULL, -- 상태 (1:미판매, 2:예약중, 3:판매)
	use_rdate  DATE          DEFAULT SYSDATE NOT NULL, -- 등록일
	use_mdate  DATE          NOT NULL, -- 수정일
	CONSTRAINT used_item_pk PRIMARY KEY (use_num),
	constraint used_item_fk1 foreign key (mem_num)
                           references member (mem_num),
    constraint used_item_fk2 foreign key (item_num)
                           references item (item_num)
);
CREATE SEQUENCE used_item_seq;

-- 장바구니 테이블
CREATE TABLE cart (
	mem_num      NUMBER NOT NULL, -- 회원고유의 번호
	item_num     NUMBER NOT NULL, -- 상품 번호
	item_quantity NUMBER NOT NULL, -- 주문 수량
	constraint cart_fk1 foreign key (mem_num)
                           references member (mem_num),
    constraint cart_fk2 foreign key (item_num)
                           references item (item_num)
);


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
	order_reg_date DATE          DEFAULT SYSDATE NOT NULL, -- 구매일
	CONSTRAINT orders_pk PRIMARY KEY (order_num),
	constraint orders_fk1 foreign key (mem_num)
                        references member (mem_num),
    constraint orders_fk2 foreign key (item_num)
                        references item (item_num)
);
CREATE SEQUENCE orders_seq;

-- 중고 및 대여 재고 테이블
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