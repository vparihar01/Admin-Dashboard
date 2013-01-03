class Post < ActiveRecord::Base
	belongs_to :user

  #NOTE Return the recently published visible post ordered by their publish date
  scope :recent, limit(10).order("created_at ASC")
end
