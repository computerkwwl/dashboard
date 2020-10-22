<div class="container" style="display:flex;justify-content:space-around;flex-wrap:wrap; width: 50%;float:left">
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
