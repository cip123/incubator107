

def sign_in(user, options={}) 

  if options[:no_capybara]
    # Sign in when not using Capybara.
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
  else
    visit signin_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
end


def full_title(page_title)
  base_title = "Incubator107"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def url_for_subdomain subdomain="www", path="/"
  "http://#{subdomain}.127.0.0.1.xip.io:#{Capybara.server_port}#{path}"
end

