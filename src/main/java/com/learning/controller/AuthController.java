package com.learning.controller;

import com.learning.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;

@Controller
public class AuthController {
    
    @Autowired
    private UserRepo userRepo;
    
    @GetMapping("/")
    public String home() {
        return "redirect:/login";
    }
    
    @GetMapping("/login")
    public String login() {
        return "login";
    }
    
    @PostMapping("/login")
    public String doLogin(@RequestParam String email, 
                         @RequestParam String password, 
                         HttpSession session,
                         Model model) {
        User user = userRepo.findByEmail(email);
        if (user != null && user.getPassword().equals(password)) {
            session.setAttribute("userId", user.getId());
            session.setAttribute("userRole", user.getRole());
            session.setAttribute("userName", user.getName());
            
            if ("STUDENT".equals(user.getRole())) {
                return "redirect:/student/dashboard";
            } else if ("TEACHER".equals(user.getRole())) {
                return "redirect:/teacher/dashboard";
            }
        }
        model.addAttribute("error", "Invalid credentials");
        return "login";
    }
    
    @GetMapping("/register")
    public String register() {
        return "register";
    }
    
    @PostMapping("/register")
    public String doRegister(@RequestParam String name,
                            @RequestParam String email,
                            @RequestParam String password,
                            @RequestParam String role,
                            @RequestParam(required = false) String section) {
        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(role);
        user.setSection(section);
        userRepo.save(user);
        return "redirect:/login";
    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
