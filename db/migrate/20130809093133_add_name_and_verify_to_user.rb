class AddNameAndVerifyToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.belongs_to :user
      t.string :name
      t.string :status
    end
  end
end
