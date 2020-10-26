package org.openurp.edu.clazz.dashboard.web.action

import org.beangle.data.dao.OqlBuilder
import org.beangle.data.model.Entity
import org.beangle.webmvc.api.view.View
import org.beangle.webmvc.entity.action.RestfulAction
import org.openurp.edu.base.model.Semester
import org.openurp.edu.clazz.model.Clazz
import org.openurp.edu.web.ProjectSupport

class DashboardEnrollmentAction extends RestfulAction[Clazz] with ProjectSupport {

  override def indexSetting(): Unit = {
    val from = get("from").getOrElse("0").toInt
    val to = get("to").getOrElse(s"${Integer.MAX_VALUE}").toInt
    val query = OqlBuilder.from(classOf[Clazz].getName, "c")
    addCondition(query)
    query.where("c.enrollment.actual between :from and :to", from, to)
    put("clazzes", entityDao.search(query))
  }

  private def addCondition[T <: Entity[_]](query: OqlBuilder[T]): Unit = {
    val semesterId = getInt("semester.id")
    semesterId match {
      case Some(value) => {
        val semester = entityDao.get(classOf[Semester], value)
        query.where("c.semester = :semester", semester)
        put("semester", semester)
      }
      case None        =>
    }
  }

  def items(): View = {
    val itemData = get("items").get.replace("enrollment", "c.enrollment")
    val query = OqlBuilder.from(classOf[Clazz].getName, "c")
    addCondition(query)
    query.select(itemData)
    put("items", entityDao.search(query))
    forward()
  }
}
