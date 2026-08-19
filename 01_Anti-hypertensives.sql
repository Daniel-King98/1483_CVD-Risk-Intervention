------------------------------------------
--
-- Author: Daniel Harris
-- Tables used: 
-- SAILUKHDV.READ_CD_CV2_SCD
--
-- Tables created:
-- SAILW1483V.HYPERTENSIVE_DRUGS
------------------------------------------
--
--Drop Table
CALL FNC.DROP_IF_EXISTS('SAILW1483V.HYPERTENSIVE_DRUGS');
COMMIT;
------------------------------------------ 
--
-- Create Table
CREATE TABLE SAILW1483V.HYPERTENSIVE_DRUGS
(
	READ_CODE					VARCHAR(5),
	DESC						VARCHAR(198),
	READ_TYPE					VARCHAR(20),
	ANTIHYPERTENSIVE_CLASS		VARCHAR(10),
	READ_CAT					VARCHAR(20),
	DRUG_COUNT					INTEGER
) 
;
COMMIT;
------------------------------------------
--
--Insert into Table

INSERT INTO SAILW1483V.HYPERTENSIVE_DRUGS
--
--THIAZIDE DIURETICS
SELECT
	R.READ_CODE,
	CASE
		WHEN R.PREF_TERM_198 IS NULL AND R.PREF_TERM_60 IS NULL THEN R.PREF_TERM_30
		WHEN R.PREF_TERM_198 IS NULL THEN R.PREF_TERM_60
		ELSE PREF_TERM_198
	END AS DESC,
	'THIAZIDE' AS READ_TYPE,
	'D' AS antihypertensive_class,
	'DRUG' AS READ_CAT,
	'1' AS drug_count
FROM
	SAILUKHDV.READ_CD_CV2_SCD R
WHERE
	READ_CODE LIKE 'b2%'
UNION
--
--LOOP DIURETICS 
SELECT
	R.READ_CODE,
	CASE
		WHEN R.PREF_TERM_198 IS NULL AND R.PREF_TERM_60 IS NULL THEN R.PREF_TERM_30
		WHEN R.PREF_TERM_198 IS NULL THEN R.PREF_TERM_60
		ELSE PREF_TERM_198
	END AS DESC,
	'LOOP' AS READ_TYPE,
	'D' AS antihypertensive_class,
	'DRUG' AS READ_CAT,
	'1' AS drug_count
FROM
	SAILUKHDV.READ_CD_CV2_SCD R
WHERE
	READ_CODE LIKE 'b3%'
	AND READ_CODE NOT IN ('b3...', 'b31..','b318.','b33..','b331.','b33y.','b319.',
'b31A.','b31B.','b31C.','b31D.', 'b31c.','b31d.','b31e.','b31l.','b31m.','b31n.','b31u.','b31y.','b31z.','b324.',
'b325.','b326.','b32w.','b32x.','b32y.','b32z.','b332.','b33z.','b34..','b341.','b34z.','b354.','b355.','b359.','b35A.')
	
UNION
--
--POTSPARING DIURETICS---amiloride, traimterine
SELECT
	R.READ_CODE,
	CASE
		WHEN R.PREF_TERM_198 IS NULL AND R.PREF_TERM_60 IS NULL THEN R.PREF_TERM_30
		WHEN R.PREF_TERM_198 IS NULL THEN R.PREF_TERM_60
		ELSE PREF_TERM_198
	END AS DESC,
	'POTSPARING' AS READ_TYPE,
	'K' AS antihypertensive_class,
	'DRUG' AS READ_CAT,
	'1' AS drug_count
FROM
	SAILUKHDV.READ_CD_CV2_SCD R
WHERE
	READ_CODE LIKE 'b41%'
	--OR READ_CODE LIKE 'b42%' --AND READ_CODE NOT IN ('b42z.','b421.')
	OR READ_CODE LIKE 'b44%'
UNION
--ALDOSTERONE ANTAG
SELECT
	R.READ_CODE,
	CASE
		WHEN R.PREF_TERM_198 IS NULL AND R.PREF_TERM_60 IS NULL THEN R.PREF_TERM_30
		WHEN R.PREF_TERM_198 IS NULL THEN R.PREF_TERM_60
		ELSE PREF_TERM_198
	END AS DESC,
	                      
	'ALDO_antag' AS READ_TYPE,
	'K' AS antihypertensive_class,   
	'DRUG' AS READ_CAT,
	'1' AS drug_count
FROM
	SAILUKHDV.READ_CD_CV2_SCD R
WHERE
	READ_CODE LIKE 'b43%'
	OR READ_CODE LIKE 'b45%'
UNION
--VERAPMAIL-& DILTIAZEM 
SELECT
	R.READ_CODE,
	CASE
		WHEN R.PREF_TERM_198 IS NULL AND R.PREF_TERM_60 IS NULL THEN R.PREF_TERM_30
		WHEN R.PREF_TERM_198 IS NULL THEN R.PREF_TERM_60
		ELSE PREF_TERM_198
	END AS DESC,
	'non_DHP' AS READ_TYPE,
	'C' AS antihypertensive_class,
	'DRUG' AS READ_CAT,
	'1' AS drug_count
FROM
	SAILUKHDV.READ_CD_CV2_SCD R
WHERE
	READ_CODE LIKE 'bb3%'
	AND   READ_CODE NOT IN   ('bb3E.','bb3o.','bb3c.', 'bb3t.')
	OR READ_CODE LIKE 'bl5%'
	OR READ_CODE LIKE 'blj%'
	UNION
--DIHYDROPYRIDINE CALCIUM CHANNEL 
SELECT
	R.READ_CODE,
	CASE
		WHEN R.PREF_TERM_198 IS NULL AND R.PREF_TERM_60 IS NULL THEN R.PREF_TERM_30
		WHEN R.PREF_TERM_198 IS NULL THEN R.PREF_TERM_60
		ELSE PREF_TERM_198
	END AS DESC,
	'dhp' AS READ_TYPE,
	'C' AS antihypertensive_class,'DRUG' AS READ_CAT,
	'1' AS drug_count
FROM
	SAILUKHDV.READ_CD_CV2_SCD R
WHERE
	READ_CODE LIKE 'bl7%'
		AND read_code NOT IN ('bl75.') 
	OR READ_CODE LIKE 'bl8%'
		AND READ_CODE NOT IN ('bl87.','bl88.')
	OR READ_CODE LIKE 'blb%'
	OR READ_CODE LIKE 'blc%'
	OR READ_CODE LIKE 'ble%'
	OR READ_CODE LIKE 'blh%'
UNION
--BETABLOCKER
SELECT

	R.READ_CODE,
	CASE
		WHEN R.PREF_TERM_198 IS NULL AND R.PREF_TERM_60 IS NULL THEN R.PREF_TERM_30
		WHEN R.PREF_TERM_198 IS NULL THEN R.PREF_TERM_60
		ELSE PREF_TERM_198
	END AS DESC,
	'BETA' AS READ_TYPE,
	'B' AS antihypertensive_class,
	'DRUG' AS READ_CAT,
	'1' AS drug_count
FROM
	SAILUKHDV.READ_CD_CV2_SCD R

WHERE READ_CODE LIKE 'bd1%' AND READ_CODE NOT IN ('bd1H.','bd1q.' )
	 OR READ_CODE LIKE 'bd2%'  AND READ_CODE NOT IN ('bd24.','bd2z.')
	 OR READ_CODE LIKE 'bd3%'AND READ_CODE NOT IN ('bd3y.','bd33.')
	 OR READ_CODE LIKE 'bd5%' AND READ_CODE NOT IN ('bd5z.','bd5c.','bd5b.','bd5b.' )
	 OR READ_CODE LIKE 'bd6%'  AND READ_CODE NOT IN ('bd6y.','bd6a.','bd63.')
	 OR READ_CODE LIKE 'bd7%'
	 OR READ_CODE LIKE 'bd8%'
	 OR READ_CODE LIKE 'bda%'
	 OR READ_CODE LIKE 'bdc%' AND READ_CODE NOT IN ('bdcy.','bdcz.', 'bdc6.','bdc7.','bdc8.','bdcs.')
	 OR READ_CODE LIKE 'bdd%'
	 OR READ_CODE LIKE 'bdf%'
	 OR READ_CODE LIKE 'bdj%'
	 OR READ_CODE LIKE 'bdl%'
	 OR READ_CODE LIKE 'bdm%'
	 OR READ_CODE LIKE 'bdn5'
UNION
--
--VASODILATOR ANTIHYPERTENSIVES-------------minoxidil and hydralazine----------
SELECT
	R.READ_CODE,
	CASE
		WHEN R.PREF_TERM_198 IS NULL AND R.PREF_TERM_60 IS NULL THEN R.PREF_TERM_30
		WHEN R.PREF_TERM_198 IS NULL THEN R.PREF_TERM_60
		ELSE PREF_TERM_198
	END AS DESC,
	'VASODILATOR' AS READ_TYPE,
	'V' AS antihypertensive_class,
	'DRUG' AS READ_CAT,
	'1' AS drug_count
FROM
	SAILUKHDV.READ_CD_CV2_SCD R
WHERE
	READ_CODE LIKE 'be%'
	AND READ_CODE NOT IN ('be1z.','be1z.','be41.','be4y.','be4z.')
UNION
--
--CENTRAL-ANTIHYPERTENSIVES-----clonidine, methyldopa, moxonidine 
SELECT
	R.READ_CODE,
	CASE
		WHEN R.PREF_TERM_198 IS NULL AND R.PREF_TERM_60 IS NULL THEN R.PREF_TERM_30
		WHEN R.PREF_TERM_198 IS NULL THEN R.PREF_TERM_60
		ELSE PREF_TERM_198
	END AS DESC,
	'CENTRAL' AS READ_TYPE,
	'Central' AS antihypertensive_class,
	'DRUG' AS READ_CAT,
	'1' AS drug_count
FROM
	SAILUKHDV.READ_CD_CV2_SCD R
WHERE
	READ_CODE LIKE 'bf%'
	AND READ_CODE  NOT IN ('bf1z.','bf28.','bf2w.','bf14.')
	AND  READ_CODE  NOT like 'bf3%'
UNION
--
--ALFA BLOCKERS
SELECT
	R.READ_CODE,
	CASE
		WHEN R.PREF_TERM_198 IS NULL AND R.PREF_TERM_60 IS NULL THEN R.PREF_TERM_30
		WHEN R.PREF_TERM_198 IS NULL THEN R.PREF_TERM_60
		ELSE PREF_TERM_198
	END AS DESC,
	'ALFA' AS READ_TYPE,
	'ALFA' AS antihypertensive_class,
	'DRUG' AS READ_CAT,
	'1' AS drug_count
FROM
	SAILUKHDV.READ_CD_CV2_SCD R
WHERE
	READ_CODE LIKE 'bh%'
	AND READ_CODE NOT IN ('bh...','bh22.',
	'bh31.','bh31.','bh32.','bh3y.','bh3y.','bh3z.')
	
UNION
--
--ACEI/ARB/ENTRESTO
SELECT
	R.READ_CODE,
	CASE
		WHEN R.PREF_TERM_198 IS NULL AND R.PREF_TERM_60 IS NULL THEN R.PREF_TERM_30
		WHEN R.PREF_TERM_198 IS NULL THEN R.PREF_TERM_60
		ELSE PREF_TERM_198
	END AS DESC,
	'ACE' AS READ_TYPE,
	'A' AS antihypertensive_class,
	'DRUG' AS READ_CAT,
	'1' AS drug_count
FROM
	SAILUKHDV.READ_CD_CV2_SCD R
WHERE
	READ_CODE LIKE 'bi%' AND READ_CODE NOT IN ('bi1G.', 'bi3p.','bi3v.', 'bi56.','bi3t.', 'bi1f.','biC8.',	'biC7.','bi4F.','bi3x.','bi3w.','bi3v.', 'bi3u.',	
'bi3t.',	'bi3s.',	'bi3p.','bi3n.',	'bi2b.','bi1s.',	'bi1f.',	'bi1e.',	'bi1G.','bi3p.','bi4F.','bi55.','bi48.',	
'bi1F.','bi1E.','bi1D.','bi1e.','bi1s.','bi28.','bi1G.','bi3t.','bi3x.','bi3v.',	'bi56.','bi3w.')
	OR READ_CODE LIKE 'bk3%' AND READ_CODE NOT IN  ('bk3z.','bk3z.'	,'bk3y.','bk35.','bk3y.','bk36.','bk39.','bk3z.','bk3A.')
	OR READ_CODE LIKE 'bk4%'  AND READ_CODE  NOT IN ('bk4z.', 'bk4x.', 'bk4z.',	'bk4y.','bk4x.',	'bk49.','bk48.','bk47.','bk4x.')
	OR READ_CODE LIKE 'bk5%'  AND READ_CODE  NOT IN ('bk5z.','bk57.','bk5z.','bk5y.','bk5x.','bk59.','bk58.', 'bk57.')
	OR READ_CODE LIKE 'bk7%'
	OR READ_CODE LIKE 'bk8%' AND READ_CODE NOT IN ( 'bk87.','bk8w.','bk8x.','bk8y.','bk87.','bk35.')
	OR READ_CODE LIKE 'bkB%'  
	OR READ_CODE LIKE 'bkC%' and READ_CODE NOT in ( 'bkC3.', 'bkCz.','bkCx.','bkCy.','bkC..','bkC1.',	'bkC2.')
	OR READ_CODE LIKE 'bkD%' AND READ_CODE NOT IN  ('bkD1.','bkD3.','bkD2.','bkDy.','bkD1.','bkD3.','bkD..','bkDz.','bkDx.','bkD2.',	'bkDy.')
	OR READ_CODE LIKE 'bkH%' AND READ_CODE NOT IN ('bkH..','bkHx.','bkHy.','bkH1.','bkH3.','bkHz.', 'bkH2.','bkH1.','bkH3.')
	OR READ_CODE LIKE 'bkI%' AND READ_CODE NOT IN  ('bkI..','bkI3.','bkI4.','bkI5.','bkI..','bkI3.','bkI4.','bkI5.','bi1E.','bkI1.','bkI2.' )
	OR READ_CODE LIKE 'bkL%'
union
-----
	-- ptassium spaing COMPOUND DIURTETICS
SELECT
	R.READ_CODE,
	CASE
		WHEN R.PREF_TERM_198 IS NULL AND R.PREF_TERM_60 IS NULL THEN R.PREF_TERM_30
		WHEN R.PREF_TERM_198 IS NULL THEN R.PREF_TERM_60
		ELSE PREF_TERM_198
	END AS DESC,
	'COMPOUND' AS READ_TYPE,
	'DK' AS antihypertensive_class,
	'DRUG' AS READ_CAT,
	'2' AS drug_count
FROM
	SAILUKHDV.READ_CD_CV2_SCD R
WHERE
	READ_CODE LIKE 'b5%'


UNION
-----------------Acei diuretic --------------------------------
SELECT
	R.READ_CODE,
	CASE
		WHEN R.PREF_TERM_198 IS NULL AND R.PREF_TERM_60 IS NULL THEN R.PREF_TERM_30
		WHEN R.PREF_TERM_198 IS NULL THEN R.PREF_TERM_60
		ELSE PREF_TERM_198
	END AS DESC,
	'ACE_diuretic' AS READ_TYPE,
	'AD' AS antihypertensive_class,
	'DRUG' AS READ_CAT,
	'2' AS drug_count
FROM
	SAILUKHDV.READ_CD_CV2_SCD R
WHERE
	READ_CODE IN (
'bi1D.','bi1E.','bi1F.','bi1G.','bi1e.','bi1f.','bi1s.','bi28.','bi2b.','bi3m.','bi3n.','bi3p.',	
'bi3s.','bi3t.','bi3u.','bi3v.','bi3w.','bi3x.','bi48.','bi4F.','bi55.','bk35.','bk36.','bk39.',
'bk3A.','bk3y.','bk3z.','bk47.','bk48.','bk49.','bk4x.','bk4y.','bk4z.','bk57.','bk58.','bk59.',
'bk5x.','bk5y.','bk5z.','bk86.','bk87.','bk88.','bk8w.','bk8x.','bk8y.','bkC..','bkC1.','bkC2.',
'bkC3.','bkCx.','bkCy.','bkCz.','biC8.','biC7.','bi4F.','bi3x.','bi3w.','bi3v.','bi3u.','bi3t.',	
'bi3s.','bi3p.','bi3n.','bi2b.','bi1s.','bi1f.','bi1e.','bi1G.','bi1F.','bi1E.','bi1D.'
)
union

-----ace and calcuium-------------
SELECT
	R.READ_CODE,
	CASE
		WHEN R.PREF_TERM_198 IS NULL AND R.PREF_TERM_60 IS NULL THEN R.PREF_TERM_30
		WHEN R.PREF_TERM_198 IS NULL THEN R.PREF_TERM_60
		ELSE PREF_TERM_198
	END AS DESC,
	'ACE_cal' AS READ_TYPE,
	'AC' AS antihypertensive_class,
	'DRUG' AS READ_CAT,
	'2' AS drug_count
FROM
	SAILUKHDV.READ_CD_CV2_SCD R
WHERE
	READ_CODE IN (
'bkHx.','bkHy.','bkD1.','bkD2.','bkD3.','bkDx.','bkDy.','bkDz.',
'bkH..','bkH1.','bkH2.','bkH3.','bkHx.','bkHy.','bkHz.')

union
---------triple ACE-calcaium- diurteic 'ACD'
SELECT
	R.READ_CODE,
	CASE
		WHEN R.PREF_TERM_198 IS NULL AND R.PREF_TERM_60 IS NULL THEN R.PREF_TERM_30
		WHEN R.PREF_TERM_198 IS NULL THEN R.PREF_TERM_60
		ELSE PREF_TERM_198
	END AS DESC,
	'ACD' AS READ_TYPE,
	'ACD' AS antihypertensive_class,
	'DRUG' AS READ_CAT,
	'3' AS drug_count
FROM
	SAILUKHDV.READ_CD_CV2_SCD R
WHERE
	READ_CODE IN (
'bkI1.','bkI2.','bkI3.','bkI4.','bkI5.') 
;
COMMIT;
--
------------------------------------------
--
-- Select all results
SELECT 
	* 
FROM 
	SAILW1483V.HYPERTENSIVE_DRUGS;
--
-- Count all results
SELECT 
	COUNT(*)
FROM 
	SAILW1483V.HYPERTENSIVE_DRUGS;
------------------------------------------
