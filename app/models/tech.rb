class Tech < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :definition
end
