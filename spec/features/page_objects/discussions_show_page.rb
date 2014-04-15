require_relative 'menu_section'

class DiscussionsShowPage < SitePrism::Page
  set_url '/discussions{/discussion_id}/notes'

  section :menu, MenuSection, ".navbar"
end