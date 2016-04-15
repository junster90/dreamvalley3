class Goal < ActiveRecord::Base
  belongs_to :user
  
  extend Enumerize
  enumerize :category, in: [:experience, :growth, :contribution], predicates: true, scope: true
end
