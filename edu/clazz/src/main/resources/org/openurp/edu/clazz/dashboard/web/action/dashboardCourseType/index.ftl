<div class="container" style="display:flex;justify-content:space-around;flex-wrap:wrap; width: 50%;float:left">
  [@b.card style="width:100%" class="card-info card-primary card-outline"]
    [@b.card_header]
      <h3>各个课程类别的开课门次数</h3>
    [/@]
    [@b.card_body]
      <table class="table table-hover table-sm" style="width: 100%">
        <thead>
           <th>课程类别</th>
           <th>门次数</th>
        </thead>
        <tbody>
          [#list courseTypes as courseType]
          <tr>
            <td>${courseType[0]}</td>
            <td>${courseType[1]}</td>
          </tr>
          [/#list]
        </tbody>
      </table>
    [/@]
  [/@]
</div>
