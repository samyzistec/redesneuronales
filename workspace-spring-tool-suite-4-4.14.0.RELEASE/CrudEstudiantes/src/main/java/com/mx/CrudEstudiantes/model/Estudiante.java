package com.mx.CrudEstudiantes.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;

@EqualsAndHashCode(callSuper=false)
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Getter
@Data
@Table(name="TBL_ESTUDIANTES")
public class Estudiante{
        @Id
        @Column(name = "ID")
        @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seqEstudiantes")
        @SequenceGenerator(name = "seqEstudiantes", allocationSize = 1, sequenceName = "SEQ_ESTUDIANTES")
        @Builder.Default
        Long id=0L;
        @NotNull @NotBlank
        String nombres;
        @NotNull @NotBlank
        String apellidos;
        Integer edad;
        @NotBlank(message = "Direccion es requerida")
        @Size(min = 5, max = 50)
        String direccion;
        String ciudad;
        String pais;
	
}
