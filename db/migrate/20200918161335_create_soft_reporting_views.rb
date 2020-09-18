class CreateSoftReportingViews < ActiveRecord::Migration[6.0]
  def change
    create_view :soft_reporting_views
  end
end
