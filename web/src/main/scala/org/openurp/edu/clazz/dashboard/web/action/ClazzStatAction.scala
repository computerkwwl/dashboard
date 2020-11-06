package org.openurp.edu.clazz.dashboard.web.action

import org.beangle.data.dao.OqlBuilder
import org.beangle.data.model.Entity
import org.beangle.webmvc.api.view.View
import org.openurp.code.job.model.ProfessionalTitle
import org.openurp.edu.base.model.{Semester, Teacher}
import org.openurp.edu.clazz.model.{Clazz, CourseTaker}

import scala.collection.mutable.Map

class ClazzStatAction extends ProjectRestfulAction[Clazz] {

  def semester(): View = {
    put("project", getProject)
    put("currentSemester", getCurrentSemester)
    forward()
  }

  def statConfig(): View = {
    val content = get("content") match {
      case Some(c) => s"_$c"
      case _       => ""
    }
    println(s"content=$content")
    forward(s"statConfig$content")
  }

  def stat_semester(): View = {
    val query = OqlBuilder.from(classOf[Clazz].getName, "c")
    addCondition(query)
    query.groupBy("c.semester.id,c.semester.schoolYear,c.semester.name")
    query.orderBy("c.semester.schoolYear desc,c.semester.name desc")
    query.select("c.semester.schoolYear,c.semester.name,count(*),count(distinct c.course.id)")
    put("semesters", entityDao.search(query))
    forward()
  }

  private def addCondition[T <: Entity[_]](query: OqlBuilder[T]): Unit = {
    val semesterId = getInt("semesterId")
    semesterId match {
      case Some(value) => {
        val semester = entityDao.get(classOf[Semester], value)
        query.where(s"${query.alias}.semester = :semester", semester)
        put("semester", semester)
      }
      case None        =>
    }
  }

  def stat_department(): View = {
    val query = OqlBuilder.from(classOf[Clazz].getName, "c")
    addCondition(query)
    query.groupBy("c.teachDepart.id,c.teachDepart.name")
    query.orderBy("c.teachDepart.name desc")
    query.select("c.teachDepart.name,count(*)")
    put("departments", entityDao.search(query))
    forward()
  }

  def stat_course_type(): View = {
    val query = OqlBuilder.from(classOf[Clazz].getName, "c")
    addCondition(query)
    query.groupBy("c.courseType.id,c.courseType.name")
    query.orderBy("c.courseType.name desc")
    query.select("c.courseType.name,count(*)")
    put("courseTypes", entityDao.search(query))
    forward()
  }

  def stat_enrollment(): View = {
    val from = get("from").getOrElse("0").toInt
    val to = get("to").getOrElse(s"${Integer.MAX_VALUE}").toInt
    val query = OqlBuilder.from(classOf[Clazz].getName, "c")
    addCondition(query)
    query.where("c.enrollment.actual between :from and :to", from, to)
    put("clazzes", entityDao.search(query))
    forward()
  }

  def stat_enrollment_items(): View = {
    val itemData = get("select").get.replace("enrollment", "c.enrollment")
    val query = OqlBuilder.from(classOf[Clazz].getName, "c")
    addCondition(query)
    query.select(itemData)
    put("items", entityDao.search(query))
    forward()
  }

  def stat_election_mode(): View = {
    val query = OqlBuilder.from(classOf[CourseTaker].getName, "ct")
    addCondition(query)
    query.groupBy("ct.electionMode.id,ct.electionMode.name")
    query.orderBy("ct.electionMode.name")
    query.select("ct.electionMode.name, count(*)")
    put("electionModes", entityDao.search(query))
    forward()
  }

  def stat_take_type(): View = {
    val query = OqlBuilder.from(classOf[CourseTaker].getName, "ct")
    addCondition(query)
    query.groupBy("ct.takeType.id,ct.takeType.name")
    query.orderBy("ct.takeType.name")
    query.select("ct.takeType.name, count(*)")
    put("takeTypes", entityDao.search(query))
    forward()
  }

  def stat_teacher(): View = {
    val query = OqlBuilder.from(classOf[Teacher].getName, "t")
    val semesterId = getInt("semesterId")
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
    put("teacherTitles", entityDao.search(query))
    forward()
  }

  def stat_teacher_detail(): View = {
    val itemData = get("select").get.replace("clazz", "c").replace("course", "c.course")
    val query = OqlBuilder.from(classOf[Clazz].getName, "c")
    addCondition(query)
    query.join("c.teachers", "t")
    query.groupBy("t.title.id, t.title.name")
    query.orderBy("t.title.name")
    query.select(s"t.title.name,$itemData")
    put("teacherTitles", entityDao.search(query))
    forward()
  }

  def stat_teachers(): View = {
    val query1 = OqlBuilder.from[ProfessionalTitle](classOf[ProfessionalTitle].getName, "pt")
    query1.where(s"exists (from ${classOf[Teacher].getName} t where t.title = pt and exists (from ${classOf[Clazz].getName} c where exists (from c.teachers ct where ct = t)))")
    val titles = entityDao.search(query1)
    val titlesMap = Map[Int, ProfessionalTitle]()
    titles.foreach(title => titlesMap(title.id) = title)
    put("titlesMap", titlesMap)

    val itemData = get("select").get.split(",")
    itemData(0) = s"t.${itemData(0)}"
    itemData(1) = s"t.user.${itemData(1)}"
    itemData(2) = s"t.user.${itemData(2)}"
    val query2 = OqlBuilder.from(classOf[Clazz].getName, "c")
    addCondition(query2)
    query2.join("c.teachers", "t")
    query2.groupBy("t.title.id, t.title.name, t.id, t.user.name, t.user.department.id, t.user.department.name")
    query2.orderBy("t.title.name, count(*) desc")
    query2.select(itemData.mkString(","))
    put("teacherTitles", entityDao.search(query2))
    forward()
  }
}
