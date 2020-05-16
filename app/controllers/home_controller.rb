# frozen_string_literal: true

class HomeController < ApplicationController
  include V4::GraphqlRunnable

  def show
    @forum_posts = ForumPost.
      joins(:forum_category).
      merge(ForumCategory.with_slug(:site_news))
    @forum_posts = localable_resources(@forum_posts).order(created_at: :desc).limit(5)

    @activity_group_result = UserHome::FetchFollowingActivityGroupsRepository.new(
      graphql_client: graphql_client(viewer: current_user)
    ).fetch(username: current_user.username, cursor: params[:cursor])
  end
end
