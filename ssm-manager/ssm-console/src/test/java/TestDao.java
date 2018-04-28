import cn.baozhen100.ssm.dao.DepartmentMapper;
import cn.baozhen100.ssm.dao.EmployeeMapper;
import cn.baozhen100.ssm.pojo.Employee;
import cn.baozhen100.ssm.pojo.EmployeeExample;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;


/**
 * @Author: dingziyuan
 * @Date: 2018-04-28 8:19
 * @Description: *
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class TestDao {

    @Autowired
    SqlSession sqlSession;


    /**
     * 批量插入100条数据
     */
    @Test
    public void insertData(){
        //1、创建SpringIOC容器
        ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
        //2、从容器中获取mapper
        DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);
        //3、批量插入多个员工；批量，使用可以执行批量操作的sqlSession。
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++) {
                String uid = UUID.randomUUID().toString().substring(0,5)+i;
                System.out.println(UUID.randomUUID());
                mapper.insertSelective(new Employee(null,uid, "M", uid+"@crud.com", 1));
        }
        System.out.println("批量插入完成");
    }


}


