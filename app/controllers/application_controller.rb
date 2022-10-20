class ApplicationController < ActionController::API
  def json_payload
    return [] if request.raw_post.empty?

    HashWithIndifferentAccess.new(JSON.parse(request.raw_post))
  end
end
