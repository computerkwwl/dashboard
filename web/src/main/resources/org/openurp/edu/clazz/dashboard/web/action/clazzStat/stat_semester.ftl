[#assign display]当前选择的是<span class="badge badge-primary" style="margin-left: 3px; margin-right: 3px">${semesters?first[0]}</span>学年度<span class="badge badge-primary" style="margin-left: 3px; margin-right: 3px">${semesters?first[1]}</span>学期，开课门次数为<span class="badge badge-primary" style="margin-left: 3px; margin-right: 3px">${semesters?first[2]}</span>，门数为<span class="badge badge-primary" style="margin-left: 3px; margin-right: 3px">${semesters?first[3]}</span>。[/#assign]
{
  "display": "${display?js_string}"
}
