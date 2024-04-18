package dao;

import java.sql.*;
import java.util.*;
import vo.Dept;

public class DeptDAO {
	// VO 사용
	public static ArrayList<HashMap<String, Object>> selectDeptOnOffList() throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT deptNo, dname, loc, 'ON' onOff FROM dept";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("deptNo", rs.getInt("deptNo"));
			m.put("dname", rs.getString("dname"));
			m.put("loc", rs.getString("loc"));
			m.put("onOff", rs.getString("onOff"));
			list.add(m);
		}
		
		conn.close();
		return list;
	}
}
