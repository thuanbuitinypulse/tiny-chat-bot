class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, :id => false do |t|
      t.bigint :id, primary_key: true
      t.string :first_name
      t.string :last_name
      t.boolean :active

      t.timestamps null: false
    end
  end
end
