package com.elcom.ServerFilestorage.repository

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface SystemRepository: JpaRepository<com.elcom.ServerFilestorage.model.System, Int> {
}