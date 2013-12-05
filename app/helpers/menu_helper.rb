module MenuHelper
  def render_menu(sn_scope)
    render_pages_scope_menu(Page.where(depth: 0).in_menu, sn_scope)
  end

  def render_pages_scope_menu(pages, sn_scope)
    pages.in_menu.each do |menu_page|
      blc = proc do |scope|
        render_pages_scope_menu(menu_page.children, scope)
      end if menu_page.children.in_menu.any?

      sn_scope.item menu_page.name.to_sym,
                    menu_page.name,
                    page_path(menu_page),
                    &blc
    end
  end
end
