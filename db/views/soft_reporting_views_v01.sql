SELECT
  reports.report_date AS daterecorded,
  reports.created_at AS dateentered,
  reports.updated_at AS datelastmod,
  departments.short_code AS location,
  reports.last_edit_by AS usercreated,
  reports.last_edit_by AS userlastmod,
  stats.code AS stat,
  reports.value as value
FROM reports
JOIN departments ON reports.department_id = departments.id
JOIN stats on reports.stat_id = stats.id