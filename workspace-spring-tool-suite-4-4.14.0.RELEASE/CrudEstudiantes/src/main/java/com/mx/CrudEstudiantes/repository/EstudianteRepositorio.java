package com.mx.CrudEstudiantes.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mx.CrudEstudiantes.model.Estudiante;
@Repository
public interface EstudianteRepositorio extends JpaRepository<Estudiante, Long> {

}
