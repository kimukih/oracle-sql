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
	
	public Dept() {
		
	}
	
	public Dept(int deptNo, String dname, String loc) {
		this.deptNo = deptNo;
		this.dname = dname;
		this.loc = loc;
	}
}
