class CreateCourses < ActiveRecord::Migration[6.1]
  def up
    create_table :courses do |t|
      t.string :title
      t.text :description
      t.decimal :price, precision: 8, scale: 2
      t.bigint :user_id

      t.timestamps
    end

    add_index :courses, :user_id
    add_foreign_key :courses, :users, column: :user_id
  end

  def down
    remove_foreign_key :courses, :users, column: :user_id
    remove_index :courses, :user_id
    drop_table :courses
  end
end
