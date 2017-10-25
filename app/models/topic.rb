class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  mount_uploader :picture, PictureUploader
  validates  :content, length: { maximum: 140 }
end
