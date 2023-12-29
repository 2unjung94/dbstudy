-- 1. 절대값 구하기
SELECT ABS(-5)
  FROM DUAL;

-- 2. 제곱근(루트) 구하기
SELECT SQRT(25) -- SQUARE ROOT
  FROM DUAL;
  
-- 3. 제곱 구하기
SELECT POWER(2, 3) -- 2의 3제곱
  FROM DUAL;

-- 4. 나머지 구하기
SELECT MOD(5, 2) -- 모듈러, 5 나누기 2
  FROM DUAL;

-- 5. 정수 올림 (큰 정수) - 원하는 자리수로 올림 하려면 함수를 직접 작성해야 함 (맨아래 참조)
SELECT CEIL(1.1)
  FROM DUAL;
  
-- 6. 정수 내림 (작은 정수) - 원하는 자리수로 내림 하려면 함수를 직접 작성해야 함 (맨아래 참조)
SELECT FLOOR(1.9)
  FROM DUAL;
  
SELECT FLOOR(-1.9)
  FROM DUAL;
  
-- 7. 원하는 자리수로 반올림
SELECT ROUND(123.456)       -- 123     (정수로 반올림)
     , ROUND(123.456, 1)    -- 123.5   (소수점 한자리에서 반올림)
     , ROUND(123.456, 2)    -- 123.46  (소수점 2자리에서 반올림)
     , ROUND(123.456, -1)   -- 120     (1의 자리에서 반올림)
     , ROUND(123.456, -2)   -- 100     (10의 자리에서 반올림)
  FROM DUAL;
  
-- 8. 원하는 자리수로 절사 ( EX. 핸드폰 요금 )
SELECT TRUNC(123.456)       -- 123    (정수로 절사)
     , TRUNC(123.456, 2)    -- 123.45 (소수점 두자리로 절사)
     , TRUNC(123.456, 1)    -- 123.4  (소수점 한자리로 절사) 
     , TRUNC(123.456, -1)   -- 120    (1의 자리에서 절사)
     , TRUNC(123.456, -2)   -- 100    (10의 자리에서 절사)
  FROM DUAL;
  
SELECT TRUNC(-1.9)
  FROM DUAL;

/*  
    원하는 자리로 올림/내림
    
    CEIL(값 * POWER(10, 자리수)) / POWER(10, 자리수)
    FLOOR(값 * POWER(10, 자리수)) / POWER(10, 자리수)
    
    예시)
    CEIL(123.456 * POWER(10, 1))  / POWER(10, 1)   : 123.5 
    CEIL(123.456 * POWER(10, 2))  / POWER(10, 2)   : 123.46
    CEIL(123.456 * POWER(10, -1)) / POWER(10, -1)  : 130
*/
