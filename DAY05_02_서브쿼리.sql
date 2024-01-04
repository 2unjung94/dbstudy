/*
    서브 쿼리 (거의 SELECT 메인쿼리 안에 SELECT 하위쿼리 넣는거 배움)
    1. 메인 쿼리에 포함되는 하위 쿼리를 서브 쿼리라고 한다.
    2. 실행 순서
        서브 쿼리 -> 메인 쿼리
    3. 종류
        1) SELECT 절 : 스칼라 서브 쿼리 - 조회할 칼럼(값) 대신 들어가는 쿼리문
        2)   FROM 절 : 인라인 뷰 (INLINE VIEW) - 테이블 대신 들어가는 쿼리문 
        3)  WHERE 절 : 일반적인 서브쿼리
            (1) 단일 행 서브 쿼리 (결과 행이 1행)
            (2) 다중 행 서브 쿼리 (결과 행이 N행)
*/

/*
    단일 행 서브 쿼리
    1. 서브 쿼리의 실행 결과가 1행이다.
    2. ** 단일 행 서브 쿼리인 경우
        1) 함수 결과를 반환하는 서브 쿼리
        2) PK 또는 UNIQUE 칼럼의 동등 비교 조건을 사용한 서브 쿼리 ** (중요)
    3. 단일 행 서브 쿼리 연산자
        =, !=, >, >=, <, <=
*/
-- 1. (사원번호가 1004인 사원의 직책)을 가진 사원 조회하기. ()안이 서브쿼리임.
SELECT *
  FROM EMPLOYEE_T
 WHERE POSITION = (SELECT POSITION 
                     FROM EMPLOYEE_T 
                    WHERE EMP_NO = 1004); -- PK(EMP_NO)의 동등 비교 조건을 사용했기 때문에 단일 행 서브 쿼리임

-- 2. 급여 평균보다 더 큰 급여를 받는 사원 조회하기.
SELECT *
  FROM EMPLOYEE_T
 WHERE SALARY > (SELECT AVG(SALARY) -- 함수 결과를 반환하는 서브쿼리이므로 단일 행 서브 쿼리
                   FROM EMPLOYEE_T);
                   
/*
    다중 행 서브 쿼리
    1. 서브 쿼리의 실행 결과가 N행이다.
    2. 다중 행 서브 쿼리 연산자
        IN, ANY, ALL 등 (IN이 주로 쓰임)
        IN('A', 'B', ...) (A 또는 B 또는 ...)
        COLUMN > ANY(1,2,3) ( COLUMN 값이 1보다 크던가, 2보다 크던가, 3보다 크던가 -> 즉 1보다 크면 다 된다) 대체 : COLUMN > MIN(1,2,3) (1보다 크면 된다)
    3. 단일 행 서브 쿼리를 제외하면 나머지는 다 다중 행 서브 쿼리
*/
-- 1. 부서가 '영업부'인 사원을 조회하시오.
SELECT *
  FROM EMPLOYEE_T
 WHERE DEPART IN(SELECT DEPT_NO
                   FROM DEPARTMENT_T
                  WHERE DEPT_NAME = '영업부'); -- DEPT_NAME은 PK, UNIQUE도 아니어서 동등비교 연산자(=)를 사용해도
                                               -- 잠재적으로 결과가 두개 이상이 나올 수 있기 때문에 잠재적으로 다중 행 서브 쿼리다. 그래서 등호 대신 IN으로 바꿔줘라.

-- 2. 근무 지역이 '서울'인 사원을 조회하시오.
SELECT *
  FROM EMPLOYEE_T
 WHERE DEPART IN(SELECT DEPT_NO                     -- '=' 연산자를 사용했을 때 '단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다' 라는 오류로 실행이 안됨. 따라서 IN 사용할 것.
                   FROM DEPARTMENT_T
                  WHERE DEPT_LOCATION = '서울');
                  
-- HR 계정으로 접속

/*
    인라인 뷰
    1. FROM 절에 포함되는 서브 쿼리이다.
    2. 서브 쿼리의 실행 결과를 임시 테이블의 형식으로 FROM 절에 두고 사용한다.
    3. SELECT 문의 실행 순서를 조정할 때 사용할 수 있다. (EX. ORDER BY절은 제일 마지막에 실행되지만, FROM 절에 서브쿼리로 ORDER BY절을 넣으면 제일 먼저 실행된다.)
*/

-- 1. 2번째로 입사한 사원을 조회하시오.
-- 1) HIRE_DATE의 오름차순 정렬을 한다. (입사순 정렬)  - 별명 A
-- 2) 오름차순 결과에 행 번호(ROWNUM)를 붙인다.        - 별명 B
-- 3) 행 번호가 2인 데이터를 조회한다.
-- ROWNUM : 오라클에서 제공하는 가상 칼럼. 행번호를 붙이고 싶을 때 사용. 사용에 제약이 있기 때문에 ROWNUM에 별명을 붙여라.
SELECT B.*
FROM (SELECT ROWNUM AS RN, A.*
        FROM (SELECT *
                FROM EMPLOYEES
                ORDER BY HIRE_DATE ASC) A /*1번*/) B -- 2번
 WHERE B.RN = 2; -- 3번

-- 2. 연봉 TOP 10을 조회하시오.
-- 1) SALARY 내림차순 정렬        -- 별명 A
-- 2) 정렬 결과에 행번호          -- 별명 B
-- 3) 행번호가 10번까지           -- WHERE 절
SELECT B.*
  FROM (SELECT ROWNUM AS RN, A.*
          FROM (SELECT *
                  FROM EMPLOYEES
                 ORDER BY SALARY DESC) A ) B
 WHERE B.RN BETWEEN 1 AND 10;
 
-- 3. 2번째로 입사한 사원을 조회하시오.
-- 1) HIRE_DATE의 오름차순 정렬을 하고 행 번호(ROW_NUMBER 함수)를 붙인다.     -- 별명A        
-- 2) 행 번호가 2인 데이터를 조회한다.
SELECT A.*
  FROM (SELECT ROW_NUMBER() OVER(ORDER BY HIRE_DATE ASC) AS RN, EMPLOYEE_ID, HIRE_DATE
          FROM EMPLOYEES) A
 WHERE A.RN = 2;

-- 2. 연봉 TOP 10을 조회하시오.
-- 1) SALARY 내림차순 정렬하고 행번호(ROW_NUMBER() 함수)를 붙인다.   -- 별명 A
-- 2) 행번호가 10번까지                                              -- WHERE 절
SELECT A.*
  FROM (SELECT ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS RN, EMPLOYEE_ID, SALARY
          FROM EMPLOYEES) A
 WHERE A.RN BETWEEN 1 AND 10;
 
/*
    스칼라 서브 쿼리
    1. SELECT 절에 포함된 서브 쿼리이다.
    2. 메인 쿼리를 서브쿼리에서 사용할 수 있다.
        1) 비상관 쿼리 : 서브 쿼리가 메인 쿼리를 사용하지 않는다.
        2) 상관 쿼리   : 서브 쿼리가 메인 쿼리를 사용한다.
*/

-- 1. (비상관) (부서번호가 50인 부서에 근무하는 사원의 사원번호, 사원명), (부서명) 조회하시오. (JOIN으로도 풀 수 있다)
--                             메  인 쿼리                                서브 쿼리
SELECT EMPLOYEE_ID
     , LAST_NAME
     , (SELECT DEPARTMENT_NAME
          FROM DEPARTMENTS
         WHERE DEPARTMENT_ID = 50)
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = 50;

-- 2. (상관) 부서번호가 50인 부서에 근무하는 사원의 사원번호, 사원명, 부서명 조회하시오. 실행결과 NULL 값이 나오는 이유는..? : 외부조인,,,,,;;;
SELECT E.EMPLOYEE_ID
     , E.LAST_NAME
     , (SELECT D.DEPARTMENT_NAME
          FROM DEPARTMENTS D
         WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID -- 외부조인을 쓰고 있음
           AND D.DEPARTMENT_ID = 50)
  FROM EMPLOYEES E;

-- 3. 부서번호, 부서명, 사원수를 조회하시오.
SELECT D.DEPARTMENT_ID
     , D.DEPARTMENT_NAME
     , (SELECT COUNT(*)
          FROM EMPLOYEES E
         WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID) AS 사원수
  FROM DEPARTMENTS D;


-- GD 계정
/*
    CREATE 문과 서브 쿼리
    1. 서브 쿼리 결과를 새로운 테이블로 만들 수 있다.
    2. 테이블을 복사하는 용도로도 사용할 수 있다.
    3. 형식
        CREATE TABLE 테이블명 (칼럼1, 칼럼2, ...)
        AS (SELECT 칼럼1, 칼럼2, ...)
*/
-- 1. 사원번호, 사원명, 급여, 부서번호를 조회하고 결과를 새 테이블로 생성하시오.
CREATE TABLE EMPLOYEE_T2 (EMP_NO, NAME, SALARY, DEPART)  -- 제약조건까지 복사되진 않는다.
AS (SELECT EMP_NO, NAME, SALARY, DEPART
      FROM EMPLOYEE_T);

-- 2. 부서 테이블의 구조만 복사하여 새 테이블로 생성하시오.
CREATE TABLE DEPARTMENT_T2 (DEPT_NO, DEPT_NAME, LOCATION)
AS (SELECT DEPT_NO, DEPT_NAME, LOCATION
      FROM DEPARTMENT_T
     WHERE 1 = 2); -- WHERE절에 항상 만족하지 않는 조건을 걸면 구조만 복사됨

/*
    INSERT 문과 서브 쿼리
    1. 서브 쿼리의 결과를 INSERT 할 수 있다.
    2. 한번에 여러 행을 INSERT 할 수 있다.
    3. 형식
        INSER INTO 테이블명 (칼럼1, 칼럼2, ...) (SELECT 칼럼1, 칼럼2, ...)
*/
-- 1. 지역이 '대구'인 부서 정보를 DEPARTMENT_T2 테이블에 삽입하시오.
INSERT INTO DEPARTMENT_T2 
(SELECT DEPT_NO, DEPT_NAME, DEPT_LOCATION
   FROM DEPARTMENT_T
  WHERE DEPT_LOCATION = '대구');
COMMIT;

-- 2. 직급이 '과장'인 사원 정보를 '과장명단' 테이블로 생성하시오.

-- CREATE 절
CREATE TABLE 과장명단 (EMP_NO, NAME, DEPART, POSITION, GENDER, HIRE_DATE, SALARY)
AS (SELECT EMP_NO, NAME, DEPART, POSITION, GENDER, HIRE_DATE, SALARY
      FROM EMPLOYEE_T
     WHERE 1 = 2);
     
-- INSERT 절
INSERT INTO 과장명단
(SELECT EMP_NO, NAME, DEPART, POSITION, GENDER, HIRE_DATE, SALARY
   FROM EMPLOYEE_T
  WHERE POSITION = '과장');
COMMIT;