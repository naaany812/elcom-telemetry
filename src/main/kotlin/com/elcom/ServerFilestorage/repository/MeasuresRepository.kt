package com.elcom.ServerFilestorage.repository

import com.elcom.ServerFilestorage.model.Measure
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.query.Param
import org.springframework.stereotype.Repository
import java.sql.Date
import java.time.OffsetDateTime




@Repository
interface MeasuresRepository: JpaRepository<Measure, Int> {
  //  fun findByDate
  @Query(value = "select * from measures  where (date BETWEEN :startDate AND :endDate) AND system_id = :systemId order by time_day", nativeQuery = true)
  open fun getRangeForSystem(@Param("startDate")start: Date?, @Param("endDate")end: Date?, @Param("systemId")systemId: Int?): List<Measure>
}