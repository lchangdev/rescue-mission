class Answer < ActiveRecord::Base
  validates :description, presence: true
    # length: { minimum: 50 }
  belongs_to :question
end
