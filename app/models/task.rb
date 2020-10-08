class Task < ApplicationRecord
  belongs_to :user
  
  validates :status, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 100 }

end

