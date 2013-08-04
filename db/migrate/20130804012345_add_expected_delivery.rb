class AddExpectedDelivery < ActiveRecord::Migration
  def change
    add_column :restaurants, :delivery_expected, :boolean, :default => false
  end
end
