package com.elcom.ServerFilestorage.repository

import com.elcom.ServerFilestorage.model.DataClimate
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.query.Param
import org.springframework.stereotype.Repository
import java.sql.Timestamp

@Repository
interface DataClimateRepository : JpaRepository<DataClimate, Int> {
    @Query(value = "select * from data_climate  where" +
            "(time BETWEEN :startDate AND :endDate)" +
            " AND " +
            "uid = :deviceUid order by time",
            nativeQuery = true)
    open fun getRange(@Param("startDate")start: Timestamp?, @Param("endDate")end: Timestamp?, @Param("deviceUid")deviceUid: String?): List<DataClimate>
}