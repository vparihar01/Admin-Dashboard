class Post < ActiveRecord::Base
	belongs_to :user

  #validates :title, :presence => true
  #NOTE Return the recently published visible post ordered by their publish date
  scope :recent, limit(10).order("created_at ASC")
end
