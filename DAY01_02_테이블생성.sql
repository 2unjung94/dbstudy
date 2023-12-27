/*
    테이블(table)
    1. 관계형 데이터베이스에서 데이터를 저장하는 객체이다.
    2. 표 형식을 가진다.
    3. 행(Row)과 열(Colum)의 집합 형식이다.
*/
/*
    테이블 만들기
    1. 열(Colum)을 만드는 과정이다. (표의 첫번째 줄을 만드는 것과 같음)
    2. 테이블 만드는 쿼리문
        CREATE TABLE 테이블이름 (
            칼럼이름1 데이터타입 제약조건, 
            칼럼이름2 데이터타입 제약조건,
            ...
        ); 데이터타입, 제약조건 각각 분리해서 공부해야함.
*/
/*
    데이터타입
    1. NUMBER(p,s) : 정밀도가 p이고, 스케일이 s인 숫자
        1) 정밀도 p : 전체 유효 숫자(123의 p=3, 0123의 p=3, 1.2의 p=2, 즉 자릿수를 의미)
        2) 스케일 s : 소수부의 유효 숫자(1.2의 s=1)
            즉, 1.2 = NUMBER(2,1)
            NUMBER(2,2) = 0.xx
        3) 스케일만 생략하면 정수로 표시하는 숫자
            NUMBER(3) = 0~999까지의 숫자
        4) 정밀도와 스케일을 생략하면 정수, 실수 모두 표시할 수 있는 숫자
    2. CHAR(size) : 글자수가 최대 size인 고정 문자 타입
        1) 고정 문자 : 글자수의 변동이 적은 문자 (예시 : 휴대전화번호, 주민번호, 우편번호 등)
        2) 최대 size : 2000 byte (영어 한글자가 1 byte. abc=3byte. 한글은 좀더 큼)
    *3. VARCHAR2(size) : 글자수가 최대 size인 가변 문자 타입
        1) 가변 문자 : 글자수의 변동이 큰 문자 (예시 : 이름, 주소 등)
        2) 최대 size : 4000 byte
        3) 웬만하면 이걸 사용할 것.
    
    ** CHAR(5)='abc' 와 VARCHAR2(5)='abc'는 서로 같냐 물을 때 false 나옴.
        -> char(5)의 abc는 메모리에 "abc__", varchar(5)의 abc는 메모리에 "abc" 저장.
        -> char를 쓰면 불필요한 공백이 있을 수 있어서 메모리 관리에는 varchar가 더 좋아 권장사용.
        
    4. CLOB : VARCHAR2(size)로 처리할 수 없는 큰 문자(4000 byte가 넘어가는 문자)
    5. DATE : 날짜/시간(년,월,일,시,분,초)
    6. TIMESTAMP : 정밀한 날짜/시간(년,월,일,시,분,초,마이크로초(백만분의 1초))
*/
/*
    제약조건 5가지
    1. NOT NULL : 필수 입력
    2. UNIQUE : 중복 불가
    3. PRIMARY KEY : 기본키. 어떤 데이터를 식별하는 키.(EX.주민등록번호, 학번, 제품번호 등). 제일 많이 쓰는건 번호.
        1) 중복 불가
        2) 반드시 값을 가지고 있어야 함.
        즉, NOT NULL과 UNIQUE가 합쳐진 것.
    4. FOREIGN KEY : 외래키
    5. CHECK : 작성한 조건으로 값의 제한
*/

-- 블로그 구현을 위한 블로그 테이블
CREATE TABLE BLOG_T (
    BLOG_NO  NUMBER             NOT NULL PRIMARY KEY, -- 기본키. NOT NULL은 함께 명시
    TITLE    VARCHAR2(100 BYTE) NOT NULL,
    EIDITOR  VARCHAR2(100 BYTE) NOT NULL,
    CONTENTS CLOB               NULL, --사용할 제약조건이 없으면 NULL 작성. NULL은 생략 가능함
    CREATED  DATE               NOT NULL
);

-- 왼쪽 테이블 누르고 새로고침 하면 만든 테이블이 보임

-- 블로그 테이블 삭제하기
DROP TABLE BLOG_T;
