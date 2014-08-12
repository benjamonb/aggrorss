class CreateFeedContents < ActiveRecord::Migration
  def change
    create_table :feed_contents do |t|
      t.string :title
      t.text :content
      t.timestamp :time
      t.string :tags
      t.string :link

      t.timestamps
    end
  end
end
