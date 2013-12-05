class Post < ActiveRecord::Base
  include HasClearUrl
  generate_clear_url_from :title

  has_many :comments, dependent: :destroy

  def self.template_variables
    {cut: {placeholder: '{{cut}}',
           description: "In blog index page post body will cut till this marker. \
                         Please, make sure that HTML markup remains valid."}}
  end

  def render_body
    body.gsub(self.class.template_variables[:cut][:placeholder], '')
  end
end
