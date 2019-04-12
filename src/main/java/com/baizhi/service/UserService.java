package com.baizhi.service;

import com.baizhi.entity.User;

import java.util.Map;

public interface UserService {

    Map select(int page, int rows);

    Map insert(User user);

    Map delete(int[] ids);

    Map selectOne(int id);

    Map update(User user);
}
