package com.elcom.ServerFilestorage.repository

import com.elcom.ServerFilestorage.model.FileData
import org.springframework.data.jpa.repository.JpaRepository

interface FileDataRepository: JpaRepository<FileData, Int> {
}