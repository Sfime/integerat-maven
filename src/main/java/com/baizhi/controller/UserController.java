package com.baizhi.controller;

import com.baizhi.entity.User;
import com.baizhi.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Controller
@RequestMapping("user")
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping("selectAll")
    public @ResponseBody
    Map selectAll(Integer page, Integer rows) {
        System.out.println(page + "----" + rows + "----" + userService);
        return userService.select(page, rows);
    }

    @RequestMapping(value = "insert")
    public @ResponseBody
    Map insert(User user) {
        return userService.insert(user);
    }

    @RequestMapping(value = "delete")
    public @ResponseBody
    Map delete(int[] ids) {
        return userService.delete(ids);
    }

    @RequestMapping(value = "selectOne")
    public @ResponseBody
    Map selectOne(int id) {
        return userService.selectOne(id);
    }

    @RequestMapping(value = "update")
    public @ResponseBody
    Map update(User user) {
        return userService.update(user);
    }
}
