class OctokitController < ApplicationController

  def repos
    respond_to do |format|
      format.json { render json: Octokit.repos(params[:user]).map{ |r| { value: r[:full_name]} } }
    end
  end

  def branches
    respond_to do |format|
      format.json { render json: Octokit.branches(params[:repo]).map{ |b| { value: "#{params[:repo]}/#{b[:name]}", sha: b[:commit][:sha] } } }
    end
  end

  def tree
    respond_to do |format|
      format.json do
        render json: Octokit.contents( params[:repo],
                    ref: params[:branch],
                    path: params[:path]).map{ |t| {
                      value: "#{params[:repo]}/#{params[:branch]}/#{t[:path]}",
                      type: t[:type] ,
                      repo: params[:repo],
                      branch: params[:branch],
                      path: t[:path]} }
      end
    end
  end

  def content
    respond_to do |format|
      format.html { render text: Base64.decode64(Octokit.contents( params[:repo],
                  ref: params[:branch],
                  path: params[:path]).content) }
    end
  end
end
