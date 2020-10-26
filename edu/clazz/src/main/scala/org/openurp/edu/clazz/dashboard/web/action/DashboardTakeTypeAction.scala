package org.openurp.edu.clazz.dashboard.web.action

import org.beangle.data.dao.OqlBuilder
import org.beangle.webmvc.entity.action.RestfulAction
import org.openurp.edu.base.model.Semester
import org.openurp.edu.clazz.model.CourseTaker
import org.openurp.edu.web.ProjectSupport

class DashboardTakeTypeAction extends RestfulAction[CourseTaker] with ProjectSupport {

  override def indexSetting(): Unit = {
    val query = OqlBuilder.from(classOf[CourseTaker].getName, "ct")
    val semesterId = getInt("semester.id")
    semesterId match {
      case Some(value) => {
        val semester = entityDao.get(classOf[Semester], value)
        query.where("ct.semester = :semester", semester)
        put("semester", semester)
      }
      case None        =>
    }
    query.groupBy("ct.takeType.id,ct.takeType.name")
    query.orderBy("ct.takeType.name")
    query.select("ct.takeType.name, count(*)")
    put("takeTypes", entityDao.search(query))
  }
}
