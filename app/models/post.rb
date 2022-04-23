class Post < ApplicationRecord
  belongs_to :end_user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :image

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :title, presence: true, length: {minimum: 1, maximum: 30 }
  validates :explanation, presence: true, length: {minimum: 1, maximum: 100 }
  validates :image, presence: true

  def favorited_by?(end_user)
    favorites.exists?(end_user_id: end_user.id)
  end

  def get_image(width,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/logo_transparent.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
end
