class AddIndexToPagesName < ActiveRecord::Migration
  def change
  	add_index :pages, :name, unique: true
  end
end
