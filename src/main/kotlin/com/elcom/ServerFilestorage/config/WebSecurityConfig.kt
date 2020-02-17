package com.elcom.ServerFilestorage.config

import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter
import org.springframework.security.core.userdetails.User
import org.springframework.security.core.userdetails.UserDetailsService
import org.springframework.security.provisioning.InMemoryUserDetailsManager

@Configuration
@EnableWebSecurity
class WebSecurityConfig : WebSecurityConfigurerAdapter() {
    override fun configure(http: HttpSecurity?) {
        http!!.authorizeRequests().antMatchers("/").permitAll()
                .anyRequest().authenticated()
                .and()
                .formLogin()
                .loginPage("/login")
                .defaultSuccessUrl("/systems",true)
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
}