<div class="container" style="display:flex;justify-content:space-around;flex-wrap:wrap; width: 50%;float:left">
  [@b.card style="width:100%" class="card-info card-primary card-outline"]
    [@b.card_header]
      <h3>[#if semester?exists]<span class="badge badge-primary" style="margin-left: 3px; margin-right: 3px">${semester.schoolYear}</span>学年度<span class="badge badge-primary" style="margin-left: 3px; margin-right: 3px">${semester.name}</span>学期[/#if]各个教师职称开课门次数最多的前${Parameters.title}位</h3>
    [/@]
    [@b.card_body]
      [#assign index = 0/]
      [#assign iTitle = ""/]
      [#assign count = Parameters.count?number]
      [#list titles as title]
        [#if iTitle != title[0]]
          [#if index gt 0 && index lt count]
                </tbody>
              </table>
            </div>
          </div>
          [/#if]
          [#assign index = 0/]
          [#assign iTitle = title[0]/]
          <div class="card card-info card-primary card-outline" style="width:100%">
            <div class="card-header">
              <h5>${title[0]}</h5>
            </div>
            <div class="card-body">
              <table class="table table-hover table-sm" style="width: 100%">
                <thead>
                   <th>姓名</th>
                   <th>学院</th>
                   <th>门次数</th>
                </thead>
                <tbody>
        [/#if]
        [#if index lt count]
                  <tr>
                    <td>${title[1]}</td>
                    <td>${title[2]}</td>
                    <td>${title[3]}</td>
                  </tr>
        [/#if]
        [#assign index = index + 1/]
        [#if index == count || !title_has_next]
                </tbody>
              </table>
            </div>
          </div>
        [/#if]
      [/#list]
    [/@]
  [/@]
</div>
