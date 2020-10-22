<div class="container" style="display:flex;justify-content:space-around;flex-wrap:wrap; width: 50%;float:left">
  [@b.card style="width:100%" class="card-info card-primary card-outline"]
    [@b.card_header]
      <h3>选课方式的分布</h3>
    [/@]
    [@b.card_body]
      <table class="table table-hover table-sm" style="width: 100%">
        <thead>
           <th>选课方式</th>
           <th>人数</th>
        </thead>
        <tbody>
          [#list electionModes as electionMode]
          <tr>
            <td>${electionMode[0]}</td>
            <td>${electionMode[1]}</td>
          </tr>
          [/#list]
        </tbody>
      </table>
    [/@]
  [/@]
</div>
