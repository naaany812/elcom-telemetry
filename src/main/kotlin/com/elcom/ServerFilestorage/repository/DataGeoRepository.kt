package com.elcom.ServerFilestorage.repository

import com.elcom.ServerFilestorage.model.DataGeo
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.query.Param
import org.springframework.stereotype.Repository
import java.sql.Timestamp

@Repository
interface DataGeoRepository : JpaRepository<DataGeo, Int> {
    @Query(value = "select * from data_geo where" +
            "(time BETWEEN :startDate AND :endDate)" +
            " AND " +
            "uid = :deviceUid order by time",
            nativeQuery = true)
    open fun getRange(@Param("startDate")start: Timestamp?, @Param("endDate")end: Timestamp?, @Param("deviceUid")deviceUid: String?): List<DataGeo>
}