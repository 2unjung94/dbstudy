/*
    WITH
    1. 자주 사용하거나 복잡한 쿼리문은 WITH 절로 등록시켜 놓을 수 있다.
    2. WITH 절에 등록된 쿼리문은 임시 저장 상태이므로 곧바로 사용해야 한다.
    3. WITH 절을 이용하면 쿼리문의 가독성이 좋아진다.
*/ 

-- 1. 연봉 2 ~ 3위 사원 정보를 조회하시오.
SELECT EMP_NO, NAME, DEPART, POSITION, GENDER, HIRE_DATE, SALARY
  FROM (SELECT RANK() OVER(ORDER BY SALARY DESC) AS RN, EMP_NO, NAME, DEPART, POSITION, GENDER, HIRE_DATE, SALARY  -- 동점자 나오게 하는 함수는 RANK()
          FROM EMPLOYEE_T)
 WHERE RN BETWEEN 2 AND 3;

-- 2. WITH 절을 이용하여 연봉 2 ~ 3위 사원 정보를 조회하시오.
WITH RANKING_T -- AS 다음 서브 쿼리를 RANKING_T라는 테이블로 지정하겠다.
AS (SELECT RANK() OVER(ORDER BY SALARY DESC) AS RN
        , EMP_NO, NAME, DEPART, POSITION, GENDER, HIRE_DATE, SALARY 
      FROM EMPLOYEE_T)

SELECT EMP_NO, NAME, DEPART, POSITION, GENDER, HIRE_DATE, SALARY
  FROM RANKING_T
 WHERE RN BETWEEN 2 AND 3;

-- ** 3. 부서별 부서번호, 부서명, 연봉총액을 조회하시오. 서브쿼리 문제인줄 알고 개같이 머리 굴리고 있는데 갑분 JOIN으로 짬 ㅡㅡ
  
SELECT DEPT_NO, DEPT_NAME, SUM(SALARY) AS 연봉총액
  FROM DEPARTMENT_T D INNER JOIN EMPLOYEE_T E
    ON D.DEPT_NO = E.DEPART
 GROUP BY DEPT_NO, DEPT_NAME;

-- 미리 크기를 줄이고 JOIN 한다.
SELECT D.DEPT_NO
     , D.DEPT_NAME
     , E.TOTAL_SALARY
  FROM DEPARTMENT_T D INNER JOIN(SELECT DEPART, SUM(SALARY) AS TOTAL_SALARY
                                   FROM EMPLOYEE_T
                                  GROUP BY DEPART) E
    ON D.DEPT_NO = E.DEPART;
    
-- 4. WITH 절을 부서별 부서번호, 부서명, 연봉총액을 조회하시오.
WITH GROUP_T
AS (SELECT DEPART, SUM(SALARY) AS TOTAL_SALARY
      FROM EMPLOYEE_T
     GROUP BY DEPART)

SELECT D.DEPT_NO
     , D.DEPT_NAME
     , G.TOTAL_SALARY
  FROM DEPARTMENT_T D INNER JOIN GROUP_T G
    ON D.DEPT_NO = G.DEPART;