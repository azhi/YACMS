class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  acts_as_nested_set
  include TheSortableTree::Scopes
end
