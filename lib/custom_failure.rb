class UnauthorizedController < Devise::FailureApp
  # see: http://www.codebeerstartups.com/2013/01/custom-redirect-after-login-fail-in-devise/
  def redirect_url
    new_person_session_url
  end
  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end
