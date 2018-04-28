package cn.baozhen100.ssm.controller;

import java.util.List;

import cn.baozhen100.ssm.pojo.Department;
import cn.baozhen100.ssm.pojo.Msg;
import cn.baozhen100.ssm.interfaces.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


/**
 * 处理
 * @author dingZiYuan
 *
 */
@Controller
public class DepartmentController {

    @Autowired
	private DepartmentService departmentService;


    /**
	 * 返回所有部门信息
	 */
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts(){
		//查出所有的部门信息
		List<Department> list = departmentService.getDepts();
		return Msg.success().add("depts", list);
	}
	
	
}
