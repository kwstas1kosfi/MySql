/*
-------------------------------------------------------------------------------------------------------------------
|ΑΜΚΑ   |ΟΝΟΜΑ   |ΕΠΙΘΕΤΟ      |ΑΦΜ |ΑΦΜ   |ΟΝΟΜΑ      |ΕΠΙΘΕΤΑ      |BARCODE |ΑΞΙΑ |ΗΜΕΡΟΜΗΝΙΑ |ΟΝΟΜΑΣΙΑ |BARCODE|
|Ασθ.   |Ασθ.    |Ασθ.         |Ασθ. |Doc. |Doc.       |Doc          |Presc.  |Med  |Presc.     |Med.     |Med.	  |
|101010 |Νίκος   |Νικολάου     |1234 |9990 |Παναγιώτης |Δημητρίου    |11111   |10   |13/11/2016 |Depon    |901234 |
|101010 |Νίκος   |Νικολάου     |1234 |9990 |Παναγιώτης |Δημητρίου    |11111   |8    |13/11/2016 |Aspirin  |905678 |
|101011 |Μαρία   |Γεωργίου     |2345 |8880 |Σοφία      |Παπαδοπούλου |22222   |8    |20/1/2020  |Aspirin  |905678 |
|101012 |Γιώργος |Παπαδόπουλος |3456 |9990 |Παναγιώτης |Δημητρίου    |33333   |12   |1/6/2018   |Salospir |901111 |
|101010 |Νίκος   |Νικολάου     |1234 |8880 |Σοφία      |Παπαδοπούλου |11112   |12   |13/1/2016  |Salospir |901111 |
|101010 |Νίκος   |Νικολάου     |1234 |9990 |Παναγιώτης |Δημητρίου    |11118   |8    |14/1/2016  |Aspirin  |905678 |
-------------------------------------------------------------------------------------------------------------------
===================================================================================================================
*/
CREATE DATABASE E_HEALTH;
USE  E_HEALTH;

CREATE TABLE IF NOT EXISTS PATIENTS(
	PAMKA INT AUTO_INCREMENT,
    PAFM INT NOT NULL,
    PNAME VARCHAR(14),
    PSURNAME VARCHAR(14),
    PRIMARY KEY (PAMKA,PAFM)
    );
    
CREATE TABLE IF NOT EXISTS DOCTORS(
	DAFM INT NOT NULL,
    DNAME VARCHAR(14),
    DSURNAME varchar(14),
    PRIMARY KEY (DAFM)
    );
    
CREATE TABLE IF NOT EXISTS MEDS(
    MBARCODE INT NOT NULL,
    MNAME VARCHAR(14),
    MVALUE FLOAT NOT NULL,
    PRIMARY KEY (MBARCODE)
    );

CREATE TABLE IF NOT EXISTS ORIGIN(
    PBARCODE INT NOT NULL,
    DATES DATE,
    PRIMARY KEY (PBARCODE)
    );


CREATE TABLE IF NOT EXISTS PRESC(
	PBARCODE INT,
    MBARCODE INT,
    PAMKA INT,
    DAFM INT,
    DATES DATE,
    
    PRIMARY KEY (PBARCODE,MBARCODE),
	FOREIGN KEY (PBARCODE) REFERENCES ORIGIN(PBARCODE),
	FOREIGN KEY (MBARCODE) REFERENCES MEDS(MBARCODE),
    FOREIGN KEY (PAMKA) REFERENCES PATIENTS(PAMKA),
    FOREIGN KEY (DAFM) REFERENCES DOCTORS(DAFM)
    );



INSERT INTO PATIENTS(PAMKA,PAFM,PNAME,PSURNAME)
	VALUES (101010,1234,'Νίκος','Νικολάου');
INSERT INTO PATIENTS(PAFM,PNAME,PSURNAME)
	VALUES (2345,'Μαρία','Γεωργίου'),(3456,'Γιώργος','Παπαδόπουλος');
    
SELECT * FROM PATIENTS;


INSERT INTO DOCTORS ( DAFM,DNAME,DSURNAME )
    VALUES  (9990 , 'Παναγιώτης','Δημητρίου'), 
			( 8880 , 'Σοφία','Παπαδοπούλου' ) ;

select *from doctors;

INSERT INTO MEDS ( MBARCODE , MNAME , MVALUE )
    VALUES  (901234 , 'Depon' , 10), 
			(905678 , 'Aspirin',8) ,
			(901111, 'Salospir' , 12);

select *from meds;
    
INSERT INTO ORIGIN ( PBARCODE , DATES )
    VALUES  ( 11111 ,'2016-11-13'),
			(22222 ,'2020-1-20'),
			(33333,'2018-6-1'),
			(11112 ,'2016-1-13'),
			(11118,'2016-1-14');
select *from origin;
        
INSERT INTO PRESC(PBARCODE,MBARCODE,PAMKA,DAFM,DATES)
	VALUES	(11111,901234,101010,9990,'2016-11-13'),
			(11111,905678,101010,9990,'2016-11-13'),
			(22222,905678,101011,8880,'2020-1-20'),
			(33333,901111,101012,9990,'2018-6-1'),
			(11112,901111,101010,8880,'2016-1-13'),
			(11118,905678,101010,9990,'2016-1-14');


-- 1 
SELECT * FROM PATIENTS;
SELECT * FROM DOCTORS;
SELECT * FROM MEDS;
SELECT * FROM ORIGIN;
SELECT * FROM PRESC;

-- 2

SELECT PAMKA,PNAME,PSURNAME
FROM PATIENTS
WHERE PAMKA <= 101050 AND PAMKA >= 101010;

-- 3 

SELECT PNAME,PSURNAME,PAFM
FROM PATIENTS 
WHERE PNAME = 'Νίκος' OR PNAME = 'Μαρία' ;

-- 4 
SELECT DNAME, DSURNAME , DOCTORS.DAFM ,PNAME , PSURNAME , PATIENTS.PAMKA, PAFM , DATES , PRESC.PBARCODE , PRESC.MBARCODE
FROM PATIENTS , DOCTORS , PRESC
WHERE PATIENTS.PAMKA = PRESC.PAMKA AND DOCTORS.DAFM = PRESC.DAFM AND
PATIENTS.PAMKA = 101010 AND DOCTORS.DAFM = 9990
ORDER BY PRESC.DATES; 


-- SELECT DNAME, DSURNAME , DOCTORS.DAFM ,PNAME , PSURNAME , PATIENTS.PAMKA, PAFM , DATES , PRESC.PBARCODE , PRESC.MBARCODE
-- FROM PATIENTS , DOCTORS , PRESC
-- WHERE PATIENTS.PAMKA = PRESC.PAMKA AND DOCTORS.DAFM = PRESC.DAFM AND
-- PATIENTS.PAMKA = 101011 AND DOCTORS.DAFM =8880
-- ORDER BY PRESC.DATES;

-- SELECT * FROM PRESC;

-- 5

-- SELECT DNAME, DSURNAME , DOCTORS.DAFM ,PNAME , PSURNAME , PATIENTS.PAMKA, PAFM , DATES , PRESC.PBARCODE , PRESC.MBARCODE,MNAME
-- FROM PATIENTS , DOCTORS , PRESC,MEDS
-- WHERE PATIENTS.PAMKA = PRESC.PAMKA AND DOCTORS.DAFM = PRESC.DAFM AND 
-- (PATIENTS.PAMKA = 101010 AND DOCTORS.DAFM = 9990) AND (DATES BETWEEN '2016-1-1' AND '2018-12-31')
-- ORDER BY PRESC.DATES; 

SELECT DNAME, DSURNAME , DOCTORS.DAFM ,PNAME , PSURNAME , PATIENTS.PAMKA, PAFM , DATES , PRESC.PBARCODE , PRESC.MBARCODE ,MNAME
FROM PATIENTS , DOCTORS , PRESC , MEDS
WHERE PATIENTS.PAMKA = PRESC.PAMKA AND DOCTORS.DAFM = PRESC.DAFM
AND MEDS.MBARCODE = PRESC.MBARCODE AND
(PATIENTS.PAMKA = 101010 AND DOCTORS.DAFM = 9990) AND (DATES BETWEEN '2016-1-1' AND '2018-12-31')
ORDER BY PRESC.DATES;

-- 6 
-- ΣΚΕΨΗ (ΒΓΑΖΕΙ ΓΙΑ ΟΛΗ ΤΗΝ ΒΑΣΗ)

SELECT MEDS.MBARCODE , COUNT(*) 
FROM MEDS	
INNER JOIN PRESC ON MEDS.MBARCODE = PRESC.MBARCODE
GROUP BY MEDS.MBARCODE ;

SELECT MEDS.MBARCODE , COUNT(*) 
FROM MEDS	
INNER JOIN PRESC ON MEDS.MBARCODE = PRESC.MBARCODE
WHERE DATES IN (SELECT DATES 
	FROM PRESC 
    WHERE YEAR(DATES) = '2016' )
GROUP BY MEDS.MBARCODE ;

-- 6 
/* -- ΠΟΣΟΤΗΤΑ ΦΑΡΜΑΚΩΝ 
SELECT MEDS.MBARCODE , COUNT(*) 
FROM MEDS	
INNER JOIN PRESC ON MEDS.MBARCODE = PRESC.MBARCODE
JOIN PATIENTS ON PRESC.PAMKA = PATIENTS.PAMKA
WHERE DATES IN (SELECT DATES 
	FROM PRESC 
    WHERE YEAR(DATES) = '2016' AND PAMKA IN (SELECT  PAMKA	
		FROM PRESC
        WHERE PAMKA = 101010 ))
GROUP BY MEDS.MBARCODE ;   */

-- ΣΥΝΟΛΙΚΟ ΚΟΣΤΟΣ ΦΑΡΜΑΚΩΝ
/*SELECT MEDS.MBARCODE , COUNT(*) 
FROM MEDS	
INNER JOIN PRESC ON MEDS.MBARCODE = PRESC.MBARCODE
JOIN PATIENTS ON PRESC.PAMKA = PATIENTS.PAMKA
WHERE DATES IN (SELECT DATES 
	FROM PRESC 
    WHERE YEAR(DATES) = '2016' AND PAMKA IN (SELECT  PAMKA	
		FROM PRESC
        WHERE PAMKA = 101010 ))
GROUP BY MEDS.MBARCODE ;*/

-- ΔΙΑΛΕΓΟΥΜΕ ΕΤΟΣ ΚΑΙ ΑΜΚΑ ΚΟΣΤΟΣ
SELECT YEAR(PRESC.DATES), SUM(MVALUE) AS MONETYRVALUE
FROM PRESC
JOIN MEDS ON MEDS.MBARCODE=PRESC.MBARCODE
WHERE PRESC.DATES IN(SELECT DATES 
	FROM PRESC 
    WHERE YEAR(DATES)='2016' AND PAMKA IN ( SELECT PAMKA
		FROM PRESC
		WHERE PAMKA = 101010));


-- 7

/* SELECT PBARCODE
FROM  DOCTORS, PRESC
WHERE DOCTORS.DAFM = PRESC.DAFM 
AND (PRESC.DAFM = 8880 AND YEAR(DATES)= '2016')
GROUP BY PBARCODE;*/


SELECT PBARCODE
FROM PRESC
WHERE DAFM=8880 AND YEAR(DATES)= '2016';

-- 8

SELECT *
FROM PRESC 
INNER JOIN MEDS ON PRESC.MBARCODE = MEDS.MBARCODE
WHERE DAFM=9990 AND MEDS.MNAME='DEPON'
GROUP BY PBARCODE;
 
 -- 9

SELECT PBARCODE 
FROM PRESC 
JOIN MEDS ON PRESC.MBARCODE = MEDS.MBARCODE
WHERE DAFM=9990 AND (MEDS.MNAME='DEPON' OR MEDS.MNAME='ASPIRIN')
GROUP BY PBARCODE;

-- 10

SELECT SUM(MVALUE) , MEDS.MNAME , MEDS.MBARCODE
FROM MEDS
JOIN PRESC ON MEDS.MBARCODE = PRESC.MBARCODE 
GROUP BY MBARCODE;

-- 11 
select meds.mbarcode,mname, sum(mvalue),year(presc.dates)
from meds
join presc on presc.mbarcode=meds.mbarcode
group by year(presc.dates),mname
order by year(presc.dates);

-- 12 

with mx as ( select dafm , count(distinct(pamka)) cnt 
	from presc group by dafm)
    select dafm,count(distinct(pamka)) from presc group by dafm
    having count(distinct(pamka))=(select max(cnt) from mx);
    
    select * from presc;

/*select dafm,max(sump)
from (select dafm,count(distinct(pamka))
	as sump
    from presc group by dafm) as sump group by dafm;
    
select dafm,max(sheees)
from(select dafm,max(sump) as sheees
	from (select dafm,count(distinct(pamka))
		as sump
		from presc group by dafm) as sump group by dafm) as sheees group by dafm ;*/
	

/*select dafm, max(SHEEES)
from(select dafm, max(sump) AS SHEEES 
    from (select dafm,count(distinct(pamka))
    as sump
    from presc group by dafm) as T2 group by dafm) as T1;

select * from patients;
select *from presc;
    
    select dafm, max(pt)
    from (select count(distinct(pamka)) as pt
    from( select dafm from presc group by dafm) ) as pt
    group by dafm;
    
    
INSERT INTO PATIENTS(PAFM,PNAME,PSURNAME)
	VALUES (234510,'Μαρία','Γεωργίου');
    INSERT INTO ORIGIN ( PBARCODE , DATES )
    VALUES  ( 00000 ,'2016-11-13');
    INSERT INTO PRESC(PBARCODE,MBARCODE,PAMKA,DAFM,DATES)
	VALUES	(00000,901234,101013,9990,'2016-11-13');
DELETE FROM ORIGIN WHERE ( 00000 ,'2016-11-13');*/

-- 13

with lw as ( select pamka, count(distinct(pbarcode))  cnt
	from presc group by pamka)
    select pamka, count(distinct(pbarcode)) from presc group by pamka
    having count(distinct(pbarcode))=(select min(cnt) from lw);
    
-- 14
/*select * from presc;

select round(avg(av),2),dafm 
	from( select  dafm,pbarcode,sum(mvalue) as av
		from presc
		join meds on meds.mbarcode=presc.mbarcode
group by pbarcode)as av group by dafm;


 select  round(sum(mvalue)/count(distinct(pbarcode)),2) as avv
		from presc
		join meds on meds.mbarcode=presc.mbarcode;*/
        
      
select round(avg(av),2) as costaverage ,dafm 
	from( 
		select  dafm,pbarcode,sum(mvalue) as av ,sum(mvalue)/count(distinct(pbarcode)) as avv
					from presc
					join meds on meds.mbarcode=presc.mbarcode
					group by pbarcode ) as loser group by dafm having round(avg(av),2) > sum(avv)/count(distinct(pbarcode)) ;
      
        
        
/*select round(avg(av),2),dafm 
	from( select  dafm,pbarcode,sum(mvalue) as av,round(sum(mvalue)/count(distinct(pbarcode)),2) as avv
		from presc
		join meds on meds.mbarcode=presc.mbarcode
group by pbarcode)as av where round(avg(av),2) > round(sum(mvalue)/count(distinct(pbarcode)),2);

 select  round(sum(mvalue)/count(distinct(pbarcode)),2) as avv
		from presc
		join meds on meds.mbarcode=presc.mbarcode;

    
    
    
select round(avg(av),2),dafm 
	from( select  dafm,pbarcode,sum(mvalue) as av,round(sum(mvalue)/count(distinct(pbarcode)),2) as avv
		from presc
		join meds on meds.mbarcode=presc.mbarcode
group by pbarcode)as av where round(avg(av),2) > (select round(sum(mvalue)/count(distinct(pbarcode)),2) from presc
		join meds on meds.mbarcode=presc.mbarcode);*/


/*select round(avg(av),2) ,dafm 
    from( 
        select  dafm,pbarcode,sum(mvalue) as av ,sum(mvalue)/count(distinct(pbarcode)) as avv
                    from presc
                    join meds on meds.mbarcode=presc.mbarcode
                    group by pbarcode ) as av group by dafm having round(avg(av),2) > sum(avv)/count(distinct(pbarcode)) ;*/

-- 15

/*create view spend as 
select count(pamka),dafm
from presc
group by dafm;

select *from spend;

create view ppl as 
SELECT SUM(MVALUE) 
FROM MEDS
JOIN PRESC ON MEDS.MBARCODE = PRESC.MBARCODe;

select *from ppl;*/

create view sad as 
SELECT SUM(MVALUE) as income,count(pamka) as sickppl,dafm 
FROM presc
JOIN meds ON MEDS.MBARCODE = PRESC.MBARCODe
group by dafm;

select *from sad;
