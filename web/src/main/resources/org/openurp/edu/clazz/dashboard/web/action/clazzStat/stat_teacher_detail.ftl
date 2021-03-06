[#assign main]教师职称[/#assign]
[#assign subject]各个${main}的开课门次数/平均课时[/#assign]
[#assign title]<h3>[#if semester?exists]<span class="badge badge-primary" style="margin-left: 3px; margin-right: 3px">${semester.schoolYear}</span>学年度<span class="badge badge-primary" style="margin-left: 3px; margin-right: 3px">${semester.name}</span>学期[/#if]${subject}</h3>[/#assign]
{
  "title": {
    "html": "${title?js_string}",
    "main": "${main}",
    "subject": "${subject}",
    "description": "[#if semester?exists]${semester.schoolYear}学年度${semester.name}学期[/#if]"
  },
  "item": {
    "titles": [ "授课教师职称", "开课门次数", "平均课时" ],
    "data": [
      [#list teacherTitles as teacherTitle]
      [ "${teacherTitle[0]?js_string}", "${teacherTitle[1]?js_string}", "${teacherTitle[2]?js_string}" ][#if teacherTitle_has_next], [/#if]
      [/#list]
    ]
  },
  "desc": false,
  "description": ""
}
