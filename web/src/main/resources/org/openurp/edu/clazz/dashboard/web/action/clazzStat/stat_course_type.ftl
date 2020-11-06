[#assign main]课程类别[/#assign]
[#assign subject]各个${main}的开课门次数[/#assign]
[#assign title]<h3>[#if semester?exists]<span class="badge badge-primary" style="margin-left: 3px; margin-right: 3px">${semester.schoolYear}</span>学年度<span class="badge badge-primary" style="margin-left: 3px; margin-right: 3px">${semester.name}</span>学期[/#if]${subject}</h3>[/#assign]
{
  "title": {
    "html": "${title?js_string}",
    "main": "${main}",
    "subject": "${subject}",
    "description": "[#if semester?exists]${semester.schoolYear}学年度${semester.name}学期[/#if]"
  },
  "item": {
    "titles": [ "课程类别", "门次数" ],
    "data": [
      [#list courseTypes as courseType]
      [ "${courseType[0]?js_string}", "${courseType[1]?js_string}" ][#if courseType_has_next], [/#if]
      [/#list]
    ]
  },
  "desc": false,
  "description": ""
}
