package dao;

import java.sql.*;
import java.util.*;

import vo.Emp;

public class EmpDAO {
	
	//q003Case.jsp
	public static ArrayList<HashMap<String, String>> selectJobCaseList() throws Exception{
		
		Connection conn = DBHelper.getConnection();
		
		ArrayList<HashMap<String, String>> jobCaseList = new ArrayList<HashMap<String, String>>();
		
		String sql = "SELECT ename,job, CASE WHEN job = 'PRESIDENT' Then '빨강' WHEN job = 'MANAGER' THEN '주황' WHEN job = 'ANALYST' THEN '노랑' WHEN job = 'CLERK' THEN '초록' ELSE '파랑' END color FROM emp ORDER BY (CASE WHEN color = '빨강' THEN 1 WHEN color = '주황' THEN 2 WHEN color = '노랑' THEN 3 WHEN color = '초록' THEN 4 ELSE 5 END) ASC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, String> m = new HashMap<String, String>();
			m.put("ename", rs.getString("ename"));
			m.put("job", rs.getString("job"));
			jobCaseList.add(m);
		}
		
		conn.close();
		return jobCaseList;
	}
	
	// DEPTNO 뒤에 부서별 인원 같이 조회하는 메서드
	public static ArrayList<HashMap<String, Integer>> selectDeptNoCntList() throws Exception{
		
		Connection conn = DBHelper.getConnection();
		
		ArrayList<HashMap<String, Integer>> deptNoCntList = new ArrayList<HashMap<String, Integer>>();
		
		String sql = "SELECT deptno deptNo, count(*) deptCnt FROM emp WHERE deptno IS NOT NULL GROUP BY deptno ORDER BY deptno";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Integer> m = new HashMap<String, Integer>();
			m.put("deptNo", rs.getInt("deptNo"));
			m.put("deptCnt", rs.getInt("deptCnt"));
			deptNoCntList.add(m);
		}
		
		conn.close();
		return deptNoCntList;
	}
	

	// 중복을 제외한 DEPTNO 목록을 출력
	public static ArrayList<Integer> selectDeptNoList() throws Exception{
		
		Connection conn = DBHelper.getConnection();
		
		ArrayList<Integer> deptNoList = new ArrayList<Integer>();
		
		String sql = "SELECT DISTINCT deptno deptNo FROM emp WHERE deptno IS NOT NULL ORDER BY deptno ASC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Integer i = rs.getInt("deptno");
			deptNoList.add(i);
		}
		
		conn.close();
		return deptNoList;
	}
	
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
			e.setEmpNo(rs.getInt("empNo"));
			e.setEname(rs.getString("ename"));
			e.setSal(rs.getDouble("sal"));
			list.add(e);
		}
		
		conn.close();
		return list;
	}
}
