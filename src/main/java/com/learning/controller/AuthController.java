package com.learning.controller;

import com.learning.model.User;
import com.learning.repository.UserRepo;
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
    public String home(HttpSession session) {
        if (session.getAttribute("userId") != null) {
            String role = (String) session.getAttribute("userRole");
            if ("STUDENT".equals(role)) {
                return "redirect:/student/dashboard";
            } else if ("TEACHER".equals(role)) {
                return "redirect:/teacher/dashboard";
            }
        }
        return "redirect:/login";
    }
    
    @GetMapping("/login")
    public String login(HttpSession session) {
        if (session.getAttribute("userId") != null) {
            return "redirect:/";
        }
        return "login";
    }
    
    @PostMapping("/login")
    public String doLogin(@RequestParam String email, 
                         @RequestParam String password, 
                         HttpSession session,
                         Model model) {
        if (email == null || email.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            model.addAttribute("error", "Email and password are required");
            return "login";
        }
        
        User user = userRepo.findByEmail(email.trim());
        
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
        
        model.addAttribute("error", "Invalid email or password");
        return "login";
    }
    
    @GetMapping("/register")
    public String register(HttpSession session) {
        if (session.getAttribute("userId") != null) {
            return "redirect:/";
        }
        return "register";
    }
    
    @PostMapping("/register")
    public String doRegister(@RequestParam String name,
                            @RequestParam String email,
                            @RequestParam String password,
                            @RequestParam String role,
                            @RequestParam(required = false) String section,
                            Model model) {
        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            role == null || role.trim().isEmpty()) {
            model.addAttribute("error", "All required fields must be filled");
            return "register";
        }
        
        if (userRepo.findByEmail(email.trim()) != null) {
            model.addAttribute("error", "Email already registered");
            return "register";
        }
        
        User user = new User();
        user.setName(name.trim());
        user.setEmail(email.trim());
        user.setPassword(password);
        user.setRole(role);
        user.setSection(section != null ? section.trim() : null);
        userRepo.save(user);
        
        return "redirect:/login?registered=true";
    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}