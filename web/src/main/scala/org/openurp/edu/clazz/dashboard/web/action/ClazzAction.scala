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

import org.beangle.webmvc.api.view.View
import org.openurp.edu.base.model.Semester
import org.openurp.edu.clazz.model.Clazz

class ClazzAction extends ProjectRestfulAction[Clazz] {

  override def indexSetting(): Unit = {
    put("project", getProject)
    put("currentSemester", getCurrentSemester)
  }

  def display(): View = {
    val semesterId = getInt("semester.id")
    semesterId match {
      case Some(value) => {
        put("semester", entityDao.get(classOf[Semester], value))
      }
      case None        =>
    }
    forward()
  }
}
