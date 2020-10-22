/*
 * OpenURP, Agile University Resource Planning Solution.
 *
 * Copyright © 2014, The OpenURP Software.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful.
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package org.openurp.edu.clazz.dashboard.web.action

import org.beangle.data.dao.OqlBuilder
import org.beangle.webmvc.entity.action.RestfulAction
import org.openurp.edu.clazz.model.Clazz
import org.openurp.edu.web.ProjectSupport

class DashboardSemesterAction extends RestfulAction[Clazz] with ProjectSupport {

  override def indexSetting(): Unit = {
    val query = OqlBuilder.from(classOf[Clazz].getName, "c")
    query.groupBy("c.semester.id,c.semester.schoolYear,c.semester.name")
    query.orderBy("c.semester.schoolYear desc,c.semester.name desc")
    query.select("c.semester.schoolYear,c.semester.name,count(*),count(distinct c.course.id)")
    put("semesters", entityDao.search(query))
  }
}
