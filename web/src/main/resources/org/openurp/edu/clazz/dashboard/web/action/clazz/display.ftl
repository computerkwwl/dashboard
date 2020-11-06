<div id="semester" class="dashboard" params="semester.id:${Parameters["semester.id"]}"></div>
<div id="department" class="dashboard" params="semester.id:${Parameters["semester.id"]}"></div>
<div id="course-type" class="dashboard" params="semester.id:${Parameters["semester.id"]}"></div>
<div class="container" style="display:flex;justify-content:space-around;flex-wrap:wrap; width: 50%;float:left">
  [@b.card style="width:100%; padding-left: 10px" class="card-info card-primary card-outline"]
    [@b.card_header]
      <h3>[#if semester?exists]<span class="badge badge-primary" style="margin-left: 3px; margin-right: 3px">${semester.schoolYear}</span>学年度<span class="badge badge-primary" style="margin-left: 3px; margin-right: 3px">${semester.name}</span>学期[/#if]按照教学班规模进行统计的门次数</h3>
    [/@]
    <table class="table table-hover table-sm">
      <thead>
        <tr>
          <th>教学班规模</th>
          <th>门次数</th>
        </tr>
      </thead>
      <tbody>
        <tr id="enrollment" class="dashboard" params="semester.id:${Parameters["semester.id"]};from:0;to:30;title:30人以下"></tr>
        <tr id="enrollment" class="dashboard" params="semester.id:${Parameters["semester.id"]};from:31;to:60;title:31～60人"></tr>
        <tr id="enrollment" class="dashboard" params="semester.id:${Parameters["semester.id"]};from:61;to:100;title:61～100人"></tr>
        <tr id="enrollment" class="dashboard" params="semester.id:${Parameters["semester.id"]};from:101;to:150;title:101～150人"></tr>
        <tr id="enrollment" class="dashboard" params="semester.id:${Parameters["semester.id"]};from:151;title:151人以上"></tr>
      </tbody>
    </table>
    <div id="enrollment" class="dashboard" method="items:max(enrollment.actual),min(enrollment.actual)" params="semester.id:${Parameters["semester.id"]}"></div>
  [/@]
</div>
<div id="election-mode" class="dashboard" params="semester.id:${Parameters["semester.id"]};display:pie"></div>
<div id="take-type" class="dashboard" params="semester.id:${Parameters["semester.id"]};display:pie"></div>
<div id="teacher" class="dashboard" params="semester.id:${Parameters["semester.id"]}"></div>
<div id="teacher" class="dashboard" method="items:count(clazz.id),avg(course.creditHours)" params="semester.id:${Parameters["semester.id"]}"></div>
<div id="teacher" class="dashboard" method="teachers:title.name,name,department.name,count(*)" params="count:5;title:五;semester.id:${Parameters["semester.id"]}"></div>
<script>
  $(document).ready(function() {
    $(".dashboard").each(function() {
      var thisObj = $(this);
      var dataMap = {};
      var params = thisObj.attr("params");
      if (params) {
        var paramsData = params.split(";");
        for (var i = 0; i < paramsData.length; i++) {
          var paramData = paramsData[i].split(":");
          dataMap[paramData[0]] = paramData[1];
        }
      }
      var m = "index";
      var method = thisObj.attr("method");
      if (method) {
        var methodData = method.split(":");
        m = methodData[0]
        dataMap[m] = methodData[1];
      }
      $.ajax({
        "type": "POST",
        "url": "${base}/dashboard-" + thisObj.prop("id") + "!" + m,
        "async": true,
        "dataType": "html",
        "data": dataMap,
        "success": function(data) {
          thisObj.after(data);
          thisObj.remove();
        }
      });
    });
  });
</script>
