module Author
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_resource!

    verify_authorized
  end
end
