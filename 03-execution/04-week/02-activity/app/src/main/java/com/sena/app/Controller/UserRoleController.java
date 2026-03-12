package com.sena.app.Controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sena.app.Entity.UserRole;
import com.sena.app.Service.UserRoleService;

@RestController
@RequestMapping("/api/userrole")
public class UserRoleController {
    
    private final UserRoleService service;

    public UserRoleController(UserRoleService service) {
        this.service = service;
    }

    @PostMapping
    public ResponseEntity<UserRole> create(@RequestBody UserRole userRole) {
        UserRole savedUserRole = service.save(userRole);
        return new ResponseEntity<>(savedUserRole, HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<List<UserRole>> All() {       
        List<UserRole> userRoles = service.All();
        return new ResponseEntity<>(userRoles, HttpStatus.OK);
    }
}
