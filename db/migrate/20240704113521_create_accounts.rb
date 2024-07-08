class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.string :password,null: false

      t.timestamps
    end
  end
end
