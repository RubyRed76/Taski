class ChangeDataTypeForStage < ActiveRecord::Migration
  def change
  	#We already have the column 'stage', just need to modify it
  	# change_column :(symbol for table name "projects"), "column name", "data type"
  	change_column :projects, :stage, :string
  end
end
