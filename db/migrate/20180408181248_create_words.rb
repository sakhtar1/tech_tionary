class CreateWords < ActiveRecord::Migration[5.1]
  def change
    create_table :words do |t|
     t.string :title
     t.string :description
     t.integer :user_id
   end
  end
end
