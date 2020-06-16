class VoteController < ApplicationController
  def create
    @vote  = Vote.new(article_id: params.require(:article_id))
    @vote.user_id = current_user.id
    if @vote.save
    else
      flash[:alert]  = "Unable to vote"
    end
    redirect_back(fallback_location: :back)
  end
  def destroy
    @vote = Vote.where(article_id: params.require(:article_id), user_id: current_user.id).first
    if @vote
      @vote.destroy
    else
      flash[:alert] = "Unable to process request"
    end
    redirect_back(fallback_location: :back)
  end
end
