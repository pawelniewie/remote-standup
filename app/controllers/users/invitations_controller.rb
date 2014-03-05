class Users::InvitationsController < Devise::InvitationsController
  def update
    if this
      redirect_to root_path
    else
      super
    end
  end

  private

  def invite_resource
    # copy team id
    resource_class.invite!(invite_params, current_inviter) do |u|
      # u.team_id = current_inviter.team_id if u.team_id.nil?
    end
  end

  def after_sign_in_path_for(user)
    new_user_invitation_path
  end
end