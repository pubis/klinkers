class Investment < ActiveRecord::Base
  attr_accessible :name, :symbol

  validates :name, presence: true
  validates :symbol, presence: true, uniqueness: true

  attr_accessor :quote
end
