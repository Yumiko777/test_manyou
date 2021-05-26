class Task < ApplicationRecord
  belongs_to :user

  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings

  validates :name, presence: true
  validates :detail, presence: true
  validates :deadline, presence: true
  validates :status, presence: true
  validates :priority, presence: true

  enum status:{ not_started: 0, doing: 1, completed: 2 }
  enum priority:{ high: 0, middle: 1, low: 2 }

  scope :search_name, -> (name) {where('name like ?',"%#{name}%")}
  scope :search_status, -> (status) {where(status: status)}
end
