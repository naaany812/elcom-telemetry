package com.elcom.ServerFilestorage.repository

import com.elcom.ServerFilestorage.model.Measure
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface MeasuresRepository: JpaRepository<Measure, Int> {
}