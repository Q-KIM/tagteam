class TagsController < ApplicationController

  before_filter :load_hub

  access_control do
    allow all
  end

  def index
    @tags = FeedItem.tag_counts_on(:tags)
  end

  def show
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    @feed_items = FeedItem.tagged_with(@tag.name, :on => @hub.tagging_key).paginate(:order => 'date_published desc', :page => params[:page], :per_page => params[:per_page])
    render :layout => ! request.xhr?
  end

  def load_hub
    @hub = Hub.find(params[:hub_id])
  end

end
