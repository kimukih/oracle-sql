<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	ArrayList<Integer> deptNoList = EmpDAO.selectDeptNoList();
	ArrayList<HashMap<String, Integer>> deptNoCntList = EmpDAO.selectDeptNoCntList();

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<select name="deptNo">
		<option value="">::: 선택 :::</option>
		<%
		for(Integer i : deptNoList){
		%>
		<option value="<%=i%>"><%=i%></option>
		<%
		}
		%>
	</select>
	<h1>DISTINCT 대신 GROUP BY를 사용해야만 하는 경우</h1>
	<table border=1>
		<tr>
			<td>DeptCnt</td>
			<td>Dept</td>
		</tr>
	<%
	for(HashMap<String, Integer> m : deptNoCntList){
	%>
		<tr>
			<td><%=(Integer)(m.get("deptCnt"))%></td>
			<td><%=(Integer)(m.get("deptNo"))%></td>
		</tr>
	<%
	}
	%>
	</table>
</body>
</html>