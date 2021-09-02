class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true,
                    length: { minimum: 5 }
  validates :content, presence: true,
                      length: { minimum: 10 }

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :reacts, as: :reactable, dependent: :destroy
end
