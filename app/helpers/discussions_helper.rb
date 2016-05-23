module DiscussionsHelper
  def show_edit_link(reply, user)
    if reply.user == user
      link_to "Edit", edit_reply_discussion_path(reply.parent, reply)
    end
  end
end
