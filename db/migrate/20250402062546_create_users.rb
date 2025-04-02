class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :emp_id
      t.string :email
      t.string :username
      t.integer :role_id
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
