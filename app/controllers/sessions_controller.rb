class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def new
    response.headers['WWW-Authenticate'] = Rack::OpenID.build_header(
        :identifier => "https://www.google.com/accounts/o8/id",
        :required => ["http://axschema.org/contact/email",
                      "http://axschema.org/namePerson/first",
                      "http://axschema.org/namePerson/last"],
        :return_to => session_url,
        :method => 'POST')
    head 401
  end

  def create
    if openid = request.env[Rack::OpenID::RESPONSE]
      begin
        raise "OpenID failed" unless openid.status == :success
        ax = OpenID::AX::FetchResponse.from_success_response(openid)
        @email = ax.get_single('http://axschema.org/contact/email')
        return render(:action => 'invalid_email') unless valid_email(@email)
        user = User.find_by_identifier_url( openid.display_identifier)
        user ||= User.create! do |u|
          u.identifier_url = openid.display_identifier
          u.email = @email
          u.first_name = ax.get_single('http://axschema.org/namePerson/first')
          u.last_name = ax.get_single('http://axschema.org/namePerson/last')
        end
        session[:user_id] = user.id
        redirect_to(session[:redirect_to] || root_path)
      rescue Exception => e
        @error = e
        Rails.env == "production" ? self.render(:action => 'problem') : raise(e)
      end
    else
      redirect_to new_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def valid_email(email)
     email.split("@")[1] == Settings.users_domain
  end
end
