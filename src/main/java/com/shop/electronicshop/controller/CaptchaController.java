package com.shop.electronicshop.controller;

import com.google.code.kaptcha.Producer;
import jakarta.annotation.Resource;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.IOException;

@RestController
@RequestMapping("/captcha")
public class CaptchaController {
    // session存储验证码的key
    public static final String SESSION_CAPTCHA_KEY = "loginCaptcha";

    @Resource
    private Producer captchaProducer;

    @GetMapping("/img")
    public void getCaptcha(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("image/png");
        resp.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
        resp.setDateHeader("Expires", 0);
        HttpSession session = req.getSession();
        // 生成4位验证码
        String codeText = captchaProducer.createText();
        session.setAttribute(SESSION_CAPTCHA_KEY, codeText);
        BufferedImage image = captchaProducer.createImage(codeText);
        ServletOutputStream out = resp.getOutputStream();
        ImageIO.write(image, "png", out);
        out.flush();
        out.close();
    }
}