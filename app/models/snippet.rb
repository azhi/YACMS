class Snippet < ActiveRecord::Base
  has_and_belongs_to_many :posts
  has_and_belongs_to_many :pages

  after_update :update_dependent_materials

  def render_content
    res = content.dup
    content.scan(/({{(.*)}})/).each do |substition|
      name = substition[1]
      child_snippet = self.class.where(name: name).first
      if child_snippet
        res.gsub!(substition.first, child_snippet.render_content)
      end
    end
    res
  end

  def update_dependent_materials
    posts.each(&:regenerate_snippets!)
    pages.each(&:regenerate_snippets!)
  end
end
