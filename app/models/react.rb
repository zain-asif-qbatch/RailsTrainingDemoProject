class React < ApplicationRecord
  enum reaction: %i[👍🏻 👎🏻 😂 ❤️ 😡]

  belongs_to :user
  belongs_to :reactable, polymorphic: true

  validates :user_id, presence: true, uniqueness: { scope: :reactable_id, message: 'You have already reacted!' }
  validates :reaction, presence: true

  scope :reactions_counts, -> { group(:reaction).count }
end
