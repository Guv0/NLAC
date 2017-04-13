class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def linkedin
    user = User.find_for_linkedin_oauth(request.env['omniauth.auth'])

    if user.persisted?
      sign_in_and_redirect user, event: :authentication
      current_or_guest_user
      set_flash_message(:notice, :success, kind: 'linkedin') if is_navigational_format?
    else
      session['devise.linkedin_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end
end
