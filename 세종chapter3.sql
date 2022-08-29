
작업폴더 작성
C:~~> cd c:\db_data
C:\db_data>
C:\db_data> C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe  -uroot -p --port 3355 < data_setting.sql
C:\db_data> C:\~~\bin\mysql.exe   -uroot -p --port 3355 < data_setting.sql


C:~~> cd C:\Program Files\MariaDB 10.5\bin
C:\Program Files\MariaDB 10.5\bin> mysql -uroot -p --port 3366

mysql> system cls ;
mysql> select  sysdate()   ;
mysql> select  now() ;

*첫번째 chapter3.sql  


select count(1) from 사원;
  *총데이터  300,024 row in set (0.02 sec)


SELECT *
FROM 사원
WHERE 사원번호 BETWEEN 100001 AND 200000;
	*총데이터 10025 rows in set (010025 rows in set (0.01 sec)


SELECT 사원.사원번호, 사원.이름, 사원.성, 급여.연봉,
       (SELECT MAX(부서번호) 
        FROM 부서사원_매핑 as 매핑 WHERE 매핑.사원번호 = 사원.사원번호) 카운트
FROM 사원, 급여
WHERE 사원.사원번호 = 10001
AND 사원.사원번호 = 급여.사원번호;
	*총데이터 17 rows in set (0.00 sec)


SELECT * FROM 사원 WHERE 사원번호 = 100000;
	*총데이터 1 rows in set (0.00 sec)



SELECT 사원.사원번호, 사원.이름, 사원.성, 급여.연봉
FROM 사원,
     (SELECT 사원번호, 연봉
      FROM 급여
      WHERE 연봉 > 80000) AS 급여
WHERE 사원.사원번호 = 급여.사원번호
AND 사원.사원번호 BETWEEN 10001 AND 10010;
	*총데이터 31 rows in set (0.00 sec)


SELECT 사원.사원번호, 사원.이름, 사원.성,
       (SELECT MAX(부서번호) 
        FROM 부서사원_매핑 as 매핑 WHERE 매핑.사원번호 = 사원.사원번호) 카운트
FROM 사원
WHERE 사원.사원번호 = 100001;
	*총데이터 1 rows in set (0.00 sec)


SELECT 사원1.사원번호, 사원1.이름, 사원1.성
FROM 사원 as 사원1
WHERE 사원1.사원번호 = 100001
UNION ALL
SELECT 사원2.사원번호, 사원2.이름, 사원2.성
FROM 사원 as 사원2
WHERE 사원2.사원번호 = 100002;
	*총데이터 2 rows in set (0.00 sec)	


SELECT (SELECT COUNT(*)
        FROM 부서사원_매핑 as 매핑
        ) as 카운트,
       (SELECT MAX(연봉)
        FROM 급여
        ) as 급여;
    *총데이터 1 rows in set (0.00 sec)


SELECT 사원.사원번호, 급여.연봉
FROM 사원,
       (SELECT 사원번호, MAX(연봉) as 연봉
        FROM 급여
        WHERE 사원번호 BETWEEN 10001 AND 20000 ) as 급여
WHERE 사원.사원번호 = 급여.사원번호;
	*총데이터 1 rows in set (0.00 sec)



SELECT 'M' as 성별, MAX(입사일자) as 입사일자
FROM 사원 as 사원1
WHERE 성별 = 'M'
UNION ALL
SELECT 'F' as 성별, MIN(입사일자) as 입사일자
FROM 사원 as 사원2
WHERE 성별 = 'F';
	*총데이터 2 rows in set (0.00 sec)


SELECT 사원_통합.* 
FROM ( 
      SELECT MAX(입사일자) as 입사일자
      FROM 사원 as 사원1
      WHERE 성별 = 'M' 
      
	  UNION 

      SELECT MIN(입사일자) as 입사일자
      FROM 사원 as 사원2
      WHERE 성별 = 'M' 
    ) as 사원_통합; 
	*총데이터 2 rows in set (0.00 sec)


 SELECT 관리자.부서번호,
       ( SELECT 사원1.이름
         FROM 사원 AS 사원1
         WHERE 성별= 'F'
         AND 사원1.사원번호 = 관리자.사원번호

         UNION ALL
 
         SELECT 사원2.이름
         FROM 사원 AS 사원2
         WHERE 성별= 'M'
         AND 사원2.사원번호 = 관리자.사원번호
       ) AS 이름
 FROM 부서관리자 AS 관리자;
	*총데이터 24 rows in set (0.00 sec)



SELECT *
FROM 사원
WHERE 사원번호 = (SELECT ROUND(RAND()*1000000));
	*Empty set (0.19 sec) 출력값은 없거나


SELECT *
FROM 사원
WHERE 사원번호 IN (SELECT 사원번호 FROM 급여 WHERE 시작일자>'2020-01-01' );
	 *Empty set (0.19 sec) 출력값은 없거나

SELECT 사원.사원번호, 급여.연봉
FROM 사원,
      (SELECT 사원번호, MAX(연봉) as 연봉
       FROM 급여
       WHERE 사원번호 BETWEEN 10001 AND 20000 ) as 급여
WHERE 사원.사원번호 = 급여.사원번호;
	*총데이터 1 row in set (0.05 sec)


SELECT * FROM 사원
WHERE 사원번호 = 10001;
	*myisam_테이블 생년월일birth_date
	*사원  생연월일 


SELECT 매핑.사원번호, 부서.부서번호, 부서.부서명
FROM 부서사원_매핑 as 매핑,   부서
WHERE 매핑.부서번호 = 부서.부서번호
AND 매핑.사원번호 BETWEEN 100001 AND 100010;
	*총데이터 12 row in set (0.05 sec)



SELECT 사원.사원번호, 직급.직급명
FROM 사원, 직급
WHERE 사원.사원번호 = 직급.사원번호
AND 사원.사원번호 BETWEEN 10001 AND 10100;
	*총데이터 151 row in set (0.05 sec)


SELECT *
FROM 사원
WHERE 입사일자 = '1985-11-21';
	*총데이터 119 row in set (0.05 sec)


SELECT *
FROM 사원출입기록
WHERE 출입문 IS NULL
OR 출입문 = 'A';
	*총데이터 250,000 row in set (0.05 sec)


SELECT * FROM 사원
WHERE 사원번호 BETWEEN 10001 AND 100000;
	*총데이터 90,000 row in set (0.05 sec)


SELECT * FROM 사원 
WHERE 사원번호 BETWEEN 10001 AND 100000 
AND 입사일자 = '1985-11-21'; 
	*총데이터 32 row in set (0.05 sec)



SELECT * FROM 사원;
SELECT count(*) FROM 사원;
	*총데이터  300,024 row in set (0.05 sec)


SELECT * FROM 사원;
desc 직급;
show index from 직급;


SELECT 사원번호 FROM 직급
WHERE 직급명 = 'Manager';
	*총데이터 24 row in set (0.05 sec)


SELECT 사원.사원번호, 직급.직급명
FROM 사원, 직급
WHERE 사원.사원번호 = 직급.사원번호
AND 사원.사원번호 BETWEEN 10001 AND 10100;
	*총데이터 151 row in set (0.05 sec)  윗쪽에도 있음 


SELECT * FROM 사원
WHERE 사원번호 BETWEEN 100001 AND 200000;
	*총데이터 10,025 row in set (0.05 sec)  윗쪽에도 있음 



show variables like 'profiling%';
set profiling = 'ON';

SELECT 사원번호  FROM 사원  WHERE  사원번호 = 100000;
show profiles;
show profile for query 1; 
	* 17 rows in set, 1 warning (0.00 sec)    

show profile all for query 1;
	* 17 rows in set, 1 warning (0.00 sec)    

show profile cpu for query 1;
	* 17 rows in set, 1 warning (0.00 sec)  

show profile block io for query 1;
	* 17 rows in set, 1 warning (0.00 sec)  

