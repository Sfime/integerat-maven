package com.baizhi.service.impl;

import com.baizhi.dao.UserDao;
import com.baizhi.entity.User;
import com.baizhi.service.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;

    @Override
    public Map select(int page, int rows) {
        Map map = new HashMap();
        PageHelper.startPage(page, rows);
        PageInfo pageInfo = new PageInfo(userDao.selectAll());
        List list = pageInfo.getList();
        long total = pageInfo.getTotal();
        map.put("rows", list);
        map.put("total", total);
        return map;
    }

    @Override
    public Map insert(User user) {
        Map map = new HashMap();
        userDao.insert(user);
        map.put("isInsert", true);
        return map;
    }

    @Override
    public Map delete(int[] ids) {
        userDao.deleteArray(ids);
        return null;
    }

    @Override
    public Map selectOne(int id) {
        Map map = new HashMap();
        User user = new User();
        user.setId(id);
        User user1 = userDao.selectOne(user);
        map.put("user", user1);
        return map;
    }

    @Override
    public Map update(User user) {
        userDao.updateByPrimaryKey(user);
        return null;
    }
}
