[#if semesters?size gt 1]
  <div class="container" style="display:flex;justify-content:space-around;flex-wrap:wrap">
    [@b.card style="width:100%" class="card-info card-primary card-outline"]
      [@b.card_header]
        <h3>每学期开课的门次数/门数</h3>
      [/@]
      [@b.card_body]
        <table class="table table-hover table-sm" style="width: 100%">
          <thead>
             <th>学年度</th>
             <th>学期</th>
             <th>门次数</th>
             <th>门数</th>
          </thead>
          <tbody>
            [#list semesters as semester]
            <tr>
              <td>${semester[0]}</td>
              <td>${semester[1]}</td>
              <td>${semester[2]}</td>
              <td>${semester[3]}</td>
            </tr>
            [/#list]
          </tbody>
        </table>
      [/@]
    [/@]
  </div>
[#else]
  <div style="display:flex;margin-left: 10px;margin-right: 10px;justify-content:space-around;flex-wrap:wrap">
    [@b.card style="width:100%" class="card-info card-primary card-outline"]
      <div style="margin-left: 10px; font-size: 12pt;">当前选择的是<span class="badge badge-primary" style="margin-left: 3px; margin-right: 3px">${semesters?first[0]}</span>学年度<span class="badge badge-primary" style="margin-left: 3px; margin-right: 3px">${semesters?first[1]}</span>学期，开课门次数为<span class="badge badge-primary" style="margin-left: 3px; margin-right: 3px">${semesters?first[2]}</span>，门数为<span class="badge badge-primary" style="margin-left: 3px; margin-right: 3px">${semesters?first[3]}</span>。<div>
    [/@]
  </div>
[/#if]
