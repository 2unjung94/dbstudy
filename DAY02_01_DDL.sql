/*
    DDL
    1. Data Definition Language
    2. 데이터 정의어
    3. 데이터베이스 객체를 다루는 언어이다.(데이터베이스 객체 : 테이블, 사용자)
    4. 종류
        1) CREATE   : 생성
        2) ALTER    : 수정
        3) DROP     : 삭제(완전 삭제)
        4) TRUNCATE : 삭제(내용만 삭제)
*/
-- 스크립트 작성시 테이블 삭제->테이블 생성

-- 테이블 삭제 **생성과 삭제는 거꾸로!!
DROP TABLE CUSTOMER_T;
DROP TABLE BANK_T;

-- 테이블 생성
CREATE TABLE BANK_T(
    BANK_CODE VARCHAR2(20 BYTE) NOT NULL,
    BANK_NAME VARCHAR2(30 BYTE),
    CONSTRAINT PK_BANK PRIMARY KEY(BANK_CODE) --제약조건의 이름 생성 : CONSTRAINT 제약조건이름 인라인에썼던제약조건(적용할컬럼)
);

CREATE TABLE CUSTOMER_T(
    CUST_NO     NUMBER              NOT NULL,
    CUST_NAME   VARCHAR2(30 BYTE)   NOT NULL,
    CUST_PHONE  VARCHAR2(30 BYTE)   UNIQUE,
    CUST_AGE    NUMBER(3)           CHECK(CUST_AGE >=0 AND CUST_AGE<=120),
                                 -- CHECK(CUST_AGE BETWEEN 0 AND 120), 나이가 0~120까지 설정.
    BANK_CODE   VARCHAR2(20 BYTE),
    CONSTRAINT PK_CUSTOMER      PRIMARY KEY(CUST_NO),
    CONSTRAINT FK_CUSTOMER_BANK FOREIGN KEY(BANK_CODE) REFERENCES BANK_T(BANK_CODE)
);

--SELECT * FROM USER_CONSTRAINTS; -- 제약조건 확인

/*
    테이블 수정하기 = 칼럼 수정이라고 보면 됨.
    1. 칼럼 추가하기          : ALTER TABLE 테이블명 ADD            칼럼명 데이터타입 제약조건
    2. 칼럼 수정하기          : ALTER TABLE 테이블명 MODIFY         칼럼명 데이터타입 제약조건
    3. 칼럼 삭제하기          : ALTER TABLE 테이블명 DROP COLUMN    칼럼명
    4. 칼럼 이름 바꾸기       : ALTER TABLE 테이블명 RENAME COLUMN  기존칼럼명 TO 신규칼럼
    5. 테이블 이름 바꾸기     : ALTER TABLE 테이블명 RENAME TO      신규테이블명  
*/

-- 1. BANK_T에 연락처(BANK_TEL) 칼럼을 추가하시오.
--ALTER TABLE BANK_T ADD BANK_TEL VARCHAR2(30 BYTE) NULL; --나
ALTER TABLE BANK_T ADD BANK_TEL VARCHAR2(15 BYTE); --선생님

-- 2. BANK_T의 은행명(BANK_NAME) 칼럼을 VARCHAR2(15 BYTE)로 바꾸고 필수 제약조건을 지정하시오.
--ALTER TABLE BANK_T MODIFY BANK_NAME VARCHAR2(15 BYTE) NOT NULL; --나
ALTER TABLE BANK_T MODIFY BANK_NAME VARCHAR2(15 BYTE) NOT NULL; --선생님

-- 3. CUSTOMER_T의 나이(CUST_AGE) 칼럼을 삭제하시오.
--ALTER TABLE CUSTOMER_T DROP COLUMN CUST_AGE; --나
ALTER TABLE CUSTOMER_T DROP COLUMN CUST_AGE; --선생님

-- 4. CUSTOMER_T의 연락처(CUST_PHONE) 칼럼명을 CUST_TEL로 수정하시오.
--ALTER TABLE CUSTOMER_T RENAME COLUMN CUST_PHONE TO CUST_TEL;--나
ALTER TABLE CUSTOMER_T RENAME COLUMN CUST_PHONE TO CUST_TEL;--선생님

-- 5. CUSTOMER_T에 등급(GRADE) 칼럼을 추가하시오. 'VIP', 'GOLD', 'SILVER', 'BRONZE' 중 하나의 값을 가지도록 설정하시오.
--ALTER TABLE CUSTOMER_T ADD GRADE VARCHAR2(30 BYTE) CHECK(GRADE = VIP OR GOLD OR SIVER OR BRONZE);--나
ALTER TABLE CUSTOMER_T ADD GRADE VARCHAR2(6 BYTE) CHECK(GRADE = 'VIP' OR GRADE = 'GOLD' OR GRADE = 'SILVER' OR GRADE = 'BRONZE') --선생님
                                                --CHECK(GRADE IN('VIP', 'GOLD', 'SILVER', 'BRONZE'));
                                                  
-- 6. CUSTOMER_T의 고객명(CUST_NAME) 칼럼의 필수 제약조건을 없애시오.
--ALTER TABLE CUSTOMER_T MODIFY CUST_NAME VARCHAR2(30 BYTE) NULL;--나
ALTER TABLE CUSTOMER_T MODIFY CUST_NAME VARCHAR2(30 BYTE) NULL;--선생님 (CREATE는 NULL을 안써도 되지만 ALTER는 명시해야함)


-- 7. CUSTOMER_T의 테이블명을 CUST_T로 수정하시오.
--ALTER TABLE CUSTOMER_T RENAME TO CUST_T;--나
ALTER TABLE CUSTOMER_T RENAME TO CUST_T;--선생님


/*
    테이블 수정하기 - PK/FK제약조건
    
    1. PK
        1) 추가 : ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 PRIMARY KEY(칼럼명)
        2) 삭제
            (1) ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명
            (2) ALTER TABLE 테이블명 DROP PRIMARY KEY
    2. FK
        1) 추가     : ALTER TABLE 자식테이블 ADD     CONSTRAINT 제약조건명 FOREIGN KEY(칼럼명) REFERENCES 부모테이블명(참조할칼럼명) [옵션]
        2) 삭제     : ALTER TABLE 테이블명   DROP    CONSTRAINT 제약조건명 
        3) 비활성화 : ALTER TABLE 테이블명   DISABLE CONSTRAINT 제약조건명
        4) 활성화   : ALTER TABLE 테이블명   ENABLE  CONSTRAINT 제약조건명
*/

-- FK_CUSTOMER_BANK 제약조건을 비활성화하시오.
ALTER TABLE CUST_T DISABLE CONSTRAINT FK_CUSTOMER_BANK; --외래키를 비활성화하면 은행코드가 작성되었지 않아도 고객테이블에 은행코드를 집어넣을 수 있다. 

-- FK_CUSTOMER_BANK 제약조건을 활성화하시오.
ALTER TABLE CUST_T ENABLE CONSTRAINT FK_CUSTOMER_BANK; --은행코드가 없는 상태, 고객테이블에 작성된 상태에서 다시 활성화를 시키면 부모키가 없다는 오류가 생김.


