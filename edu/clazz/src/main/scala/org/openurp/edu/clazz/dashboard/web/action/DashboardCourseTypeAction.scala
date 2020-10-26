package org.openurp.edu.clazz.dashboard.web.action

import org.beangle.data.dao.OqlBuilder
import org.beangle.webmvc.entity.action.RestfulAction
import org.openurp.edu.base.model.Semester
import org.openurp.edu.clazz.model.Clazz
import org.openurp.edu.web.ProjectSupport

class DashboardCourseTypeAction extends RestfulAction[Clazz] with ProjectSupport {

  override def indexSetting(): Unit = {
    val query = OqlBuilder.from(classOf[Clazz].getName, "c")
    val semesterId = getInt("semester.id")
    semesterId match {
      case Some(value) => {
        val semester = entityDao.get(classOf[Semester], value)
        query.where("c.semester = :semester", semester)
        put("semester", semester)
      }
      case None        =>
    }
    query.groupBy("c.courseType.id,c.courseType.name")
    query.orderBy("c.courseType.name desc")
    query.select("c.courseType.name,count(*)")
    put("courseTypes", entityDao.search(query))
  }
}
