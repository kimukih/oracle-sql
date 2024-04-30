<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	-- GROUPING SETS를 사용하면 UNION ALL의 효과를 얻을 수 있음 (이미지 11)

	SELECT CASE WHEN deptno IS NULL AND GROUPING(deptno) = 0 THEN '부서없음'
	            WHEN deptno IS NULL AND GROUPING(deptno) = 1 THEN '전체'
	            ELSE TO_CHAR(deptno) END deptno,
	            COUNT(*), GROUPING(deptno)
	FROM emp
	GROUP BY GROUPING SETS((), deptno);
	
	
	-- GROUP BY CUBE, ROLLUP
	SELECT gender, COUNT(*) 인원수, GROUPING(gender) 전체
	FROM emp
	GROUP BY GROUPING SETS((), gender);
	
	-- ROLLUP : 전체 요소에서 뒤에서 하나씩 빼서 만듬
	-- ex GROUP BY(gender, deptno, job) 인 경우
	-- (gender, deptno, job), (gender, deptno), gender 3가지 조합
	SELECT gender, COUNT(*) 인원수, GROUPING(gender) 전체
	FROM emp
	GROUP BY ROLLUP(gender);
	
	-- CUBE : 모든 조합의 경우의 수 출력
	SELECT gender, deptno, COUNT(*) 인원수, GROUPING(gender) 전체
	FROM emp
	GROUP BY CUBE(gender, deptno);
	
	SELECT gender, deptno, COUNT(*)
	FROM emp
	GROUP BY ROLLUP(gender, deptno);
	
	-- GRUOP BY 확장절
	-- 1) GROUPING SETS > ROLLUP / CUBE
	-- 2) GROUPING()함수
	
	
	
	-- 계층 쿼리 (Hierarchical Query)
	-- == SELF JOIN 조인식
	-- 출력조건 : 정방향 출력(전체출력), 역방향 출력
	
	-- 정방향 출력
	-- 현재 멤버의 empno가 다음 멤버의 mgr인 순서대로 진행
	SELECT * -- (처리4)
	FROM emp -- (처리1)
	-- 특정 멤버를 제외하는 조건 추가
	-- 결과값에서 BLAKE는 삭제되지만 그 하위 멤버들은 삭제가 되지 않음
	-- 쿼리 작성 순서에 관계없이 계층쿼리(SELF JOIN)의 처리 순서가 WHERE 절보다 먼저이기 때문에
	-- SELF JOIN을 처리한 결과값이 먼저 출력되고 그 결과값에서 WHERE절의 조건을 처리한다.
	WHERE ename != 'BLAKE' -- (처리3)
	START WITH mgr IS NULL -- 시작조건(매니저가 없다 = 최상위 멤버이다) (처리2)
	-- 출력 조건(이전 행을 기준으로 함), PRIOR : 이전행을 가리킴
	-- 이전 행의 empno와 현재행의 mgr이 같은 순서대로 출력
	CONNECT BY PRIOR empno = mgr;
	
	-- 역방향 출력
	-- 현재 멤버의 empno가 이전 멤버의 mgr인 순서대로 진행
	SELECT *
	FROM emp
	START WITH ename = 'SMITH' -- 시작조건(특정 컬름의 값으로 지정)
	-- 출력 조건(이전 행을 기준으로 함), PRIOR : 이전행을 가리킴
	-- 이전 행의 mgr과 현재행의 empno가 같은 순서대로 출력
	CONNECT BY PRIOR mgr = empno;
	
	
	-- 계층쿼리에서 사용가능한 함수와 의사컬럼
	-- 계층쿼리는 LPAD()와 함께 자주 쓰임 (시각화 자료 만들기)
	-- rowid = 메모리의 참조값
	-- rownum = SELECT절의 결과값에 번호를 붙인것
	-- rownum의 처리 우선순위는 WHERE절 뒤, ORDER BY절 앞
	SELECT rowid, rownum, ename FROM emp;
	
	SELECT rownum, rowid, level, ename FROM emp; -- error (CONNECT BY 절이 없음)
	
	SELECT LPAD(' ', 3*(LEVEL-1))||ename, empno, mgr, level, CONNECT_BY_ROOT(ename)
	FROM emp
	START WITH mgr IS NULL
	CONNECT BY PRIOR empno = mgr;
	
	
	
	-- 분석 함수
	-- 서브쿼리를 사용하지 않고 함수를 사용하여
	-- 서브쿼리를 사용한 효과를 얻을 수 있음
	
	-- error, 개별행을 조회할 결과셋이 존재하지 않음
	SELECT ename, sal, SUM(sal)
	FROM emp
	GROUP BY();
	
	SELECT SUM(sal) FROM emp;
	
	-- 스칼라 서브쿼리 : SELECT절의 "단일값(스칼라) SELECT문" 사용
	SELECT ename, sal,(SELECT SUM(sal) FROM emp) 합계 
	FROM emp;
	
	-- 위의 쿼리에 분석함수를 적용하면
	-- OVER() 함수는 본래 결과셋을 건드리는게 아니라
	-- 본래의 결과셋을 가상공간에 복제하여 먼저 쿼리를 실행 후 결과값을 가져옴
	SELECT ename, sal, SUM(sal) OVER(PARTITION BY gender) 합계
	FROM emp;
	
	SELECT ename, sal, gender
	        , SUM(sal) OVER()
	        , ROUND(AVG(sal) OVER(), 0)
	        , MIN(sal) OVER()
	        , MAX(sal) OVER()
	        , COUNT(*) OVER() cnt_over
	        -- emp를 복제 후 2개의 집합셋 계산
	        , COUNT(sal) OVER(PARTITION BY gender) cnt_over_partition
	FROM emp; -- 집계 분석 함수
	
	-- 순위 분석 함수
	SELECT ename, sal
	        , ROW_NUMBER() OVER(ORDER BY sal DESC) row_num
	        , RANK() OVER(ORDER BY sal DESC) ran_k -- emp를 복제 후 정렬
	        , DENSE_RANK() OVER(ORDER BY sal DESC) dense_ran_k
	        -- emp를 2개의 집합으로 나누고 각각의 집합셋 계산
	        , RANK() OVER(PARTITION BY gender ORDER BY sal DESC) over_partition
	FROM emp
	ORDER BY row_num;
	
	
	-- SELECT ename, sal, gender
	-- NTILE : 특정 기준에 따라 등급을 나누어 주는 분석 함수
	-- NTITLE로 쓰지 않도록 주의
	SELECT ename, sal, NTILE(4) OVER(ORDER BY sal DESC) nt
	FROM emp
	ORDER BY nt;
</body>
</html>