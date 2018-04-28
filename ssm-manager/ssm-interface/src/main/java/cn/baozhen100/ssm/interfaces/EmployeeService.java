package cn.baozhen100.ssm.interfaces;

import cn.baozhen100.ssm.pojo.Employee;

import java.util.List;


public interface EmployeeService {
	

	/**
	 * 删除指定id的员工信息
	 * @param empId
	 * @return
	 */
	public Integer deleteEmpById(Integer empId);
	
	/**
	 * 查询所有员工
	 * @return
	 */
	public List<Employee> getAll() ;

	
	/**
	 * 员工保存
	 * @param employee
	 */
	public void saveEmp(Employee employee);

	/**
	 * 检验用户是否重复
	 * @param empName
	 * @return true为数据库没有该用户名,可用
	 */
	public boolean checkUser(String empName) ;

	/**
	 * 获得当前用户的所有信息
	 */
	public Employee findEmpById(Integer empId);


	/**
	 * 修改用户数据
	 * @param employee
	 */
	public void updateEmp(Employee employee) ;

	/**
	 * 批量删除用户
	 */
	public void deleteEmpBatch(List<Integer> ids);

}
