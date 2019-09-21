package com.company.csi.service.Impl;

import com.company.csi.mapper.StaffMapper;
import com.company.csi.pojo.Department;
import com.company.csi.pojo.Position;
import com.company.csi.pojo.Staff;
import com.company.csi.pojo.StaffExample;
import com.company.csi.service.DepartmentService;
import com.company.csi.service.PositionService;
import com.company.csi.service.StaffService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 员工接口实现类
 */
@Service
public class StaffServiceImpl implements StaffService {

    @Autowired
    StaffMapper staffMapper;

    @Autowired
    PositionService positionService;

    @Autowired
    DepartmentService departmentService;

    @Override
    public List<Staff> list() {
        StaffExample example = new StaffExample();
        example.setOrderByClause("id desc");
        List<Staff> staffList = staffMapper.selectByExample(example);
        setPosition(staffList);
        setDepartment(staffList);
        return staffList;
    }

    @Override
    public void add(Staff bean) {
        bean.setCreateDate(new Date());
        staffMapper.insertSelective(bean);
    }

    @Override
    public void delete(int id) {
        staffMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Staff bean) {
        staffMapper.updateByPrimaryKeySelective(bean);
    }

    @Override
    public Staff get(int id) {
        return staffMapper.selectByPrimaryKey(id);
    }

    @Override
    public void deleteAll(List<Integer> idList) {
        StaffExample example = new StaffExample();
        example.createCriteria().andIdIn(idList);
        staffMapper.deleteByExample(example);
    }

    @Override
    public List<Staff> search(int positionId, String staffName, String idNumber,
                              String gender, String phone, int departmentId) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("positionId", positionId);
        map.put("staffName", staffName);
        map.put("idNumber", idNumber);
        map.put("gender", gender);
        map.put("phone", phone);
        map.put("departmentId", departmentId);
        List<Staff> staffList = staffMapper.selectBy(map);
        setPosition(staffList);
        setDepartment(staffList);
        return staffList;
    }



    /**
     * 为员工设置职位
     */
    public void setPosition(Staff staff) {
        Position position = positionService.get(staff.getPositionId());
        staff.setPosition(position);
    }

    public void setPosition(List<Staff> staffList) {
        for (Staff staff : staffList) {
            setPosition(staff);
        }
    }

    /**
     * 为员工设置部门
     */
    public void setDepartment(Staff staff) {
        Department department = departmentService.get(staff.getDepartmentId());
        staff.setDepartment(department);
    }

    public void setDepartment(List<Staff> staffList) {
        for (Staff staff : staffList) {
            setDepartment(staff);
        }
    }


}
