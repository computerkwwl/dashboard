[#assign main]修读类别[/#assign]
[#assign subject]${main}的分布[/#assign]
[#assign title]<h3>[#if semester?exists]<span class="badge badge-primary" style="margin-left: 3px; margin-right: 3px">${semester.schoolYear}</span>学年度<span class="badge badge-primary" style="margin-left: 3px; margin-right: 3px">${semester.name}</span>学期[/#if]${subject}</h3>[/#assign]
{
  "title": {
    "html": "${title?js_string}",
    "main": "${main}",
    "subject": "${subject}",
    "description": "[#if semester?exists]${semester.schoolYear}学年度${semester.name}学期[/#if]"
  },
  "item": {
    "titles": [ "修读类别", "人数" ],
    "data": [
      [#list takeTypes as takeType]
      [ "${takeType[0]?js_string}", "${takeType[1]?js_string}" ][#if takeType_has_next], [/#if]
      [/#list]
    ]
  },
  "desc": false,
  "description": ""
}
