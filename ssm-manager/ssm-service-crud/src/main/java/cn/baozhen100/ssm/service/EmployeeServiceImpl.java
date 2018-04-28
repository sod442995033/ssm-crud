package cn.baozhen100.ssm.service;

import java.util.List;

import cn.baozhen100.ssm.dao.EmployeeMapper;
import cn.baozhen100.ssm.interfaces.EmployeeService;
import cn.baozhen100.ssm.pojo.Employee;
import cn.baozhen100.ssm.pojo.EmployeeExample;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;


@Service("employeeService")
public class EmployeeServiceImpl implements EmployeeService {

	@Resource
	EmployeeMapper employeeMapper;

	/**
	 * 删除指定id的员工信息
	 * @param empId
	 * @return
	 */
	@Override
	public Integer deleteEmpById(Integer empId){
		return employeeMapper.deleteByPrimaryKey(empId);
	}
	
	/**
	 * 查询所有员工
	 * @return
	 */
	@Override
	public List<Employee> getAll() {
		// TODO Auto-generated method stub
		return employeeMapper.selectByExampleWithDept(null);
	}

	
	/**
	 * 员工保存
	 * @param employee
	 */
	@Override
	public void saveEmp(Employee employee) {
		
		employeeMapper.insertSelective(employee);
	}

	/**
	 * 检验用户是否重复
	 * @param empName
	 * @return true为数据库没有该用户名,可用
	 */
	@Override
	public boolean checkUser(String empName) {
		EmployeeExample example = new EmployeeExample();
		EmployeeExample.Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(example);
		return count == 0;
	}

	/**
	 * 获得当前用户的所有信息
	 */
	@Override
	public Employee findEmpById(Integer empId) {
		return employeeMapper.selectByPrimaryKey(empId);
	}


	/**
	 * 修改用户数据
	 * @param employee
	 */
	@Override
	public void updateEmp(Employee employee) {
		 employeeMapper.updateByPrimaryKeySelective(employee);
	}

	/**
	 * 批量删除用户
	 */
	@Override
	public void deleteEmpBatch(List<Integer> ids) {
		EmployeeExample example = new EmployeeExample();
		EmployeeExample.Criteria criteria = example.createCriteria();
		//delete from xxx where emp_id in (1,2,3,4);
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(example);
	}

}
