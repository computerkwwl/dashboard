[
  { "id": "semester", "template": "line" },
  { "id": "department", "template": "table" },
  { "id": "course_type", "template": "table" },
  { "id": "enrollment", "template": "table", "limits": [ { "from": 0, "to": 30, "title": "30人以下" }, { "from": 31, "to": 60, "title": "31～60人" }, { "from": 61, "to": 100, "title": "61～100人" }, { "from": 101, "to": 150, "title": "101～150人" }, { "from": 151, "title": "151人以上" } ], "desc": { "method": "enrollment_items", "select": "max(enrollment.actual),min(enrollment.actual)" } },
  { "id": "election_mode", "template": "pie" },
  { "id": "take_type", "template": "pie" },
  { "id": "teacher", "template": "table" },
  { "id": "teacher_detail", "template": "table", "desc": { "select": "count(clazz.id),avg(course.creditHours)" } },
  { "id": "teachers", "template": "multi_table", "desc": { "select": "title.name,name,department.name,count(*)", "count": 5, "title": "五" } }
]