package com.company.csi.service.Impl;

import com.company.csi.mapper.DepartmentMapper;
import com.company.csi.pojo.Department;
import com.company.csi.pojo.DepartmentExample;
import com.company.csi.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 部门接口实现类
 */
@Service
public class DepartmentServiceImpl implements DepartmentService {

    @Autowired
    DepartmentMapper departmentMapper;

    @Override
    public void add(Department bean) {
        departmentMapper.insertSelective(bean);
    }

    @Override
    public void delete(int id) {
        departmentMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Department bean) {
        departmentMapper.updateByPrimaryKeySelective(bean);
    }

    @Override
    public Department get(int id) {
        return departmentMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Department> list() {
        DepartmentExample example = new DepartmentExample();
        example.setOrderByClause("id desc");
        return departmentMapper.selectByExample(example);
    }

    @Override
    public void deleteAll(List<Integer> idList) {
        DepartmentExample example = new DepartmentExample();
        example.createCriteria().andIdIn(idList);
        departmentMapper.deleteByExample(example);
    }

    @Override
    public List<Department> searchByDepartmentName(String departmentName) {
        DepartmentExample example = new DepartmentExample();
        example.createCriteria().andDepartmentNameLike("%" + departmentName + "%");
        return departmentMapper.selectByExample(example);
    }
}
