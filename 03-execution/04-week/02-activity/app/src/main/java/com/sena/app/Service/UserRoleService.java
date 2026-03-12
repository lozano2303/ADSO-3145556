package com.sena.app.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sena.app.Entity.UserRole;
import com.sena.app.IRepository.IUserRoleRepository;

@Service
public class UserRoleService {
    
    @Autowired
    private IUserRoleRepository repository;

    public UserRole save(UserRole userRole) {
        return repository.save(userRole);
    }

    public List<UserRole> All() {
        return repository.findAll();
    }
    
}
