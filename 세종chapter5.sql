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


*chapter5.sql

* SQL
SELECT 사원.사원번호, 
       급여.평균연봉, 
         급여.최고연봉, 
         급여.최저연봉
 FROM 사원,
       ( SELECT 사원번호,
            ROUND(AVG(연봉),0) 평균연봉,
                  ROUND(MAX(연봉),0) 최고연봉,
                  ROUND(MIN(연봉),0) 최저연봉
             FROM 급여
            GROUP BY 사원번호
       ) 급여
WHERE 사원.사원번호 = 급여.사원번호
AND 사원.사원번호 BETWEEN 10001 AND 10100;
	* 결과 100 rows in set (sec)


SELECT count(1) from 사원;
	* 결과  300,024  row in set (18.43 sec)

SELECT count(1) from 사원 where 사원번호 BETWEEN 10001 AND 10100;
	* 결과   100 1 row in set (0.00 sec)


* SQL
SELECT 사원.사원번호,
       ( SELECT ROUND(AVG(연봉),0)
           FROM 급여 as 급여1
          WHERE 사원번호 = 사원.사원번호
       ) AS 평균연봉,
       ( SELECT ROUND(MAX(연봉),0)
           FROM 급여 as 급여2
          WHERE 사원번호 = 사원.사원번호
       ) AS 최고연봉,
       ( SELECT ROUND(MIN(연봉),0)
           FROM 급여 as 급여3
          WHERE 사원번호 = 사원.사원번호
       ) AS 최저연봉
  FROM 사원
 WHERE 사원.사원번호 BETWEEN 10001 AND 10100;
	* 결과 100 rows in set (0.00 sec)


* SQL
SELECT 사원.사원번호, 사원.이름, 사원.성, 사원.입사일자
  FROM 사원,
       급여       
 WHERE 사원.사원번호 = 급여.사원번호
   AND 사원.사원번호 BETWEEN 10001 AND 50000
 GROUP BY 사원.사원번호
 ORDER BY SUM(급여.연봉) DESC
 LIMIT 150,10;
	* 결과 10 rows in set (0.41 sec)

* SQL
SELECT 사원.사원번호, 사원.이름, 사원.성, 사원.입사일자
  FROM (SELECT 사원번호
          FROM 급여
           WHERE 사원번호 BETWEEN 10001 AND 50000
           GROUP BY 사원번호
           ORDER BY SUM(급여.연봉) DESC
           LIMIT 150,10) 급여,
        사원
 WHERE 사원.사원번호 = 급여.사원번호;
	* 결과 10 rows in set ( sec)


* SQL
SELECT COUNT(사원번호) AS 카운트
  FROM (
         SELECT 사원.사원번호, 부서관리자.부서번호
           FROM ( SELECT *
                   FROM 사원
                  WHERE 성별= 'M'
                    AND 사원번호 > 300000
                ) 사원
           LEFT JOIN 부서관리자
                 ON 사원.사원번호 = 부서관리자.사원번호
       ) 서브쿼리;
	* 결과  60,108 row in set ( sec)


* SQL
SELECT COUNT(사원번호) as 카운트   FROM 사원
 WHERE 성별 = 'M'
   AND 사원번호 > 300000;
	* 결과  60108  row in set (0.05 sec)


* SQL
SELECT DISTINCT 매핑.부서번호
  FROM 부서관리자 관리자,
       부서사원_매핑 매핑
 WHERE 관리자.부서번호 = 매핑.부서번호
 ORDER BY 매핑.부서번호;
	* 결과 9 rows in set ( sec)


* SQL
SELECT 매핑.부서번호
  FROM ( SELECT DISTINCT 부서번호 
           FROM 부서사원_매핑 매핑
       ) 매핑
 WHERE EXISTS (SELECT 1 
                 FROM 부서관리자 관리자
                WHERE 부서번호 = 매핑.부서번호)
 ORDER BY 매핑.부서번호;
	* 결과 9 rows in set (0.00 sec)

* SQL
SELECT *
  FROM 사원
 WHERE 이름 = 'Georgi'
   AND 성 = 'Wielonsky';
	* 결과1 row in set ( sec)


* SQL
SELECT COUNT(DISTINCT(이름)) 이름_개수, COUNT(DISTINCT(성  )) 성_개수, COUNT(1) 전체
FROM 사원;
	* 결과 row in set (0.41 sec)

* SQL
ALTER TABLE 사원  ADD INDEX I_사원_성_이름 (성,이름);
show index from 사원;

* SQL
SELECT * FROM 사원
WHERE 이름 = 'Georgi'
AND 성 = 'Wielonsky';
	* 결과  row in set (0.00 sec)


* SQL
alter table 사원 drop index I_사원_성_이름;

* SQL
SELECT *   FROM 사원
 WHERE 이름 = 'Matt'
    OR 입사일자 = '1987-03-31';
	* 결과 343 rows in set (  sec)

* SQL
select count(1) from 사원;
	* 결과   300,024 row in set ( sec)


* SQL
select count(1) from 사원 where 이름='Matt';
	* 결과   233  row in set (0.16 sec)

* SQL
select count(1) from 사원 where 입사일자='1987-03-31';
	* 결과   111 row in set (0.00 sec)

* SQL
show index from 사원;

* SQL
ALTER TABLE 사원  ADD INDEX I_이름(이름);

* SQL
SELECT *   FROM 사원
 WHERE 이름 = 'Matt'
    OR 입사일자 = '1987-03-31';
	* 결과 343 rows in set (0.00 sec)

* SQL
ALTER TABLE 사원 DROP INDEX I_이름;

* SQL
select @@autocommit;
	* 결과 row in set (0.00 sec)


* SQL
set autocommit=0;

* SQL
select @@autocommit;


* SQL
UPDATE 사원출입기록  SET 출입문 = 'X'
WHERE 출입문 = 'B';
	* 결과	Query OK, 300000 rows affected (34.13 sec)

* SQL
rollback;


* SQL
show index from 사원출입기록;

* SQL
ALTER TABLE 사원출입기록  DROP INDEX I_출입문;

* SQL
show index from 사원출입기록;

* SQL
SELECT @@autocommit;


* SQL
UPDATE 사원출입기록 SET 출입문 = 'X'
WHERE 출입문 = 'B';
	* 결과 Query OK, 300000 rows affected (3.82 sec)

* SQL
rollback;


* SQL
ALTER TABLE 사원출입기록  ADD INDEX I_출입문(출입문);


* SQL
set autocommit=1;

* SQL
select @@autocommit;


* SQL
SELECT 사원번호, 이름, 성   FROM 사원
 WHERE 성별 = 'M'
   AND 성 = 'Baba';
	* 결과 135 rows in set ( sec)

* SQL
SELECT COUNT(DISTINCT 성) 성_개수, COUNT(DISTINCT 성별) 성별_개수  
FROM 사원 ;
	* 결과
	| 성_개수 | 성별_개수 |
	|    1637 |         2 |

* SQL
show index from 사원;

* SQL
ALTER TABLE 사원 DROP INDEX I_성별_성,
ADD INDEX I_성_성별(성, 성별);


* SQL
SELECT 사원번호, 이름, 성 FROM 사원
WHERE 성별 = 'M'
AND 성 = 'Baba';
	* 결과 135 rows in set ( sec)

* SQL
ALTER TABLE 사원 DROP INDEX I_성_성별,
ADD INDEX I_성별_성(성별, 성);


* SQL
SELECT 부서명, 비고
  FROM 부서
 WHERE 비고 = 'active'
   AND ASCII(SUBSTR(비고,1,1)) = 97
   AND ASCII(SUBSTR(비고,2,1)) = 99;
	* 결과 4 rows in set (0.00 sec)


* SQL
SELECT 부서명, 비고  FROM 부서
WHERE 비고 = 'active';
	* 결과 7 rows in set ( sec)


* SQL
SELECT 비고, 
       SUBSTR(비고,1,1) 첫번째, 
       ASCII(SUBSTR(비고,1,1)) 첫번째_아스키, 
	   SUBSTR(비고,2,1) 두번째,
       ASCII(SUBSTR(비고,2,1)) 두번째_아스키
FROM 부서
WHERE 비고 = 'active';
	* 결과 7 rows in set ( sec)


* SQL
SELECT COLUMN_NAME, collation_name
FROM information_schema.COLUMNS
WHERE table_schema = 'tuning'
AND TABLE_NAME = '부서';
	* 결과 3 rows in set ( sec)


* SQL  
ALTER TABLE 부서
CHANGE COLUMN 비고 비고 VARCHAR(40) NULL DEFAULT NULL COLLATE 'UTF8MB4_bin';


* SQL
SELECT COLUMN_NAME, collation_name
FROM information_schema.COLUMNS
WHERE table_schema = 'tuning'
AND TABLE_NAME = '부서';
	

* SQL
SELECT 부서명, 비고
FROM 부서
WHERE 비고 = 'active';
	* 결과 4 rows in set ( sec)


* SQL
ALTER TABLE 부서
CHANGE COLUMN 비고 비고 VARCHAR(40) NULL DEFAULT NULL COLLATE 'utf8_general_ci';


* SQL
SELECT 이름, 성, 성별, 생년월일
FROM 사원
WHERE LOWER(이름) = LOWER('MARY')
AND 입사일자 >= STR_TO_DATE('1990-01-01', '%Y-%m-%d');
	*결과  96 rows in set (0.18 sec)


* SQL
SELECT COUNT(1)  FROM 사원;
	* 결과   300,024  row in set ( sec)


* SQL
SELECT COUNT(1)
FROM 사원
WHERE 입사일자 >= STR_TO_DATE('1990-01-01', '%Y-%m-%d');
	* 결과 135,227  row in set (0.04 sec)


* SQL
SELECT COUNT(1)  FROM 사원
WHERE LOWER(이름) = LOWER('MARY');
	* 결과    224  row in set ( sec)

* SQL
show index from 사원;


* SQL
SELECT * FROM 사원
WHERE 이름 = 'MARY';
	* 결과 Empty set (0.32 sec)


* SQL
SELECT COLUMN_NAME, collation_name
FROM information_schema.columns
WHERE TABLE_NAME='사원'
AND table_schema='tuning';
	* 결과 6 rows in set ( sec)


* SQL
ALTER TABLE 사원 ADD COLUMN 소문자_이름 VARCHAR(14) NOT NULL AFTER 이름;


* SQL
UPDATE 사원  SET 소문자_이름 = LOWER(이름);
	* 결과 300024 rows affected ( sec)


* SQL
ALTER TABLE 사원 ADD INDEX I_소문자이름(소문자_이름);
	* 결과  0 rows affected ( sec)

* SQL
desc 사원;

* SQL
SELECT 이름, 소문자_이름  FROM 사원
LIMIT 10;
	* 결과 10 rows in set ( sec)


* SQL
SELECT 이름, 성, 성별, 생년월일 FROM 사원
WHERE 소문자_이름= 'MARY'
AND 입사일자 >= '1990-01-01';
	* 결과 96 rows in set ( sec)


* SQL
ALTER TABLE 사원 DROP COLUMN 소문자_이름;


* SQL
mysql> desc 사원;

* SQL
SELECT COUNT(1)   FROM 급여
  WHERE 시작일자 BETWEEN STR_TO_DATE('2000-01-01', '%Y-%m-%d')
                     AND STR_TO_DATE('2000-12-31', '%Y-%m-%d');

	* 결과   255,785 row in set (1.23 sec)


* SQL
SELECT COUNT(1) FROM 급여;
	* 결과  284,4047

* SQL
SELECT YEAR(시작일자), COUNT(1)  FROM 급여
GROUP BY YEAR(시작일자);
	* 결과 18 rows in set ( sec)

====================================================================================
* SQL
ALTER TABLE 급여
partition by range COLUMNS (시작일자)
(
    partition p85 values less than ('1985-12-31'),
    partition p86 values less than ('1986-12-31'),
    partition p87 values less than ('1987-12-31'),
    partition p88 values less than ('1988-12-31'),
    partition p89 values less than ('1989-12-31'),
    partition p90 values less than ('1990-12-31'),
    partition p91 values less than ('1991-12-31'),
    partition p92 values less than ('1992-12-31'),
    partition p93 values less than ('1993-12-31'),
    partition p94 values less than ('1994-12-31'),
    partition p95 values less than ('1995-12-31'),
    partition p96 values less than ('1996-12-31'),
    partition p97 values less than ('1997-12-31'),
    partition p98 values less than ('1998-12-31'),
    partition p99 values less than ('1999-12-31'),
    partition p00 values less than ('2000-12-31'),
    partition p01 values less than ('2001-12-31'),
    partition p02 values less than ('2002-12-31'),
    partition p03 values less than (MAXVALUE)
);
	* 결과  2,844,047 rows affected (  sec)

* SQL
SELECT COUNT(1) FROM 급여
WHERE 시작일자 BETWEEN STR_TO_DATE('2000-01-01', '%Y-%m-%d')
AND STR_TO_DATE('2000-12-31', '%Y-%m-%d');
	* 결과   255,785 row in set ( sec)


* SQL
ALTER TABLE 급여 REMOVE PARTITIONING;
	* 결과  2,844,047 rows affected ( sec)
	* Records: 2844047  Duplicates: 0  Warnings: 0