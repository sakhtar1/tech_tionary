class Word < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :title, :description

  def title_capitalize
    title.capitalize
  end

  def description_capitalize
    description.capitalize
  end


end
