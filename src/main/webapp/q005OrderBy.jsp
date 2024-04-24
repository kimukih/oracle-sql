<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>

<!-- 컨트롤러(모델반환) -->
<%
	// 어떤 컬럼으로 정렬할 것인가
	String col = request.getParameter("col");
	System.out.println("col : " + col);

	// 오름차순 asc / 내림차순 desc
	String sort = request.getParameter("sort");
	System.out.println("sort : " + sort);
	
	
	// DAO 호출 > 모델값 반환
	ArrayList<Emp> list = EmpDAO.selectEmpListSort(col, sort);
	System.out.println("EmpDAO.selectEmpListSort(col, sort) : " + EmpDAO.selectEmpListSort(col, sort));
%>

<!-- 뷰(출력) -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<table border="1">
		<tr>
			<th>
				empno
				<a href="./q005OrderBy.jsp?col=empno&sort=asc">오름</a>
				<a href="./q005OrderBy.jsp?col=empno&sort=desc">내림</a>
			</th>
			<th>
				ename
				<a href="./q005OrderBy.jsp?col=ename&sort=asc">오름</a>
				<a href="./q005OrderBy.jsp?col=ename&sort=desc">내림</a>
			</th>
		</tr>
		
		<%
			for(Emp e : list) {
		%>
				<tr>
					<td><%=e.getEmpNo()%></td>
					<td><%=e.getEname()%></td>
				</tr>
		<%		
			}
		%>
	</table>
</body>
</html>