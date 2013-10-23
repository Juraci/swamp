# Swamp

[![Build Status](https://travis-ci.org/Juraci/swamp.png?branch=master)](https://travis-ci.org/Juraci/swamp)

Automatically generates the interfaces for the most common actions that a page can provide, 
so you can use the generated methods to quickly create your page objects using [capybara](https://github.com/jnicklas/capybara) and [capybara-page-object](https://github.com/andyw8/capybara-page-object).

## How to install

It requires Ruby 1.9.3 or later and Firefox 24.0 or later. To install, type:

```bash
gem install swamp
```

## How to use

* In the terminal type: 

```shell
swamp
```
* It will ask you to provide an URL:

```shell
Enter the url for the page to be scanned:
```

* Provide a valid one, beginning with `http://` or `https://` for instance:

```shell
Enter the url for the page to be scanned:
https://accounts.google.com
```

* Hit enter and wait for the code snippets, like this: 

```shell
Enter the url for the page to be scanned:
https://accounts.google.com

Scanning, please wait...

def type_email(input)
  source.fill_in("Email", with: input)
end
def type_passwd(input)
  source.fill_in("Passwd", with: input)
end
def sign_in
  source.find(:css, "#signIn").click
end
def select_lang_chooser(option)
  source.select(option, :from => "lang-chooser")
end
def link_forgot_passwd
  source.click_link("link-forgot-passwd")
end
def link_signup
  source.click_link("link-signup")
end
```
(notice that the method names are a best guess and you are always free to change them)

* Copy the code snippets and paste inside your capybara-page-object classes like this:

```ruby
module PageObjects
  class SignIn < CapybaraPageObject::Page
  
    path ""
  
    def type_email(input)
      source.fill_in("Email", with: input)
    end
  
    def type_passwd(input)
      source.fill_in("Passwd", with: input)
    end
  
    def sign_in
      source.find(:css, "#signIn").click
    end
  
    def select_lang_chooser(option)
      source.select(option, :from => "lang-chooser")
    end
  
    def link_forgot_passwd
      source.click_link("link-forgot-passwd")
    end

    def link_signup
      source.click_link("link-signup")
    end
  end
end
```

* Then just call the methods passing the expected parameters when necessary. For instance:

```ruby
When /^I attempt to sign in with valid information$/ do
  sign_in_page = PageObjects::SignIn.new
  sign_in_page.type_email "username@email.com"
  sign_in_page.type_passwd "mypassword"
  sign_in_page.sign_in
end
```

