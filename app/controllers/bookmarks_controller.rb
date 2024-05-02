class BookmarksController < ApplicationController
  def new
    @bookmark = Bookmark.new
    @list = List.find(params[:list_id])
  end

  def create
    @bookmark = Bookmark.create(bookmarks_params)
    @list = List.find(params[:list_id])
    @bookmark.list = @list
    if @bookmark.valid?
      @bookmark.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @list = @bookmark.list
    @bookmark.destroy
    redirect_to(list_path(@list))
  end

  private

  def bookmarks_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
