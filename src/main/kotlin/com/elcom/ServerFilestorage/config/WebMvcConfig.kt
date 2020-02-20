package com.elcom.ServerFilestorage.config

import org.springframework.context.annotation.Configuration
import org.springframework.web.servlet.config.annotation.EnableWebMvc
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter


@Configuration
@EnableWebMvc
class WebMvcConfig : WebMvcConfigurerAdapter() {
    override fun addResourceHandlers(registry: ResourceHandlerRegistry) {
        registry.addResourceHandler(
                "/webjars/**",
                "/img/**",
                "/fonts/**",
                "/bootstrap/**",
                "/css/**",
                "/js/**")
                .addResourceLocations(
                        "classpath:/META-INF/resources/webjars/",
                        "classpath:/static/img/",
                        "classpath:/static/fonts/",
                        "classpath:/static/bootstrap/",
                        "classpath:/static/css/",
                        "classpath:/static/js/")
    }
 /*   override fun addViewControllers(registry: ViewControllerRegistry) {
        registry.addViewController("/measures").setViewName("measures")
        registry.addViewController("/systems").setViewName("systems")
        registry.addViewController("/login").setViewName("login")
    }*/
}