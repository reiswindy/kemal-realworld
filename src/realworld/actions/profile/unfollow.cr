require "../base"
require "../../models/user"
require "../../models/following"
require "../../services/repo"

module Realworld::Actions::Profile
  class Unfollow < Realworld::Actions::Base
    include Realworld::Services
    include Realworld::Models

    def call(env, user)
      if user
        p_owner = Repo.get_by!(User, username: env.params.url["username"])
        if p_owner
          if following = user.followed_users.select {|fu| fu.followed_user_id == p_owner.id}.first?
            query = Repo::Query.where(follower_user_id: user.id, followed_user_id: p_owner.id)
            changeset = Repo.delete_all(Following, query)
            
            user.followed_users.delete(following)
          end

          # TODO: Return success
        else
          # TODO: Return error
        end
      else
        # TODO: Return error
      end
    end
  end
end