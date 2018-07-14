class Goal < ApplicationRecord
  validates :user_id, :description, presence: true
  
  belongs_to :user
  
  def change_publicity
    if self.public
      self.public = false
    else
      self.public = true
    end
    self.save
  end
  
  def change_goal_status
    if self.completed
      self.completed = false
    else
      self.completed = true
    end
    self.save
  end
end
