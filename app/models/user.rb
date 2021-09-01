class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birth_date, presence: true

  validate :validate_age

  has_many :posts, dependent: :destroy
  has_many :followed_users, dependent: :destroy
  has_many :reacts, as: :reactable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  scope :not_followed_users, -> { where.not(id: [followed_users]) }

  private

  def validate_age
    return unless birth_date.present? && birth_date > 18.years.ago.to_date

    errors.add(:birth_date, 'You should be over 18 years old.')
  end
end
