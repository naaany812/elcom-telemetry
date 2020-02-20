package com.elcom.ServerFilestorage.config

import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter
import org.springframework.security.core.userdetails.User
import org.springframework.security.core.userdetails.UserDetailsService
import org.springframework.security.provisioning.InMemoryUserDetailsManager
import org.springframework.web.cors.CorsConfiguration
import org.springframework.web.cors.CorsConfigurationSource
import org.springframework.web.cors.UrlBasedCorsConfigurationSource
import java.util.*


@Configuration
@EnableWebSecurity
class WebSecurityConfig : WebSecurityConfigurerAdapter() {
    override fun configure(http: HttpSecurity?) {
        http!!.cors().and().csrf().disable()
        http!!.authorizeRequests().antMatchers("/","/js/**","/bootstrap/**","/css/**","/fonts/**","/img/**").permitAll()
                .anyRequest().authenticated()
                .and()
                .formLogin()
                .loginPage("/login")
                .defaultSuccessUrl("/measures",true)
                .and()
                .logout()
                .permitAll()
                .invalidateHttpSession(true)
                .logoutSuccessUrl("/login")
                .deleteCookies("JSESSIONID")
    }

    @Bean
    override fun userDetailsService(): UserDetailsService {
        var user = User.withDefaultPasswordEncoder()
                .username("admin")
                .password("admin")
                .roles("ADMIN")
                .build()
        return InMemoryUserDetailsManager(user)
    }
    @Bean
    fun corsConfigurationSource(): CorsConfigurationSource? {
        val configuration = CorsConfiguration()
        configuration.allowedOrigins = Arrays.asList("*")
        configuration.allowedMethods = Arrays.asList("*")
        configuration.allowedHeaders = Arrays.asList("*")
        configuration.allowCredentials = true
        val source = UrlBasedCorsConfigurationSource()
        source.registerCorsConfiguration("/**", configuration)
        return source
    }
}