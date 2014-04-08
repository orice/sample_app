include ApplicationHelper

def sign_in(user, options={})
  if options[:no_capybara]
    # Sign in when not using Capybara.
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.hash(remember_token))
  else
    visit signin_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end

def valid_signup(user)
    fill_in "Name",         with: "Example User"
    fill_in "Email",        with: "user@example.com"
    fill_in "Password",     with: "foobar"
    fill_in "Confirmation", with: "foobar"
end


RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end
RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-success', text: message)
  end
end
#RSpec::Matchers.define :be_signed_in_as do |message|
 # match do |page|
  #	expect(page).to have_link ('Profile')
  #	expect(page).to have_link ('Sign out')
    #page.should have_link ('Profile', href: user_path(user))
    #page.should have_link ('Sign out', href: signout_path))
	#page.should have_no_link('Sign In', href: signin_path)
  #end
end