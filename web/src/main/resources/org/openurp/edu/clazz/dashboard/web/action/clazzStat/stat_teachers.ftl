[#assign main]教师职称[/#assign]
[#assign subject]各个${main}的开课门次数最多的前${Parameters.title}位[/#assign]
[#assign title]<h3>[#if semester?exists]<span class="badge badge-primary" style="margin-left: 3px; margin-right: 3px">${semester.schoolYear}</span>学年度<span class="badge badge-primary" style="margin-left: 3px; margin-right: 3px">${semester.name}</span>学期[/#if]${subject}</h3>[/#assign]
{
  "title": {
    "html": "${title?js_string}",
    "main": "${main}",
    "subject": "${subject}",
    "description": "[#if semester?exists]${semester.schoolYear}学年度${semester.name}学期[/#if]"
  },
  "item": {
    "titles": [ "姓名", "学院", "门次数" ],
    "data": [
      [#assign index = 0/]
      [#assign iTitle = ""/]
      [#assign count = Parameters.count?number]
      [#list teacherTitles as teacherTitle]
      [#if iTitle != teacherTitle[0]][#if index gt 0 && (iTitle != teacherTitle[0] || index gte count)] ] }, [/#if][#assign index = 0/][#assign iTitle = teacherTitle[0]/]{ "${teacherTitle[0]?js_string}": [[/#if][#if index lt count] [ "${teacherTitle[1]?js_string}", "${teacherTitle[2]?js_string}", "${teacherTitle[3]?js_string}" ][#if teacherTitle_has_next && index + 1 lt count && iTitle == teacherTitles[teacherTitle_index + 1][0]], [/#if][/#if][#assign index = index + 1/][#if !teacherTitle_has_next] ] }[/#if]
      [/#list]
    ]
  },
  "desc": false,
  "description": ""
}
