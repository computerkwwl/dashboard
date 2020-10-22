package org.openurp.edu.clazz.dashboard.web.action

import org.beangle.data.dao.OqlBuilder
import org.beangle.webmvc.entity.action.RestfulAction
import org.openurp.edu.clazz.model.CourseTaker
import org.openurp.edu.web.ProjectSupport

class DashboardElectionModeAction extends RestfulAction[CourseTaker] with ProjectSupport {

  override def indexSetting(): Unit = {
    val query = OqlBuilder.from(classOf[CourseTaker].getName, "ct")
    query.groupBy("ct.electionMode.id,ct.electionMode.name")
    query.orderBy("ct.electionMode.name")
    query.select("ct.electionMode.name, count(*)")
    put("electionModes", entityDao.search(query))
  }
}
