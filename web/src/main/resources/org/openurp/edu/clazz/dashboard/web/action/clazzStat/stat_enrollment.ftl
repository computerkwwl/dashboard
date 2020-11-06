[#assign main]教学班规模[/#assign]
[#assign subject]按照${main}进行统计的门次数[/#assign]
[#assign title]<h3>[#if semester?exists]<span class="badge badge-primary" style="margin-left: 3px; margin-right: 3px">${semester.schoolYear}</span>学年度<span class="badge badge-primary" style="margin-left: 3px; margin-right: 3px">${semester.name}</span>学期[/#if]${subject}</h3>[/#assign]
{
  "title": {
    "html": "${title?js_string}",
    "main": "${main}",
    "subject": "${subject}",
    "description": "[#if semester?exists]${semester.schoolYear}学年度${semester.name}学期[/#if]"
  },
  "item": {
    "titles": [ "教学班规模", "门次数" ],
    "data": [
      [ "${Parameters.title}", "${clazzes?size}" ]
    ]
  },
  "desc": false,
  "description": ""
}
