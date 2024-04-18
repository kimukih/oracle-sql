package dao;

import java.sql.*;
import java.util.*;

import vo.Emp;

public class EmpDAO {
	
	// 조인으로 Map을 사용하는 경우
	public static ArrayList<HashMap<String, Object>> selectEmpAndDeptList() throws Exception{
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT e.empNo empNo, e.ename ename, e.deptNo deptNo, d.dname dname FROM emp e INNER JOIN dept d ON e.deptno = d.deptno";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<>();
			m.put("empNo", rs.getInt("empNo"));
			m.put("ename", rs.getString("ename"));
			m.put("deptNo", rs.getInt("deptNo"));
			m.put("dname", rs.getString("dname"));
			list.add(m);
		}
		
		conn.close();
		return list;
	}
	
	// VO 사용
	public static ArrayList<Emp> selectEmpList() throws Exception{
		ArrayList<Emp> list = new ArrayList<>();
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT empNo, ename, sal FROM emp";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Emp e = new Emp();
			e.empNo = rs.getInt("empNo");
			e.ename = rs.getString("ename");
			e.sal = rs.getDouble("sal");
			list.add(e);
		}
		
		conn.close();
		return list;
	}
}
