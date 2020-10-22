[@b.head/]
  <div style="height: 5px"></div>
  <div id="semester" class="dashboard"></div>
  <div id="department" class="dashboard"></div>
  <div id="course-type" class="dashboard"></div>
  <div id="enrollment" class="dashboard" params="from:0;to:30;title:30人以下"></div>
  <div id="enrollment" class="dashboard" params="from:31;to:60;title:31～60人"></div>
  <div id="enrollment" class="dashboard" params="from:61;to:100;title:61～100人"></div>
  <div id="enrollment" class="dashboard" params="from:101;to:150;title:101～150人"></div>
  <div id="enrollment" class="dashboard" params="from:150;title:150人以上"></div>
  <div id="enrollment" class="dashboard" method="items:max(enrollment.actual),min(enrollment.actual)"></div>
  <div id="election-mode" class="dashboard"></div>
  <div id="teacher" class="dashboard"></div>
  <div id="teacher" class="dashboard" method="items:count(clazz.id),avg(course.creditHours)"></div>
  <div id="teacher" class="dashboard" method="teachers:title.name,name,department.name,count(*)" params="count:5;title:五"></div>
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
[@b.foot/]
