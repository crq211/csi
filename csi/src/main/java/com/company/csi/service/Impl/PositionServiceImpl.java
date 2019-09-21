package com.company.csi.service.Impl;

import com.company.csi.mapper.PositionMapper;
import com.company.csi.pojo.DepartmentExample;
import com.company.csi.pojo.PositionExample;
import com.company.csi.service.PositionService;
import org.springframework.beans.factory.annotation.Autowired;
import com.company.csi.pojo.Position;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 职位接口实现类
 */
@Service
public class PositionServiceImpl implements PositionService {

    @Autowired
    PositionMapper positionMapper;

    @Override
    public void add(Position bean) {
        positionMapper.insertSelective(bean);
    }

    @Override
    public void delete(int id) {
        positionMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Position bean) {
        positionMapper.updateByPrimaryKeySelective(bean);
    }

    @Override
    public Position get(int id) {
        return positionMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Position> list() {
        PositionExample example = new PositionExample();
        example.setOrderByClause("id desc");
        return positionMapper.selectByExample(example);
    }

    @Override
    public void deleteAll(List<Integer> idList) {
        PositionExample example = new PositionExample();
        example.createCriteria().andIdIn(idList);
        positionMapper.deleteByExample(example);
    }

    @Override
    public List<Position> searchByPositionName(String positionName) {
        PositionExample example = new PositionExample();
        example.createCriteria().andPositionNameLike("%" + positionName + "%");
        return positionMapper.selectByExample(example);
    }
}
