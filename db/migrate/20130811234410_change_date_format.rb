class ChangeDateFormat < ActiveRecord::Migration
  def change
  	change_table :events do |t|
  		t.remove :start
  		t.remove :end
  		t.remove :updated_at
      t.datetime :start
      t.datetime :end
      t.timestamps
     end
  end
end
