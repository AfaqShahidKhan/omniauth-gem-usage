# app/controllers/omniauth_callbacks_controller.rb

class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      handle_callback('facebook')
    end
  
    def google_oauth2
      handle_callback('google_oauth2')
    end
  
    private
  
    def handle_callback(provider)
      @user = User.from_omniauth(request.env['omniauth.auth'])
  
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
      else
        session["devise.#{provider}_data"] = request.env['omniauth.auth']
        redirect_to new_user_registration_url
      end
    end
  end
  