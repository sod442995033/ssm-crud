package cn.baozhen100.ssm.service;

import java.util.List;

import cn.baozhen100.ssm.dao.DepartmentMapper;
import cn.baozhen100.ssm.interfaces.DepartmentService;
import cn.baozhen100.ssm.pojo.Department;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;


@Service("departmentService")
public class DepartmentServiceImpl implements DepartmentService {
	
	@Resource
	private DepartmentMapper departmentMapper;


	@Override
	public List<Department> getDepts() {
		// TODO Auto-generated method stub
		List<Department> list = departmentMapper.selectByExample(null);
		return list;
	}
}
