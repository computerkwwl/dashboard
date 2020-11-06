[#assign line]
<div style="display:flex;margin-left: 10px;margin-right: 10px;justify-content:space-around;flex-wrap:wrap">
  [@b.card style="width:100%" class="card-info card-primary card-outline"]
    <div style="margin-left: 10px; font-size: 12pt;" v-html="line"><div>
  [/@]
</div>
[/#assign]
[#assign table]
<div class="container" style="display:flex;justify-content:space-around;flex-wrap:wrap; width: 50%;float:left">
  [@b.card style="width:100%" class="card-info card-primary card-outline"]
    [@b.card_header]
      <h3 v-html="title.html" style="float: left"></h3>
      <span v-if="title.second" style="position: relative;top: 13px;margin-left: 3px;margin-right: 3px;" v-html="title.second"></span>
    [/@]
    [@b.card_body]
      <table class="table table-hover table-sm" style="width: 100%">
        <thead>
          <th v-for="colTitle in item.titles">{{ colTitle }}</th>
        </thead>
        <tbody>
          <tr v-for="data in item.data">
            <td v-for="iData in data">{{ iData }}</td>
          </tr>
        </tbody>
      </table>
      <div v-if="desc" v-html="description"></div>
    [/@]
  [/@]
</div>
[/#assign]
[#assign pie][#--饼图--]
<div style="float:left;width:50%;height:400px"></div>
[/#assign]
[#assign multi_table]
<div class="container" style="display:flex;justify-content:space-around;flex-wrap:wrap; width: 50%;float:left">
  [@b.card style="width:100%" class="card-info card-primary card-outline"]
    [@b.card_header]
      <h3 v-html="title.html" style="float: left"></h3>
      <span v-if="title.second" style="position: relative;top: 13px;margin-left: 3px;margin-right: 3px;" v-html="title.second"></span>
    [/@]
    [@b.card_body]
      <div v-for="group in item.data" class="card card-info card-primary card-outline" style="width:100%">
        <div class="card-header">
          <h5>{{ Object.keys(group)[0] }}</h5>
        </div>
        <div class="card-body">
          <table class="table table-hover table-sm" style="width: 100%">
            <thead>
              <th v-for="colTitle in item.titles">{{ colTitle }}</th>
            </thead>
            <tbody>
              <tr v-for="dataLine in group[Object.keys(group)[0]]">
                <td v-for="iData in dataLine">{{ iData }}</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
      <div v-if="desc" v-html="description"></div>
    [/@]
  [/@]
</div>
[/#assign]
{
  "line": {
    "template": "${line?js_string}",
    "keyList": [ "line" ]
  },
  "table": {
    "template": "${table?js_string}",
    "keyList": [ "title", "item", "desc", "description" ]
  },
  "pie": {
    "template": "${pie?js_string}"
  },
  "multi_table": {
    "template": "${multi_table?js_string}",
    "keyList": [ "title", "item", "desc", "description" ]
  }
}
