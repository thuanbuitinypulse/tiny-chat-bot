class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.bigint :user_id
      t.string :state

      t.timestamps null: false
    end
  end
end
