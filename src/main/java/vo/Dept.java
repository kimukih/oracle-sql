package vo;
	// Value Object
	// read-only의 단순한 값 형태만 저장하기 위한 파일
	// getter 기능만 존재

	// DTO (Date Transfer Object)

	// VO > DTO, Domain

public class Dept {
	
	private String dname;
	private String loc;
	private int deptNo;
	
	public String getDname() {
		return dname;
	}
	
	public void setDname(String dname) {
		this.dname = dname;
	}
	
	public String getLoc() {
		return loc;
	}
	
	public void setLoc(String loc) {
		this.loc = loc;
	}
	
	public int getDeptNo() {
		return deptNo;
	}
	
	public void setDeptNo(int deptNo) {
		this.deptNo = deptNo;
	}
	
}
