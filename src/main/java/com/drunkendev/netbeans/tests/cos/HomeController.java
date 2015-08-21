/*
 * HomeController.java    Aug 21 2015, 15:29
 *
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.drunkendev.netbeans.tests.cos;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


/**
 *
 * @author  Brett Ryan
 */
@Controller
public class HomeController {

    @RequestMapping("/")
    public ModelAndView home() throws IOException {
        ModelAndView mav = new ModelAndView("home");
        StringBuilder res = new StringBuilder();
        try (Reader r = new InputStreamReader(HomeController.class.getResourceAsStream("/test.txt"));
             BufferedReader br = new BufferedReader(r)) {
            String l;
            while ((l = br.readLine()) != null) {
                if (res.length() > 0) {
                    res.append(System.lineSeparator());
                }
                res.append(l);
            }
        }
        mav.addObject("fileContent", res.toString());
        return mav;
    }

}
