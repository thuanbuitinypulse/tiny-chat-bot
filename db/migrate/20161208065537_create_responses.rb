class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :session_id
      t.string :response_type
      t.text :content

      t.timestamps null: false
    end
  end
end
