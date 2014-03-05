class Users::InvitationsController < Devise::InvitationsController

  private

  def invite_resource
    # copy team id
    resource_class.invite!(invite_params, current_inviter) do |u|
      u.admin = current_inviter.admin.nil? ? current_inviter : current_inviter.admin
    end
  end

  def after_accept_path_for(user)
    settings_path
  end

  def after_invite_path_for(user)
    new_user_invitation_path
  end
end