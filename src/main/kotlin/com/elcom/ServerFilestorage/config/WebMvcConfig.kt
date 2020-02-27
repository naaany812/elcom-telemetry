package com.elcom.ServerFilestorage.config

import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.context.annotation.Description
import org.springframework.web.servlet.ViewResolver
import org.springframework.web.servlet.config.annotation.EnableWebMvc
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter
import org.thymeleaf.spring5.SpringTemplateEngine
import org.thymeleaf.spring5.view.ThymeleafViewResolver
import org.thymeleaf.templateresolver.ClassLoaderTemplateResolver


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

//    @Bean
//    @Description("Thymeleaf template resolver serving HTML 5")
//    fun templateResolver(): ClassLoaderTemplateResolver? {
//        val templateResolver = ClassLoaderTemplateResolver()
//        templateResolver.prefix = "templates/"
//        templateResolver.isCacheable = false
//        templateResolver.suffix = ".html"
//        templateResolver.characterEncoding = "UTF-8"
//        return templateResolver
//    }
//
//    @Bean
//    @Description("Thymeleaf template engine with Spring integration")
//    fun templateEngine(): SpringTemplateEngine? {
//        val templateEngine = SpringTemplateEngine()
//     //   templateEngine.addDialect(Sec)
//        templateEngine.setTemplateResolver(templateResolver())
//        return templateEngine
//    }
//
//    @Bean
//    @Description("Thymeleaf view resolver")
//    fun viewResolver(): ViewResolver? {
//        val viewResolver = ThymeleafViewResolver()
//        viewResolver.templateEngine = templateEngine()
//        viewResolver.characterEncoding = "UTF-8"
//        return viewResolver
//    }
    /*   override fun addViewControllers(registry: ViewControllerRegistry) {
           registry.addViewController("/measures").setViewName("measures")
           registry.addViewController("/systems").setViewName("systems")
           registry.addViewController("/login").setViewName("login")
       }*/
}