package com.shop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CartController {

    @GetMapping(value = "/cart")
    public String cart() {
        return "cart/cart";
    }

}