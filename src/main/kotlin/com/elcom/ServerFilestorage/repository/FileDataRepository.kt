package com.elcom.ServerFilestorage.repository

import com.elcom.ServerFilestorage.model.Device
import com.elcom.ServerFilestorage.model.FileData
import com.elcom.ServerFilestorage.model.Measure
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.query.Param

interface FileDataRepository: JpaRepository<FileData, Int> {
}