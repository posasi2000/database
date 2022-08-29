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

  
*두번째 chapter4.sql

SELECT COUNT(1) FROM 급여;
	*총데이터 결과 2,844,047  row in set ( sec)

SELECT COUNT(1)  FROM 부서;
	*총데이터 결과 9  row in set (sec)
	 
SELECT COUNT(1) FROM 부서관리자;
	*총데이터 결과 24  row in set ( sec)

SELECT COUNT(1) FROM 부서사원_매핑;
	*총데이터 결과  331,603  row in set ( sec)

SELECT COUNT(1) FROM 사원;
	*총데이터 결과  300,024 row in set ( sec)

SELECT COUNT(1) FROM 사원출입기록;
	*총데이터 결과   660,000 row in set ( sec)

SELECT COUNT(1) FROM 직급;
	*총데이터 결과  443,308   row in set ( sec)

show index from 급여;
show index from 부서;
show index from 부서관리자;
show index from 부서사원_매핑;
show index from 사원;
show index from 사원출입기록;
show index from 직급;


SELECT * FROM 사원
WHERE SUBSTRING(사원번호,1,4) = 1100
AND LENGTH(사원번호) = 5;
	*총데이터 결과 10 rows in set ( sec)


SELECT COUNT(1) FROM 사원;   #총데이터 결과  300,024 row in set ( sec)

SELECT * FROM 사원
WHERE 사원번호 BETWEEN 11000 AND 11009;
	*총데이터 결과 10 rows in set (0.00 sec)


SELECT IFNULL(성별,'NO DATA') AS 성별, COUNT(1) 건수
FROM 사원
GROUP BY IFNULL(성별,'NO DATA');
	*총데이터 결과 2건 
	| M    | 179973 |
	| F    | 120051 |


desc 사원 ;
SELECT 성별, COUNT(1) 건수 FROM 사원
GROUP BY 성별;
	* 결과 2건
	| 성별 | 건수   |
	| M    | 179973 |
	| F    | 120051 |


SELECT COUNT(1) FROM 급여
WHERE 사용여부 = 1;
	* 결과  42,842

SELECT 사용여부, COUNT(1) FROM 급여
GROUP BY 사용여부;
	* 결과
	| 사용여부 | COUNT(1) |
	| 0        |  2801205 |
	| 1        |    42842 |


SELECT *  FROM 사원                                                     
WHERE CONCAT(성별,' ',성) = 'M Radwan';
	* 결과 102건  rows in set 


SELECT CONCAT(성별,' ',성) '성별_성', COUNT(1)  FROM 사원
WHERE CONCAT(성별,' ',성) = 'M Radwan'
UNION ALL
SELECT '전체 데이터', COUNT(1) FROM 사원;
	*결과
	| 성별_성     | COUNT(1) |
	| M Radwan    |      102 |
	| 전체 데이터 |   300024 |

SELECT *  FROM 사원
WHERE 성별 = 'M'
AND 성 =  'Radwan';
	* 결과 102 rows in set 

SELECT DISTINCT 사원.사원번호, 이름, 성, 부서번호  FROM 사원
JOIN 부서관리자
ON (사원.사원번호 = 부서관리자. 사원번호);
	* 결과 24 rows in set 


 
SELECT 사원.사원번호, 이름, 성, 부서번호 FROM 사원
JOIN 부서관리자
ON (사원.사원번호 = 부서관리자. 사원번호);
	* 결과 24 rows in set (0.00 sec)


SELECT 'M' AS 성별, 사원번호  FROM 사원 
 WHERE 성별 = 'M'
   AND 성 ='Baba'
  UNION
SELECT 'F', 사원번호
  FROM 사원
 WHERE 성별 = 'F'
   AND 성 = 'Baba';
	* 결과 226 rows in set 

show index from 사원;
SELECT 'M' as 성별, 사원번호
  FROM 사원 
 WHERE 성별 = 'M'
   AND 성 ='Baba'
 UNION ALL
SELECT 'F' as 성별, 사원번호
  FROM 사원
 WHERE 성별 = 'F'
   AND 성 ='Baba';	
	* 결과 226 rows in set 


SELECT 성, 성별, COUNT(1) as 카운트   FROM 사원
 GROUP BY 성, 성별;
	* 결과 3,274 rows in set ( sec)



show index from 사원;
SELECT 성, 성별, COUNT(1) as 카운트  FROM 사원
GROUP BY 성별, 성;
	* 결과 3,274 rows in set (0.04 sec)


SELECT 사원번호 FROM 사원
WHERE 입사일자 LIKE '1989%'
AND 사원번호 > 100000;
	* 결과 20,001 rows in set ( sec)

show index from 사원;
SELECT COUNT(1) FROM 사원;
	* 결과  300,024 row in set ( sec)

SELECT COUNT(1) FROM 사원 WHERE 입사일자 LIKE '1989%';
	* 결과   28,394 

SELECT COUNT(1) FROM 사원 WHERE 사원번호 > 100000;
	* 결과  210,024 

SELECT 사원번호  FROM 사원 USE INDEX(I_입사일자)
WHERE 입사일자 LIKE '1989%'
AND 사원번호 > 100000;
	* 결과 20,001 rows in set ( sec)


SELECT 사원번호  FROM 사원
WHERE 입사일자 >= '1989-01-01' AND 입사일자 < '1990-01-01'
AND 사원번호 > 100000;
	* 결과 20,001 rows in set ( sec)


SELECT * FROM 사원출입기록
WHERE 출입문 = 'B';
	* 결과 300000 rows in set ( sec)


SELECT 출입문, COUNT(1)
FROM 사원출입기록
GROUP BY 출입문;
	* 결과 4 rows in set ( sec)


SELECT *  FROM 사원출입기록 IGNORE INDEX(I_출입문)
WHERE 출입문 = 'B';
	* 결과 300,000 rows in set ( sec)


SELECT 이름, 성  FROM 사원
WHERE 입사일자 BETWEEN STR_TO_DATE('1994-01-01', '%Y-%m-%d') 
AND STR_TO_DATE('2000-12-31', '%Y-%m-%d');
	* 결과 48,875 rows in set ( sec)


select count(1) from 사원;
	* 결과   300,024

SELECT 이름, 성  FROM 사원
WHERE YEAR(입사일자) BETWEEN '1994' AND '2000';
	* 결과 48,875 rows in set ( sec)

* SQL
SELECT 매핑.사원번호, 부서.부서번호   FROM 부서사원_매핑 매핑, 부서
WHERE 매핑.부서번호 = 부서.부서번호
AND 매핑.시작일자 >= '2002-03-01';
	* 결과 1,341 rows in set (13.27 sec)

SELECT COUNT(1) FROM 부서사원_매핑;
	* 결과   331,603  row in set ( sec)


SELECT COUNT(1) FROM 부서;
	* 결과   9 row in set ( sec)


SELECT COUNT(1) FROM 부서사원_매핑 WHERE 시작일자>='2002-03-01';
	* 결과    1,341 row in set ( sec)


SELECT STRAIGHT_JOIN 매핑.사원번호, 부서.부서번호
FROM 부서사원_매핑 매핑, 부서
WHERE 매핑.부서번호 = 부서.부서번호
AND 매핑.시작일자 >= '2002-03-01' ;
	* 결과 1,341 rows in set ( sec)


SELECT 사원.사원번호, 사원.이름, 사원.성   FROM 사원
 WHERE 사원번호 > 450000
   AND ( SELECT MAX(연봉)
           FROM 급여
          WHERE 사원번호 = 사원.사원번호
       ) > 100000;
	* 결과 3,155 rows in set ( sec)


SELECT 사원.사원번호, 사원.이름, 사원.성
  FROM 사원
 WHERE 사원번호 > 450000
   AND ( SELECT MAX(연봉)
           FROM 급여
          WHERE 사원번호 = 사원.사원번호
       ) > 100000;
	* 결과 2 rows in set, 2 warnings ( sec)


SELECT COUNT(1) FROM 사원;
	* 결과   300,024 rows in set ( sec)

SELECT COUNT(1) FROM 급여;	
	* 결과  284,4047 rows in set ( sec)

SELECT COUNT(1)
FROM 사원
WHERE 사원번호 > 450000;
	* 결과   49,999  row in set (0.03 sec)

show index from 사원;
show index from 급여;

SELECT 사원.사원번호,
       사원.이름,
       사원.성
  FROM 사원,
       급여
 WHERE 사원.사원번호 > 450000
   AND 사원.사원번호 = 급여.사원번호
  GROUP BY 사원.사원번호
 HAVING MAX(급여.연봉) > 100000;	
	* 결과 3155 rows in set ( sec)


SELECT COUNT(DISTINCT 사원.사원번호) as 데이터건수
  FROM 사원,
       ( SELECT 사원번호
           FROM 사원출입기록 기록
          WHERE 출입문 = 'A'
       ) 기록
 WHERE 사원.사원번호 = 기록.사원번호;
	* 결과   150,000   rows in set ( sec)


DESC 사원;

SELECT COUNT(1) as 데이터건수  FROM 사원
 WHERE EXISTS (SELECT 1
                 FROM 사원출입기록 기록
                WHERE 출입문 = 'A'
                AND 기록.사원번호 = 사원.사원번호);
	* 결과   150,000 row in set (0.45 sec)

