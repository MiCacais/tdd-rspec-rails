class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.string :smoker
      t.string :phone
      t.string :avatar

      t.timestamps null: false
    end
  end
end
