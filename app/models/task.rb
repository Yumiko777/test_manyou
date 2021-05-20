class Task < ApplicationRecord
  validates :name, presence: true
  validates :detail, presence: true
  validates :deadline, presence: true

  enum status:{ not_started: 0, doing: 1, completed: 2 }

  scope :search_name, -> (name) {where('name like ?',"%#{name}%")}
  scope :search_status, -> (status) {where(status: status)}
end
