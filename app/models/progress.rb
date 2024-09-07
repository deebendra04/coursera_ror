class Progress < ApplicationRecord
  belongs_to :user
  belongs_to :course_content
end
