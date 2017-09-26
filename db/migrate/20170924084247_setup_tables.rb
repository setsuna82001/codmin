class SetupTables < ActiveRecord::Migration[5.1]
  def change
    create_table :contents do |t|
      # colmun
      t.string :title, null: false
      t.string :url
      t.string :img
      t.timestamps
      # index
      t.index :title
      t.index :url, unique: true
    end

    %i(tag author).each do |symbol|
      # master table
      create_table "mst_#{symbol}s".to_sym do |t|
        # colmun
        t.string :name, null: false
        t.timestamps
        # index
        t.index :name, unique: true
      end

      # relation table
      mst_colmun = "mst_#{symbol}_id".to_sym
      create_table "#{symbol}s".to_sym do |t|
        # colmun
        t.integer :content_id, null: false
        t.integer mst_colmun, null: false
        t.timestamps
        # index
        t.index :content_id
        t.index mst_colmun
      end
    end

  end
end
