-- 데이터타입 변환 함수
/*
    DUAL 테이블
    1. 테이블이 필요 없는 경우에 사용하는 테이블
    2. 테이블이 필요 없는 조회(DQL)의 경우에도 FROM절까지 작성해야 하는데 이때 사용한다.
    3. 1개의 열(COLUMN)과 1개의 행(ROW)으로 구성되어 있다.
    4. DUMMY 칼럼
       X     값
*/
SELECT *
FROM    DUAL;

/*
    1. 문자 -> 숫자 변환
        TO_NUMBER(문자)
        TO_NUMBER('123') OOO
        TO_NUMBER('ABC') XXX
*/
SELECT '100',TO_NUMBER('100') AS 숫자변환-- 문자 : 왼쪽 정렬, 숫자 : 오른쪽 정렬
  FROM DUAL;

-- 아래 쿼리는 
SELECT *
  FROM DEPARTMENT_T
 WHERE DEPT_NO = '1';
 
-- 이렇게 바뀐 뒤에 실행된다.
SELECT *
  FROM DEPARTMENT_T
 WHERE DEPT_NO = TO_NUMBER('1');
 
/*
    2. 숫자 -> 문자 변환
        TO_CHAR(숫자, [형식]) -- 형식은 생략 가능
*/
SELECT TO_CHAR(SALARY)
     , TO_CHAR(SALARY, '99999999')  -- 8자리 문자열로 변환, 빈자리는 공백으로 채움
     , TO_CHAR(SALARY, '00000000')  -- 8자리 문자열로 변환, 빈자리를 0으로 채움
     , TO_CHAR(SALARY, '9,999,999') -- 7자리 문자열로 변환, 천 단위 구분 기호 사용
     , TO_CHAR(SALARY, '999,999')   -- 6자리 문자열로 변환, 천 단위 구분 기호 사용, 원본이 7자리이므로 정상 변환이 안 됨
  FROM EMPLOYEE_T;
  
/*
    3. 문자 -> 날짜 변환
        TO_DATE(문자, [형식]) -- 형식 생략 가능. 생략시 00/00/00 이 기본
        
        * 날짜/시간 형식
        1) YY   : 년도 2자리 
        2) YYYY : 년도 4자리 
        3) MM   : 월 2자리 
        4) DD   : 일 2자리 
        5) AM   : 오전 / 오후
        6) HH   : 12시간(01~12)
        7) HH24 : 24시간(01~24)
        8) MI   : 분 2자리
        9) SS   : 초 2자리
       10) FF3  : 밀리초 3자리 (1/1000초)
*/

SELECT TO_DATE(HIRE_DATE)
     , TO_DATE(HIRE_DATE, 'YY/MM/DD') -- 입력된 값을 년도/월/일 로 해석
     , TO_DATE(HIRE_DATE, 'YY/DD/MM') -- 입력된 값을 년도/일/월 로 해석
     , TO_DATE(HIRE_DATE, 'HH/MI/SS') -- 입력된 값을 시/분/초로 해석 (오류 발생)
  FROM EMPLOYEE_T;
  
/*
    4. 날짜 -> 문자 변환
        TO_CHAR(날짜, [형식])
        
        * 현재 날짜/시간 함수
            1) SYSDATE(현재 오라클이 설치된 컴퓨터의 시간) : 년,월,일,시,분,초
            2) SYSTIMESTAMP(밀리초까지 나오는)             : 년,월,일,시,분,초,밀리초
*/
 
SELECT SYSDATE
     , SYSTIMESTAMP
     , TO_CHAR(SYSDATE, 'YYYY. MM. DD.  HH:MI:SS')  
     , TO_CHAR(SYSTIMESTAMP, 'YYYY-MM-DD AM HH:MI:SS.FF3')
  FROM DUAL;
