package com.elcom.ServerFilestorage.repository

import com.elcom.ServerFilestorage.model.Device
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface DeviceRepository : JpaRepository<Device,Int>{

}
