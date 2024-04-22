<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	ArrayList<HashMap<String, String>> jobCaseList = EmpDAO.selectJobCaseList();

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<h1>CASE식을 이용한 정렬</h1>
	<table border=1>
		<tr>
			<td>ENAME</td>
			<td>JOB</td>
		</tr>
		<%
		for(HashMap<String, String> m : jobCaseList){
		%>
		<tr>
			<td><%=m.get("ename")%></td>
			<td><%=m.get("job")%></td>
		</tr>
		<%
		}
		%>
	</table>
</body>
</html>