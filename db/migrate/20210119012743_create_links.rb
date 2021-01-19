class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.string :code
      t.string :origin_url
      t.string :obfuscated_code
      t.integer :use_count, default: 0
      t.datetime :expired_at
      t.timestamps
    end
    add_index :links, :code, unique: true
  end
end
