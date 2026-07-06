package com.shop.electronicshop.config;

import com.google.code.kaptcha.impl.DefaultKaptcha;
import com.google.code.kaptcha.util.Config;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import java.util.Properties;

@Configuration
public class CaptchaConfig {
    @Bean
    public DefaultKaptcha getDefaultKaptcha() {
        DefaultKaptcha captchaProducer = new DefaultKaptcha();
        Properties properties = new Properties();
        // 图片宽高
        properties.setProperty("kaptcha.image.width", "120");
        properties.setProperty("kaptcha.image.height", "40");
        // 字符数量
        properties.setProperty("kaptcha.textproducer.char.length", "4");
        // 字体大小
        properties.setProperty("kaptcha.textproducer.font.size", "32");
        // 干扰线条数
        properties.setProperty("kaptcha.noise.count", "5");
        Config config = new Config(properties);
        captchaProducer.setConfig(config);
        return captchaProducer;
    }
}