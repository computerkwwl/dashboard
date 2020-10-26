<div class="container" style="display:flex;justify-content:space-around;flex-wrap:wrap; width: 50%;float:left">
  [@b.card style="width:100%" class="card-info card-primary card-outline"]
    [@b.card_header]
      <h3>[#if semester?exists]<span class="badge badge-primary" style="margin-left: 3px; margin-right: 3px">${semester.schoolYear}</span>学年度<span class="badge badge-primary" style="margin-left: 3px; margin-right: 3px">${semester.name}</span>学期[/#if]各个学院（开课院系）的开课门次数</h3>
    [/@]
    [@b.card_body]
      <table class="table table-hover table-sm" style="width: 100%">
        <thead>
           <th>开课院系</th>
           <th>门次数</th>
        </thead>
        <tbody>
          [#list departments as department]
          <tr>
            <td>${department[0]}</td>
            <td>${department[1]}</td>
          </tr>
          [/#list]
        </tbody>
      </table>
    [/@]
  [/@]
</div>
