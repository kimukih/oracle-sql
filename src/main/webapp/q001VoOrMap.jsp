<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<!-- Controller -->
<%
	// 모델
	// ArrayList<Dept> deptList = DeptDAO.selectDeptList();
	ArrayList<Emp> empList = EmpDAO.selectEmpList();
	ArrayList<HashMap<String, Object>> deptOnOffList = DeptDAO.selectDeptOnOffList();
	ArrayList<HashMap<String, Object>> empAndDeptList = EmpDAO.selectEmpAndDeptList();

%>

<!-- View -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>q001VoOrMap - Query예제 001</title>
</head>
<body>
	<h1>Dept List</h1>
	<table border=1>
		<tr>
			<th>deptNo</th>
			<th>dname</th>
			<th>loc</th>
		</tr>
		<%
			for(HashMap<String, Object> m : deptOnOffList){
		%>
			<tr>
				<td><%=(Integer)(m.get("deptNo"))%></td>
				<td><%=(String)(m.get("dname"))%></td>
				<td><%=(String)(m.get("loc"))%></td>
			</tr>
		<%
			}
		%>
	</table>
	
	<h1>Emp List</h1>
	<table border=1>
		<tr>
			<th>empNo</th>
			<th>ename</th>
			<th>sal</th>
		</tr>
		<%
			for(Emp e : empList){
		%>
			<tr>
				<td><%=e.empNo%></td>
				<td><%=e.ename%></td>
				<td><%=e.sal%></td>
			</tr>
		<%
			}
		%>
	</table>
	
	<h1>Dept + onOff List</h1>
	<table border=1>
		<tr>
			<th>deptNo</th>
			<th>dname</th>
			<th>loc</th>
			<th>onOff</th>
		</tr>
		<%
			for(HashMap<String, Object> m : deptOnOffList){
		%>
			<tr>
				<td><%=(Integer)(m.get("deptNo"))%></td>
				<td><%=(String)(m.get("dname"))%></td>
				<td><%=(String)(m.get("loc"))%></td>
				<td><%=(String)(m.get("onOff"))%></td>
			</tr>
		<%
			}
		%>
	</table>
	
	<h1>Emp And Dept List</h1>
	<table border=1>
		<tr>
			<th>empNo</th>
			<th>ename</th>
			<th>deptNo</th>
			<th>dname</th>
		</tr>
		<%
			for(HashMap<String, Object> m : empAndDeptList){
		%>
			<tr>
				<td><%=(Integer)(m.get("empNo"))%></td>
				<td><%=(String)(m.get("ename"))%></td>
				<td><%=(Integer)(m.get("deptNo"))%></td>
				<td><%=(String)(m.get("dname"))%></td>
			</tr>
		<%
			}
		%>
	</table>
</body>
</html>