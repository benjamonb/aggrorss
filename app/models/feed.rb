class Feed < ActiveRecord::Base
  has_many :feed_contents
  attr_accessor :news

  def self.fetch_parse_all
    Feed.all.each do |single_feed|
      single_feed.fetch_feed
      single_feed.parse_feed
    end
  end

  def fetch_feed
    @news = Feedjira::Feed.fetch_and_parse(self.url)
    @news = @news.entries
  end

  def parse_feed
    @news.each do |item|
      new_entry = {}
      new_entry[:title] = item.title
      new_entry[:link] = item.url
      new_entry[:time] = item.published
      new_entry[:summary] = item.summary if item.summary
      new_entry[:tags_by_origin] = item.categories if item.categories
      new_entry[:image] = item.image if item.image
      self.feed_contents.find_or_create_by(new_entry)
    end
  end

end
