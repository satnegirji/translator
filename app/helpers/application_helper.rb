module ApplicationHelper

  def admin?
    current_user && current_user.respond_to?(:admin?) && current_user.admin?
  end

  def main_nav_menu_heading
    if admin?
      content_tag(:span, class: "admin-header") do
        t('main_nav.menu_admin_header')
      end
    else
      t('main_nav.menu_heading')
    end
  end
end
