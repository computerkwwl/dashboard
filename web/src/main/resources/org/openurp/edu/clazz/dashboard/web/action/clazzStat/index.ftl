[@b.head/]
<div id="semester-area" v-html="semester"></div>
[#assign course_data_display = "数据加载中……"/]
<div id="course-data-display">${course_data_display}</div>
<script>
  $(function() {
    function init() {
      require([ "vue" ], function(Vue) {
        loadSemester(Vue);
      });
    }

    function loadSemester(Vue) {
      $.ajax({
        "type": "POST",
        "url": "${base}/clazz-stat!semester",
        "async": false,
        "dataType": "html",
        "success": function(data) {
          var conditionVM = new Vue({
            "el": "#semester-area",
            "data": {
              "semester": data
            }
          });
          var semesterObj = $("#" + conditionVM.$el.id);
          eval(semesterObj.find("script").text());
          var submitObj = semesterObj.find(":submit");
          submitObj.click(function() {
            $("#course-data-display").html("${course_data_display}");
            loadStatData(Vue, conditionVM);
          });
          submitObj.click();
        }
      });
    }

    function loadStatData(Vue, conditionVM) {
      setTimeout(function() {
        var course_stat_dic = {};
        course_stat_dic.params = {};
        course_stat_dic.params.semesterId = $("#" + conditionVM.$el.id).find("[name='semester.id']").val();
        loadStatData_itemList(course_stat_dic);
        loadStatData_displayTemplate(course_stat_dic);
        loadStatData_itemList_data(course_stat_dic);
        var displayObj = $("#course-data-display");
        displayObj.empty();
        for (var i = 0; i < course_stat_dic.itemList.length; i++) {
          var item = course_stat_dic.itemList[i];
          var template = course_stat_dic.templates[item.template];
          displayObj.append(template.template);
          var itemObj = displayObj.children().last();

          if ($.inArray(item.template, [ "pie" ]) >= 0) {
            if ("pie" == item.template) {
              itemObj.prop("id", item.id + "-echarts");

              var flagData = [];
              var fillData = [];
              for (var c = 0; c < item.data.item.data.length; c++) {
                var col = item.data.item.data[c];
                flagData.push(col[0]);
                fillData.push({ "name": col[0], "value": (col.length > 1 ? col[1] : 0) });
              }
              pie(itemObj.prop("id"), item.data.title.subject, item.data.title.description, item.data.title.main, flagData, fillData);
            }
          } else {
            var willKey = template.keyList;
            var fromKeys = Object.keys(item.data);
            var outputData = {};
            //outputData.id = "stat-" + item.id;
            for (var k = 0; k < willKey.length; k++) {
              outputData[willKey[k]] = item.data[fromKeys[k]];
            }
            console.log({ "outputData": outputData });
            itemObj.prop("id", "stat-" + item.id);
            new Vue({
              "el": "#" + itemObj.prop("id"),
              "data": outputData
            });
          }
        }
      }, 100);
    }

    function loadStatData_itemList(course_stat_dic) {
      $.ajax({
        "type": "POST",
        "url": "${base}/clazz-stat!statConfig",
        "async": false,
        "dataType": "json",
        "data": {
          "content": "params"
        },
        "success": function(data) {
          course_stat_dic.itemList = data;
        }
      });
    }

    function loadStatData_displayTemplate(course_stat_dic) {
      $.ajax({
        "type": "POST",
        "url": "${base}/clazz-stat!statConfig",
        "async": false,
        "dataType": "json",
        "data": {
          "content": "templates"
        },
        "success": function(data) {
          course_stat_dic.templates = data;
        }
      });
    }

    function loadStatData_itemList_data(course_stat_dic) {
      for (var i = 0; i < course_stat_dic.itemList.length; i++) {
        var item = course_stat_dic.itemList[i];
        if (item.limits || item.desc && $.inArray("method", Object.keys(item.desc)) >= 0 || item.display && $.inArray(item.display, [ "pie" ])) {
          if (item.limits || item.desc && $.inArray("method", Object.keys(item.desc)) >= 0) {
            var dataCollection = {};
            if (item.limits) {
              for (var l = 0; l < item.limits.length; l++) {
                var backData = $.extend({}, true, course_stat_dic.params);
                $.extend(backData, true, item.limits[l]);
                $.ajax({
                  "type": "POST",
                  "url": "${base}/clazz-stat!stat_" + item.id,
                  "async": false,
                  "dataType": "json",
                  "data": backData,
                  "success": function(data) {
                    dataCollection.title = data.title;
                    if (l == 0) {
                      dataCollection.item = {};
                    }
                    dataCollection.item.titles = data.item.titles;
                    if (l == 0) {
                      dataCollection.item.data = data.item.data;
                    } else {
                      dataCollection.item.data = dataCollection.item.data.concat(data.item.data);
                    }
                  },
                  "error": function(request, errMsg, exceptionObj) {
                    console.log({ "loadStatData_itemList_data": [request, errMsg, exceptionObj] });
                  }
                });
              }
            }
            if (item.desc && $.inArray("method", Object.keys(item.desc)) >= 0) {
              dataCollection.desc = true;
              var backData = $.extend({}, true, course_stat_dic.params);
              for (var d in item.desc) {
                if (d != "method") {
                  backData[d] = item.desc[d];
                }
              }
              $.ajax({
                "type": "POST",
                "url": "${base}/clazz-stat!stat_" + item.desc.method,
                "async": false,
                "dataType": "html",
                "data": backData,
                "success": function(data) {
                  dataCollection.description = data;
                }
              });
            } else {
              dataCollection.desc = false;
              dataCollection.description = "";
            }
            item.data = dataCollection;
          }
        } else {
          var backData = $.extend({}, true, course_stat_dic.params);
          if (item.desc) {
            for (var d in item.desc) {
              backData[d] = item.desc[d];
            }
          }
          $.ajax({
            "type": "POST",
            "url": "${base}/clazz-stat!stat_" + item.id,
            "async": false,
            "dataType": "json",
            "data": backData,
            "success": function(data) {
              item.data = data;
            },
            "error": function(request, errMsg, exceptionObj) {
              console.log({ "loadStatData_itemList_data": [request, errMsg, exceptionObj] });
            }
          });
        }
      }
    }

    function pie(id, subject, description, main, flagData, fillData) {
      require(["echarts"],function(echarts) {
        console.log({ "echarts": echarts });
        var dom = document.getElementById(id);
        var myChart = echarts.init(dom);
        var app = {};
        option = null;
        option = {
          title: {
              text: subject,
              subtext: description,
              left: 'center'
          },
          tooltip: {
            trigger: 'item',
            formatter: '{a} <br/>{b} : {c} ({d}%)'
          },
          legend: {
            orient: 'vertical',
            left: 'left',
            data: flagData
          },
          series: [
            {
              name: main,
              type: 'pie',
              radius: '55%',
              center: ['50%', '50%'],
              data: fillData,
              emphasis: {
                itemStyle: {
                  shadowBlur: 10,
                  shadowOffsetX: 0,
                  shadowColor: 'rgba(0, 0, 0, 0.5)'
                }
              }
            }
          ]
        };
        if (option && typeof option === "object") {
          myChart.setOption(option, true);
        }
      });
    }

    $(document).ready(function() {
      init();
    });
  });
</script>
[@b.foot/]
