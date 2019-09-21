package com.company.csi.service.Impl;

import com.company.csi.mapper.SyslogMapper;
import com.company.csi.pojo.Syslog;
import com.company.csi.service.SyslogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class SyslogServiceImpl implements SyslogService{

    @Autowired
    SyslogMapper syslogMapper;

    @Override
    public void add(Syslog bean) {
        syslogMapper.insertSelective(bean);
    }
}
