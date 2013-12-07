class Post < ActiveRecord::Base
  include CanRegenerateSrcs
  include HasClearUrl
  generate_clear_url_from :title

  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :images
  has_and_belongs_to_many :attachments

  def self.template_variables
    {cut: {tag: '<cut />',
           description: "In blog index page post body will cut till this tag."}}
  end

  def render_body
    body.gsub(self.class.template_variables[:cut][:tag], '')
  end
end
