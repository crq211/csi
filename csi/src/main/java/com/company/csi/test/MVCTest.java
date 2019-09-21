package com.company.csi.test;


import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

/**
 * 新技能，利用单元测试测试登录请求
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "classpath:springMVC.xml"})
@WebAppConfiguration
public class MVCTest {

    //传入springMVC的ioc
    @Autowired
    WebApplicationContext context;

    //虚拟的mvc请求
    MockMvc mockMvc;

    //调用之前初始化
    @Before
    public void initMockMvc() {
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        //模拟请求拿到返回值,控制器里面要有这个方法
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/login")
                .param("userName", "root")
                .param("userPassword", "sss")).andReturn();
        //请求失败后，请求域中会有msg，取出进行验证
        String msg = (String) result.getRequest().getAttribute("msg");

        System.out.println(msg);

    }
}
