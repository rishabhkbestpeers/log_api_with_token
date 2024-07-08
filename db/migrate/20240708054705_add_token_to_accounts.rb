class AddTokenToAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :token, :string
  end
end
