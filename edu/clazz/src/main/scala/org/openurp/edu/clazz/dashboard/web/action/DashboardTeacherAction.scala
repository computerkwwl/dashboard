package org.openurp.edu.clazz.dashboard.web.action

import org.beangle.data.dao.OqlBuilder
import org.beangle.webmvc.api.view.View
import org.beangle.webmvc.entity.action.RestfulAction
import org.openurp.code.job.model.ProfessionalTitle
import org.openurp.edu.base.model.{Semester, Teacher}
import org.openurp.edu.clazz.model.Clazz
import org.openurp.edu.web.ProjectSupport

import scala.collection.mutable._

class DashboardTeacherAction extends RestfulAction[Teacher] with ProjectSupport {

  override def indexSetting(): Unit = {
    val query = OqlBuilder.from(classOf[Teacher].getName, "t")
    val semesterId = getInt("semester.id")
    semesterId match {
      case Some(value) => {
        val semester = entityDao.get(classOf[Semester], value)
        query.where(s"exists (from ${classOf[Clazz].getName} c where c.semester = :semester and exists (from c.teachers ct where ct = t))", semester)
        put("semester", semester)
      }
      case None        => query.where(s"exists (from ${classOf[Clazz].getName} c where exists (from c.teachers ct where ct = t))")
    }
    query.where("t.title is not null")
    query.select("count(*)")
    put("sum", entityDao.search(query))
    query.groupBy("t.title.id, t.title.name")
    query.orderBy("t.title.name")
    query.select("t.title.name,count(*)")
    put("titles", entityDao.search(query))
  }

  def items(): View = {
    val itemData = get("items").get.replace("clazz", "c").replace("course", "c.course")
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
    query.join("c.teachers", "t")
    query.groupBy("t.title.id, t.title.name")
    query.orderBy("t.title.name")
    query.select(s"t.title.name,${itemData}")
    put("titles", entityDao.search(query))
    forward()
  }

  def teachers(): View = {
    val query1 = OqlBuilder.from[ProfessionalTitle](classOf[ProfessionalTitle].getName, "pt")
    query1.where(s"exists (from ${classOf[Teacher].getName} t where t.title = pt and exists (from ${classOf[Clazz].getName} c where exists (from c.teachers ct where ct = t)))")
    val titles = entityDao.search(query1)
    put("titles", titles)
    val titlesMap = Map[Int, ProfessionalTitle]()
    titles.foreach(title => titlesMap(title.id) = title)
    put("titlesMap", titlesMap)

    val itemData = get("teachers").get.split(",")
    itemData(0) = s"t.${itemData(0)}"
    itemData(1) = s"t.user.${itemData(1)}"
    itemData(2) = s"t.user.${itemData(2)}"
    val query2 = OqlBuilder.from(classOf[Clazz].getName, "c")
    val semesterId = getInt("semester.id")
    semesterId match {
      case Some(value) => {
        val semester = entityDao.get(classOf[Semester], value)
        query2.where("c.semester = :semester", semester)
        put("semester", semester)
      }
      case None        =>
    }
    query2.join("c.teachers", "t")
    query2.groupBy("t.title.id, t.title.name, t.id, t.user.name, t.user.department.id, t.user.department.name")
    query2.orderBy("t.title.name, count(*) desc")
    query2.select(itemData.mkString(","))
    put("titles", entityDao.search(query2))
    forward()
  }
}
