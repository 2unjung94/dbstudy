-- 1. 대소문자 변환하기
SELECT UPPER('apple') -- 소문자->대문자      APPLE
     , LOWER('APPLE') -- 대문자->소문자      apple
     , INITCAP('APPLE') -- 첫글자만 대문자로 Apple
  FROM DUAL;

-- 2. 글자수/바이트수 반환하기
SELECT NAME
     , LENGTH(NAME) AS 글자수
     , LENGTHB(NAME) AS 바이트수
  FROM EMPLOYEE_T;

-- 3. 문자 연결하기
-- 1) ||           : 연결 연산자 (오라클에서만 사용 가능)
-- 2) CONCAT(A, B) : 연결 함수. 인자값은 2개여서 3개면 안됨. 여러 DB를 사용하는게 좋다.
SELECT 'A' || 'B' || 'C'
     , CONCAT(CONCAT('A', 'B'), 'C')
  FROM DUAL;

SELECT *
  FROM EMPLOYEE_T
 WHERE NAME LIKE '한' || '%'; -- '한'을 변수처리 해서 변수로 시작하는 이름의 정보를 보여준다.

-- 4. 특정 문자의 위치 반환
-- 1) 문자의 위치는 1부터 시작한다.
-- 2) 못 찾으면 0을 반환한다.
SELECT NAME
    , INSTR(NAME, '이')
  FROM EMPLOYEE_T;

-- 5. 일부 문자열 반환
SELECT NAME
     , SUBSTR(NAME, 1, 1) AS 성   -- 1번째 글자부터 1글자를 반환
     , SUBSTR(NAME, 2)    AS 이름 -- 2번째 글자부터 끝까지 반환
  FROM EMPLOYEE_T;

-- 구*민, 김*서, 이*영, 한*일 이름조회하기
SELECT CONCAT(CONCAT(SUBSTR(NAME, 1, 1), '*'), SUBSTR(NAME,3)) AS 이름
  FROM EMPLOYEE_T;
  
SELECT SUBSTR(NAME, 1, 1) || '*' || SUBSTR(NAME, LENGTH(NAME)) AS 이름
  FROM EMPLOYEE_T;

-- 6. 찾아 바꾸기
SELECT REPLACE(DEPT_NAME, '부', '팀') AS 부서  -- '부'를 '팀'으로 바꾸기
  FROM DEPARTMENT_T;
  
SELECT REPLACE(DEPT_NAME, '부', '') AS 부서 -- '부'를 ''로 바꾸기(지우기)
  FROM DEPARTMENT_T;

-- 7. 채우기 (숫자는 불가)
-- 1) LPAD(EXPR1, N, [EXPR2]) : N자리의 EXPR1을 반환, 왼쪽에 EXPR2를 채움(생략하면 공백 채움)
-- EX)LPAD('A', 10, '*') : **********A
-- 2) RPAD(EXPR1, N, [EXPR2]) : N자리의 EXPR1을 반환, 왼쪽에 EXPR2를 채움(생략하면 공백 채움)
-- EX)LPAD('A', 10, '*') : A**********

SELECT LPAD(NAME, 10, '*') -- 10자리(한글은 5글자)의 NAME 반환(한글 한글자 = 알파벳 두글자), 왼쪽에 '*' 채움
     , RPAD(NAME, 10, '*') -- 10자리(한글은 5글자)의 NAME 반환(한글 한글자 = 알파벳 두글자), 오른쪽에 '*' 채움
  FROM EMPLOYEE_T;

-- 8. 공백 제거
-- 1) LTRIM(EXPR) : 왼쪽 공백 제거
-- 2) RTRIM(EXPR) : 오른쪽 공백 제거
-- 3)  TRIM(EXPR) : 왼쪽/오른쪽 제거
SELECT LTRIM('   HELLO   WORLD    ')
     , RTRIM('   HELLO   WORLD    ')
     ,  TRIM('   HELLO   WORLD    ')
  FROM DUAL;
  