class AddNotNullConstraintsToZodiacs < ActiveRecord::Migration[7.0]
  def change
    change_column_null :zodiacs, :name, false
    change_column_null :zodiacs, :start_date, false
    change_column_null :zodiacs, :end_date, false
  end
end
