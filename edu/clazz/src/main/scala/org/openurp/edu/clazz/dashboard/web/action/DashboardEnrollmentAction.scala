package org.openurp.edu.clazz.dashboard.web.action

import org.beangle.data.dao.OqlBuilder
import org.beangle.webmvc.api.view.View
import org.beangle.webmvc.entity.action.RestfulAction
import org.openurp.edu.clazz.model.Clazz
import org.openurp.edu.web.ProjectSupport

class DashboardEnrollmentAction extends RestfulAction[Clazz] with ProjectSupport {

  override def indexSetting(): Unit = {
    val from = get("from").getOrElse("0").toInt
    val to = get("to").getOrElse(s"${Integer.MAX_VALUE}").toInt
    val query = OqlBuilder.from(classOf[Clazz].getName, "c")
    query.where("c.enrollment.actual between :from and :to", from, to)
    put("clazzes", entityDao.search(query))
  }

  def items(): View = {
    val itemData = get("items").get.replace("enrollment", "c.enrollment")
    val query = OqlBuilder.from(classOf[Clazz].getName, "c")
    query.select(itemData)
    put("items", entityDao.search(query))
    forward()
  }
}
