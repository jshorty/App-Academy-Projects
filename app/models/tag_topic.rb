class TagTopic < ActiveRecord::Base

  has_many :taggings,
    class_name: "Tagging",
    foreign_key: :tag_topic_id,
    primary_key: :id

  has_many :links, through: :taggings, source: :shortened_url

  has_many :visits, through: :links, source: :visits

  def most_tagged
    link_counts = links.group(:long_url).count
    link_counts.key(link_counts.values.max)
  end

end


# SELECT
#   shortened_url.*
# FROM
#   tag_topics
#   JOIN taggings
#   ON tag_topic.id = taggings.tag_topic_id
#   JOIN shortened_urls
#   ON taggings.shortened_url_id = shortened_url.id
#   JOIN visits
#   ON shortened_url.id = visits.url_id
# WHERE
#   tag_topic.id = 1
# GROUP BY
#   shortened_url.long_url
# ORDER BY
#   COUNT(shortened_url.long_url) DESC
# LIMIT 1
