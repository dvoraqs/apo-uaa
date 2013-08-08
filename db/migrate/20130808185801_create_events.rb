class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :google_id
      t.string :facebook_id
      t.string :google_link
      t.string :facebook_link
      t.string :updated_at
      t.string :title
      t.text :description
      t.string :location
      t.string :start
      t.string :end
      t.string :service_area
      t.string :status
    end
  end
end
