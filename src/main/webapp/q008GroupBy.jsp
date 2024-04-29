<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 집합 연산 -->
	create table 친구(name varchar2(50));
	create table 직장동료(name varchar2(50));
	
	insert into 친구 values('루피');
	insert into 친구 values('조로');
	insert into 친구 values('상디');
	
	insert into 직장동료 values('루피');
	insert into 직장동료 values('나미');
	commit;
	
	-- 친구동료 모두 합집합
	select name from 친구
	union all
	select name from 직장동료; -- 1)번 2)번 결과셋의 열모양(개수, 자료형)이 같아야 한다.
	
	-- 친구동료 중복제거 합집합
	select name from 친구
	union -- -- 두결과셋을 비교후 중복값을 제거한다
	select name from 직장동료;
	
	-- 차집합
	select name from 친구
	minus
	select name from 직장동료;
	
	-- 교집합
	select name from 친구
	intersect
	select name from 직장동료;
	
	<!-- 1. 스칼라 서브쿼리 : SELECT절의 "단일값(스칼라) SELECT문" -->
	-- 서브쿼리(자식 SELECT문)
	-- 1) 스칼라 : SELECT문의 SELECT절(컬럼값자리)애 사용된 SELECT문 --> 단일값(스칼라)
	SELECT * FROM emp;
	SELECT ROUND(AVG(sal)) FROM emp;
	-- 위 쿼리의 결과물을 같이 조회 - CROSS JOIN
	SELECT * 
	FROM emp CROSS JOIN (SELECT ROUND(AVG(sal)) FROM emp) t; 
	-- 스칼라 서브쿼리를 이요
	SELECT emp.*,(SELECT ROUND(AVG(sal)) FROM emp) 평균 FROM emp;
	
	SELECT emp.*,(SELECT deptno FROM dept WHERE deptno = 10)  FROM emp;
	
	-- error
	SELECT emp.*,(SELECT deptno FROM dept)  FROM emp; -- 스카라 결과값은 항상 단일값이여 한다
	
	<!-- 2. 인라인 뷰 :   FROM 절 SELECT문
	ex) emp테이블과 customer테이블에 동일한 아이디를 사용할 수 없는 경우 중복 아이디 검사
	-->
	-- 2) 인라인뷰 : SELECT문의 FORM절
	SELECT *
	FROM (SELECT * FROM emp WHERE gender = 'F') t
	WHERE t.deptno = 20;
	
	SELECT *
	FROM emp
	WHERE gender = 'F' and deptno=20;
	
	-- 쇼핑몰 emp 테이블, customer 테이블 -> 사용자ID는 두테이블에서 중복되어서는 안된다
	-- 'test'라는 아디가 사용가능한?
	SELECT * FROM emp WHERE emp_id = 'test'; -- null
	SELECT * FROM customer WHERE customer_id = 'test'; -- null
	-- 두 쿼리의 결과가 모두 null일때 'test'아이디를 사용가능
	
	-- 두개의 검사쿼리를 하나의 쿼리로 조회
	SELECT ec.id
	FROM 
	    (SELECT emp_id id FROM emp
	    UNION ALL -- 집합연산자
	    SELECT customer_id id FROM customer) ec -- 인라인뷰
	WHERE ec.id = 'test';
	
	<!-- 3. 서브쿼리 :  WHERE절, HAVIING절, ..., 사용되는 연산자(=, IN, ANY, ALL, ...)
	1) 1행 1컬럼값 비교  -->
	-- a) 단일행 단일컬럼
	-- 전체평균보다 높 사원
	SELECT emp.*
	FROM emp
	WHERE sal > (SELECT AVG(sal) FROM emp);
	-- 전체평균보다 부서평균이 낮은 부서
	SELECT deptno, AVG(sal)
	FROM emp
	GROUP BY deptno
	HAVING AVG(sal) < (SELECT AVG(sal) FROM emp);
	
	-- 다중컬럼
	SELECT emp.*
	FROM emp
	WHERE (deptno, gender) = (SELECT deptno, gender FROM emp WHERE ename = 'SCOTT');

	-- b) 다중행 단일컬럼
	SELECT emp.*
	FROM emp
	WHERE sal IN (SELECT sal FROM emp WHERE deptno = 10);
	
	SELECT emp.*
	FROM emp
	WHERE sal >ANY (SELECT sal FROM emp WHERE deptno = 10);
	
	SELECT emp.*
	FROM emp
	WHERE sal >ALL (SELECT sal FROM emp WHERE deptno = 10);
	
	-- 다중행 다중컬럼 - IN
	SELECT emp.*
	FROM emp
	WHERE (deptno, gender) IN (SELECT deptno, gender FROM emp WHERE ename = 'SCOTT' OR ename ='JAMES');
	
	<!-- GROUP BY 확장 -->
	-- GROUP BY 확장 - 표준아님(SQLD시험)
	-- 1)
	SELECT gender, COUNT(*)
	FROM emp
	GROUP BY gender;
	-- 2)
	SELECT deptno, COUNT(*)
	FROM emp
	GROUP BY deptno;
	
	-- 3)
	SELECT deptno, gender, COUNT(*)
	FROM emp
	GROUP BY deptno, gender
	ORDER BY deptno ASC, gender DESC;
	-- 4)
	SELECT deptno, gender, COUNT(*)
	FROM emp
	GROUP BY gender, deptno
	ORDER BY deptno ASC, gender DESC;
	
	-- 집합연산을 사용
	SELECT gender, null, COUNT(*) FROM emp GROUP BY gender
	UNION ALL
	SELECT null, NVL(deptno, 0), COUNT(*) FROM emp GROUP BY deptno;
	
	-- GROUPING SETS()를 사용
	SELECT gender, deptno, COUNT(*)
	FROM emp
	GROUP BY GROUPING SETS(deptno, gender)
	ORDER BY gender;
	
	-- 집합연산을 사용
	SELECT gender, null, COUNT(*) FROM emp GROUP BY gender
	UNION ALL
	SELECT null, deptno, COUNT(*) FROM emp GROUP BY deptno
	UNION ALL
	SELECT null, null, COUNT(*) FROM emp GROUP BY ();
	
	-- GROUPING SETS()를 사용
	SELECT gender, deptno, COUNT(*)
	FROM emp
	GROUP BY GROUPING SETS((),gender, deptno)
	ORDER BY gender;
</body>
</html>