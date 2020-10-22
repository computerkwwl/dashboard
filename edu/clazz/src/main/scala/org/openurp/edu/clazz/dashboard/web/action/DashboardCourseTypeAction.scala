package org.openurp.edu.clazz.dashboard.web.action

import org.beangle.data.dao.OqlBuilder
import org.beangle.webmvc.entity.action.RestfulAction
import org.openurp.edu.clazz.model.Clazz
import org.openurp.edu.web.ProjectSupport

class DashboardCourseTypeAction extends RestfulAction[Clazz] with ProjectSupport {

  override def indexSetting(): Unit = {
    val query = OqlBuilder.from(classOf[Clazz].getName, "c")
    query.groupBy("c.courseType.id,c.courseType.name")
    query.orderBy("c.courseType.name desc")
    query.select("c.courseType.name,count(*)")
    put("courseTypes", entityDao.search(query))
  }
}
