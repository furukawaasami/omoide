class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_many :posts, dependent: :destroy
    has_many :post_comments, dependent: :destroy
    has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
    has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
    has_many :followings, through: :relationships, source: :followed
    has_many :followers, through: :reverse_of_relationships, source: :follower
    has_many :favorites, dependent: :destroy
        # フォローしたときの処理
    def follow(end_user_id)
        relationships.create(followed_id: end_user_id)
    end
    # フォローを外すときの処理
    def unfollow(end_user_id)
        relationships.find_by(followed_id: end_user_id).destroy
    end
    # フォローしているか判定
    def following?(end_user)
        followings.include?(end_user)
    end

    def active_for_authentication?
      super && (is_deleted == false)
    end

    def self.guest
      find_or_create_by!(nickname: 'ゲスト' ,email: 'guest@example.com') do |end_user|
      end_user.password = SecureRandom.urlsafe_base64
      end_user.nickname = "ゲスト"
     end
    end
end
