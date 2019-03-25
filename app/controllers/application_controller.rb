class ApplicationController < ActionController::Base
  def home
    render html: "hello"
  end
end
