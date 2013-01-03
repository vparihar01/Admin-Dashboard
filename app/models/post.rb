class Post < ActiveRecord::Base
	belongs_to :user

  scope :recent, limit(10).order("created_at ASC")
end
