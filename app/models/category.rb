class Category < ActiveRecord::Base
  belongs_to :parent, :class_name => "Category"
  has_many :children, :class_name => "Category", :foreign_key => "parent_id", :dependent => :destroy
  
  belongs_to :user

  has_many :transaction_items

  validates :name, :presence => true
  validates :locale, :presence => true
  
  validate :child_match_parent

  scope :roots, where('parent_id IS NULL')
  scope :expenses, where(:expense => true)
  scope :incomes, where(:expense => false)

  def display_name
    if self.parent
      "#{self.parent.display_name} : #{self.name}"
    else
      "#{self.name}"
    end
  end
  
  def child_match_parent
    if parent
      if parent.expense != expense
        errors.add(:base, "Child income/expense must match parent")
      end
      if parent.locale != locale
        errors.add(:base, "Child locale must match parent")
      end
      if parent.user != user
        errors.add(:base, "Child user must match parent")
      end
    end
  end
end
