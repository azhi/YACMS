class Page < ActiveRecord::Base
  include CanRegenerateSrcs
  include HasClearUrl
  generate_clear_url_from :title

  has_and_belongs_to_many :images
  has_and_belongs_to_many :attachments

  acts_as_nested_set
  include TheSortableTree::Scopes

  scope :in_menu, ->{ where(show_in_menu: true) }
end
