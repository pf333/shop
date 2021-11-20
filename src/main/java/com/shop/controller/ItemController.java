package com.shop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ItemController {

    @GetMapping(value = "/admin/itemReg")
    public String itemReg() {
        return "item/itemReg";
    }

    @GetMapping(value = "/admin/itemMgt")
    public String itemMgt() {
        return "item/itemMgt";
    }

}
