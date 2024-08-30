class CreatePermissions < ActiveRecord::Migration[7.0]
  def change
    create_table :permissions do |t|
      t.string :name
      t.text :description
      t.string :action
      t.string :subject_class

      t.timestamps
    end
  end
end
