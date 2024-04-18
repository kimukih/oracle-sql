package vo;

public class Emp {
	
	private String ename;
	private String job;
	private String hireDate;
	private double sal;
	private double comm;
	private int empNo;
	private int mgr;
	private int deptNo;
	
	public Emp() {
		
	}
	
	public Emp(int empNo, String ename, String job, int mgr, String hireDate, double sal, double comm, int deptNo) {
		this.empNo = empNo;
		this.ename = ename;
		this.job = job;
		this.mgr = mgr;
		this.hireDate = hireDate;
		this.sal = sal;
		this.comm = comm;
		this.deptNo = deptNo;
	}
}
