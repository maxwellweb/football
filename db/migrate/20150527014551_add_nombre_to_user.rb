class AddNombreToUser < ActiveRecord::Migration
  def change
    add_column :users, :primer_nombre, :string
    add_column :users, :primer_apellido, :string
    add_column :users, :nombre_perfil, :string
  end
end
