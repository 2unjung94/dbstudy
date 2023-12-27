-- single-line comment
/*
    multi-line comment
*/
/*
    sys 계정
    1. 오라클 관리 계정이다.
    2. 일반 사용자를 만드는 역할로 국한해서 사용한다.
    3. SYS 계정으로 일반 쿼리 작업을 수행하지 않도록 주의한다.
*/
/*
    새로운 사용자 생성 방법
    **오라클의 쿼리문은 대문자로 작성
    1. 사용자를 만드는 쿼리문을 실행한다.
        CREATE USER 계정이름 IDENTIFIED BY 비밀번호;
    2. 사용자에게 권한을 부여한다.
        1) 접속 권한
            GRANT CONNECT TO 계정이름;
        2) 접속/사용 권한 부여
            GRANT CONNECT, RESOURCE TO 계정이름;
        3) 관리자 권한 부여
            GRANT DBA TO 계정이름;
            (DBA: DataBase Adiministor)
    
*/
/*
    쿼리문 실행하는 방법
    1. 커서를 두고 CRTL+ENTER : 커서가 있는 쿼리문만 실행된다.
    2. 블록을 잡고 CRTL+ENTER : 블록 잡은 부분의 쿼리문만 실행된다.
    3. F5                    : 전체 스크립트가 실행된다.
*/
--CREATE USER C##GD IDENTIFIED BY 1111; /*계정이름 만들때 C##쓸이름 이렇게 작성해야함-이번 버전에서 추가된 조건*/
--GRANT DBA TO C##GD;

/*
    계정 삭제하기
    1. 데이터베이스 객체를 가진 경우 - CASCADE : 해당 객체를 먼저 지우고 계정을 지우는 옵션이 붙음
        DROP USER 계정이름 CASCADE;
    2. 데이터베이스 객체를 안 가진 경우
        DROP USER 계정이름;
*/
--DROP USER C##GD;
/*
    GD 계정을 만드는 전체 스크립트
*/
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE; -- C## 제거를 위해서
DROP USER GD CASCADE; -- 기존 GD계정이 있을때 상황이라
CREATE USER GD IDENTIFIED BY 1111;
GRANT DBA TO GD;
