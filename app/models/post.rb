class Post < ApplicationRecord
	belongs_to :user
	has_many :comments
	mount_uploader :photo, PhotoUploader
	def user_photo
		user.photo
	end

	def user_name
		user.name
	end
	validates :photo, :description, :user_id, presence: true
	acts_as_votable
	delegate :photo, :name, to: :user, prefix: true 
end
