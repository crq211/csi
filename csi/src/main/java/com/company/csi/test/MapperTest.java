package com.company.csi.test;

import com.company.csi.mapper.DepartmentMapper;
import com.company.csi.mapper.UserMapper;
import com.company.csi.pojo.Department;
import com.company.csi.pojo.DepartmentExample;
import com.company.csi.pojo.User;
import com.company.csi.pojo.UserExample;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * 进行spring单元测试CRUD是否能成功
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    UserMapper userMapper;

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void testCRUD() {
        System.out.println(userMapper);
//        userMapper.insertSelective(new User(null,"root", "admin", "1274dg721gd1g", new Date(), "张三"));
//
//        UserExample example = new UserExample();
//        example.setOrderByClause("id desc");
//        List<User> userList = userMapper.selectByExample(example);
//        System.out.println(userList);

        departmentMapper.insertSelective(new Department(null, "经理部", "一群经理"));


        //通过sqlSession获取的这个mapper是可以批量操作的
        UserMapper mapper = sqlSession.getMapper(UserMapper.class);
        for (int i = 0; i < 2; i++) {
            String name = UUID.randomUUID().toString().substring(0, 5) + i;
//            mapper.insertSelective(new User(null,"root", name, name + "1274dg721gd1g", new Date(), "张三"));
        }
    }

}
