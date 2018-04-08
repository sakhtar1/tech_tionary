class CreateTechs < ActiveRecord::Migration[5.1]
  def change
    create_table :techs do |t|
      t.string :title
      t.string :description
      t.integer :user_id
    end
  end
end
