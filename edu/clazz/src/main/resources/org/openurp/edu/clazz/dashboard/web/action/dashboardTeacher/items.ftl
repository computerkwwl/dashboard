<div class="container" style="display:flex;justify-content:space-around;flex-wrap:wrap; width: 50%;float:left">
  [@b.card style="width:100%" class="card-info card-primary card-outline"]
    [@b.card_header]
      <h3>各个教师职称的开课门次数/平均课时</h3>
    [/@]
    [@b.card_body]
      <table class="table table-hover table-sm" style="width: 100%">
        <thead>
           <th>授课教师职称</th>
           <th>开课门次数</th>
           <th>平均课时</th>
        </thead>
        <tbody>
          [#list titles as title]
          <tr>
            <td>${title[0]}</td>
            <td>${title[1]}</td>
            <td>${title[2]}</td>
          </tr>
          [/#list]
        </tbody>
      </table>
    [/@]
  [/@]
</div>
