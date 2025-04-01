package com.mx.CrudEstudiantes.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mx.CrudEstudiantes.model.Estudiante;
import com.mx.CrudEstudiantes.repository.EstudianteRepositorio;

@Service
public class EstudianteServiceImpl implements EstudianteService{
	@Autowired
	private EstudianteRepositorio estudianteRepositorio;
	
	@Override
	public List<Estudiante> findEstudianteAll() {
		return estudianteRepositorio.findAll();
	}
	@Override
	public Estudiante createEstudiante(Estudiante estudiante) {
		return estudianteRepositorio.saveAndFlush(estudiante);
	}
	@Override
	public Estudiante updateEstudiante(Estudiante estudiante) {
		
		return estudianteRepositorio.save(estudiante);
	}
	@Override
	public void deleteEstudiante(Long id) {
		estudianteRepositorio.deleteById(id);
	}
	@Override
	public Optional<Estudiante> getEstudiante(Long id) {
		return estudianteRepositorio.findById(id);
	}
}
