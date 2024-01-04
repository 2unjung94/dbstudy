/*
    내부 조인
*/


-- 1. 사원번호, 사원명, 부서번호, 부서명을 조회하시오.
SELECT E.EMP_NO, E.NAME, E.DEPART, D.DEPT_NAME
  FROM DEPARTMENT_T D, EMPLOYEE_T E  -- INNER JOIN 지우고 , 바꾸기  
 WHERE D.DEPT_NO = E.DEPART;                    -- ON절에서 WHERE절로
    
-- 2. 부서별 평균연봉을 조회하시오. 부서명과 평균연봉을 조회하시오.
SELECT D.DEPT_NAME AS 부서명
     , AVG(E.SALARY) AS 평균연봉
  FROM DEPARTMENT_T D, EMPLOYEE_T E
 WHERE D.DEPT_NO = E.DEPART
 GROUP BY D.DEPT_NAME;
 
/*
    외부 조인(OUTER JOIN)
*/

-- 1. 모든 사원들의 사원번호, 사원명, 부서명을 조회하시오.
SELECT E.EMP_NO, E.NAME, D.DEPT_NAME
  FROM DEPARTMENT_T D, EMPLOYEE_T E
 WHERE D.DEPT_NO(+) = E.DEPART; -- 오른쪽 조인은 왼쪽에 (+) 추가하기

-- 2. 부서별 사원수를 조회하시오. 부서명, 사원수를 조회하시오. 사원이 없으면 0으로 조회하시오.
SELECT D.DEPT_NAME, E.EMP_NO, E.NAME, E.DEPART, E.POSITION, E.GENDER  
  FROM DEPARTMENT_T D, EMPLOYEE_T E
 WHERE D.DEPT_NO = E.DEPART(+); -- 왼쪽 조인은 오른쪽에 (+) 추가하기

SELECT D.DEPT_NAME, COUNT(E.EMP_NO)                    
  FROM DEPARTMENT_T D, EMPLOYEE_T E
 WHERE D.DEPT_NO = E.DEPART(+) -- 왼쪽 조인은 오른쪽에 (+) 추가하기
 GROUP BY D.DEPT_NAME; 
 
-- HR 계정으로 접속

-- 내부 조인

-- 1. 사원번호, 사원명, 부서명을 조회하시오.            
SELECT E.EMPLOYEE_ID, E.LAST_NAME, D.DEPARTMENT_NAME
  FROM DEPARTMENTS D, EMPLOYEES E -- 일대다 관계에서 PK먼저 쓴다 (부서에는 여러명의 사원이 있다)
 WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID;

-- 2. 부서번호, 부서명, 지역명을 조회하시오.
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, L.STREET_ADDRESS
  FROM LOCATIONS L, DEPARTMENTS D -- 일대다 관계에서 PK먼저 쓴다 (지역에는 여러개의 부서가 있다)
 WHERE L.LOCATION_ID = D.LOCATION_ID ;

-- 3. 사원번호, 사원명, 직업, 직업별 최대연봉, 연봉을 조회하시오.
SELECT E.EMPLOYEE_ID, E.LAST_NAME, E.JOB_ID, J.MAX_SALARY, E.SALARY
  FROM JOBS J, EMPLOYEES E -- 일대다 관계에서 PK먼저 쓴다 (직업에는 여러명의 사원이 포함되어 있다)
 WHERE J.JOB_ID = E.JOB_ID;
    
-- 외부 조인

-- 4. 사원번호, 사원명, 부서명을 조회하시오. 부서가 없으면 '부서없음'으로 조회하시오.
SELECT E.EMPLOYEE_ID, E.LAST_NAME, NVL(D.DEPARTMENT_NAME, '부서없음')
  FROM DEPARTMENTS D, EMPLOYEES E -- EMPLOYEES의 테이블에 조건이 만족하지 않더라도 일단 조회해라.
 WHERE D.DEPARTMENT_ID(+) = E.DEPARTMENT_ID;

-- 5. 부서별 평균급여를 조회하시오. 부서명, 평균급여를 조회하시오. 근무중인 사원이 없으면 평균급여를 0으로 조회하시오.
SELECT D.DEPARTMENT_NAME, NVL(AVG(E.SALARY), 0)
  FROM DEPARTMENTS D, EMPLOYEES E -- 부서테이블은 조건이 안맞더라도 조회해야 하므로 LEFT JOIN
 WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID(+)
 GROUP BY D.DEPARTMENT_ID, D.DEPARTMENT_NAME; -- 이름보단 PK인 ID로 그룹화 하는게 더 정확성이 높기 때문에 ID로도 그룹화 한다.
 
-- 3개 이상 테이블 조인하기

-- 6. [EMPLOYEES 사원번호, 사원명], [DEPARTMENTS부서번호, 부서명], [LOCATIONS 지역번호, 지역명]을 조회하시오. 
-- E D 먼저 조인하고 나중에 L과 조인하는 방법
SELECT E.EMPLOYEE_ID, E.LAST_NAME, D.DEPARTMENT_ID, D.DEPARTMENT_NAME, L.LOCATION_ID, L.STREET_ADDRESS
  FROM DEPARTMENTS D, EMPLOYEES E, LOCATIONS L
 WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID  
   AND D.LOCATION_ID = L.LOCATION_ID;
-- E와 L은 조인관계 안됨
-- 순서 정하는거는 딱히 신경 안써도 된다. 답 나오는게 우선

-- D L 먼저 조인하고 나중에 E와 조인하는 방법 (PK가 왼쪽에 오는게 성능이 좋으므로 이게 더 낫다)
SELECT E.EMPLOYEE_ID, E.LAST_NAME, D.DEPARTMENT_ID, D.DEPARTMENT_NAME, L.LOCATION_ID, L.STREET_ADDRESS
  FROM LOCATIONS L ,DEPARTMENTS D, EMPLOYEES E
 WHERE L.LOCATION_ID = D.LOCATION_ID
   AND D.DEPARTMENT_ID = E.DEPARTMENT_ID;

-- 7. C국가명, L도시명, D부서명을 조회하시오.
SELECT C.COUNTRY_NAME, L.CITY, D.DEPARTMENT_NAME
  FROM COUNTRIES C, LOCATIONS L, DEPARTMENTS D
 WHERE C.COUNTRY_ID = L.COUNTRY_ID  /*국가, 지역 조인 완료*/
   AND L.LOCATION_ID = D.LOCATION_ID; -- 처음 조인한 것과 부서와 조인
  
-- 셀프 조인 (하나의 테이블에 일대다 관계를 가지는 칼럼들이 존재하는 경우)

-- 8. 사원번호, 사원명, 매니저번호, 매니저명을 조회하시오.
-- 관계
-- 1명의 매니저가 N명의 사원을 관리한다. 일대다 관계 성립

-- 1                             N
-- 매니저테이블  : EMPLOYEES M   사원테이블    : EMPLOYEES E
-- PK            : EMPLOYEE_ID   FK            : MANAGER_ID

-- 조인조건      : M.EMPLOYEES_ID = E.MANAGER_ID
SELECT E.EMPLOYEE_ID  AS 사원번호
     , E.LAST_NAME    AS 사원명
     , E.MANAGER_ID   AS 매니저번호
     , M.LAST_NAME    AS 매니저명
  FROM EMPLOYEES M, EMPLOYEES E
 WHERE M.EMPLOYEE_ID = E.MANAGER_ID;
    
-- 9. 같은 부서내에서 나보다 급여를 더 많이 받는 사원을 조회하시오.
-- 관계
-- 나는 여러 사원과 관계를 맺는다.
-- 나(EMPLOYEES ME)                    너님들(EMPLOYEES YOU)
-- 같은 부서의 사원만 조인하기 위해서 부서 번호로 조인조건을 생성함.

SELECT ME.EMPLOYEE_ID   AS 사원번호
     , ME.LAST_NAME     AS 사원명
     , ME.SALARY        AS 급여
     , YOU.EMPLOYEE_ID  AS 너사원번호
     , YOU.LAST_NAME    AS 너이름
     , YOU.SALARY       AS 너급여
  FROM EMPLOYEES ME, EMPLOYEES YOU
 WHERE ME.DEPARTMENT_ID = YOU.DEPARTMENT_ID
   AND ME.SALARY < YOU.SALARY;