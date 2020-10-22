package org.openurp.edu.clazz.dashboard.web.action

import org.beangle.data.dao.OqlBuilder
import org.beangle.webmvc.entity.action.RestfulAction
import org.openurp.edu.clazz.model.Clazz
import org.openurp.edu.web.ProjectSupport

class DashboardDepartmentAction extends RestfulAction[Clazz] with ProjectSupport {

  override def indexSetting(): Unit = {
    val query = OqlBuilder.from(classOf[Clazz].getName, "c")
    query.groupBy("c.teachDepart.id,c.teachDepart.name")
    query.orderBy("c.teachDepart.name desc")
    query.select("c.teachDepart.name,count(*)")
    put("departments", entityDao.search(query))
  }
}
