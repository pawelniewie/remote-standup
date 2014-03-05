class Users::InvitationsController < Devise::InvitationsController
  def update
    redirect_to settings_path
  end

  private

  def invite_resource
    # copy team id
    resource_class.invite!(invite_params, current_inviter) do |u|
      u.admin = current_inviter.admin.nil? ? current_inviter : current_inviter.admin
    end
  end

  def after_sign_in_path_for(user)
    new_user_invitation_path
  end
end