class AddRecurrenceAndEventCreator < ActiveRecord::Migration
  def change
  	change_table :events do |t|
      t.string :recurrence_rule
      t.datetime :recurs_until
      t.belongs_to :user
     end
  end
end