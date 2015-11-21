class Sub < ActiveRecord::Base
  validates :title, :description, :moderator_id, presence: true
  validates :title, uniqueness: true

  has_many :posts,
    class_name: "Post",
    primary_key: :id,
    foreign_key: :sub_id

  belongs_to :moderator,
  class_name: "User",
  primary_key: :id,
  foreign_key: :moderator_id
end
