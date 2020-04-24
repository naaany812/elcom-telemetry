package com.elcom.ServerFilestorage.repository

import com.elcom.ServerFilestorage.model.Device
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.query.Param
import org.springframework.stereotype.Repository
import java.sql.Date

@Repository
interface DeviceRepository : JpaRepository<Device, Int> {
    @Query(value = "select * from devices  where system_id = :trainId order by car_number desc", nativeQuery = true)
    fun getDevicesFromTrain(@Param("trainId") trainId: Int?) : List<Device>
    @Query(value = "select * from devices  where train_id = :trainId and device_hw_id = device_hw_head_id order by car_number", nativeQuery = true)
    fun getHeadDevicesFromTrain(@Param("trainId") trainId: Int?) : List<Device>
    @Query(value = "select * from devices  where device_uid = :uid", nativeQuery = true)
    fun getFirstDeviceByUid(@Param("uid") uid: String?) : Device

}
