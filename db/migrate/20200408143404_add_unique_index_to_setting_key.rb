class AddUniqueIndexToSettingKey < ActiveRecord::Migration[6.0]
  def change
    add_index :settings, :key, unique: true
  end
end
