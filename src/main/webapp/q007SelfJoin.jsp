<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<!-- 컨트롤러 -->
<%
	ArrayList<HashMap<String, Object>> empMgrGrade = EmpDAO.selectEmpMgrGrade();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<h1>직원 권한 및 직원 별 매니저 권한 등급</h1>
	<table border="1">
		<tr>
			<th>EMPNO</th>
			<th>ENAME</th>
			<th>GRADE</th>
			<th>mgrName</th>
			<th>mgrGrade</th>
		</tr>

		<%
			for(HashMap<String, Object> m : empMgrGrade) {
		%>
				<tr>
					<td><%=m.get("empNo")%></td>
					<td><%=m.get("ename")%></td>
					<td>
						<%
							for(int i=0; i<(Integer)(m.get("grade")); i++) {
						%>
								&#127765;
						<%
							}
						%>
					</td>
					<td><%=m.get("mgrName")%></td>
					<td>
						<%
							for(int i=0; i<(Integer)(m.get("mgrGrade")); i++) {
						%>
								&#127761;
						<%
							}
						%>
					</td>
				</tr>
		<%		
			}
		%>
	</table>
</body>
</html>