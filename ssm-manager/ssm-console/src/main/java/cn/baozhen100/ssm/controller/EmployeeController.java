package cn.baozhen100.ssm.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import cn.baozhen100.ssm.pojo.Employee;
import cn.baozhen100.ssm.pojo.Msg;
import cn.baozhen100.ssm.interfaces.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 
 * @author dingZiYuan
 *
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 删除方法(即可批量删除,也可以单个删除)
     *
     * @param ids
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
    public Msg deleteEmpById(@PathVariable("ids") String ids) {
        if (ids.contains("-")) {
            String[] StringIds = ids.split("-");
            List<Integer> listIds = new ArrayList();
            for (String id : StringIds) {
                listIds.add(Integer.parseInt(id));
            }
            employeeService.deleteEmpBatch(listIds);
        } else {
            employeeService.deleteEmpById(Integer.parseInt(ids));
        }
        return Msg.success();
    }

    /**
     * 员工更新
     * Tomcat中会判断是否为POST
     * 非Post请求不能再tomcat中继续运行
     * 需要支持直接发送PUT之类的请求并封装请求体中的数据
     * 1.配置上SpringMVC的HttpPutFormContentFilter过滤器
     * 2.它可以将请求体中的数据解析包装成一个map
     * 3.request被重新包装,request.getParameter()被重写,就会从自己封装的map中取值
     *
     * @param employee
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    public Msg saveEmp(Employee employee) {
        employeeService.updateEmp(employee);
        System.out.println(employee);
        return Msg.success();
    }


    /**
     * 根据员工id查询员工信息
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id) {

        Employee employee = employeeService.findEmpById(id);
        return Msg.success().add("emp", employee);

    }


    /**
     * 检验用户名是否重复
     *
     * @param empName
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkUser")
    public Msg checkUser(@RequestParam("empName") String empName) {
        //先判断用户名是否合法
        String regex = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
        if (!empName.matches(regex)) {
            return Msg.fail().add("va_msg", "用户名必须是6到16位数字字母或2到5位汉字!");
        }

        //数据库名称重复校验
        boolean b = employeeService.checkUser(empName);
        if (b) {
            return Msg.success().add("va_msg", "用户名可用!");
        } else {
            return Msg.fail().add("va_msg", "用户名已存在!");
        }
    }


    /**
     * 员工保存
     * 支持JSR303校验
     * 导入hibernate-validator
     *
     * @param employee
     * @return
     */
    @RequestMapping(value = "/empAdd", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        Map map = new HashMap<String, Object>();


        //校验失败,应该返回失败,在模态框中显示校验失败的错误信息
        if (result.hasErrors()) {
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors) {
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        } else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }


    }

    /**
     * 查询所有员工
     *
     * @param pn
     * @param model
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        // 这不是一个分页查询；
        // 引入PageHelper分页插件
        // 在查询之前只需要调用，传入页码，以及每页的大小
        PageHelper.startPage(pn, 8);
        // startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
        // 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
        // 封装了详细的分页信息,包括有我们查询出来的数据，传入连续显示的页数
        PageInfo page = new PageInfo(emps, 5);
        Msg add = Msg.success().add("pageInfo", page);
        return add;
    }

}