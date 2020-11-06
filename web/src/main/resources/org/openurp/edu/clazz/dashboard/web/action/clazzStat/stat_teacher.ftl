[#assign main]授课老师的职称[/#assign]
[#assign subject]${main}分布[/#assign]
[#assign title]<h3>[#if semester?exists]<span class="badge badge-primary" style="margin-left: 3px; margin-right: 3px">${semester.schoolYear}</span>学年度<span class="badge badge-primary" style="margin-left: 3px; margin-right: 3px">${semester.name}</span>学期[/#if]${subject}</h3>[/#assign]
[#assign second]总共<span class="badge badge-primary" style="margin-left: 3px; margin-right: 3px">${sum?first}</span>人[/#assign]
{
  "title": {
    "html": "${title?js_string}",
    "main": "${main}",
    "subject": "${subject}",
    "description": "[#if semester?exists]${semester.schoolYear}学年度${semester.name}学期[/#if]",
    "second": "${second?js_string}"
  },
  "item": {
    "titles": [ "授课教师职称", "门次数" ],
    "data": [
      [#list teacherTitles as teacherTitle]
      [ "${teacherTitle[0]?js_string}", "${teacherTitle[1]?js_string}" ][#if teacherTitle_has_next], [/#if]
      [/#list]
    ]
  },
  "desc": false,
  "description": ""
}
