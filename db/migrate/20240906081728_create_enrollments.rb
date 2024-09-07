class CreateEnrollments < ActiveRecord::Migration[6.1]
  def up
    create_table :enrollments do |t|
      t.string :discription
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :enrollments
  end
end
