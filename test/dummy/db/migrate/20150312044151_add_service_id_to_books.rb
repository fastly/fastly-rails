class AddServiceIdToBooks < ActiveRecord::Migration
  def change
    add_column :books, :service_id, :string
  end
end
