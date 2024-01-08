-- 예제 합본

/*조인(HR)*/

-- 1. LOCATION_ID가 1700인 부서에 근무하는 사원들의 EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_NAME을 조회하시오.


-- 2. DEPARTMENT_NAME이 'Executive'인 부서에 근무하는 사원들의 EMPLOYEE_ID, FIRST_NAME을 조회하시오.



-- 3. 모든 사원들의 EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_NAME, STREET_ADDRESS, CITY를 조회하시오.




-- 4. 사원이 근무 중인 부서를 대상으로 DEPARTMENT_NAME과 근무 중인 사원 수와 평균 연봉을 조회하시오.



-- 5. JOB_HISTORY 테이블에 존재하는 사원들을 대상으로 사원번호, 현재 JOB_ID, 예전 JOB_ID를 조회하시오.



-- 6. 모든 사원들의 EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_NAME을 조회하시오. 부서가 없는 사원의 부서명은 'None'으로 조회되도록 처리하시오.



-- 7. 모든 부서의 DEPARTMENT_NAME과 근무 중인 사원 수를 조회하시오. 근무하는 사원이 없으면 0으로 조회하시오.



-- 8. 모든 부서의 DEPARTMENT_ID, DEPARTMENT_NAME, STATE_PROVINCE, COUNTRY_NAME, REGION_NAME을 조회하시오.


/*서브쿼리*/

-- 1. 사원번호가 110인 사원과 동일한 직책(JOB_ID)을 가진 사원을 조회하시오.


-- 2. 부서명이 'IT'인 부서에 근무하는 사원을 조회하시오.


-- 3. 가장 높은 연봉를 받는 사원을 조회하시오.


-- 4. 평균 연봉 미만인 사원을 조회하시오.


-- 5. 평균 근속 개월 수 이상인 사원을 조회하시오.

-- 6. 'Seattle'에서 근무하는 사원을 조회하시오.


-- 7. 가장 먼저 입사한 사원을 조회하시오.


-- 8. 부서번호가 50인 부서와 같은 국가(COUNTRY_ID)에 있는 부서 정보를 조회하시오.


-- 9. 부서명이 'Marketing'인 부서에서 가장 높은 연봉를 받는 사람보다 더 높은 연봉를 받는 사원을 조회하시오.


-- 10. 11 ~ 20번째로 입사한 사원을 조회하시오.


/* DDL */

-- 1. 다음 칼럼 정보를 이용하여 MEMBER_T 테이블을 생성하시오.
--    1) 회원번호: MEM_NO, NUMBER, 필수
--    2) 회원아이디: MEM_ID, VARCHAR2(30 BYTE), 필수, 중복 불가
--    3) 회원패스워드: MEM_PW, VARCHAR2(30 BYTE), 필수
--    4) 회원포인트: MEM_POINT, NUMBER
--    5) 회원구분: MEM_GUBUN, VARCHAR2(7 BYTE), 'REGULAR', 'SOCIAL' 값 중 하나를 가짐
--    6) 회원이메일: MEM_EMAIL, VARCHAR2(100 BYTE), 중복 불가

       

-- 2. MEMBER_T 테이블에 다음 새로운 칼럼을 추가하시오.
--    1) 회원주소: MEM_ADDRESS VARCHAR2(200 BYTE) NULL
--    2) 회원가입일: JOINED_AT DATE NULL


-- 3. 추가된 회원주소 칼럼을 다시 삭제하시오.


-- 4. 회원구분 칼럼의 타입을 VARCHAR2(20 BYTE)으로 수정하시오.

-- 5. 회원패스워드 칼럼의 이름을 MEM_PWD로 수정하시오.


-- 6. 회원번호 칼럼에 기본키(PK_MEMBER)를 설정하시오.


-- 7. 다음 칼럼 정보를 이용하여 BOARD_T 테이블을 생성하시오.
--    1) 글번호: BOARD_NO, NUMBER, 필수
--    2) 글제목: TITLE, VARCHAR2(4000 BYTE), 필수
--    3) 글내용: CONTENTS, VARCHAR2(4000 BYTE), 필수
--    4) 조회수: HIT, VARCHAR2(1 BYTE)
--    5) 작성자: MEM_ID, VARCHAR2(30 BYTE), 필수
--    6) 작성일자: CREATED_AT, VARCHAR2(10 BYTE)


-- 8. 조회수 칼럼의 타입을 NUMBER로 수정하시오.


-- 9. 글내용 칼럼의 필수 제약조건을 제거하시오.

-- 10. 글번호 칼럼에 기본키(PK_BOARD)를 설정하시오.


-- 11. 작성자 칼럼에 MEMBER_T 테이블의 회원아이디를 참조하는 FK_BOARD_MEMBER 외래키를 설정하시오.
-- 게시글을 작성한 회원 정보가 삭제되면 해당 회원이 작성한 게시글도 모두 함께 지워지도록 처리하시오.



-- 12. MEMBER_T 테이블과 BOARD_T 테이블을 모두 삭제하시오.


/* DQL */
-- 1. EMPLOYEES 테이블에서 JOB_ID를 조회하시오. 동일한 JOB_ID는 한 번만 출력하고 알파벳 순으로 정렬하여 조회하시오.


-- 2. EMPLOYEES 테이블에서 DEPARTMENT_ID가 50인 사원 중에서 SALARY가 5000 이상인 사원을 조회하시오.


-- 3. EMPLOYEES 테이블에서 FIRST_NAME이 'Steven', LAST_NAME이 'King'인 사원을 조회하시오.


-- 4. EMPLOYEES 테이블에서 EMPLOYEE_ID가 151 ~ 200인 사원을 조회하시오.



-- 5. EMPLOYEES 테이블에서 JOB_ID가 'IT_PROG', 'ST_MAN'인 사원을 조회하시오.


-- 6. EMPLOYEES 테이블에서 HIRE_DATE가 2005년도인 사원을 조회하시오.


-- 7. EMPLOYEES 테이블에서 MANAGER_ID가 없는 사원을 조회하시오.



-- 8. EMPLOYEES 테이블에서 COMMISSION_PCT를 받는 사원들의 실제 커미션을 조회하시오. 커미션은 COMMISSION_PCT * SALARY로 계산하시오.



-- 9. EMPLOYEES 테이블에서 FIRST_NAME이 'J'로 시작하는 사원을 조회하시오.



-- 10. EMPLOYEES 테이블에서 JOB_ID가 'MAN'으로 끝나는 사원들의 MANAGER_ID를 중복을 제거하여 조회하시오.


-- 11. EMPLOYEES 테이블에서 전체 사원을 DEPARTMENT_ID의 오름차순으로 조회하되, 동일한 DEPARTMENT_ID 내에서는 HIRE_DATE의 오름차순으로 조회하시오.

 

-- 12. EMPLOYEES 테이블에서 DEPARTMENT_ID가 80인 사원들을 높은 SALARY순으로 조회하시오. SALARY는 9,000처럼 천 단위 구분기호를 표기해서 조회하시오.


-- 13. EMPLOYEES 테이블에서 전체 사원의 근무 개월 수를 정수로 조회하시오. 1개월 1일을 근무했다면 2개월을 근무한 것으로 처리해서 조회하시오.


-- 14. EMPLOYEES 테이블에서 PHONE_NUMBER에 따른 지역(REGION)을 조회하시오.
-- PHONE_NUMBER가 011로 시작하면 'MOBILE', 515로 시작하면 'EAST', 590으로 시작하면 'WEST', 603으로 시작하면 'SOUTH', 650으로 시작하면 'NORTH'로 조회하시오.


-- 15. EMPLOYEES 테이블에서 근무 개월 수가 240개월 이상이면 '퇴직금정산대상', 아니면 빈 문자열('')을 조회하시오.


-- 16. EMPLOYEES 테이블에서 SALARY 평균이 10000 이상인 부서의 DEPARTMENT_ID와 SALARY 평균을 조회하시오. 평균은 정수로 내림처리하시오.


-- 17. EMPLOYEES 테이블에서 DEPARTMENT_ID와 JOB_ID가 모두 같은 사원들을 그룹화하여 각 그룹의 사원수를 조회하시오. DEPARTMENT_ID가 NULL인 사원은 제외하시오.


-- 18. EMPLOYEES 테이블에서 전체 사원들의 부서내 연봉 순위를 조회하시오. 


-- 19. DEPARTMENTS 테이블에서 LOCATION_ID로 그룹화하여 각 그룹의 부서수를 조회하시오. MANAGER_ID가 없는 지역은 제외하시오.


-- 20. DEPARTMENTS 테이블에서 DEPARTMENT_NAME의 첫 2글자로 그룹화하여 각 그룹의 부서수를 조회하시오. 'IT'와 'Co'인 부서만 조회하시오.

/* DML */

-- 시퀀스 삭제(시퀀스들은 관계를 맺는게 없으므로 그냥 지우면 됨)


-- 부서 테이블의 부서번호를 생성하는 시퀀스 만들기 (디폴트로 생성)


-- 사원테이블의 사원번호를 생성하는 시퀀스 만들기


-- 테이블 삭제



-- 부서 테이블 생성



-- 직원 테이블 생성


-- 부서 테이블에 행 삽입하기. 테이블의 모든 칼럼을 작성하는 경우 칼럼 리스트 생략 가능. 아니라면 칼럼리스트 적어야 함. 사원 테이블 행 삽입시 생략함. 밑에 볼것.


-- 사원 테이블에 행 삽입하기. 날짜는 함수로 넣는게 좋음. 날짜는 문자로 가능. 오라클의 디폴트는 연/월/일(각 두자리씩)이지만 연-월-일(각 두자리씩) 작성가능.


-- 커밋


-- 1. DEPARTMENT_T에서 부서번호(DEPT_NO)가 3인 부서의 지역(DEPT_LOCATION)을 '인천'으로 수정하시오
        --WHERE절의 등호(=)는 동등비교 연산자

-- 2. EMPLOYEE_T에서 부서번호(DEPART)가 2인 부서의 사원들의 기본급(SALARY)을 10% 인상하시오.


-- 롤백



-- 1. DEPARTMENT_T에서 부서번호(DEPT_NO)가 3인 부서를 삭제하시오. (부서번호가 3인 사원은 없다. 참조 무결성에 영향을 미치지 않는다.)

-- 2. EMPLOYEE_T에서 부서번호(DEPART)가 1과 4인 부서를 삭제하시오.


-- 3. DEPARTMENT_T에서 부서번호(DEPT_NO)가 2인 부서를 삭제하시오. (부서번호가 2인 사원이 있다. 부서가 없어지면 사원 정보가 참조 무결성에 위배된다. 참조 무결성 위배에 대비해서 ON DELETE SET NULL 옵션을 주었으므로 사원 테이블의 부서번호가 NULL로 함께 수정된다.)

 
-- 롤백









